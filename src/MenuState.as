package
{
    import org.flixel.*;
    import flash.utils.*;

    public class MenuState extends FlxState
    {
        [Embed(source = "../art/bg-scaled.png")] protected var backdrop_img:Class;
        [Embed(source = "../art/BoltTitle1.png")] protected var title_img:Class;
        [Embed(source = "../art/Button.png")] protected var button_img:Class;

        private var play_button:FlxButton;
        private var title:FlxSprite;
        private var bg:BackDrop;

        override public function create():void {

            bg = new BackDrop(0, 0, backdrop_img);
            add(bg);

            play_button = new FlxButton(300, 300, "Play!", this.start_game);
            play_button.label.setFormat(null, 8, 0x333333, "center");
            play_button.loadGraphic(button_img);
            add(play_button);

            title = new FlxSprite(0, 0);
            title.loadGraphic(title_img);
            add(title);
        }

        public function start_game():void {
            FlxG.switchState(new PlayState);
        }
    }
}
