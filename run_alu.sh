#!/usr/bin/env bash
set -euo pipefail

WIDTH=${1:-4}

python - <<PY
import re
path = "Constant_Package.vhdl"
with open(path, "r", encoding="utf-8") as f:
    data = f.read()
new_data, count = re.subn(
    r"(constant\\s+C_DWG\\s*:\\s*Integer\\s*:=\\s*)\\d+",
    r"\\g<1>" + str(${WIDTH}),
    data,
)
if count == 0:
    raise SystemExit("C_DWG constant not found")
with open(path, "w", encoding="utf-8") as f:
    f.write(new_data)
PY

rm -f *.o *.cf

ghdl -a --std=08 Constant_Package.vhdl my_half_adder.vhdl my_full_adder.vhdl my_gen_and.vhdl my_gen_or.vhdl my_gen_xor.vhdl my_gen_add_sub.vhdl my_shifter.vhdl my_alu.vhdl my_alu_tb.vhdl

ghdl -e --std=08 my_alu_tb

ghdl -r --std=08 my_alu_tb

