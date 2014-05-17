Strict

Public

' Imports:
Import external

' Functions:
#If Not DELAY_IMPLEMENTED
	Function Delay:Bool(MS:Int)
		Return False
	End
#End