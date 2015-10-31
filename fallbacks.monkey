Strict

Public

' Preprocessor related:
#TIME_WRAP_MOJO = True ' False

' Imports (Public):
Import external

' Imports (Private):
Private

#If TIME_MOJO_IMPLEMENTED
	Import mojo.app
#End

Public

' Functions:

' If we couldn't find a good enough version, use placeholders:
#If Not DELAY_IMPLEMENTED
	Function Delay:Bool(MS:Int)
		Return False
	End
#End

#If Not MILLISECS_IMPLEMENTED And (Not TIME_MOJO_IMPLEMENTED Or TIME_WRAP_MOJO)
	Function Millisecs:Int()
		#If TIME_WRAP_MOJO
			Return app.Millisecs()
		#Else
			Return 0
		#End
	End
	
	Function InitMillisecs:Int()
		Return 0
	End
#End