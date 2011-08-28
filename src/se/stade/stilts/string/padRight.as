package se.stade.stilts.string
{
	public function padRight(value:*, padding:String):String
	{
		return value + padding.slice(0, value.length);
	}
}