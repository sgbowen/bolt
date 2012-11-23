package
{
    import org.flixel.FlxButton

    public class Play extends FlxButton
    {

        private var game:PlayState;
        public var isSelected:Boolean;

        public function Play (x:uint, y:uint, game:PlayState) {
            super(x, y);
            this.game = game;
            onDown = onClick;
            isSelected = false;
            makeGraphic(48, 48, 0xff00ff00);
        }

        public function onClick():void {
            if (!isSelected) {
                isSelected = true;
                makeGraphic(48, 48, 0xffff0000);
                game.playBlocks();
            } 
        }

        public function deselect():void {
            if (isSelected) {
                makeGraphic(48, 48, 0xff00ff00);
                isSelected = false;
            }
        }

    }
}
