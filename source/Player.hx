package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxAngle;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;

class Player extends FlxSprite {

	public var _moving:Bool = false;
	public var _move_dir:String;
    public var _moveSpeed:Float = 200;
    public var _powerup:FlxSound;

	public function new (x:Float = 0, y:Float = 0)  {
    	super(x, y);

    	loadGraphic(AssetPaths.ball2__png, true, 32, 32);
    	
    	setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add('lr', [3, 4, 3, 5], 6, false);
		animation.add('u', [6, 7, 6, 8], 6, false);
		animation.add('d', [0, 1, 0, 2], 6, false);
		// animation.add('jump', [2]);

		// acceleration.y = 400;
        // maxVelocity.y = 300;

    	drag.x = drag.y = 1600;

    	_powerup = FlxG.sound.load(AssetPaths.powerup__wav);
    }

    override public function draw () : Void 
	{
		if (velocity.x != 0 || velocity.y != 0) {
			switch(facing) {
				case FlxObject.LEFT, FlxObject.RIGHT:
					animation.play('lr');
					
				case FlxObject.UP:
					animation.play('u');

				case FlxObject.DOWN:
					animation.play('d');
			}
		}
			
		super.draw();
	}

    private function movement () {
    	var _up:Bool = false;
    	var _down:Bool = false;
    	var _left:Bool = false;
    	var _right:Bool = false;
    	var _space:Bool = false;
		
		_up = FlxG.keys.anyPressed(['UP', 'W']);
		_down = FlxG.keys.anyPressed(['DOWN', 'S']);
		_left = FlxG.keys.anyPressed(['LEFT', 'A']);
		_right = FlxG.keys.anyPressed(['RIGHT', 'D']);
		_space = FlxG.keys.anyPressed(['SPACE']);

		if (_up && _down) {
			_up = _down = false;
		}

		if (_left && _right) {
			_left = _right = false;
		}

		if ( _up || _down || _left || _right) {

			var mA:Float = 0;
			
			if (_up) {
				mA = -90;
				
				if (_left) {
					mA -= 45;
				} else if (_right) {
					mA += 45;
				}

				facing = FlxObject.UP;

				_powerup.play();
			} else if (_down) {
				mA = 90;
				if (_left) {
					mA += 45;
				} else if (_right) {
					mA -= 45;
				}

				facing = FlxObject.DOWN;
			} else if (_left) {
				mA = 180;
				facing = FlxObject.RIGHT;
			} else if (_right) {
				mA = 0;
				facing = FlxObject.LEFT;
			}
				
			FlxAngle.rotatePoint(_moveSpeed, 0, 0, 0, mA, velocity);
		}


		/*
		if (_jump >= 0 && _space) {
        	_jump += FlxG.elapsed;
            if (_jump > 0.25) {
            	_jump = -1;
            }
       	} else {
       		_jump = -1;
       	} 

       	if (_jump > 0) {
        	if (_jump < 0.065) {
            	velocity.y = -180;
            } else {
                acceleration.y = 50; 
            } 
        } else {
        	velocity.y = 480;
        }
        */
    }


	override public function update():Void 
	{
		movement();
		super.update();
	}

	public function getBulletSpawnPosition():FlxPoint
	{
		var p: FlxPoint = new FlxPoint(x + 36, y + 12);
		return p;
	}

	public function getBulletDirection():UInt {
		return facing;
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