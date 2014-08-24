Strict

Public

' Preprocessor related:
#If BRL_GAMETARGET_IMPLEMENTED 'LANG = "cpp" And TARGET <> "glfw" And TARGET <> "win8" And TARGET <> "sexy"
	#TIME_MOJO_IMPLEMENTED = True
#Else
	#TIME_MOJO_IMPLEMENTED = False
#End

#If LANG = "cpp" 'And TARGET <> "ios"
	#DELAY_IMPLEMENTED = True
	
	#If Not TIME_MOJO_IMPLEMENTED
		#MILLISECS_IMPLEMENTED = True
	#Else
		#MILLISECS_IMPLEMENTED = False
	#End
#End

' Imports (Monkey):
'Import mojo

' Imports (Native):
#If DELAY_IMPLEMENTED
	Import "native/delay.${LANG}"
#End

#If MILLISECS_IMPLEMENTED
	Import "native/millisecs.${LANG}"
	
	#Rem
		' No longer needed:
		#If HOST = "linux"
			#CC_LIBS += "-lrt"
		#End
	#End
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

#If MILLISECS_IMPLEMENTED
	Function Millisecs:Int()="millisecs"
#End

Public