package
{
    import org.flixel.*;
    import flash.utils.*;

    public class PlayState extends FlxState
    {

        [Embed(source = "../art/bg-scaled.png")] protected var backdrop_img:Class;

        public var blockGroup:FlxGroup;
        private var bg:BackDrop;
        public var isRecording:Boolean;
        public var isPlaying:Boolean;
        private var play_button:Play;
        private var record_button:Record;
        private var time_steps:int;
        private var cur_time_step:int;
        public var counter:Counter;

        override public function create():void
        {
            isRecording = false;
            isPlaying = false;
            time_steps = 10;

            bg = new BackDrop(0, 0, backdrop_img);
            add(bg);
            
            blockGroup = new FlxGroup();
            blockGroup.add(new Block(new Position(48, 48), new Position(240, 240), this));
            blockGroup.add(new Block(new Position(144, 48), new Position(336, 240), this));

            //add(new FlxText(0, 0, 100, "Hello, World!"));

            for each (var block:Block in blockGroup.members) {
                add(block.destination);
            }

            add(blockGroup);

            add(record_button = new Record(624, 672, this));
            add(play_button = new Play(672, 672, this));
            add(counter = new Counter(576, 672, time_steps));
            //add(new Block(50, 125, true));
            //add(new Block(125, 50, false));
        }

        public function updateBlocks():void {
            for each(var block:Block in blockGroup.members)
                block.isSelected = false;
        }

        public function resetBlocks():void {
            for each(var block:Block in blockGroup.members)
                block.resetPos();
        }

        public function playBlocks():void {
            isPlaying = true;
            cur_time_step = 0;

            setTimeout(timerHandler, 250);

            play_button.deselect();
            isPlaying = false;
        }

        public function stepBlocks(time_step:int):void {
            for each (var block:Block in blockGroup.members)
                    block.step(cur_time_step);
        }

        public function timerHandler():void {
            stepBlocks(cur_time_step);
            if (checkWin()) {
                add(new FlxText(0, 0, 100, "You win!"));
            } else if (!checkBlockOverlap()) {
                if (cur_time_step < time_steps - 1) {
                    cur_time_step++;
                    setTimeout(timerHandler, 250);
                }
            }
        }

        public function checkBlockOverlap():Boolean {
            for each (var block:Block in blockGroup.members) {
                for each (var other:Block in blockGroup.members) {
                    if (block != other && block.overlaps(other)) {
                        resetBlocks();
                        return true;
                    }
                }
            }

            return false;
        }

        public function checkWin():Boolean {
            for each (var block:Block in blockGroup.members) {
                if (!block.destination.hit) {
                    return false;
                }
            }

            return true;
        }
    }
}
