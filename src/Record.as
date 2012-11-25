package
{
    import org.flixel.FlxButton

    public class Record extends FlxButton
    {

        [Embed(source="../art/record-button-unpressed.png")] private var record_button_unpressed:Class;
        [Embed(source="../art/record-button-pressed.png")] private var record_button_pressed:Class;

        private var game:PlayState;
        public var isSelected:Boolean;

        public function Record (x:uint, y:uint, game:PlayState) {
            super(x, y);
            this.game = game;
            onDown = onClick;
            isSelected = false;
            loadGraphic(record_button_unpressed);
        }

        public function onClick():void {
            if (!isSelected && !(game.isPlaying)) {
                isSelected = true;
                game.isRecording = true;
                game.counter.reset_count();
                loadGraphic(record_button_pressed);
            } else {
                isSelected = false;
                game.isRecording = false;
                game.updateBlocks();
                game.resetBlocks();
                loadGraphic(record_button_unpressed);
            }
        }

    }
}
