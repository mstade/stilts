package se.stade.stilts.time
{
	public final class TimeSpan
	{
		public static const TicksPerMillisecond:uint	= 1;
		public static const TicksPerSecond:uint			= 1000 * TicksPerMillisecond;
		public static const TicksPerMinute:uint			=   60 * TicksPerSecond;
		public static const TicksPerHour:uint			=   60 * TicksPerMinute;
		public static const TicksPerDay:uint			=   24 * TicksPerHour;
		public static const TicksPerWeek:uint			=    7 * TicksPerDay;
		
		public static const Min:TimeSpan				= new TimeSpan(Number.MIN_VALUE);
		public static const Max:TimeSpan				= new TimeSpan(Number.MAX_VALUE);
		public static const Zero:TimeSpan				= new TimeSpan(0);
		
		public static const Week:TimeSpan				= FromWeeks(1);
		public static const Day:TimeSpan				= FromDays(1);
		public static const Hour:TimeSpan				= FromHours(1);
		public static const Minute:TimeSpan				= FromMinutes(1);
		public static const Second:TimeSpan				= FromSeconds(1);
		public static const Millisecond:TimeSpan		= FromMilliseconds(1);
		
		public static function FromWeeks(weeks:Number):TimeSpan
		{
			return FromTicks(weeks * TicksPerWeek);
		}
		
		public static function FromDays(days:Number):TimeSpan
		{
			return FromTicks(days * TicksPerDay);
		}
		
		public static function FromHours(hours:Number):TimeSpan
		{
			return FromTicks(hours * TicksPerHour);
		}
		
		public static function FromMinutes(minutes:Number):TimeSpan
		{
			return FromTicks(minutes * TicksPerMinute);
		}
		
		public static function FromSeconds(seconds:Number):TimeSpan
		{
			return FromTicks(seconds * TicksPerSecond);
		}
		
		public static function FromMilliseconds(milliseconds:Number):TimeSpan
		{
			return FromTicks(milliseconds * TicksPerMillisecond);
		}
		
		public static function FromTicks(ticks:Number):TimeSpan
		{
			return new TimeSpan(ticks);
		}
		
		public static function FromTime(hours:Number, minutes:Number, seconds:Number, milliseconds:Number = 0):TimeSpan
		{
			var ticks:Number = (milliseconds || 0) * TicksPerMillisecond;
			ticks += seconds * TicksPerSecond;
			ticks += minutes * TicksPerMinute;
			ticks += hours * TicksPerHour;
			
			return TimeSpan.FromTicks(ticks);
		}
		
		public function TimeSpan(ticks:Number = 0)
		{
			_ticks = ticks || 0;
			
			_totalWeeks = ticks / TicksPerWeek;
			_totalDays = ticks / TicksPerDay;
			_totalHours = ticks / TicksPerHour;
			_totalMinutes = ticks / TicksPerMinute;
			_totalSeconds = ticks / TicksPerSecond;
			_totalMilliseconds = ticks / TicksPerMillisecond;
			
			_days = totalDays - TicksPerWeek / TicksPerDay * int(totalWeeks);
			_hours = totalHours - TicksPerDay / TicksPerHour * int(totalDays);
			_minutes = totalMinutes - TicksPerHour / TicksPerMinute * int(totalHours);
			_seconds = totalSeconds - TicksPerMinute / TicksPerSecond * int(totalMinutes);
			_milliseconds = totalMilliseconds - TicksPerSecond / TicksPerMillisecond * int(totalSeconds);
		}
		
		private var _ticks:Number;
		public function get ticks():Number { return _ticks; }
		
		private var _duration:TimeSpan;
		public function get duration():TimeSpan
		{
			if (!_duration)
				_duration = FromTicks(Math.abs(ticks));  // This can't be in the constructor since it would introduce a stack overflow
			
			return _duration;
		}
		
		public function get weeks():int { return totalWeeks; }
		
		private var _days:int = int.MIN_VALUE;
		public function get days():int { return _days; }
		
		private var _hours:int = int.MIN_VALUE;
		public function get hours():int { return _hours; }
		
		private var _minutes:int = int.MIN_VALUE;
		public function get minutes():int { return _minutes; }
		
		private var _seconds:int = int.MIN_VALUE;
		public function get seconds():int { return _seconds; }
		
		private var _milliseconds:int = int.MIN_VALUE;
		public function get milliseconds():int { return _milliseconds; }
		
		private var _totalWeeks:Number;
		public function get totalWeeks():Number { return _totalWeeks; }
		
		private var _totalDays:Number;
		public function get totalDays():Number { return _totalDays; }
		
		private var _totalHours:Number;
		public function get totalHours():Number { return _totalHours; }
		
		private var _totalMinutes:Number;
		public function get totalMinutes():Number { return _totalMinutes; }
		
		private var _totalSeconds:Number;
		public function get totalSeconds():Number { return _totalSeconds; }
		
		private var _totalMilliseconds:Number;
		public function get totalMilliseconds():Number { return _totalMilliseconds; }
		
		public function add(other:TimeSpan):TimeSpan
		{
			return FromTicks(ticks + other.ticks);
		}
		
		public function subtract(other:TimeSpan):TimeSpan
		{
			return FromTicks(ticks - other.ticks);
		}
		
		public function modulo(other:TimeSpan):TimeSpan
		{
			return FromTicks(ticks % other.ticks);
		}
		
		public function multiply(value:Number):TimeSpan
		{
			return FromTicks(ticks * value);
		}
		
		public function divide(value:Number):TimeSpan
		{
			return FromTicks(ticks / value);
		}
		
		public function equals(other:TimeSpan):Boolean
		{
			return this == other || ticks == other.ticks;
		}
		
		public function toString():String
		{
			return weeks + " weeks, " + hours + " hours, " + minutes + " minutes, " + seconds + "," + milliseconds + " seconds";
		}

		public function valueOf():Object
		{
			return ticks;
		}
	}
}