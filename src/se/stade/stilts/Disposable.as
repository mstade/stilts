package se.stade.stilts
{
	/**
	 * Disposable types generally make use of some resource which may result
	 * in the type lingering in memory longer than necessary. Implementing
	 * this interface can help consumers of this type to dispose of it,
	 * without knowing intricate implementation details. This is generally
	 * done by clearing any references that are no longer needed in order
	 * to help the garbage collector find objects that can be freed.
	 * 
	 * @author Marcus Stade
	 */
	public interface Disposable
	{
		/**
		 * Makes sure that any references that this object might have, such as
		 * event listeners or bindings, are properly disposed of so as not to
		 * introduce memory leaks. This method is <em>not</em> automatically
		 * called by the flash player and must be manually invoked.
		 *
		 * Disposing of this type will most likely put it in an unusable state
		 * and is not reversible. It is however safe to call this method multiple
		 * times. 
		 */
		function dispose():void;
	}
}