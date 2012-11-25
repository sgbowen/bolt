package
{
    import org.flixel.FlxButton

    public class Play extends FlxButton
    {

        [Embed(source="../art/play-button-unpressed.png")] private var play_button_unpressed:Class;
        [Embed(source="../art/play-button-pressed.png")] private var play_button_pressed:Class;

        private var game:PlayState;
        public var isSelected:Boolean;

        public function Play (x:uint, y:uint, game:PlayState) {
            super(x, y);
            this.game = game;
            onDown = onClick;
            isSelected = false;
            loadGraphic(play_button_unpressed);
        }

        public function onClick():void {
            if (!isSelected) {
                isSelected = true;
                loadGraphic(play_button_pressed);
                game.playBlocks();
            } 
        }

        public function deselect():void {
            if (isSelected) {
                loadGraphic(play_button_unpressed);
                isSelected = false;
            }
        }

    }
}
