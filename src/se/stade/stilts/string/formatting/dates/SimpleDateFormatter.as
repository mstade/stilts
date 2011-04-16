package se.stade.stilts.string.formatting.dates
{
	import se.stade.stilts.time.DateTime;
	import se.stade.stilts.string.formatting.TypeFormatter;
	import se.stade.stilts.string.formatting.utils.padLeft;
	import se.stade.stilts.string.formatting.utils.padRight;
	
	public class SimpleDateFormatter implements TypeFormatter
	{
		public function get types():Vector.<Class>
		{
			return new <Class>[Date, DateTime];
		}
		
		protected var shortDayname:Vector.<String> = new <String>["Sun", "Mon", "Tue", "Wed", "Fri", "Sat"];
		protected var fullDayname:Vector.<String> = new <String>["Sunday", "Monday", "Tuesday", "Wednesday", "Friday", "Saturday"];

		public function formatDay(input:String, dayOfWeek:uint):String
		{
			var dayNum:String = padLeft("00", dayOfWeek);
			
			return input.replace(/DDDD/g, fullDayname[dayOfWeek])
						.replace( /DDD/g, shortDayname[dayOfWeek])
						.replace(  /DD/g, dayNum);
		}
		
		protected var shortMonthname:Vector.<String> = new <String>["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
		protected var fullMonthname:Vector.<String> = new <String>["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
		
		public function formatMonth(input:String, month:uint):String
		{
			var monthNum:String = padLeft("00", String(month).slice(-2));
			
			return input.replace(/MMMM/g, fullMonthname[month])
						.replace( /MMM/g, shortMonthname[month])
						.replace(  /MM/g, monthNum);
		}
		
		public function formatYear(input:String, year:Number):String
		{
			var shortYear:String = padLeft("00", String(year).substr(-2));
			
			return input.replace(/YYYY/g, padLeft("0000", year))
						.replace(  /YY/g, padLeft("00", shortYear));
		}
		
		public function formatTime(input:String, hour:uint, minute:uint, second:uint, millisecond:uint):String
		{
			var designator:String = hour > 12 ? "AM" : "PM";
			var tenths:String = String(millisecond).slice(0, 1);
			var hundreths:String = padRight(String(millisecond).slice(0, 2), "00");
			var thousands:String = padRight(millisecond, "000");
			
			return input.replace( /hh/g, padLeft("00", hour % 13))
						.replace( /HH/g, padLeft("00", hour))
						.replace( /mm/g, padLeft("00", minute))
						.replace( /ss/g, padLeft("00", second))
						.replace(/fff/g, padRight(String(millisecond), "000"))
						.replace( /ff/g, padRight(String(millisecond).slice(0, 2), "00"))
						.replace(  /f/g, padRight(String(millisecond).slice(0, 1), "0"))
		}
		
		public function format(subject:*, parameters:String):String
		{
			var year:Number, month:uint, day:uint;
			
			if (subject is Date)
			{
				year = subject.fullYear;
				month = subject.month;
				day = subject.day;
			}
			else
			{
				year = subject.year;
				month = subject.month;
				day = subject.dayOfWeek.value;
			}
			
			parameters = formatYear(parameters, year);
			parameters = formatMonth(parameters, month);
			parameters = formatDay(parameters, day);
			
			return parameters;
		}
	}
}