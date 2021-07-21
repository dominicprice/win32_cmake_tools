# win32_cmake_tools

A (small) collection of utilities for writing CMake scripts for Windows. Motivated 
by the lack of tools for automatically finding relevant utilities, these scripts 
will hopefully become redundant in future releases of vcpkg.

## Usage

Include in your project by copying the files you need to a directory in your 
`CMAKE_MODULE_PATH` and then using it with e.g.

```
include(win32_ensure_vcpkg.cmake)
win32_ensure_cmake()
```

## Running the test

Disclaimer: this is not anything like a complete test suite, just a small script
to make sure that no obvious errors pop up.

`cd` into the `tests` directory, then run the following commands:

```
mkdir build
cd build
cmake ..
```

and hopefully this runs without errors and prints somewhere in the output the paths
to both vcpkg and pkgconfig.