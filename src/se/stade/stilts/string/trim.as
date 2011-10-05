package se.stade.stilts.string
{
    public function trim(value:String):String
    {
        return value.replace(/^\s+|\s+$/g, "");
    }
}
