package
{
    import org.flixel.FlxButton

    public class Record extends FlxButton
    {

        private var game:PlayState;
        public var isSelected:Boolean;

        public function Record (x:uint, y:uint, game:PlayState) {
            super(x, y);
            this.game = game;
            onDown = onClick;
            isSelected = false;
            makeGraphic(48, 48, 0xff00ff00);
        }

        public function onClick():void {
            if (!isSelected && !(game.isPlaying)) {
                isSelected = true;
                game.isRecording = true;
                makeGraphic(48, 48, 0xffff0000);
            } else {
                isSelected = false;
                game.isRecording = false;
                game.resetBlocks();
                makeGraphic(48, 48, 0xff00ff00);
            }
        }

    }
}
