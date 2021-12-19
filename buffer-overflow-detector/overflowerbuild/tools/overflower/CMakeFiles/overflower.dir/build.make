# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/seoyeonroh/buffer-overflow-detector

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/seoyeonroh/buffer-overflow-detector/overflowerbuild

# Include any dependencies generated for this target.
include tools/overflower/CMakeFiles/overflower.dir/depend.make

# Include the progress variables for this target.
include tools/overflower/CMakeFiles/overflower.dir/progress.make

# Include the compile flags for this target's objects.
include tools/overflower/CMakeFiles/overflower.dir/flags.make

tools/overflower/CMakeFiles/overflower.dir/main.cpp.o: tools/overflower/CMakeFiles/overflower.dir/flags.make
tools/overflower/CMakeFiles/overflower.dir/main.cpp.o: ../tools/overflower/main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/seoyeonroh/buffer-overflow-detector/overflowerbuild/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object tools/overflower/CMakeFiles/overflower.dir/main.cpp.o"
	cd /home/seoyeonroh/buffer-overflow-detector/overflowerbuild/tools/overflower && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/overflower.dir/main.cpp.o -c /home/seoyeonroh/buffer-overflow-detector/tools/overflower/main.cpp

tools/overflower/CMakeFiles/overflower.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/overflower.dir/main.cpp.i"
	cd /home/seoyeonroh/buffer-overflow-detector/overflowerbuild/tools/overflower && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/seoyeonroh/buffer-overflow-detector/tools/overflower/main.cpp > CMakeFiles/overflower.dir/main.cpp.i

tools/overflower/CMakeFiles/overflower.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/overflower.dir/main.cpp.s"
	cd /home/seoyeonroh/buffer-overflow-detector/overflowerbuild/tools/overflower && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/seoyeonroh/buffer-overflow-detector/tools/overflower/main.cpp -o CMakeFiles/overflower.dir/main.cpp.s

# Object files for target overflower
overflower_OBJECTS = \
"CMakeFiles/overflower.dir/main.cpp.o"

# External object files for target overflower
overflower_EXTERNAL_OBJECTS =

bin/overflower: tools/overflower/CMakeFiles/overflower.dir/main.cpp.o
bin/overflower: tools/overflower/CMakeFiles/overflower.dir/build.make
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAArch64CodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAArch64AsmParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAArch64Desc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAArch64Disassembler.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAArch64Info.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAArch64Utils.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAMDGPUCodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAMDGPUAsmParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAMDGPUDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAMDGPUDisassembler.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAMDGPUInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAMDGPUUtils.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMARMCodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMARMAsmParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMARMDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMARMDisassembler.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMARMInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMARMUtils.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMBPFCodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMBPFAsmParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMBPFDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMBPFDisassembler.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMBPFInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMHexagonCodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMHexagonAsmParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMHexagonDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMHexagonDisassembler.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMHexagonInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMLanaiCodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMLanaiAsmParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMLanaiDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMLanaiDisassembler.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMLanaiInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMMipsCodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMMipsAsmParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMMipsDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMMipsDisassembler.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMMipsInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMMSP430CodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMMSP430AsmParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMMSP430Desc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMMSP430Disassembler.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMMSP430Info.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMNVPTXCodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMNVPTXDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMNVPTXInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMPowerPCCodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMPowerPCAsmParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMPowerPCDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMPowerPCDisassembler.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMPowerPCInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMRISCVCodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMRISCVAsmParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMRISCVDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMRISCVDisassembler.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMRISCVInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMRISCVUtils.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMSparcCodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMSparcAsmParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMSparcDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMSparcDisassembler.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMSparcInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMSystemZCodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMSystemZAsmParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMSystemZDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMSystemZDisassembler.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMSystemZInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMWebAssemblyCodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMWebAssemblyAsmParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMWebAssemblyDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMWebAssemblyDisassembler.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMWebAssemblyInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMX86CodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMX86AsmParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMX86Desc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMX86Disassembler.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMX86Info.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMX86Utils.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMXCoreCodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMXCoreDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMXCoreDisassembler.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMXCoreInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAVRCodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAVRAsmParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAVRDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAVRDisassembler.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAVRInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAsmParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMCore.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMLinker.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMBitReader.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMIRReader.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMipo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMScalarOpts.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAnalysis.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMSupport.a
bin/overflower: /usr/lib/x86_64-linux-gnu/libcurses.so
bin/overflower: /usr/lib/x86_64-linux-gnu/libform.so
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAArch64Desc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAArch64Info.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAArch64Utils.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMMIRParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAMDGPUDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAMDGPUInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAMDGPUUtils.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMARMDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMARMInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMARMUtils.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMHexagonDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMHexagonInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMLanaiDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMLanaiInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMLinker.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMIRReader.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAsmParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMInstrumentation.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMVectorize.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMSystemZDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMSystemZInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMWebAssemblyDesc.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMWebAssemblyInfo.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMCFGuard.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMGlobalISel.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAsmPrinter.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMDebugInfoDWARF.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMSelectionDAG.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMCodeGen.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMScalarOpts.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAggressiveInstCombine.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMInstCombine.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMBitWriter.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMTransformUtils.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMTarget.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMAnalysis.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMProfileData.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMObject.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMBitReader.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMCore.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMRemarks.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMBitstreamReader.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMTextAPI.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMMCParser.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMMCDisassembler.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMMC.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMBinaryFormat.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMDebugInfoCodeView.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMDebugInfoMSF.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMSupport.a
bin/overflower: /usr/lib/llvm-10/lib/libLLVMDemangle.a
bin/overflower: tools/overflower/CMakeFiles/overflower.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/seoyeonroh/buffer-overflow-detector/overflowerbuild/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../../bin/overflower"
	cd /home/seoyeonroh/buffer-overflow-detector/overflowerbuild/tools/overflower && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/overflower.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tools/overflower/CMakeFiles/overflower.dir/build: bin/overflower

.PHONY : tools/overflower/CMakeFiles/overflower.dir/build

tools/overflower/CMakeFiles/overflower.dir/clean:
	cd /home/seoyeonroh/buffer-overflow-detector/overflowerbuild/tools/overflower && $(CMAKE_COMMAND) -P CMakeFiles/overflower.dir/cmake_clean.cmake
.PHONY : tools/overflower/CMakeFiles/overflower.dir/clean

tools/overflower/CMakeFiles/overflower.dir/depend:
	cd /home/seoyeonroh/buffer-overflow-detector/overflowerbuild && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/seoyeonroh/buffer-overflow-detector /home/seoyeonroh/buffer-overflow-detector/tools/overflower /home/seoyeonroh/buffer-overflow-detector/overflowerbuild /home/seoyeonroh/buffer-overflow-detector/overflowerbuild/tools/overflower /home/seoyeonroh/buffer-overflow-detector/overflowerbuild/tools/overflower/CMakeFiles/overflower.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : tools/overflower/CMakeFiles/overflower.dir/depend
