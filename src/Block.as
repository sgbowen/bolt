package 
{
    import org.flixel.FlxG;
    import org.flixel.FlxSprite;

    public class Block extends FlxSprite
    {
        private static const WIDTH:uint = 32;
        private static const SPEED:int = 150;

        private var isSelected:Boolean;

        public function Block(x:uint, y:uint, selected:Boolean = false) {
            super(x, y);
            makeGraphic(WIDTH, WIDTH, 0xff00ff00);
            isSelected = selected;
        }

        override public function update():void {
            super.update();
            handleInput();
        }

        public function handleInput():void {
            if ((FlxG.keys.LEFT || FlxG.keys.A) && this.x > 1
                && this.velocity.y == 0) {
                this.velocity.x = -SPEED;
            } 
            else if ((FlxG.keys.RIGHT || FlxG.keys.D) && this.x < 640 - this.width
                && this.velocity.y == 0) {
                this.velocity.x = SPEED;
            } 
            else if ((FlxG.keys.DOWN || FlxG.keys.S) && this.y < 480 - this.height
                && this.velocity.x == 0) {
                this.velocity.y = SPEED;
            } 
            else if ((FlxG.keys.UP || FlxG.keys.W) && this.y > 1
                && this.velocity.x == 0) {
                this.velocity.y = -SPEED;
            } else {
                stopMoving();
            }
        }

        public function stopMoving():void {
            this.velocity.x = 0;
            this.velocity.y = 0;
        }


    }
}
