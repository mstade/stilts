package se.stade.stilts.string.formatting.dates
{
	import se.stade.stilts.errors.NotImplementedError;
	import se.stade.stilts.string.formatting.TypeFormatter;
	
	public class NumberFormatter implements TypeFormatter
	{
		public function get types():Vector.<Class>
		{
			return new <Class>[Number];
		}
		
		
		public function getDecimals(subject:Number, parameters:String):String
		{
			var decimalCount:String = parameters.split(".", 2)[1] || "";
			return subject.toFixed(Math.max(decimalCount.length, 20));
		}
		
		public function formatWhole(subject:Number, parameters:String):String
		{
			throw new NotImplementedError;
		}
		
		public function formatExponential(subject:Number, parameters:String):String
		{
			throw new NotImplementedError;
		}
		
		public function formatFixed(subject:Number, parameters:String):String
		{
			throw new NotImplementedError;
		}
		
		public function format(subject:*, parameters:String):String
		{
			var num:Number = subject as Number;
			
			//if (parameters.indexOf("e") >= 0)
				return formatExponential(subject, parameters);
		}
	}
}