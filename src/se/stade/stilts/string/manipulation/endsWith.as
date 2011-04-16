package se.stade.stilts.string.manipulation
{
	public function endsWith(subject:String, value:String):Boolean
	{
		return subject.substr(subject.length - value.length) == value;
	}
}