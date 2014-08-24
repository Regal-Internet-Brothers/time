Strict

Public

' Imports:
Import external

' Functions:

' If we couldn't find a good enough version, use placeholders:
#If Not DELAY_IMPLEMENTED
	Function Delay:Bool(MS:Int)
		Return False
	End
#End

#If Not MILLISECS_IMPLEMENTED
	Function Millisecs:Int()
		Return 0
	End
#End