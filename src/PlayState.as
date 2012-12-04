package
{
    import org.flixel.*;
    import flash.utils.*;

    public class PlayState extends FlxState
    {

        [Embed(source = "../art/bg-scaled.png")] protected var backdrop_img:Class;

        public var level:LevelMap;
        //public var blockGroup:FlxGroup;
        private var bg:BackDrop;
        public var isRecording:Boolean;
        public var isPlaying:Boolean;
        private var play_button:PlayButton;
        private var record_button:Record;
        private var time_steps:int;
        private var cur_time_step:int;
        public var counter:Counter;
        public var levelNames:Array;
        public var levelCurrent:uint;

        private const TILE_LENGTH:uint = 50;

        override public function create():void
        {
            isRecording = false;
            isPlaying = false;
            time_steps = 15;
            levelCurrent = 0;
            levelNames = new Array("demo","tiles1","time","default");

            bg = new BackDrop(0, 0, backdrop_img);
            add(bg);

            level = new LevelMap(levelNames[levelCurrent], this);
            time_steps = level.mapTime;
            //level.draw();
            add(level);
            
            //blockGroup = new FlxGroup();
            //blockGroup.add(new Block(new Position(48, 48), new Position(240, 240), 0xff00ff, this));
            //blockGroup.add(new Block(new Position(144, 48), new Position(336, 240), 0x00ffff, this));
            //blockGroup.add(new Block(new Position(240, 48), new Position(432, 240), 0xffff00, this));
            //blockGroup.add(new Block(new Position(336, 48), new Position(528, 240), 0x222222, this));
            //add(new FlxText(0, 0, 100, "Hello, World!"));

            for each (var block:Block in level.blockGroup.members) {
                add(block.destination);
            }

            add(level.blockGroup);

           
            record_button = new Record(720, 48, this);
            add(record_button);
            add(play_button = new PlayButton(720, 96, this));
            add(counter = new Counter(720, 0, time_steps));
        }

        public function updateBlocks():void {
            for each(var block:Block in level.blockGroup.members)
                block.isSelected = false;
        }

        public function resetBlocks():void {
            for each(var block:Block in level.blockGroup.members)
                block.resetPos();
        }

        public function playBlocks():void {
            isPlaying = true;
            cur_time_step = 0;

            setTimeout(timerHandler, 250);

        }

        public function stepBlocks(time_step:int):Boolean { //modify this
            var steps_left:Boolean = false;
            for each (var block:Block in level.blockGroup.members) {
              for each (var other:Block in level.blockGroup.members)
              {
                var blockPos:Position = block.getNewPos(cur_time_step);
                var otherPos:Position = other.getNewPos(cur_time_step);
                if (block != other && (blockPos.x == other.x && blockPos.y == other.y) && (block.x == otherPos.x && block.y == otherPos.y))
                { 
                    collide(block, other);
                    return false;
                }
              }
              if (block.step(cur_time_step) && !steps_left) {
                  steps_left = true;
              } 
            }
            return steps_left;
        }

        public function timerHandler():void {
            if (!stepBlocks(cur_time_step)) {
                if (checkWin()) {
                    add(new FlxText(0, 0, 100, "You won!  Loading next level..."));
                    setTimeout(levelUp, 2000);
                }
                resetBlocks();
                play_button.deselect();
                isPlaying = false;
                return;
            }
            if (checkWin()) {
                var tex:FlxText;
                tex = new FlxText(0, FlxG.height/2-100, FlxG.width, "You won!!!\nYou are truly a master of puzzling.");
                tex.size = 32;
                tex.alignment = "center";
                add(tex);
            } else if (!checkBlockOverlap()) {
                if (cur_time_step < time_steps) {
                    cur_time_step++;
                    setTimeout(timerHandler, 250);
                    return;
                }
            }
            resetBlocks();
            play_button.deselect();
            isPlaying = false;
        }

        public function collide(block:Block, other:Block):void {
                block.highlightTemp(0xffff0000);
                other.highlightTemp(0xffff0000);
                setTimeout(detectedCollision, 500);
        }

        public function detectedCollision():void {
            resetBlocks();
            for each (var block:Block in level.blockGroup.members) {
                block.resetColor();
            }
        }

        public function checkBlockOverlap():Boolean {
            for each (var block:Block in level.blockGroup.members) {
                for each (var other:Block in level.blockGroup.members) {
                    if (block != other && block.overlaps(other)) {
                        collide(block, other);
                        return true;
                    }
                }
            }

            return false;
        }

        public function checkWin():Boolean {
            for each (var block:Block in level.blockGroup.members) {
                if (!block.destination.hit) {
                    return false;
                }
            }

            return true;
        }

        public function levelUp():Boolean {
           clear();
           levelCurrent++;
           add(bg);
            
            if(levelCurrent >= levelNames.length) {
                return false; }
            level = new LevelMap(levelNames[levelCurrent], this);
            time_steps = level.mapTime;
            //level.draw();
            add(level);
            
            for each (var block:Block in level.blockGroup.members) {
                add(block.destination);
            }
            add(level.blockGroup);
           
            record_button = new Record(720, 48, this);
            add(record_button);
            add(play_button = new PlayButton(720, 96, this));
            add(counter = new Counter(720, 0, time_steps));
            return true;
        }
    }
}
