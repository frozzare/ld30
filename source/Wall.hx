package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Wall extends FlxSprite {
	public function new (x:Float = 0, y:Float = 0, sg:String) {
		super(x, y);

		if (sg != null) {
			loadGraphic(sg);
		}
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