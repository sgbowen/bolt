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
        [Embed(source="../art/sprite-left-selected.png")] private var sprite_left_selected:Class;
        [Embed(source="../art/sprite-right-selected.png")] private var sprite_right_selected:Class;
        [Embed(source="../art/sprite-up-selected.png")] private var sprite_up_selected:Class;
        [Embed(source="../art/sprite-down-selected.png")] private var sprite_down_selected:Class;

        private static const SQUARE:int = 48;
        private static const GAME_WIDTH:int = 720;
        private static const GAME_HEIGHT:int = 720;

        private static const NO_MOVE:int = 0;
        private static const MOVE_LEFT:int = 1;
        private static const MOVE_RIGHT:int = 2;
        private static const MOVE_UP:int = 3;
        private static const MOVE_DOWN:int = 4;
        private static const MOVE_STALL:int = 5;

        public var isSelected:Boolean;
        private var game:PlayState = new PlayState();
        
        private var startPos:Position;
        public var destination:Destination;
        private var recorded_moves:ArrayList;

        public function Block(initial:Position, destination:Position, tint:uint, game:PlayState) {
            super(initial.x, initial.y);
            loadGraphic(sprite_down);
            isSelected = false;
            onDown = onClick;
            this.startPos = initial;
            this.game = game;
            this.destination = new Destination(destination, tint, this);
            this.color = tint;
            recorded_moves = new ArrayList();
        }

        override public function update():void {
            super.update();
            handleInput();
        }

        public function handleInput():void {
            if (isSelected && game.isRecording && !game.counter.out()) {
                var movedir:uint = processMovement();
                if (movedir > 0) {
                    recorded_moves.addItem(movedir);
                    game.counter.decrement();
                }
            }
        }
        
        public function processMovement():int {
                if ((FlxG.keys.justPressed("LEFT") 
                    || FlxG.keys.justPressed("A")) && this.x >= SQUARE) {
                    this.facing = FlxObject.LEFT;
                    loadGraphic(sprite_left_selected);
                    if(this.game.level.getTile(this.x/SQUARE-1, this.y/SQUARE) == 0) {
                    this.x -= SQUARE;
                    return MOVE_LEFT; }
                    else { return NO_MOVE; }
                } 
                else if ((FlxG.keys.justPressed("RIGHT") 
                    || FlxG.keys.justPressed("D")) 
                    && this.x <= GAME_WIDTH - 2 * SQUARE) {
                    this.facing = FlxObject.RIGHT;
                    loadGraphic(sprite_right_selected);
                    if(this.game.level.getTile(this.x/SQUARE+1, this.y/SQUARE) == 0) {
                    this.x += SQUARE;
                    return MOVE_RIGHT; }
                    else { return NO_MOVE; }
                } 
                else if ((FlxG.keys.justPressed("DOWN")
                    || FlxG.keys.justPressed("S")) 
                    && this.y <= GAME_HEIGHT - 2 * SQUARE) {
                    this.facing = FlxObject.DOWN;
                    loadGraphic(sprite_down_selected);
                    if(this.game.level.getTile(this.x/SQUARE, this.y/SQUARE+1) == 0) {
                    this.y += SQUARE;
                    return MOVE_DOWN; }
                    else { return NO_MOVE; }
                } 
                else if ((FlxG.keys.justPressed("UP")
                    || FlxG.keys.justPressed("W")) 
                    && this.y >= SQUARE) {
                    this.facing = FlxObject.UP;
                    loadGraphic(sprite_up_selected);
                    if(this.game.level.getTile(this.x/SQUARE, this.y/SQUARE-1) == 0) {
                    this.y -= SQUARE;
                    return MOVE_UP; }
                    else { return NO_MOVE; }
                }
                else if ((FlxG.keys.justPressed("SHIFT")
                    || FlxG.keys.justPressed("Q")) 
                    && this.y >= SQUARE) {
                    return MOVE_STALL;
                } else {
                    return NO_MOVE;
                }
        }


        public function onClick():void {
            resetPos();
            erase_recording();
            game.updateBlocks();
            isSelected = true;
            loadGraphic(sprite_down_selected);
        }

        public function resetPos():void {
            x = startPos.x;
            y = startPos.y;
            this.facing = FlxObject.DOWN;
        }

        public function step(time_step:int):void {
            if (time_step < recorded_moves.length) {
                var movedir:uint = uint(recorded_moves.getItemAt(time_step));
                if (movedir == 1 && this.game.level.getTile(this.x/SQUARE-1, this.y/SQUARE) == 0) { //left
                  x = x-SQUARE;
                  this.facing = FlxObject.LEFT;
                  loadGraphic(sprite_left_selected);
                }
                else if (movedir == 2 && this.game.level.getTile(this.x/SQUARE+1, this.y/SQUARE) == 0) { //right
                  x = x+SQUARE;
                  this.facing = FlxObject.RIGHT;
                  loadGraphic(sprite_right_selected);
                }
                else if (movedir == 3 && this.game.level.getTile(this.x/SQUARE, this.y/SQUARE-1) == 0) { //up
                  y = y-SQUARE;
                  this.facing = FlxObject.UP;
                  loadGraphic(sprite_up_selected);
                }
                else if (movedir == 4 && this.game.level.getTile(this.x/SQUARE, this.y/SQUARE+1) == 0) { //down
                  y = y+SQUARE;
                  this.facing = FlxObject.DOWN;
                  loadGraphic(sprite_down_selected);
                }
                else if (movedir == 5) { //stall
                }
                else {
                }
            }
        }
        
        public function getNewPos(time_step:int):Position {
            if (time_step < recorded_moves.length) {
                var movedir:uint = uint(recorded_moves.getItemAt(time_step));
                if (movedir == 1 && this.game.level.getTile(this.x/SQUARE-1, this.y/SQUARE) == 0) { //left
                  var posnew:Position = new Position(x-SQUARE, y);
                  return posnew;
                }
                else if (movedir == 2 && this.game.level.getTile(this.x/SQUARE+1, this.y/SQUARE) == 0) { //right
                  var posnew2:Position = new Position(x+SQUARE, y);
                  return posnew2;
                }
                else if (movedir == 3 && this.game.level.getTile(this.x/SQUARE, this.y/SQUARE-1) == 0) { //up
                  var posnew3:Position = new Position(x, y-SQUARE);
                  return posnew3;
                }
                else if (movedir == 4 && this.game.level.getTile(this.x/SQUARE, this.y/SQUARE+1) == 0) { //down
                  var posnew4:Position = new Position(x, y+SQUARE);
                  return posnew4;
                }
                else { //stall
                  var posnew5:Position = new Position(x, y);
                  return posnew5;
                }
            }
            var def:Position = new Position(x, y);
            return def;
        }
        
        public function erase_recording():void {
            recorded_moves = new ArrayList();
        }

    }
}
