# win32_ensure_pkgconfig.cmake
#   Attempt to find pkgconfig in the user's PATH, otherwise download
#   a version from sourceforge and put into CMAKE_PROGRAM_PATH,
#   throwing a FATAL_ERROR if this is not possible
# Distributed under the MIT licence

function(win32_ensure_pkgconfig)
	if(WIN32)
		# Try to find pkg-config otherwise download a standalone version from sourceforge. First add the path
		# we download it to into PATH so that we don't unnecessarily redownload it in future runs
		list(APPEND CMAKE_PROGRAM_PATH "${CMAKE_BINARY_DIR}/downloads/pkg-config-lite-0.28-1/bin")	
		find_package(PkgConfig QUIET)
		if(NOT PKG_CONFIG_FOUND)
			message(STATUS "Could not find pkg-config, downloading suitable version...")
			file(DOWNLOAD "https://sourceforge.net/projects/pkgconfiglite/files/0.28-1/pkg-config-lite-0.28-1_bin-win32.zip/download" "${CMAKE_BINARY_DIR}/downloads/pkg-config-lite-0.28-1_bin-win32.zip" SHOW_PROGRESS)
			execute_process(COMMAND "powershell" "Expand-Archive" "-Force" "${CMAKE_BINARY_DIR}/downloads/pkg-config-lite-0.28-1_bin-win32.zip" "${CMAKE_BINARY_DIR}/downloads")
		endif()
		find_package(PkgConfig QUIET)
		if(NOT PKG_CONFIG_FOUND)
			message(FATAL_ERROR "Unable to install pkg-config, check you have an internet connection and are running powershell>=5.0; alternatively download pkg-config manually from https://sourceforge.net/projects/pkgconfiglite/files/0.28-1/pkg-config-lite-0.28-1_bin-win32.zip/download and add to a location in your PATH.")
		endif()
	endif()
endfunction()