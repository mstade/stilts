package se.stade.stilts.string.formatting
{
	public class RegExpFormatter implements TypeFormatter
	{
		public function get types():Vector.<Class>
		{
			return new <Class>[RegExp];
		}
		
		public function format(subject:*, parameters:String):String
		{
			return subject.source;
		}
	}
}