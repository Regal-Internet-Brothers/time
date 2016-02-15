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

' Aliases:
#If Not MILLISECS_IMPLEMENTED
	#If TIME_MOJO_IMPLEMENTED And TIME_WRAP_MOJO
		#MILLISECS_IMPLEMENTED = True
		
		Alias Millisecs = app.Millisecs
	#End
#End

' Functions:

' If we couldn't find a good enough version, use placeholders:
#If Not DELAY_IMPLEMENTED
	Function Delay:Bool(MS:Int)
		Return False
	End
#End

#If Not MILLISECS_IMPLEMENTED
	#If Not TIME_MOJO_IMPLEMENTED And Not TIME_WRAP_MOJO
		Function Millisecs:Int()
			Return 0
		End
	#End
	
	Function InitMillisecs:Int()
		Return 0
	End
#End