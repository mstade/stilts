package se.stade.stilts.string.formatting
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import se.stade.daffodil.define;

	public class StringFormatter implements Formatter
	{
		public function StringFormatter(formatters:Vector.<TypeFormatter>)
		{
			for each (var formatter:TypeFormatter in formatters)
			{
				setTypeFormatter(formatter);
			}
		}
		
		private var typeFormatters:Dictionary = new Dictionary();
		
		public function setTypeFormatter(formatter:TypeFormatter):void
		{
			for each (var type:Class in formatter.types)
			{
				typeFormatters[type] = formatter;
			}
		}
		
		public function format(template:String, ... substitutions):String
		{
			var subs:Object = substitutions;
			
			if (substitutions.length == 1 && getQualifiedClassName(substitutions[0]) == "Object")
				subs = substitutions[0];
			
			for (var token:String in subs)
			{
				var pattern:RegExp = new RegExp("\\{token(?::([^\\}]+))?\\}".replace("token", token), "g");
				var match:Object;
				
				while (match = pattern.exec(template))
				{
					var parameters:String = match[1];
					var start:String = template.slice(0, match.index);
					var end:String = template.slice(match.index + match[0].length);
					
					var substitute:* = subs[token];
					var typeFormatter:TypeFormatter = typeFormatters[define(substitute)];
					
					var substitution:String = typeFormatter ? typeFormatter.format(substitute, parameters) : substitute.toString();
					
					template = start + substitution + end;
				}
			}
			
			return template;
		}
	}
}