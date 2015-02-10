
// delay.cpp:

// Includes:
#if !defined(_WIN32) && !defined(WIN32) && !defined(_WIN64)
	#include <unistd.h>
#endif

// Namespace(s):
namespace time_module
{
	// Functions:
	/*
		// I wish Monkey officially supported C++11 already:
		template<typename metric=int>
		bool delay(metric ms)
	*/
	
	//bool delay(long ms)
	bool delay(int ms)
	{
		#if defined(WIN32) || defined(_WIN32) || defined(_WIN64)
			Sleep((DWORD)ms); // Sleep((int)ms);
		#else//#if defined(linux) || defined(__APPLE__) && defined(__MACH__)
			usleep((useconds_t)(ms*1000)); // usleep((int)(ms*1000));
		#endif
		
		// Return the default response.
		return true;
	}
}
