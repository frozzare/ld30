package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
using flixel.util.FlxSpriteUtil;

class LevelState extends FlxState {

	private var lvl:String;

	public function new (lvl:String = "level") : Void {
		this.lvl = lvl;
		super();
	}

	override public function create () : Void {
		bgColor = 0xff7EC0EE;

		var text = new FlxText(0, (FlxG.height/2) - 20, 100, "Congratulations!");
		text.alignment = "center";
    	add(text);
    	text.screenCenter(true, false);
    	
    	var info = new FlxText(0, 0, 200, "Hit enter to proceed to next level");
    	info.alignment = "center";
    	add(info);
    	info.screenCenter();
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		if (FlxG.keys.pressed.ENTER) {
    		FlxG.switchState(new PlayState(lvl));
		}

		super.update();
	}

}