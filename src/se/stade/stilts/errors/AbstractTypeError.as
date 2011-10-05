package se.stade.stilts.errors
{
    import flash.errors.IllegalOperationError;

    public class AbstractTypeError extends IllegalOperationError
    {
        public function AbstractTypeError(message:String = "", id:int = 0)
        {
            super(message || "This type is abstract and can not be instantiated, only inherited.", id);
        }
    }
}
