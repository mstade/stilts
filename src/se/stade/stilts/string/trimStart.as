package se.stade.stilts.string
{
    public function trimStart(value:String):String
    {
        return value.replace(/^\s+/, "");
    }
}
