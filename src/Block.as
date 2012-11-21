package 
{
    import org.flixel.FlxG;
    import org.flixel.FlxSprite;
    import org.flixel.FlxButton;
    import org.flixel.FlxState;
    import org.flixel.FlxObject;

    public class Block extends FlxButton
    {

        [Embed(source="../art/sprite-left.png")] private var sprite_left:Class;
        [Embed(source="../art/sprite-right.png")] private var sprite_right:Class;
        [Embed(source="../art/sprite-up.png")] private var sprite_up:Class;
        [Embed(source="../art/sprite-down.png")] private var sprite_down:Class;

        private static const WIDTH:uint = 32;
        private static const SPEED:int = 150;
        private static const SQUARE:int = 48;
        private static const GAME_WIDTH:int = 640;
        private static const GAME_HEIGHT:int = 640;

        public var isSelected:Boolean;
        private var game:PlayState = new PlayState();

        public function Block(x:uint, y:uint, game:PlayState) {
            super(x, y);
            loadGraphic(sprite_down);
            isSelected = true;
            onDown = onClick;
            this.game = game;
        }

        override public function update():void {
            super.update();
            handleInput();
        }

        public function handleInput():void {
            if (isSelected) {
                if ((FlxG.keys.justPressed("LEFT") 
                    || FlxG.keys.justPressed("A")) && this.x > SQUARE) {
                    this.x -= SQUARE;
                    this.facing = FlxObject.LEFT;
                    loadGraphic(sprite_left);
                } 
                else if ((FlxG.keys.justPressed("RIGHT") 
                    || FlxG.keys.justPressed("D")) 
                    && this.x < GAME_WIDTH - SQUARE) {
                    this.x += SQUARE;
                    this.facing = FlxObject.RIGHT;
                    loadGraphic(sprite_right);
                } 
                else if ((FlxG.keys.justPressed("DOWN")
                    || FlxG.keys.justPressed("S")) 
                    && this.y < GAME_HEIGHT - SQUARE) {
                    this.y += SQUARE;
                    this.facing = FlxObject.DOWN;
                    loadGraphic(sprite_down);
                } 
                else if ((FlxG.keys.justPressed("UP")
                    || FlxG.keys.justPressed("W")) 
                    && this.y > SQUARE) {
                    this.y -= SQUARE;
                    this.facing = FlxObject.UP;
                    loadGraphic(sprite_up);
                } else {
                }
            }
        }

        public function onClick():void {
            if (isSelected)
                isSelected = false;
            else {
                game.updateBlocks();
                isSelected = true;
            }
        }

    }
}
