

// Millisecs.cpp: Native uptime checking for Windows, OSX, and Linux.

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

// Global variable(s):
//unsigned long startTime = 0;

// Functions:
inline int millisecs() // inline int uptime()
{
        #if defined(_WIN32) || defined(WIN32)
			return GetTickCount();
		
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
			return (int)((tv.tv_sec * 1000) + (tv.tv_usec / 1000));

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

/*
inline int millisecs()
{
	int ut = uptime();
	int originalStartTime = startTime;

	if (startTime == 0)
		startTime = ut;

	return ut-originalStartTime;
}
*/