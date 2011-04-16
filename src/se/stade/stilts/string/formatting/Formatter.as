package se.stade.stilts.string.formatting
{
	public interface Formatter
	{
		function format(template:String, ... substitutions):String;
	}
}