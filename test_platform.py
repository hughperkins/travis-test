from __future__ import print_function
import platform

sharedobject_extension = '.so'
print('platform uname[0]', platform.uname()[0])
if platform.uname()[0] == 'Darwin':
  sharedobject_extension = '.dylib'
print('sharedobject_extension', sharedobject_extension)
