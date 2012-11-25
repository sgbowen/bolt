package
{
    import org.flixel.*;
    import flash.utils.*;

    public class LevelMap extends FlxTilemap
    {
      private var wid:int;
      private var hei:int;
      public var mapName:String;
      public var blockGroup:FlxGroup; 

      [Embed(source = "/../art/tiles.png")] public static const TILES:Class;

      public function LevelMap(mapNameInput:String, game:PlayState) {
        super();
        //hardcode a demo level
        var arrayData:Array = new Array(1,1,1,1,1,1,1,1,1,1,1,
                              1,0,0,0,1,0,0,0,0,0,1,
                              1,0,0,0,1,0,0,0,0,0,1,
                              1,0,0,0,1,0,0,0,0,0,1,
                              1,0,0,0,0,0,0,0,0,0,1,
                              1,0,0,0,1,1,1,1,1,0,1,
                              1,0,0,0,1,1,1,0,0,0,1,
                              1,0,0,0,1,1,1,0,0,0,1,
                              1,1,1,1,1,1,1,1,1,1,1);
        loadMap(arrayToCSV(arrayData, 11, false), FlxTilemap.ImgAuto,0,0, FlxTilemap.AUTO);
        mapName = mapNameInput;
        blockGroup = new FlxGroup();
        blockGroup.add(new Block(new Position(48, 48), new Position(240, 240), 0xff00ff, game));
        blockGroup.add(new Block(new Position(144, 48), new Position(336, 240), 0x00ffff, game));
        blockGroup.add(new Block(new Position(240, 48), new Position(432, 240), 0xffff00, game));
        blockGroup.add(new Block(new Position(336, 48), new Position(528, 240), 0x222222, game));
      }
    }
}
