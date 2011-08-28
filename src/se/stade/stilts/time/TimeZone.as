package se.stade.stilts.time
{
	public final class TimeZone
	{
		public static const UTC:TimeZone = new TimeZone(TimeSpan.Zero, "Z");
		public static const Local:TimeZone = new TimeZone();
		
		private static var _localOffset:TimeSpan;
		public static function get LocalOffset():TimeSpan
		{
			/* Unfortunately, the Date object doesn't expose the timezone offset
			* without creating an instance first. We also can't store this in a
			* const since that might render the value incorrect if the timezone
			* were to change during program execution. */
			var now:Date = new Date();
			
			if (now.timezoneOffset != _localOffset.totalMinutes)
				_localOffset = TimeSpan.FromMinutes(now.timezoneOffset);
			
			return _localOffset;
		}
		
		public static function FromHours(offset:Number):TimeZone
		{
			return FromTime(TimeSpan.FromHours(offset));
		}
		
		public static function FromMinutes(offset:Number):TimeZone
		{
			return FromTime(TimeSpan.FromMinutes(offset));
		}
		
		public static function FromTime(offset:TimeSpan):TimeZone
		{
			if (!offset || offset.equals(LocalOffset))
				return Local;
			
			var sign:int = offset.ticks < 0 ? -1 : 1;
			
			offset = offset.duration.modulo(TimeSpan.FromHours(13 * sign));
			if (offset.equals(UTC.offset))
				return UTC;
			
			return new TimeZone(offset);
		}
		
		public static function FromName(name:String):TimeZone
		{
			name = name.toLowerCase();
			
			// Handle military codes
			if (name.length == 1)
			{
				if (name == "z")
					return UTC;
				else if (name.search(/^[a-i]$/) == 0)
					return TimeZone.FromHours(name.charCodeAt(0) - 96);
				else if (name.search(/^[k-m]$/) == 0)
					return TimeZone.FromHours(name.charCodeAt(0) - 97);
				else if (name.search(/^[n-y]$/) == 0)
					return TimeZone.FromHours(109 - name.charCodeAt(0));
			}
			
			// The usual suspects
			switch (name)
			{
				case "gmt":
				case "utc":
					return UTC;
				case "edt":
					return TimeZone.FromTime(TimeSpan.FromHours(-4));
				case "est":
					return TimeZone.FromTime(TimeSpan.FromHours(-5));
				case "pdt":
					return TimeZone.FromTime(TimeSpan.FromHours(-7));
				case "pst":
					return TimeZone.FromTime(TimeSpan.FromHours(-8));
				case "edt":
					return TimeZone.FromTime(TimeSpan.FromHours(-4));
				case "cet":
					return TimeZone.FromTime(TimeSpan.FromHours(1));
			}
			
			return UTC;
		}
		
		public function TimeZone(offset:TimeSpan = null, name:String = "")
		{
			if (offset)
				_offset = offset.modulo(TimeSpan.Day);
			
			_name = name;
		}
		
		private var _offset:TimeSpan;
		public function get offset():TimeSpan
		{
			return _offset || LocalOffset;
		}
		
		private var _name:String;
		public function get name():String
		{
			if (_name)
				return _name;
			else if (equals(UTC))
				return UTC.name;
			
			return toUTCString();
		}
		
		public function equals(other:TimeZone):Boolean
		{
			return this == other || offset.equals(other.offset);
		}
		
		public function toUTCString():String
		{
			var sign:String;
			
			if (offset.totalMinutes > 0)
				sign = "+";
			else if (offset.totalMinutes < 0)
				sign = "-";
			else
				return UTC.name;
			
			var hours:String = offset.hours.toString();
			hours += "00".slice(0, hours.length);
			
			var minutes:String = offset.minutes.toString();
			minutes += "00".slice(0, minutes.length);
			
			return sign + hours + ":" + minutes;
		}
		
		public function toString():String
		{
			return name;
		}

		public function valueOf():Object
		{
			return offset.totalMinutes;
		}
	}
}