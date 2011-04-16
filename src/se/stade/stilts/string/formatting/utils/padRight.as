package se.stade.stilts.string.formatting.utils
{
	public function padRight(value:*, padding:String):String
	{
		return value + padding.slice(0, value.length);
	}
}