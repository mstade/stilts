package se.stade.stilts.math
{
    public function clamp(value:Number, min:Number, max:Number):Number
    {
        if (value < min)
            return min;
        else if (value > max)
            return max;
        
        return value;
    }
}
