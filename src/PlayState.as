package
{
    import org.flixel.*;

    public class PlayState extends FlxState
    {

        [Embed(source = "../art/bg-scaled.png")] protected var backdrop_img:Class;

        public var blockGroup:FlxGroup;
        private var bg:BackDrop;

        override public function create():void
        {
            bg = new BackDrop(0, 0, backdrop_img);
            add(bg);
            
            blockGroup = new FlxGroup();
            blockGroup.add(new Block(48, 48, this));
            //blockGroup.add(new Block(125, 50, this));
            //add(new FlxText(0, 0, 100, "Hello, World!"));
            add(blockGroup);
            //add(new Block(50, 125, true));
            //add(new Block(125, 50, false));
        }

        public function updateBlocks():void {
            for each(var block:Block in blockGroup) 
                block.isSelected = false;
        }
    }
}
