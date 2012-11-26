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
            blockGroup.add(new Block(new Position(48, 48), new Position(240, 240), 0xff00ff, this));
            blockGroup.add(new Block(new Position(144, 48), new Position(336, 240), 0x00ffff, this));
            blockGroup.add(new Block(new Position(240, 48), new Position(432, 240), 0xffff00, this));
            blockGroup.add(new Block(new Position(336, 48), new Position(528, 240), 0x222222, this));

            for each (var block:Block in blockGroup.members) {
                add(block.destination);
            }

            add(blockGroup);

            add(record_button = new Record(720, 48, this));
            add(play_button = new Play(720, 96, this));
            add(counter = new Counter(720, 0, time_steps));
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
                if (cur_time_step < time_steps) {
                    cur_time_step++;
                    setTimeout(timerHandler, 250);
                    return;
                }
            }
            play_button.deselect();
            isPlaying = false;
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
