Strict

Public

' Preprocessor related:
#If BRL_GAMETARGET_IMPLEMENTED 'LANG = "cpp" And TARGET <> "glfw" And TARGET <> "win8" And TARGET <> "winrt" And TARGET <> "sexy"
	#TIME_MOJO_IMPLEMENTED = True
#Else
	#TIME_MOJO_IMPLEMENTED = False
#End

#If TARGET = "glfw" Or TARGET = "stdcpp"
	#DELAY_IMPLEMENTED = True
#End

#If LANG = "cpp" Or LANG = "cs" ' And TARGET <> "ios"
	#If Not TIME_MOJO_IMPLEMENTED
		#MILLISECS_IMPLEMENTED = True
	#End
#End

#If LANG = "cpp" And TARGET <> "win8" And TARGET <> "winrt"
	#MILLISECS_EXTERNAL_FILE = True
#End

' Imports (Monkey) (Private):
Private

#If DELAY_IMPLEMENTED
	Import brl.process
#End

Public

' Imports (Native):
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

#If MILLISECS_IMPLEMENTED
	#If LANG = "cpp"
		Function Millisecs:Int()="time_module::timeSystem<>::millisecs"
		Function InitMillisecs:Int()="time_module::timeSystem<>::initMillisecs"
	#Else
		Function Millisecs:Int()="time.millisecs"
		Function InitMillisecs:Int()="time.initMillisecs"
	#End
#End

Public

' Functions:
#If DELAY_IMPLEMENTED
	Function Delay:Bool(MS:Int)
		Sleep(MS)
		
		' Return the default response.
		Return True
	End
#End