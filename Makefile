# RISC-V VHDL Makefile 

VHDL_COMPILER = ghdl
SIMULATOR = ghdl
PACKAGE_FILES := $(wildcard Packages/*.vhd)
SOURCE_FILES := $(wildcard Modules/*.vhd)
TESTBENCH_FILES = $(wildcard Testbenches/*.vhd)


check_syntax:
	$(VHDL_COMPILER) -s $(PACKAGE_FILES) $(SOURCE_FILES) &> output.txt

check_syntax_terminal:
	$(VHDL_COMPILER) -s $(PACKAGE_FILES) $(SOURCE_FILES)

simulate:
	$(VHDL_COMPILER) -a  --workdir=bld $(PACKAGE_FILES)
	$(VHDL_COMPILER) -a  --workdir=bld $(SOURCE_FILES)

run:
	make simulate
	$(VHDL_COMPILER) -a  --workdir=bld $(TESTBENCH_FILES)
	$(VHDL_COMPILER) -e  --workdir=bld $(TESTBENCH_ENTITY)
	$(SIMULATOR) -r --workdir=bld $(TESTBENCH_ENTITY) --wave=vcd/$(TESTBENCH_ENTITY).ghw

view:
	gtkwave vcd/$(TESTBENCH_ENTITY).ghw
	

# Clean target to remove generated files
clean:
	rm -f *.o *.cf $(VCD_FILE)
	rm -rf bld vcd schematics
	mkdir bld vcd schematics
	mkdir bld/Verilog bld/json



MODULES = programme_counter registers rege data_memory program_memory alu
schematic: $(MODULES)
$(MODULES):
	make simulate
	cd bld;\
	ghdl -a ../Modules/$@.vhd;\
	$(VHDL_COMPILER) --synth --out=verilog $@ > Verilog/$@.v;\
	yosys -p "prep -top $@; write_json json/$@.json" Verilog/$@.v;\
	netlistsvg json/$@.json -o ../schematics/$@.svg;\