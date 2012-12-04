package
{
    import org.flixel.*;
    import flash.utils.*;

    public class LevelMap extends FlxTilemap
    {
      private var wid:int;
      private var hei:int;
      private var maxwid:uint = 15;
      private var maxhei:uint = 15;
      private var TILE_LENGTH:uint = 48;
      public var mapName:String;
      public var mapTime:uint;
      public var blockGroup:FlxGroup; 

      [Embed(source = "/../art/tiles.png")] public static const large_tiles:Class;
      [Embed(source = "levels/default.txt", mimeType = 'application/octet-stream')]private static var default_default:Class;
      [Embed(source = "levels/demo.txt", mimeType = 'application/octet-stream')]private static var default_demo:Class;
      [Embed(source = "levels/tiles1.txt", mimeType = 'application/octet-stream')]private static var default_tiles1:Class;

      public function LevelMap(mapNameInput:String, game:PlayState) {
        super();

        if(mapNameInput == "demo") {
        loadMap(new default_demo(), large_tiles, TILE_LENGTH, TILE_LENGTH, FlxTilemap.AUTO);
        mapTime = 20;
        mapName = "Demo";
        blockGroup = new FlxGroup();
        blockGroup.add(new Block(new Position(48, 240), new Position(432, 48), 0xff00ff, game));
        blockGroup.add(new Block(new Position(48, 288), new Position(240, 48), 0x00ffff, game));
        blockGroup.add(new Block(new Position(336, 288), new Position(48, 288), 0xffff00, game));
        blockGroup.add(new Block(new Position(336, 48), new Position(144, 144), 0x222222, game));
        }
        else if(mapNameInput == "tiles1") {
        loadMap(new default_tiles1(), large_tiles, TILE_LENGTH, TILE_LENGTH, FlxTilemap.AUTO);
        mapTime = 20;
        mapName = "Tiles #1";
        blockGroup = new FlxGroup();
        blockGroup.add(new Block(new Position((6*48), (6*48)), new Position((8*48), (6*48)), 0xff00ff, game));
        }
        else {
        loadMap(new default_default(), large_tiles, TILE_LENGTH, TILE_LENGTH, FlxTilemap.AUTO);
        mapTime = 64;
        mapName = "<default>";
        blockGroup = new FlxGroup();
        blockGroup.add(new Block(new Position((3*48), (6*48)), new Position((11*48), (6*48)), 0xff8800, game));
        blockGroup.add(new Block(new Position((11*48), (8*48)), new Position((3*48), (8*48)), 0x884400, game));
        }
      }
    }
}
