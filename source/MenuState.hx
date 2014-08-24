package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
using flixel.util.FlxSpriteUtil;
import flixel.util.FlxDestroyUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState {

  private var text: FlxText;
  private var btnPlay: FlxButton;

  /**
   * Function that is called up when to state is created to set it up.
   */
  override public function create():Void
  {

    bgColor = 0xff43993e;

    var text = new FlxText(0, (FlxG.height/2) - 40, 100, "Alf the game");
    text.alignment = "center";
    add(text);
    text.screenCenter(true, false);
      
    btnPlay = new FlxButton(0, 0, "Play", clickPlay);
    add(btnPlay);
    btnPlay.screenCenter();

    super.create();
  }

  private function clickPlay():Void
  {
     FlxG.switchState(new PlayState("level"));
  }

  /**
   * Function that is called when this state is destroyed - you might want to
   * consider setting all objects this state uses to null to help garbage collection.
   */
  override public function destroy():Void
  {
    btnPlay = FlxDestroyUtil.destroy(btnPlay);
    super.destroy();
  }

  /**
   * Function that is called once every frame.
   */
  override public function update():Void
  {
    if (FlxG.keys.pressed.ENTER) {
        FlxG.switchState(new PlayState("level"));
    }
    super.update();
  }
}