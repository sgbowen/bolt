package 
{
    import org.flixel.FlxG;
    import org.flixel.FlxSprite;
    import org.flixel.FlxButton;
    import org.flixel.FlxState;
    import org.flixel.FlxObject;
    import mx.collections.*;

    public class Block extends FlxButton
    {

        [Embed(source="../art/sprite-left.png")] private var sprite_left:Class;
        [Embed(source="../art/sprite-right.png")] private var sprite_right:Class;
        [Embed(source="../art/sprite-up.png")] private var sprite_up:Class;
        [Embed(source="../art/sprite-down.png")] private var sprite_down:Class;

        private static const WIDTH:uint = 32;
        private static const SPEED:int = 150;
        private static const SQUARE:int = 48;
        private static const GAME_WIDTH:int = 720;
        private static const GAME_HEIGHT:int = 720;

        public var isSelected:Boolean;
        private var game:PlayState = new PlayState();
        
        private var startx:uint;
        private var starty:uint;
        private var recorded_moves:ArrayList;

        public function Block(x:uint, y:uint, game:PlayState) {
            super(x, y);
            loadGraphic(sprite_down);
            isSelected = false;
            onDown = onClick;
            startx = x;
            starty = y;
            this.game = game;
            recorded_moves = new ArrayList();
        }

        override public function update():void {
            super.update();
            handleInput();
        }

        public function handleInput():void {
            if (isSelected && game.isRecording) {
                if ((FlxG.keys.justPressed("LEFT") 
                    || FlxG.keys.justPressed("A")) && this.x >= SQUARE) {
                    this.x -= SQUARE;
                    this.facing = FlxObject.LEFT;
                    loadGraphic(sprite_left);
                    recorded_moves.addItem(new Position(x, y));
                } 
                else if ((FlxG.keys.justPressed("RIGHT") 
                    || FlxG.keys.justPressed("D")) 
                    && this.x <= GAME_WIDTH - 2 * SQUARE) {
                    this.x += SQUARE;
                    this.facing = FlxObject.RIGHT;
                    loadGraphic(sprite_right);
                    recorded_moves.addItem(new Position(x, y));
                } 
                else if ((FlxG.keys.justPressed("DOWN")
                    || FlxG.keys.justPressed("S")) 
                    && this.y <= GAME_HEIGHT - 2 * SQUARE) {
                    this.y += SQUARE;
                    this.facing = FlxObject.DOWN;
                    loadGraphic(sprite_down);
                    recorded_moves.addItem(new Position(x, y));
                } 
                else if ((FlxG.keys.justPressed("UP")
                    || FlxG.keys.justPressed("W")) 
                    && this.y >= SQUARE) {
                    this.y -= SQUARE;
                    this.facing = FlxObject.UP;
                    loadGraphic(sprite_up);
                    recorded_moves.addItem(new Position(x, y));
                } 
            }
        }

        public function onClick():void {
            game.updateBlocks();
            isSelected = true;
        }

        public function resetPos():void {
            x = startx;
            y = starty;
            facing = FlxObject.DOWN;
        }

        public function step(time_step:int):void {
            if (time_step < recorded_moves.length) {
                var pos:Position = Position(recorded_moves.getItemAt(time_step));
                x = pos.x;
                y = pos.y;
            }
        }

    }
}
