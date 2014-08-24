package ;

import openfl.Assets;
import haxe.io.Path;
import haxe.xml.Parser;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectGroup;
import flixel.addons.editors.tiled.TiledTileSet;

class Level extends flixel.addons.editors.tiled.TiledMap {

	private inline static var c_PATH_LEVEL_TILESHEETS = "assets/tiled/";

	public var foregroundTiles:FlxGroup;
	public var backgroundTiles:FlxGroup;
	private var collidableTileLayers:Array<FlxTilemap>;
	public function new (tiledLevel:Dynamic) {
		super(tiledLevel);

		foregroundTiles = new FlxGroup();
		backgroundTiles = new FlxGroup();

		FlxG.camera.setBounds(0, 0, fullWidth, fullHeight, true);

		for (tileLayer in layers) {
			var tileSheetName:String = tileLayer.properties.get("tileset");

			if (tileSheetName == null) {
				throw "'tileset' property not defined for the '" + tileLayer.name + "' layer. Please add the property to the layer.";
			}

			var tileSet:TiledTileSet = null;
			for (ts in tilesets)
			{
				if (ts.name == tileSheetName)
				{
					tileSet = ts;
					break;
				}
			}
			
			if (tileSet == null) {
				throw "Tileset '" + tileSheetName + " not found. Did you mispell the 'tilesheet' property in " + tileLayer.name + "' layer?";
			}


			var imagePath 		= new Path(tileSet.imageSource);
			var processedPath 	= c_PATH_LEVEL_TILESHEETS + imagePath.file + "." + imagePath.ext;


			var tilemap:FlxTilemap = new FlxTilemap();
			tilemap.widthInTiles = width;
			tilemap.heightInTiles = height;
			tilemap.loadMap(tileLayer.tileArray, processedPath, tileSet.tileWidth, tileSet.tileHeight, 0, 1, 1, 1);
			

			if (tileLayer.properties.contains("nocollide"))
			{
				backgroundTiles.add(tilemap);
			}
			else
			{
				if (collidableTileLayers == null) {
					collidableTileLayers = new Array<FlxTilemap>();
				}

				foregroundTiles.add(tilemap);

				collidableTileLayers.push(tilemap);
			}
		}
	}

	public function loadObjects(state:PlayState) {
		for (group in objectGroups) {
			for (o in group.objects) {
				loadObject(o, group, state);
			}
		}
	}

	private function loadObject(o:TiledObject, g:TiledObjectGroup, state:PlayState) {
		
		var x:Int = o.x;
		var y:Int = o.y;
		
		// objects in tiled are aligned bottom-left (top-left in flixel)
		if (o.gid != -1)
			y -= g.map.getGidOwner(o.gid).tileHeight;
		
		switch (o.type.toLowerCase())
		{
			case "player_start":
				// var player = new FlxSprite(x, y);
				var player = new Player(x,y);
				// player.makeGraphic(32, 32, 0xffaa1111);
				player.maxVelocity.x = 160;
				player.maxVelocity.y = 400;
				player.acceleration.y = 400;
				// player.drag.x = player.maxVelocity.x * 4;
				FlxG.camera.follow(player);
				state.player = player;
				state.add(player);
			
			case "enemy":
				var tileset = g.map.getGidOwner(o.gid);
				var enemy = new Enemy(x, y, c_PATH_LEVEL_TILESHEETS + tileset.imageSource);
				enemy.state = state;
				state.enemys.add(enemy);

			case "coin":
				var tileset = g.map.getGidOwner(o.gid);
				var coin = new FlxSprite(x, y, c_PATH_LEVEL_TILESHEETS + tileset.imageSource);
				state.coins.add(coin);

			case "door":
				var tileset = g.map.getGidOwner(o.gid);
				var door = new FlxSprite(x, y, c_PATH_LEVEL_TILESHEETS + tileset.imageSource);
				state.door = door;
				state.add(door);

			case "wall":
				var tileset = g.map.getGidOwner(o.gid);
				var wall = new Wall(x, y, c_PATH_LEVEL_TILESHEETS + tileset.imageSource);
				state.walls.add(wall);

			case "floor":
				var floor = new FlxObject(x, y, o.width, o.height);
				state.floor = floor;
		}
	}

	public function collideWithLevel(obj:FlxObject, ?notifyCallback:FlxObject->FlxObject->Void, ?processCallback:FlxObject->FlxObject->Bool):Bool
	{
		if (collidableTileLayers != null)
		{
			for (map in collidableTileLayers)
			{
				// IMPORTANT: Always collide the map with objects, not the other way around. 
				//			  This prevents odd collision errors (collision separation code off by 1 px).
				return FlxG.overlap(map, obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate);
			}
		}
		return false;
	}

}