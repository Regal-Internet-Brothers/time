

// Millisecs.cpp: Native uptime checking for Windows, OSX, and Linux.

// Preprocessor related:
// Nothing so far.

// Includes:
#if defined(_WIN32) || defined(WIN32)
	//#define WIN32_LEAN_AND_MEAN
	//#include <windows.h>
#else
	#if defined(__linux__)
		#include <sys/sysinfo.h>
	#elif defined(__APPLE__) && defined(__MACH__)
		#include <time.h>
		#include <errno.h>
		#include <sys/sysctl.h>
	#else
		// Nothing so far. (Unsupported)
	#endif
#endif

// Functions:
inline int millisecs()
{
        #if defined(_WIN32) || defined(WIN32)
			return GetTickCount();
		
		#elif defined(__linux__)
			struct sysinfo info;
			sysinfo(&info);
			
			return info.uptime;

		#elif defined(__APPLE__) && defined(__MACH__)			
			struct timeval boottime;
			size_t len = sizeof(boottime);
			int mib[2] = { CTL_KERN, KERN_BOOTTIME };
		    
			if (sysctl(mib, 2, &boottime, &len, NULL, 0) < 0)
			{
				return -1.0;
			}
			
			time_t bsec = boottime.tv_sec, csec = time(NULL);
			
			return difftime(csec, bsec);
		#else
			return 0;
		#endif
}

