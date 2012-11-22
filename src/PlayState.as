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

        override public function create():void
        {
            isRecording = false;
            isPlaying = false;
            time_steps = 10;

            bg = new BackDrop(0, 0, backdrop_img);
            add(bg);
            
            blockGroup = new FlxGroup();
            blockGroup.add(new Block(48, 48, this));
            blockGroup.add(new Block(125, 50, this));

            //add(new FlxText(0, 0, 100, "Hello, World!"));
            add(blockGroup);
            add(record_button = new Record(624, 672, this));
            add(play_button = new Play(672, 672, this));
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
            if (cur_time_step < time_steps) {
                cur_time_step++;
                setTimeout(timerHandler, 250);
            }
        }
    }
}
