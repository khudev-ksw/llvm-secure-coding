#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Instructions.h"
#include "llvm/ADT/SmallSet.h"
using namespace llvm;

namespace {
  struct uafVerify : public FunctionPass {
    static char ID; // Pass identification, replacement for typeid
    uafVerify() : FunctionPass(ID) {}

    //map of free-ed ptr
    std::map<Instruction*, bool> freeedMap;
    SmallSet<Instruction*, 32> userDefCallInsts;

    void getFreeedOperandInst(Function &F)
    {
	
	for(Function::iterator bb = F.begin(), e = F.end(); bb!=e; bb++)
	{
		for(BasicBlock::iterator bbi = bb->begin(), bbie = bb->end();bbi!=bbie;bbi++){
		if(isa<CallInst>(bbi))
	 	{
                        CallInst *tempi = cast<CallInst>(bbi);
                        // check function of bbi is a free or not
                        StringRef callName = tempi->getCalledFunction()->getName();
			if(callName=="free")
                        {
                                errs() << "     Detected function :" << callName << "\n";
                                errs() << "     Instruction value :" << *tempi << "\n";
                                
                                //retreive operands of free
                                for(Use &U :tempi->operands())
                                {
					if((U.get())->getName()!="free")
					{
						Instruction* freeedOp = cast<Instruction>(U.get());
	                                        errs() << "     free-ed operands :" << *(freeedOp) << "\n";
						// call @free -> fist operand -> bitcast -> first operand -> select operand(original ptr)
						Instruction* preorigin = cast<Instruction>(freeedOp->getOperand(0));
						errs() << "     pre-origin : " << *(preorigin) << "\n";
						Instruction* originPtr = cast<Instruction>(preorigin->getOperand(0));
						errs() << "     origin : " << *(originPtr) << "\n\n";
						freeedMap[originPtr] = true;

					}

                                }
                        }
	 	}
	}}
    }

    void printEveryInstOp(Function &F)
    {
	for(Function::iterator bb = F.begin(), e = F.end(); bb!=e; bb++)
	{
		for(BasicBlock::iterator bbi = bb->begin(), bbie = bb->end();bbi!=bbie;bbi++)
		{
			errs() << *bbi << "\n";
			for(Use &U :bbi->operands())
			{
				errs() << "   " << *(U.get()) << "\n";
			}
		}
	}
    }

    void printUserDefCallInst(Function &F)
    {
        for(Function::iterator bb = F.begin(), e = F.end(); bb!=e; bb++)
        {
                for(BasicBlock::iterator bbi = bb->begin(), bbie = bb->end();bbi!=bbie;bbi++)
                {
                        if(isa<CallInst>(bbi))
			{
				for(Use &U :bbi->operands())
				{

					if(U.get()->getName()!="free" && U.get()->getName()!="malloc" && U.get()->getName()!="")
					{

						userDefCallInsts.insert(&(*bbi));
					}
				}
			}

                }
        }
    }

    bool runOnFunction(Function &F) override {
      getFreeedOperandInst(F);

      // print all freeed map
      std::map<Instruction*, bool>::iterator mi = freeedMap.begin();
      std::map<Instruction*, bool>::iterator me = freeedMap.end();
      while(mi!=me)
      {
	errs() << *(mi->first) << " ::: " << mi->first << " ::: " << mi->second << "\n\n";
        mi++;
      }

      printEveryInstOp(F);
      printUserDefCallInst(F);
      for(auto S :userDefCallInsts) errs() << *S << " ::: " << &(*S) << "\n";
      freeedMap.clear();

    }
  };
}

char uafVerify::ID = 0;
static RegisterPass<uafVerify> X("uafVerify", "use-after-free test - find free inst");
