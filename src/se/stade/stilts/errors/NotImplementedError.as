package se.stade.stilts.errors
{
	public class NotImplementedError extends AbstractTypeError
	{
		public function NotImplementedError(message:String = "", id:int = 0)
		{
			super(message || "This method or property is not implemented yet.", id);
		}
	}
}