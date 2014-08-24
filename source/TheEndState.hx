package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
using flixel.util.FlxSpriteUtil;
import flixel.util.FlxDestroyUtil;

class TheEndState extends FlxState {

	public var died:Bool = false;
	public var lvl:String;
	public var completed:Bool = false;

	public function new (died:Bool, lvl:String) : Void {
		this.died = died;
		this.lvl = lvl;
		super();
	}

	override public function create():Void
	{
		if (died) {
			bgColor = 0xffff0000;
			var text = new FlxText(0, 30, 100, "You died! (Restart with R)");
    		add(text);
    		text.screenCenter();
		} else {
			completed = true;
			bgColor = 0xff7EC0EE;
			var text = new FlxText(0, 30, 300, "You completed the game! Congratulations! (Press R to restart the game)");
			text.alignment = "center";
    		add(text);
    		text.screenCenter();
		}
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

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		if (FlxG.keys.pressed.R) {
			if (completed) {
				lvl = "level";
			}

    		FlxG.switchState(new PlayState(lvl));
		}

		super.update();
	}

}