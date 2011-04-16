package se.stade.stilts.string.formatting
{
	public interface TypeFormatter
	{
		function get types():Vector.<Class>;
		function format(subject:*, parameters:String):String;
	}
}