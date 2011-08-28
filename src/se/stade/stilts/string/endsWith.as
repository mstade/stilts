package se.stade.stilts.string
{
	public function endsWith(subject:String, value:String):Boolean
	{
		return subject.substr(subject.length - value.length) == value;
	}
}