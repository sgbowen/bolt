package
{
    import org.flixel.*;

    public class PlayState extends FlxState
    {
        override public function create():void
        {
            add(new FlxText(0, 0, 100, "Hello, World!"));
            add(new Block(50, 125, true));
        }
    }
}
