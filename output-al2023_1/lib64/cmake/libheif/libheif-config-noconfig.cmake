#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "heif" for configuration ""
set_property(TARGET heif APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(heif PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib64/libheif.so.1.19.2"
  IMPORTED_SONAME_NOCONFIG "libheif.so.1"
  )

list(APPEND _IMPORT_CHECK_TARGETS heif )
list(APPEND _IMPORT_CHECK_FILES_FOR_heif "${_IMPORT_PREFIX}/lib64/libheif.so.1.19.2" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
