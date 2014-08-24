package ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.system.FlxSound;

class Bullet extends FlxSprite {

	public function new (x:Float = 0, y:Float = 0, f:UInt = 0) {
		super(x,y);
		makeGraphic(4, 4, 0xFF597137);
		
		if (f != 0) {
			facing = f;
		}
	}

    override public function draw () : Void 
	{
		if (velocity.x != 0 || velocity.y != 0) {
			switch(facing) {
				case FlxObject.LEFT:
					velocity.x = 1000;
							
				case  FlxObject.RIGHT:
					velocity.x = -800;
			}
		}

		if (velocity.x == 0) {
			velocity.x = 1000;
		}
			
		super.draw();
	}

	override public function update () : Void {
		super.update();
	}
}