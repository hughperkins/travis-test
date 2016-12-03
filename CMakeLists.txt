cmake_minimum_required(VERSION 2.8)

# add_library(swiglib1 SHARED swiglib1_wrap.cxx)
# set_target_properties(swiglib1 PROPERTIES
#     PREFIX "")

add_library(sublib SHARED sublib.cpp)

FIND_PACKAGE(SWIG REQUIRED)
INCLUDE(${SWIG_USE_FILE})

FIND_PACKAGE(PythonLibs)
INCLUDE_DIRECTORIES(${PYTHON_INCLUDE_PATH})
INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR})

# SET(CMAKE_SWIG_FLAGS "")

SWIG_ADD_MODULE(swiglib1 python swiglib1.i swiglib1.cpp)
SWIG_LINK_LIBRARIES(swiglib1 ${PYTHON_LIBRARIES})
target_link_libraries(_swiglib1 sublib)

# find_package(SWIG REQUIRED)
# find_package( PythonLibs REQUIRED )
# include_directories(${PYTHON_INCLUDE_DIRS})
# python_add_module(_swiglib1 swiglib1_wrap.cxx swiglib1.cpp)
# target_link_libraries(_swiglib1 ${PYTHON_LIBRARY})
