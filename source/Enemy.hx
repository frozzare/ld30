package ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import flixel.util.FlxVelocity;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxPoint;

class Enemy extends FlxSprite {

	public var speed:Float = 80;
	private var _moveDir:Float;
	private var _idleTmr:Float;
	private var _brain:FSM;
	private var bullets:FlxTypedGroup<Bullet>;
	public var state:PlayState;
	public var seesPlayer:Bool = false;
	public var playerPos(default, null):FlxPoint;

	public function new (x:Float = 0, y:Float = 0, sg:String = null) {
		super(x,y);

		if (sg != null) {
			loadGraphic(sg);
		}
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("d", [0, 1, 0, 2], 6, false);
		animation.add("lr", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);

		bullets = new FlxTypedGroup<Bullet>();

		_brain = new FSM(idle);
		_idleTmr = 0;

		playerPos = FlxPoint.get();
	}

	public function idle():Void {
		if (seesPlayer) {
			_brain.activeState = chase;
		} else if (_idleTmr <= 0) {
			if (FlxRandom.chanceRoll(1)) {
				_moveDir = -1;
				velocity.x = velocity.y = 0;
			} else {
				_moveDir = FlxRandom.intRanged(0, 8) * 45;
				FlxAngle.rotatePoint(speed * .5, 0, 0, 0, _moveDir, velocity);
			}
		//	fire();
			_idleTmr = FlxRandom.intRanged(1, 4);			
		} else {
			_idleTmr -= FlxG.elapsed;
		}
	}

	public function chase():Void
	{
		if (!seesPlayer)
		{
			_brain.activeState = idle;
		}
		else
		{
			FlxVelocity.moveTowardsPoint(this, playerPos, Std.int(speed));
		}
	}
	
	override public function update():Void 
	{
		_brain.update();

		if (FlxG.overlap(this, state.player)) {
			state.player.kill();
			state.the_end(true);
		}

		for (b in bullets) {
			if (FlxG.overlap(b, state.player)) {
				state.player.kill();
				state.the_end(true);
			}
		}

		super.update();
	}

	override public function kill():Void 
	{
		alive = false;
		FlxTween.tween(this, { alpha:0, y:y - 16 }, .66, {ease:FlxEase.circOut, complete:finishKill } );
	}

	public function getBulletSpawnPosition():FlxPoint
	{
		var p: FlxPoint = new FlxPoint(x + 36, y + 12);
		return p;
	}

	private function finishKill(_):Void
	{
		exists = false;
	}

	private function fire():Void {
		var p = getBulletSpawnPosition();
		var bullet: Bullet = new Bullet(p.x, p.y);
		bullets.add(bullet);
		state.add(bullets);
		state.bulletSound.play();
	}


}