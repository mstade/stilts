package se.stade.stilts.numbers
{
    import se.stade.stilts.errors.AbstractTypeError;

    import flash.utils.describeType;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;

    public class Enum
    {
        public function Enum(self:Enum, value:Number = NaN, name:String = "")
        {
            if (this != self)
                throw new AbstractTypeError();
            
            _name = name;
            _value = value;
        }
        
        private function initialize():void
        {
            var description:XML = describeType(getDefinitionByName(getQualifiedClassName(this)));
            
            for each (var constant:XML in description..constant)
            {
                var EnumType:Class = getDefinitionByName(constant.@type) as Class;
                var enum:Enum = EnumType[constant.@name];
                
                if (!enum._name)
                    enum._name = constant.@name;
            }
        }
        
        private var _name:String;
        public function get name():String
        {
            if (!_name)
                initialize();
            
            return _name;
        }
        
        private var _value:Number;
        public function get value():Number
        {
            return _value;
        }
        
        public function valueOf():Object
        {
            return value;
        }
        
        public function toString():String
        {
            return name;
        }
    }
}
