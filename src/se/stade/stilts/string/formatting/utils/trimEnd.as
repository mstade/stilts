package se.stade.stilts.string.formatting.utils
{
	public function trimEnd(value:String):String
	{
		return value.replace(/\s+$/, "");
	}
}