
// millisecs.cpp: Native uptime checking for Windows, Mac OS X, and Linux.

// Preprocessor related:
// Nothing so far.

// Includes:
#if defined(_WIN32) || defined(WIN32)
	//#define WIN32_LEAN_AND_MEAN
	//#include <windows.h>
#else
	#if defined(__linux__)
		//#include <sys/sysinfo.h>
		#include <sys/time.h>
	#elif defined(__APPLE__) && defined(__MACH__)
		#include <time.h>
		//#include <ctime>
		
		#include <errno.h>
		#include <sys/sysctl.h>
	#else
		// Nothing so far. (Unsupported)
	#endif
#endif

// Namespace(s):

// Due to name conflicts, this must use a different naming convention.
namespace time_module
{
	template <typename metric = int>
	class timeSystem
	{
		public:
			// Global variable(s):
			static metric startTime;
			
			// Functions:
			static metric uptime()
			{
				#if defined(_WIN32) || defined(WIN32)
					return (metric)GetTickCount();
				
				#elif defined(__linux__)
					/*
					struct timespec
					{
						// Fields:
						time_t tv_sec; // Seconds.
						long tv_nsec; // Nanoseconds.
					};
					*/
					
					/*
					struct sysinfo info;
					sysinfo(&info);
					
					return info.uptime;
					*/
					
					// Allocate a time-value structure.
					struct timeval tv;
					
					// Get the time of day.
					gettimeofday(&tv, NULL);
					
					// Pretty basic, just convert both of the integers to milliseconds.
					return ((metric)((tv.tv_sec * 1000) + (tv.tv_usec / 1000)));
			
				#elif defined(__APPLE__) && defined(__MACH__)			
					struct timeval boottime;
					size_t len = sizeof(boottime);
					int mib[2] = { CTL_KERN, KERN_BOOTTIME };
					
					if (sysctl(mib, 2, &boottime, &len, NULL, 0) < 0)
						return -1.0;
					
					time_t bsec = boottime.tv_sec, csec = time(NULL);
					
					return difftime(csec, bsec);
				#else
					return 0;
				#endif
			}
			
			static metric millisecs()
			{
				return uptime()-startTime;
			}
			
			// Initialization must be done per-type.
			static metric initMillisecs()
			{
				// Local variable(s):
				
				// Grab the current up-time.
				metric ut = uptime();
				
				// Assign the start-time to the current up-time.
				startTime = ut;
				
				// Return the current up-time.
				return ut;
			}
	};
	
	// Global variable(s):
	template<typename metric> metric timeSystem<metric>::startTime = (metric)0;
}
