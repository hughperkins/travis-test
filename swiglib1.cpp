#include <iostream>
using namespace std;

#include "sublib.h"

extern "C" {
    void foo();
}

void foo() {
    cout << "foo()" << endl;
    mysublibfunc();
}
