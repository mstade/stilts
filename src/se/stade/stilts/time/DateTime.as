package se.stade.stilts.time
{
    import se.stade.stilts.string.padLeft;

    public class DateTime
    {
        public static function FromYear(year:Number, timezone:TimeZone = null):DateTime
        {
            return FromMonth(year, 1, timezone);
        }
        
        public static function FromMonth(year:Number, month:uint, timezone:TimeZone = null):DateTime
        {
            return FromDay(year, month, 1, timezone);
        }
        
        public static function FromDay(year:Number, month:uint, day:uint, timezone:TimeZone = null):DateTime
        {
            var date:Date = new Date(year, (month || 1) - 1, day);
            return FromDate(date, timezone);
        }
        
        public static function FromTime(time:TimeSpan, timezone:TimeZone = null):DateTime
        {
            return FromTicks(time.ticks, timezone);
        }
        
        public static function FromTicks(ticks:Number, timezone:TimeZone = null):DateTime
        {
            return new DateTime(ticks, timezone);
        }
        
        public static function Now(timezone:TimeZone = null):DateTime
        {
            return FromDate(new Date(), timezone);
        }
        
        public static function FromDate(date:Date, timezone:TimeZone = null):DateTime
        {
            /* The Date constructor assumes local time when specifying date
            * parts. Because of this, we need to offset the time of the date
            * object so that the UTC properties actually reflect local time
            * instead. Otherwise things get super confusing as the ticks are
            * not in local time, but UTC. So essentially, we offset the ticks
            * so that they are in local time instead. This is because while
            * the Date object assumes local time when specifying date parts,
            * it assumes UTC when specifying only ticks (which is what is
            * going on in the DateTime constructor.)
            *
            * Ahh, the joys of undocumented 'features'.
            */
            return new DateTime(date.time - date.timezoneOffset * TimeSpan.TicksPerMinute, timezone);
        }
        
        /* This is a flash player limitation. We shall have no more than a hundred
         * million days, and sharks with frickin' laserbeams on their heads!
         *
         *                                                      -- Dr. Evil
         */
        internal static const DATE_TICK_LIMIT:Number = 100000000 * TimeSpan.TicksPerDay;
        
        public static const Max:DateTime = FromTicks(DATE_TICK_LIMIT, TimeZone.UTC);
        public static const Min:DateTime = FromTicks(-DATE_TICK_LIMIT, TimeZone.UTC);
        public static const Zero:DateTime = FromTicks(0, TimeZone.UTC);
        
        public function DateTime(ticks:Number = NaN, timezone:TimeZone = null)
        {
            var date:Date = new Date(ticks);
            
            if (timezone)
            {
                date.time += timezone.offset.milliseconds;
                _timezone = timezone;
            }
            else    
            {
                _timezone = TimeZone.Local;
            }
            
            _timespan = TimeSpan.FromMilliseconds(date.time);
            
            _year = date.fullYearUTC;
            _month = date.monthUTC + 1;
            _day = date.dateUTC;
            
            _hour = date.hoursUTC;
            _minute = date.minutesUTC;
            _second = date.secondsUTC;
            _millisecond = date.millisecondsUTC;
            
            _dayOfWeek = DayOfWeek.From(date.dayUTC);
        }
        
        public final function get ticks():Number { return timespan.ticks; }
        
        private var _timezone:TimeZone;
        public final function get timezone():TimeZone { return _timezone; }
        
        private var _timespan:TimeSpan;
        public final function get timespan():TimeSpan { return _timespan; }
        
        private var _today:DateTime;
        public final function get today():DateTime
        {
            if (!_today)
                _today = FromDay(year, month, day, timezone);
            
            return _today;
        }
        
        private var _tomorrow:DateTime;
        public final function get tomorrow():DateTime
        {
            if (!_tomorrow)
                _tomorrow = FromTicks(today.add(TimeSpan.FromDays(1)).ticks, timezone);

            return _tomorrow;
        }
        
        private var _yesterday:DateTime;
        public final function get yesterday():DateTime
        {
            if (!_yesterday)
                _yesterday = FromTicks(today.subtract(TimeSpan.FromDays(1)).ticks, timezone);
            
            return _yesterday;
        }
        
        private var _year:Number;
        public final function get year():Number { return _year; }
        
        private var _month:uint;
        public final function get month():uint { return _month; }
        
        private var _day:uint;
        public final function get day():uint { return _day; }
        
        private var _hour:uint;
        public final function get hour():uint { return _hour; }
        
        private var _minute:uint;
        public final function get minute():uint { return _minute; }
        
        private var _second:uint;
        public final function get second():uint { return _second; }
        
        private var _millisecond:uint;
        public final function get millisecond():uint { return _millisecond; }
        
        private var _dayOfWeek:DayOfWeek;
        public final function get dayOfWeek():DayOfWeek { return _dayOfWeek; }
        
        private var _dayOfYear:uint;
        public final function get dayOfYear():uint
        {
            if (!_dayOfYear)
                _dayOfYear = timespan.subtract(firstDayOfYear.timespan).totalDays + 1;
            
            return _dayOfYear;
        }
        
        private var _firstDayOfYear:DateTime;
        public final function get firstDayOfYear():DateTime
        {
            if (!_firstDayOfYear)
                _firstDayOfYear = FromDay(year, 1, 1, timezone);
            
            return _firstDayOfYear;
        }
        
        public final function add(time:TimeSpan):DateTime
        {
            return FromTicks(timespan.add(time).ticks, timezone);
        }
        
        public final function subtract(time:TimeSpan):DateTime
        {
            return FromTicks(timespan.subtract(time).ticks, timezone);
        }
        
        public final function equals(other:DateTime):Boolean
        {
            return this == other || ticks == other.ticks;
        }
        
        public final function toDate():Date
        {
            return new Date(ticks);
        }
        
        public final function toLocal():DateTime
        {
            return toZone(TimeZone.Local);
        }
        
        public final function toUTC():DateTime
        {
            return toZone(TimeZone.UTC);
        }
        
        public final function toZone(other:TimeZone):DateTime
        {
            if (timezone.equals(other))
                return this;
            
            var utcTime:TimeSpan = timespan.subtract(timezone.offset);
            return FromTicks(utcTime.ticks, other);
        }
        
        public function toString():String
        {
            var YYYY:String = padLeft("0000", year.toFixed(0));
            var MM:String = padLeft("00", month.toString());
            var DD:String = padLeft("00", day.toString());
            
            var hh:String = padLeft("00", hour.toString());
            var mm:String = padLeft("00", minute.toString());
            var ss:String = padLeft("00", second.toString());
            
            return "{year}-{month}-{day}T{hour}:{min}:{sec}{tz}"
                   .replace("{year}",  YYYY)
                   .replace("{month}", MM)
                   .replace("{day}",   DD)
                   .replace("{hour}",  hh)
                   .replace("{min}",   mm)
                   .replace("{sec}",   ss)
                   .replace("{tz}",    timezone.toUTCString());
        }

        public function valueOf():Object
        {
            return ticks;
        }
    }
}
