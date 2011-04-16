package se.stade.stilts.string.formatting.utils
{
	public function trim(value:String):String
	{
		return value.replace(/^\s+|\s+$/g, "");
	}
}