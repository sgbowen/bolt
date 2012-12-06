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
            levelNames = new Array("default","demo","tiles1","time","time","time");

            bg = new BackDrop(0, 0, backdrop_img);
            add(bg);

            level = new LevelMap(levelNames[levelCurrent], this);
            time_steps = level.mapTime;
            add(level);
            
            for each (var block:Block in level.blockGroup.members) {
                add(block.destination);
            }

            add(level.blockGroup);
            
            var label:FlxText;
            label = new FlxText(10, FlxG.height-50, FlxG.width, level.mapName);
            label.size = 32;
            add(label);
           
            record_button = new Record(720, 48, this);
            add(record_button);
            add(play_button = new PlayButton(720, 96, this));
            add(counter = new Counter(720, 0, time_steps));
            add(counter.txt);
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

        public function stepBlocks(time_step:int):int { //modify this
            var steps_left:Boolean = false;
            for each (var block:Block in level.blockGroup.members) {
              for each (var other:Block in level.blockGroup.members)
              {
                var blockPos:Position = block.getNewPos(cur_time_step);
                var otherPos:Position = other.getNewPos(cur_time_step);
                if (block != other && (blockPos.x == other.x && blockPos.y == other.y) && (block.x == otherPos.x && block.y == otherPos.y))
                { 
                    collide(block, other);
                    return -1;
                }
              }
              if (block.step(cur_time_step) && !steps_left) {
                  steps_left = true;
              } 
            }
            if (steps_left)
                return 1;
            else
                return 0;
        }

        public function timerHandler():void {
            if (stepBlocks(cur_time_step) < 0) {
                play_button.deselect();
                isPlaying = false;
                return;
            }
            if (checkWin()) {
                add(new FlxText(0, 0, 100, "You won!  Loading next level..."));
                /*var label:FlxText;
                label = new FlxText(10, 10, FlxG.width, "You won!  Loading next level...");
                label.size = 32;
                add(label);*/

                play_button.deselect();
                isPlaying = false;
                setTimeout(levelUp, 2000);
                return;
            }

            /*if (checkWin()) {
                var tex:FlxText;
                tex = new FlxText(0, FlxG.height/2-100, FlxG.width, "You won!!!\nYou are truly a master of puzzling.");
                tex.size = 32;
                tex.alignment = "center";
                add(tex);
            }*/
            if (!checkBlockOverlap()) {
                if (cur_time_step < time_steps) {
                    cur_time_step++;
                    setTimeout(timerHandler, 250);
                    return;
                }
            } else {
                play_button.deselect();
                isPlaying = false;
            }
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
                var tex:FlxText;
                tex = new FlxText(0, FlxG.height/2-100, FlxG.width, "You won!!!\nYou are truly a master of puzzling.");
                tex.size = 32;
                tex.alignment = "center";
                add(tex);
                return false; }
            level = new LevelMap(levelNames[levelCurrent], this);
            time_steps = level.mapTime;
            add(level);
            
            for each (var block:Block in level.blockGroup.members) {
                add(block.destination);
            }
            add(level.blockGroup);
            
            var label:FlxText;
            label = new FlxText(10, FlxG.height-50, FlxG.width, level.mapName);
            label.size = 32;
            add(label);
           
            record_button = new Record(720, 48, this);
            add(record_button);
            add(play_button = new PlayButton(720, 96, this));
            add(counter = new Counter(720, 0, time_steps));
            add(counter.txt);
            return true;
        }
    }
}
