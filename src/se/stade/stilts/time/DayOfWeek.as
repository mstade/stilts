package se.stade.stilts.time
{
	import se.stade.stilts.numerical.Enum;
	
	public final class DayOfWeek extends Enum
	{
		public static const Sunday:DayOfWeek = new DayOfWeek(Sunday, 0);
		public static const Monday:DayOfWeek = new DayOfWeek(Monday);
		public static const Tuesday:DayOfWeek = new DayOfWeek(Tuesday);
		public static const Wednesday:DayOfWeek = new DayOfWeek(Wednesday);
		public static const Thursday:DayOfWeek = new DayOfWeek(Thursday);
		public static const Friday:DayOfWeek = new DayOfWeek(Friday);
		public static const Saturday:DayOfWeek = new DayOfWeek(Saturday);
		
		public static function From(value:uint):DayOfWeek
		{
			switch (value)
			{
				case 0: return Sunday;
				case 1: return Monday;
				case 2: return Tuesday;
				case 3: return Wednesday;
				case 4: return Thursday;
				case 5: return Friday;
				case 6: return Saturday;
			}
			
			return null;
		}
		
		public static function ToArray():Array
		{
			return [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday];
		}
		
		public function DayOfWeek(self:Enum, value:Number=NaN)
		{
			super(this, value);
		}
	}
}