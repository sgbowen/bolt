package
{
    import org.flixel.FlxSprite

    public class Destination extends FlxSprite
    {

        [Embed(source="../art/DestinationButtonUnselected.png")] 
            private var img_unselected:Class;
        [Embed(source="../art/DestinationButtonSelected.png")] 
            private var img_selected:Class;

        private var block:Block;
        public var hit:Boolean;

        public function Destination (initial:Position, tint:uint, block:Block) {
            super(initial.x, initial.y);
            this.block = block;
            this.hit = false;
            this.color = tint;
            loadGraphic(img_unselected);
        }

        override public function update():void {
            super.update();
            if (this.overlaps(block) && !hit) {
                hit = true;
                loadGraphic(img_selected);
            } else if (!this.overlaps(block) && hit) {
                hit = false;
                loadGraphic(img_unselected);
            }
        }
    }
}
