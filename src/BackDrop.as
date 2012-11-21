package
{
    import org.flixel.FlxSprite;

    public class BackDrop extends FlxSprite
    {

        public function BackDrop(x:uint, y:uint, img:Class) {
            super(x, y);
            loadGraphic(img);
        }

    }
}
