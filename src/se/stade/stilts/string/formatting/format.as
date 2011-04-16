package se.stade.stilts.string.formatting
{
	public function format(template:String, ... substitutions):String
	{
		return formatter.format.apply(null, [template].concat(substitutions));
	}
}
import se.stade.stilts.string.formatting.Formatter;
import se.stade.stilts.string.formatting.RegExpFormatter;
import se.stade.stilts.string.formatting.StringFormatter;
import se.stade.stilts.string.formatting.TypeFormatter;
import se.stade.stilts.string.formatting.dates.SimpleDateFormatter;


const formatter:Formatter = new StringFormatter(new <TypeFormatter>
	[
		new SimpleDateFormatter,
		new RegExpFormatter
	]);