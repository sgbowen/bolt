package
{
    import org.flixel.FlxText;
    import org.flixel.FlxSprite;

    public class Counter extends FlxSprite
    {

        [Embed(source = "../art/counter.png")] protected var counter_img:Class;

        private static const WIDTH:int = 48;
        private static const text_size:int = 16;

        private var initial_count:int;
        public var txt:FlxText;

        public function Counter (x:uint, y:uint, count:int) {
            super(x, y);
            txt = new FlxText(x + 12, y + 12, WIDTH, String(count));
            txt.size = text_size;
            initial_count = count;
            loadGraphic(counter_img);
        }

        public function decrement():void {
            if (!out()) {
                var msg_int:int = int(txt.text);
                txt.text = String(msg_int - 1);
            }
        }

        public function out():Boolean {
            var msg_int:int = int(txt.text);
            return (msg_int == 0);
        }

        public function reset_count():void {
            txt.text = String(initial_count);
        }

    }
}
