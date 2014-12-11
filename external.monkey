Strict

Public

' Preprocessor related:
#If BRL_GAMETARGET_IMPLEMENTED 'LANG = "cpp" And TARGET <> "glfw" And TARGET <> "win8" And TARGET <> "winrt" And TARGET <> "sexy"
	#TIME_MOJO_IMPLEMENTED = True
#Else
	#TIME_MOJO_IMPLEMENTED = False
#End

#If LANG = "cpp" Or LANG = "cs" ' And TARGET <> "ios"
	#DELAY_IMPLEMENTED = True
	
	#If Not TIME_MOJO_IMPLEMENTED
		#MILLISECS_IMPLEMENTED = True
	#Else
		#MILLISECS_IMPLEMENTED = False
	#End
#End

#If LANG = "cpp" And TARGET <> "win8" And TARGET <> "winrt"
	#DELAY_EXTERNAL_FILE = True
	#MILLISECS_EXTERNAL_FILE = True
#End

' Imports (Monkey):
'Import mojo

' Imports (Native):
#If DELAY_IMPLEMENTED And DELAY_EXTERNAL_FILE
	Import "native/delay.${LANG}"
#End

#If MILLISECS_IMPLEMENTED And MILLISECS_EXTERNAL_FILE
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
	#If LANG = "cpp"
		#If TARGET = "win8" Or TARGET = "winrt"
			' Windows 8 specific:
			Function __Native_Delay:Void(MS:Int)="Concurrency::wait"
		#Else	
			Function Delay:Bool(MS:Int)="delay"
		#End
	#Elseif LANG = "cs"
		Function __Native_Delay:Void(MS:Int) = "System.Threading.Thread.Sleep"
	#End
#End

#If MILLISECS_IMPLEMENTED
	Function Millisecs:Int()="millisecs"
#End

Public

' Wrappers for external functions:
#If LANG = "cs" Or TARGET = "win8" Or TARGET = "winrt"
	' This wrapper is for external commands which don't have return types:
	Function Delay:Bool(MS:Int)
		__Native_Delay(MS)
		
		' Return the default response.
		Return True
	End
#End