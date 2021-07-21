# win32_ensure_vcpkg.cmake
#   Attempt to find vcpkg in the user's PATH and other likely locations,
#   throwing a FATAL_ERROR if it is not found
# Distributed under the MIT licence

function(win32_ensure_vcpkg)
	if(WIN32)
		# Try and find vpckg location by running `where vcpkg`
		if(NOT VCPKG_TOOLCHAIN)	
			execute_process(COMMAND "where" "vcpkg" OUTPUT_VARIABLE VCPKG_EXE_PATH)
			string(REGEX REPLACE "\r?\n" ";" VCPKG_EXE_PATH "${VCPKG_EXE_PATH}")
			string(REGEX MATCHALL "^.*\\.vcpkg.exe$" VCPKG_EXE_PATH "${VCPKG_EXE_PATH}")
			if(VCPKG_EXE_PATH)
				get_filename_component(VCPKG_BASEDIR "${VCPKG_EXE_PATH}" DIRECTORY)
				set(CMAKE_TOOLCHAIN_FILE "${VCPKG_BASEDIR}/scripts/buildsystems/vcpkg.cmake")
				include(${CMAKE_TOOLCHAIN_FILE})
			endif()
		endif()
		
		# Try and find vcpkg location by looking in likely locations
		if(NOT VCPKG_TOOLCHAIN)
			find_file(CMAKE_TOOLCHAIN_FILE vcpkg.cmake HINTS $ENV{userprofile} $ENV{systemdrive} PATH_SUFFIXES vcpkg/scripts/buildsystems)
			if(CMAKE_TOOLCHAIN_FILE)
				include(${CMAKE_TOOLCHAIN_FILE})
			endif()
		endif()
		
		if(VCPKG_TOOLCHAIN)
			message(STATUS "Using vcpkg located at ${Z_VCPKG_ROOT_DIR}")
		else()
			message(FATAL_ERROR "Could not find vcpkg; either make sure that the location of vcpkg.exe is in your PATH variable or specify the location of the vcpkg toolchain file (usually located in <vcpkg-root>/scripts/buildsystems/vcpkg.cmake) using -DCMAKE_TOOLCHAIN_FILE=/path/to/vcpkg.cmake")
		endif()
	endif()
endfunction()