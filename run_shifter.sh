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

ghdl -a --std=08 Constant_Package.vhdl my_shifter.vhdl my_shifter_tb.vhdl my_shifter_tb2.vhdl

ghdl -e --std=08 my_shifter_tb

ghdl -r --std=08 my_shifter_tb

ghdl -e --std=08 my_shifter_tb2

ghdl -r --std=08 my_shifter_tb2

