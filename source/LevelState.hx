package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
using flixel.util.FlxSpriteUtil;

class LevelState extends FlxState {

	private var btnPlay: FlxButton;
	private var lvl:String;

	public function new (lvl:String = "level") : Void {
		this.lvl = lvl;
		super();
	}

	override public function create () : Void {
		bgColor = 0xff7EC0EE;

		var text = new FlxText(0, (FlxG.height/2) - 40, 100, "Congratulations!");
		text.alignment = "center";
    	add(text);
    	text.screenCenter(true, false);
    	
    	btnPlay = new FlxButton(0, 0, "Play next level", clickPlay);
    	add(btnPlay);
    	btnPlay.screenCenter();
	}

  	private function clickPlay():Void
  	{
    	FlxG.switchState(new PlayState(lvl));
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