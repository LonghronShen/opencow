#ifndef BCF6B7EF_6AA5_4AB3_8F47_BAB9427D2815
#define BCF6B7EF_6AA5_4AB3_8F47_BAB9427D2815

#include <tchar.h>
#include <windows.h>

#ifndef UNUSED_ARG
#define UNUSED_ARG(x) ((void)(x))
#endif

#ifndef OPENCOW_DLL
#define OPENCOW_DLL "opencow.dll"
#endif

extern "C" HMODULE __stdcall LoadOpencowLibrary(void) {
  HMODULE hModule = ::LoadLibraryA(".\\" OPENCOW_DLL);
  if (hModule)
    ::MessageBoxA(NULL, "Loaded .\\" OPENCOW_DLL, "simple", MB_OK);
  else
    ::MessageBoxA(NULL, "Failed to load .\\" OPENCOW_DLL, "simple", MB_OK);
  return hModule;
}

extern "C" HMODULE(__stdcall *_PfnLoadUnicows)(void) = &LoadOpencowLibrary;

#endif /* BCF6B7EF_6AA5_4AB3_8F47_BAB9427D2815 */
