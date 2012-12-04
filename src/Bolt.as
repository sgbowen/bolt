package
{
    import org.flixel.*;
    [SWF(width="768", height="720", backgroundColor="#000000")]

    public class Bolt extends FlxGame
    {
        public function Bolt()
        {
            super(768, 720, MenuState, 1, 60, 30, true);
        }
    }

}
