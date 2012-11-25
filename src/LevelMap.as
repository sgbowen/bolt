package
{
    import org.flixel.*;
    import flash.utils.*;

    public class LevelMap extends FlxTilemap
    {
      public function LevelMap(mapTitle:String) {
        super();
        var mapString:String = FlxTilemap.bitmapToCSV();
      }
    }
}
