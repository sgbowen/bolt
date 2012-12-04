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
        private var credits_button:FlxButton;
        private var title:FlxSprite;
        private var bg:BackDrop;

        override public function create():void {

            bg = new BackDrop(0, 0, backdrop_img);
            add(bg);

            play_button = new FlxButton(250, 400, "Play!", this.start_game);
            play_button.loadGraphic(button_img);
            play_button.label.setFormat(null, 24, 0x333333, "center");
            play_button.labelOffset = new FlxPoint(0,34);
            add(play_button);

            credits_button = new FlxButton(400, 400, "Credits", this.show_credits);
            credits_button.loadGraphic(button_img);
            credits_button.label.setFormat(null, 16, 0x333333, "center");
            credits_button.labelOffset = new FlxPoint(0,38);
            add(credits_button);

            title = new FlxSprite(0, 100);
            title.loadGraphic(title_img);
            add(title);
        }

        public function start_game():void {
            FlxG.switchState(new PlayState);
        }
        public function show_credits():void {
            FlxG.switchState(new CreditsState);
        }
    }
}
