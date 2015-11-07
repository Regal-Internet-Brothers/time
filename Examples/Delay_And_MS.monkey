Strict

Public

' Imports:
Import regal.time

' Functions:
Function Main:Int()
	' Initialize 'Millisecs'; sets an initial offset if needed.
	InitMillisecs()
	
	Local FirstSnapshot:= Millisecs()
	
	Print("First time snapshot: " + FirstSnapshot)
	
	' Works on some targets, does nothing on others.
	Delay(1000)
	
	Local SecondSnapshot:= Millisecs()
	Local TimePassed:= (SecondSnapshot - FirstSnapshot)
	
	Print("Second time snapshot: " + SecondSnapshot)
	
	Print("Delayed for " + TimePassed + "ms.")
	
	' Return the default response.
	Return 0
End