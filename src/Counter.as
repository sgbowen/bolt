package
{
    import org.flixel.FlxText;

    public class Counter extends FlxText
    {

        private static const WIDTH:int = 48;
        private static const text_size:int = 16;

        private var initial_count:int;

        public function Counter (x:uint, y:uint, count:int) {
            super(x, y, WIDTH, String(count));
            size = text_size;
            initial_count = count;
        }

        public function decrement():void {
            if (!out()) {
                var msg_int:int = int(text);
                text = String(msg_int - 1);
            }
        }

        public function out():Boolean {
            var msg_int:int = int(text);
            return (msg_int == 0);
        }

        public function reset_count():void {
            text = String(initial_count);
        }

    }
}
