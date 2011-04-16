package se.stade.stilts.string.manipulation
{
	public function startsWith(subject:String, value:String):Boolean
	{
		return subject.indexOf(value) == 0;
	}
}