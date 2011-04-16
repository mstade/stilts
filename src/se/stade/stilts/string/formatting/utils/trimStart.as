package se.stade.stilts.string.formatting.utils
{
	public function trimStart(value:String):String
	{
		return value.replace(/^\s+/, "");
	}
}