package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/data/data-goes-here.txt", "assets/data/data-goes-here.txt");
			type.set ("assets/data/data-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/ball.png", "assets/images/ball.png");
			type.set ("assets/images/ball.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/ball2.png", "assets/images/ball2.png");
			type.set ("assets/images/ball2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/images-go-here.txt", "assets/images/images-go-here.txt");
			type.set ("assets/images/images-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/music/coin.wav", "assets/music/coin.wav");
			type.set ("assets/music/coin.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/music/music-goes-here.txt", "assets/music/music-goes-here.txt");
			type.set ("assets/music/music-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/music/powerup.wav", "assets/music/powerup.wav");
			type.set ("assets/music/powerup.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/music/shoot.wav", "assets/music/shoot.wav");
			type.set ("assets/music/shoot.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/music/test.wav", "assets/music/test.wav");
			type.set ("assets/music/test.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/sounds-go-here.txt", "assets/sounds/sounds-go-here.txt");
			type.set ("assets/sounds/sounds-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/tiled/arrow.png", "assets/tiled/arrow.png");
			type.set ("assets/tiled/arrow.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/tiled/coin.png", "assets/tiled/coin.png");
			type.set ("assets/tiled/coin.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/tiled/door.png", "assets/tiled/door.png");
			type.set ("assets/tiled/door.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/tiled/enemy.png", "assets/tiled/enemy.png");
			type.set ("assets/tiled/enemy.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/tiled/level.png", "assets/tiled/level.png");
			type.set ("assets/tiled/level.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/tiled/level.pxm", "assets/tiled/level.pxm");
			type.set ("assets/tiled/level.pxm", Reflect.field (AssetType, "binary".toUpperCase ()));
			path.set ("assets/tiled/level.tmx", "assets/tiled/level.tmx");
			type.set ("assets/tiled/level.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/tiled/level2.tmx", "assets/tiled/level2.tmx");
			type.set ("assets/tiled/level2.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/tiled/wall.png", "assets/tiled/wall.png");
			type.set ("assets/tiled/wall.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/sounds/beep.ogg", "assets/sounds/beep.ogg");
			type.set ("assets/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/flixel.ogg", "assets/sounds/flixel.ogg");
			type.set ("assets/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
