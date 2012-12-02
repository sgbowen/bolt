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
      public var blockGroup:FlxGroup; 

      [Embed(source = "/../art/tiles.png")] public static const large_tiles:Class;
      [Embed(source = "levels/demo.txt", mimeType = 'application/octet-stream')]private static var default_demo:Class;

      public function LevelMap(mapNameInput:String, game:PlayState) {
        super();
        loadMap(new default_demo(), large_tiles, TILE_LENGTH, TILE_LENGTH, FlxTilemap.AUTO);
        mapName = mapNameInput;
        blockGroup = new FlxGroup();
        blockGroup.add(new Block(new Position(48, 240), new Position(432, 48), 0xff00ff, game));
        blockGroup.add(new Block(new Position(48, 288), new Position(240, 48), 0x00ffff, game));
        blockGroup.add(new Block(new Position(336, 288), new Position(48, 288), 0xffff00, game));
        blockGroup.add(new Block(new Position(336, 48), new Position(144, 144), 0x222222, game));
      }
    }
}
