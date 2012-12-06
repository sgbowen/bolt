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
      [Embed(source = "levels/time.txt", mimeType = 'application/octet-stream')]private static var default_time:Class;

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
        blockGroup.add(new Block(new Position(336, 48), new Position(144, 144), 0xffffff, game));
        }
        else if(mapNameInput == "tiles1") {
        loadMap(new default_tiles1(), large_tiles, TILE_LENGTH, TILE_LENGTH, FlxTilemap.AUTO);
        mapTime = 12;
        mapName = "Tiles #1";
        blockGroup = new FlxGroup();
        blockGroup.add(new Block(new Position((6*48), (6*48)), new Position((8*48), (6*48)), 0x000000, game));
        blockGroup.add(new Block(new Position((6*48), (8*48)), new Position((8*48), (8*48)), 0xff0000, game));
        blockGroup.add(new Block(new Position((7*48), (7*48)), new Position((7*48), (7*48)), 0xff00ff, game));
        blockGroup.add(new Block(new Position((7*48), (9*48)), new Position((9*48), (7*48)), 0x0000ff, game));
        blockGroup.add(new Block(new Position((8*48), (6*48)), new Position((6*48), (8*48)), 0x00ffff, game));
        blockGroup.add(new Block(new Position((8*48), (8*48)), new Position((7*48), (9*48)), 0x00ff00, game));
        blockGroup.add(new Block(new Position((9*48), (7*48)), new Position((6*48), (6*48)), 0xffff00, game));
        blockGroup.add(new Block(new Position((9*48), (9*48)), new Position((9*48), (9*48)), 0xffffff, game));
        }
        else if(mapNameInput == "time") {
        loadMap(new default_time(), large_tiles, TILE_LENGTH, TILE_LENGTH, FlxTilemap.AUTO);
        mapTime = 42;
        mapName = "Time";
        blockGroup = new FlxGroup();
        blockGroup.add(new Block(new Position((7*48), (3*48)), new Position((9*48), (4*48)), 0x0080ff, game));
        //blockGroup.add(new Block(new Position((3*48), (7*48)), new Position((10*48), (5*48)), 0x0000bf, game));
        blockGroup.add(new Block(new Position((9*48), (4*48)), new Position((11*48), (7*48)), 0x8000ff, game));
        //blockGroup.add(new Block(new Position((10*48), (9*48)), new Position((10*48), (9*48)), 0xbf00bf, game));
        blockGroup.add(new Block(new Position((9*48), (10*48)), new Position((9*48), (10*48)), 0xff0080, game));
        //blockGroup.add(new Block(new Position((4*48), (9*48)), new Position((7*48), (11*48)), 0xbf0000, game));
        blockGroup.add(new Block(new Position((5*48), (4*48)), new Position((5*48), (10*48)), 0xff8000, game));
        //blockGroup.add(new Block(new Position((4*48), (5*48)), new Position((4*48), (9*48)), 0xbfbf00, game));
        blockGroup.add(new Block(new Position((10*48), (5*48)), new Position((3*48), (7*48)), 0x80ff00, game));
        //blockGroup.add(new Block(new Position((11*48), (7*48)), new Position((4*48), (5*48)), 0x00bf00, game));
        blockGroup.add(new Block(new Position((5*48), (10*48)), new Position((5*48), (4*48)), 0x80ffff, game));
        //blockGroup.add(new Block(new Position((7*48), (11*48)), new Position((7*48), (3*48)), 0x00bfbf, game));
        }
        else {
        loadMap(new default_default(), large_tiles, TILE_LENGTH, TILE_LENGTH, FlxTilemap.AUTO);
        mapTime = 64;
        mapName = "Level 1";
        blockGroup = new FlxGroup();
        blockGroup.add(new Block(new Position((3*48), (6*48)), new Position((11*48), (6*48)), 0xff8800, game));
        blockGroup.add(new Block(new Position((11*48), (8*48)), new Position((3*48), (8*48)), 0x884400, game));
        }
      }
    }
}
