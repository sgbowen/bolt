package
{
    import org.flixel.*;
    import flash.utils.*;

    public class CreditsState extends FlxState
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

            var tex:FlxText = new FlxText(0, FlxG.height/2-135, FlxG.width, "Credits\n\nSusie Bowen\nRhiannon Malia\nRoberto Valle\nShannon Williams");
            tex.size = 32;
            tex.alignment = "center";
            add(tex)

            play_button = new FlxButton(300, 500, "Menu", this.show_main);
            play_button.loadGraphic(button_img);
            play_button.label.setFormat(null, 20, 0x333333, "center");
            play_button.labelOffset = new FlxPoint(0,34);
            add(play_button);

        }

        public function show_main():void {
            FlxG.switchState(new MenuState);
        }
    }
}
