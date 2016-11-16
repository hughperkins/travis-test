#include "llvm/IR/Module.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/SourceMgr.h"

#include <iostream>
#include <memory>

using namespace std;
using namespace llvm;

int main(int argc, char *argv[]) {
    LLVMContext context;

    string llString = R"(
    define void @foo() {
        ret void
    }
)";

    StringRef llStringRef(llString);
    cout << "got llstringref" << endl;
    unique_ptr<MemoryBuffer> llMemoryBuffer = MemoryBuffer::getMemBuffer(llStringRef);
    cout << "got memory buffer " << endl;
    SMDiagnostic smDiagnostic;
    unique_ptr<Module> M = parseIR(llMemoryBuffer->getMemBufferRef(), smDiagnostic,
                                context);
    cout << "parsed module" << endl;
    if(!M) {
        smDiagnostic.print("irtopencl", errs());
        // return "";
        throw runtime_error("failed to parse IR");
    }

    Function *F = M->getFunction("foo");

    ValueToValueMapTy valueMap;
     // struct ClonedCodeInfo codeInfo;
    Function *newFunc = CloneFunction(F,
                   valueMap,
                   false);

    cout << "done" << endl;
    return 0;
}