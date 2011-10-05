package se.stade.stilts.string
{
    public function trimEnd(value:String):String
    {
        return value.replace(/\s+$/, "");
    }
}
