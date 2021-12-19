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
		// errs() << &(*bbi) << "\n";
		if(isa<CallInst>(bbi))
	 	{
			//errs() << &(*bbi) << "\n";
                        CallInst *tempi = cast<CallInst>(bbi);
                        // check function of bbi is a free or not
                        StringRef callName = tempi->getCalledFunction()->getName();
			if(callName=="free")
                        {
                                errs() << "     Detected function :" << callName << "\n";
                                //errs() << "Instruction address(bbi) :" << &(*bbi)  << "\n";
                                errs() << "     Instruction value :" << *tempi << "\n";
                                
                                //retreive operands of free
                                for(Use &U :tempi->operands())
                                {
                                        //errs() << "     Is it a free function declaration?: ";
                                        //if((U.get())->getName()=="free") errs() << "Yes\n";
					if((U.get())->getName()!="free")
					{
						//errs() << "No\n";
						Instruction* freeedOp = cast<Instruction>(U.get());
	                                        errs() << "     free-ed operands :" << *(freeedOp) << "\n";
						// call @free -> fist operand -> bitcast -> first operand -> select operand(original ptr)
						Instruction* preorigin = cast<Instruction>(freeedOp->getOperand(0));
						errs() << "     pre-origin : " << *(preorigin) << "\n";
						Instruction* originPtr = cast<Instruction>(preorigin->getOperand(0));
						errs() << "     origin : " << *(originPtr) << "\n\n";
						freeedMap[originPtr] = true;

					}
                                        //errs() << "tempi function :" << ((U.get())->getName()) << "\n";
                                        //check the operands is a ptr or not
                                        //errs() << "type of operands :" << *((U.get())->getType()) << "\n";
                                        //if(isa<PointerType>((U.get())->getType())) errs() << "Is A ptr\n\n";
                                        //else errs() << "Not a ptr\n\n";
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
				//CallInst* callbbi = cast<CallInst>(bbi);
				for(Use &U :bbi->operands())
				{
					//errs() << "U.get() : " << U.get()->getName() << "\n";
					//Instruction* bbiop = cast<Instruction>(U.get());
					if(U.get()->getName()!="free" && U.get()->getName()!="malloc" && U.get()->getName()!="")
					{
						//errs() << U.get()->getName() << "\n";
						//errs() << *bbi << "\n";
						userDefCallInsts.insert(&(*bbi));
					}
				}
			}
                        /*for(Use &U :bbi->operands())
                        {
                                errs() << "   " << *(U.get()) << "\n";
                        }*/
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

      // printEveryInstOp(F);
      // printUserDefCallInst(F);
      // for(auto S :userDefCallInsts) errs() << *S << " ::: " << &(*S) << "\n";
      freeedMap.clear();

    }
  };
}

char uafVerify::ID = 0;
static RegisterPass<uafVerify> X("uafVerify", "use-after-free test - find free inst");
