package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Ax extends FlxSprite {

	public function new (x:Float = 0, y:Float = 0) {
		x -= 10;
		y -= 8;
		super(x, y);
		loadGraphic(AssetPaths.ax__png, true, 16, 16);
	}

	override public function draw () : Void {
		super.draw();
	}

	override public function update () : Void {
		super.update();
	}

	override public function kill():Void 
	{
		alive = false;
		FlxTween.tween(this, { alpha:0, y:y - 16 }, .66, {ease:FlxEase.circOut, complete:finishKill } );
	}

	private function finishKill(_):Void
	{
		exists = false;
	}

}