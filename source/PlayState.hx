package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxDestroyUtil;
import flixel.system.FlxSound;
import Reflect;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var level:Level;
	public var floor:FlxObject;
	public var bullets:FlxTypedGroup<Bullet>;
	public var player:Player;
	public var enemys:FlxTypedGroup<Enemy>;
	public var youDied:Bool = false;
	public var _text:FlxText;
	public var bulletSound:FlxSound;
	public var coins:FlxGroup;
	public var door:FlxSprite;
	public var score:FlxText;
	public var killedText:FlxText;
	public var lvl:String;
	public var coinSound:FlxSound;
	public var lastLvl:String = "level2";
  	public var gameSound:FlxSound;

	public function new (lvl:String = "level") {
		this.lvl = lvl;
		super();
	}

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		bgColor = 0xff7EC0EE;

		FlxG.mouse.visible = false;

		level = new Level("assets/tiled/" + lvl + ".tmx");

		add(level.backgroundTiles);

		add(level.foregroundTiles);

    	// _level1 = new Level1(100, 100);
    	// add(_level1);

		enemys = new FlxTypedGroup<Enemy>();
		add(enemys);

		bullets = new FlxTypedGroup<Bullet>();
		add(bullets);

		coins = new FlxGroup();
		add(coins);

		bulletSound = FlxG.sound.load(AssetPaths.shoot__wav);
		coinSound = FlxG.sound.load(AssetPaths.coin__wav);
		
		//gameSound = FlxG.sound.load(AssetPaths.game__wav);
		//gameSound.play();

    	level.loadObjects(this);

		score = new FlxText(2, 2, 80);
		score.scrollFactor.set(0, 0); 
		score.borderColor = 0xff000000;
		score.borderStyle = FlxText.BORDER_SHADOW;
		score.text = 'SCORE: ' + (coins.countDead() * 10);
		add(score);

		killedText = new FlxText(2, 14, 80);
		killedText.scrollFactor.set(0, 0);
		killedText.borderColor = 0xff000000;
		killedText.borderStyle = FlxText.BORDER_SHADOW;
		killedText.text = 'KILLED: ' + enemys.countDead();
		add(killedText);

		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	public function the_end(died:Bool):Void {
		FlxG.switchState(new TheEndState(died, lvl));
	}

	private function checkEnemyVision():Void
	{
		/*for (e in enemys.members) {
			if (level.ray(e.getMidpoint(), player.getMidpoint())) {
				e.seesPlayer = true;
				e.playerPos.copyFrom(player.getMidpoint());
			} else {
				e.seesPlayer = false;
			}
		}*/
	}
	

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		if (gameSound != null && !gameSound.active) {
			gameSound.play();
		}

		if (FlxG.keys.pressed.W) {
			player.velocity.y = -player.maxVelocity.y / 2;
		}

		if (FlxG.keys.pressed.SPACE) {
			var p = player.getBulletSpawnPosition();
			var f = player.getBulletDirection();
			var bullet: Bullet = new Bullet(p.x, p.y, f);
			bullets.add(bullet);
			bulletSound.play();
		} else {
			checkEnemyVision();
		}

		super.update();

		for (b in bullets.members) {
			if (level.collideWithLevel(b)) {
				b.kill();
			}
		}

		for (e in enemys.members) {
			level.collideWithLevel(e);
		}

		// Collect coins
		FlxG.overlap(coins, player, getCoin);

		// Open door
		FlxG.overlap(door, player, openDoor);

		// Kill enemy
		FlxG.overlap(bullets, enemys, killEnemy);

		// Kill player
		FlxG.overlap(enemys, player, killPlayer);

		// Bullets can kill coins.. that's bad :)
		FlxG.overlap(bullets, coins, killCoins);

		level.collideWithLevel(player);

		if (FlxG.overlap(player, floor))
		{
			the_end(true);
		}
	}

	public function killCoins (b:Bullet, c:FlxObject): Void {
		c.kill();
	}	

	public function killPlayer (e:Enemy, p:Player): Void {
		the_end(true);
	}

	public function killEnemy (b:Bullet, e:Enemy): Void {
		e.kill();
		killedText.text = 'KILLED: ' + enemys.countDead();
	}

	public function openDoor (d:FlxObject, p:Player):Void {
		if (lvl == lastLvl) {
			the_end(false);
		} else {
			FlxG.switchState(new LevelState("level2"));
		}
	}
	
	public function getCoin(c:FlxObject, p:Player):Void {
		coinSound.play();
		c.kill();
		score.text = 'SCORE: ' + (coins.countDead() * 10);
		
		/*if (coins.countLiving() == 0)
		{
			status.text = "Find the exit";
			exit.exists = true;
		}*/
	}
}