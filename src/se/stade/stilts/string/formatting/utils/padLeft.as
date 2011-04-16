package se.stade.stilts.string.formatting.utils
{
	public function padLeft(padding:String, value:*):String
	{
		return padding.slice(0, value.length) + value;
	}
}