package
{
    import org.flixel.*;
    import flash.utils.*;

    public class LevelMap extends FlxTilemap
    {
      private var wid:int;
      private var hei:int;
      private var blockGroup:FlxGroup; 
      public function LevelMap(mapTitle:String) {
        super();
        //hardcode a demo level
        arrayData = new Array(1,1,1,1,1,1,1,1,1,1,1,
                              1,0,0,0,1,0,0,0,0,0,1,
                              1,0,0,0,1,0,0,0,0,0,1,
                              1,0,0,0,1,0,0,0,0,0,1,
                              1,0,0,0,0,0,0,0,0,0,1,
                              1,0,0,0,1,1,1,1,1,0,1,
                              1,0,0,0,1,1,1,0,0,0,1,
                              1,0,0,0,1,1,1,0,0,0,1,
                              1,1,1,1,1,1,1,1,1,1,1);
        var mapString:String = FlxTilemap.bitmapToCSV("levels/demo.png");
        loadMap(mapString, FlxTilemap.ImgAuto,0,0,FlxTilemap.ImgAuto);
        blockGroup = new FlxGroup();
        blockGroup.add(new Block(new Position(48, 48), new Position(240, 240), 0xff00ff, this));
        blockGroup.add(new Block(new Position(144, 48), new Position(336, 240), 0x00ffff, this));
        blockGroup.add(new Block(new Position(240, 48), new Position(432, 240), 0xffff00, this));
        blockGroup.add(new Block(new Position(336, 48), new Position(528, 240), 0x222222, this));
      }
    }
}
