# - Find mariadb
# Find the native MariaDB includes and library
#
#  MARIADB_INCLUDE_DIR - where to find mysql.h, etc.
#  MARIADB_LIBRARIES   - List of libraries when using MariaDB.
#  MARIADB_FOUND       - True if MariaDB found.

IF (MARIADB_INCLUDE_DIR)
  # Already in cache, be silent
  SET(MARIADB_FIND_QUIETLY TRUE)
ENDIF (MARIADB_INCLUDE_DIR)

IF (WIN32)
  FIND_PATH(MARIADB_INCLUDE_DIR mysql.h
    $ENV{PROGRAMFILES}/MariaDB*/include
    $ENV{SYSTEMDRIVE}/MariaDB*/include)
ELSEIF (LINUX)
  FIND_PATH(MARIADB_INCLUDE_DIR mysql.h
    /usr/local/include/mariadb
    /usr/include/mariadb)
ELSEIF (APPLE)
  FIND_PATH(MARIADB_INCLUDE_DIR mysql.h
  /opt/homebrew/include/mariadb)
ENDIF()

SET(MARIADB_NAMES mariadb)
IF (WIN32)
  FIND_LIBRARY(MARIADB_LIBRARY
    NAMES ${MARIADB_NAMES}
    PATHS $ENV{PROGRAMFILES}/MariaDB*/lib 
    $ENV{SYSTEMDRIVE}/MariaDB*/lib
    PATH_SUFFIXES mariadb)
ELSEIF (LINUX)
  FIND_LIBRARY(MARIADB_LIBRARY
    NAMES ${MARIADB_NAMES}
    PATHS /usr/lib 
    /usr/local/lib
    PATH_SUFFIXES mariadb)
ELSEIF (APPLE)
  FIND_LIBRARY(MARIADB_LIBRARY
    NAMES ${MARIADB_NAMES}
    PATHS /opt/homebrew/lib
    PATH_SUFFIXES mariadb)
ENDIF()

IF (MARIADB_INCLUDE_DIR AND MARIADB_LIBRARY)
  SET(MARIADB_FOUND TRUE)
  SET(MARIADB_LIBRARY ${MARIADB_LIBRARY})
ELSE (MARIADB_INCLUDE_DIR AND MARIADB_LIBRARY)
  SET(MARIADB_FOUND FALSE)
  SET(MARIADB_LIBRARY)
ENDIF (MARIADB_INCLUDE_DIR AND MARIADB_LIBRARY)

IF (MARIADB_FOUND)
  IF (NOT MARIADB_FIND_QUIETLY)
    MESSAGE(STATUS "Found MariaDB: ${MARIADB_LIBRARY}")
  ENDIF (NOT MARIADB_FIND_QUIETLY)
ELSE (MARIADB_FOUND)
  IF (MARIADB_FIND_REQUIRED)
    MESSAGE(STATUS "Looked for MariaDB libraries named ${MARIADB_NAMES}.")
    MESSAGE(FATAL_ERROR "Could NOT find MariaDB library")
  ENDIF (MARIADB_FIND_REQUIRED)
ENDIF (MARIADB_FOUND)

MARK_AS_ADVANCED(MARIADB_LIBRARY MARIADB_INCLUDE_DIR)