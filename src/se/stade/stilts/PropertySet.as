package se.stade.stilts
{
    import flash.events.Event;
    import flash.utils.Dictionary;
    
    public dynamic class PropertySet extends Dictionary
    {
        public static function from(object:Object):PropertySet
        {
            var set:PropertySet = object as PropertySet;
            
            if (set)
                return set;

            set = new PropertySet;
            set.setProperties(object);
            
            return set;
        }
        
        public function PropertySet(weakKeys:Boolean = false)
        {
            super(weakKeys);
        }
        
        public var throwsErrors:Boolean = false;
        
        public function setProperties(properties:Object):void
        {
            for (var name:String in properties)
            {
                this[name] = properties[name];
            }
        }
        
        public function applyTo(target:Object):void
        {
            if (throwsErrors)
            {
                for (var name:String in this)
                {
                    target[name] = this[name]; 
                }
            }
            else
            {
                for (name in this)
                {
                    if (name in target)
                    {
                        try
                        {
                            target[name] = this[name];
                        }
                        catch (e:Error)
                        {
                            // Silently catch the error
                        }
                    }
                }
            }
        }
    }
}
