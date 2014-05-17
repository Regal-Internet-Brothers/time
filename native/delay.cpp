
// Delay.cpp:

// Functions:
bool delay(long ms)
{
	#if defined(_WIN32) || defined(_WIN64)
		Sleep(ms);
	#else//#if defined(linux) || defined(__APPLE__) && defined(__MACH__)
		usleep(ms*1000);
	#endif
	
	// Return the default response.
	return true;
}
