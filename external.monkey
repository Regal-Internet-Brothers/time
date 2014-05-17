Strict

Public

' Preprocessor related:
#If LANG = "cpp" 'And TARGET <> "ios"
	#DELAY_IMPLEMENTED = True
#End

' Imports (Monkey):
'Import mojo

#If BRL_GAMETARGET_IMPLEMENTED 'LANG = "cpp" And TARGET <> "glfw" And TARGET <> "win8" And TARGET <> "sexy"
	#MOJO_IMPLEMENTED = True
#Else
	#MOJO_IMPLEMENTED = False
#End

' Imports (Native):
#If DELAY_IMPLEMENTED
	Import "native/delay.${LANG}"
#End

#If Not MOJO_IMPLEMENTED
	Import "native/millisecs.${LANG}"
#End

' External bindings:
Extern

#If DELAY_IMPLEMENTED
	' Private external-wrapper(s):
	
	#If TARGET = "win8"
		Extern Private
		
		' Windows 8 specific:
		Function WIN8_Delay:Void(MS:Int)="Concurrency::wait"
		
		Public
		
		' Wrappers:
		Function Delay:Bool(MS:Int)
			WIN8_Delay(MS)
			
			' Return the default response.
			Return True
		End
	#Else	
		Function Delay:Bool(MS:Int)="delay"
	#End
#End

#If Not MOJO_IMPLEMENTED
	Function Millisecs:Int()="millisecs"
#End

Public