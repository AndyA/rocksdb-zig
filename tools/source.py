# /// script
# requires-python = ">=3.14"
# dependencies = []
# ///
import glob
from typing import Generator

ROCKSDB = "../syndica-rocksdb"

DIRS = [
    "cache",
    "db",
    "env",
    "file",
    "logging",
    "memory",
    "memtable",
    "monitoring",
    "options",
    "table",
    "test_util",
    "tools",
    "trace_replay",
    "util",
    "utilities",
]

EXTRA = [
    "port/mmap.cc",
    "port/stack_trace.cc",
]


def find_sources(root: str, dirs: list[str]) -> Generator[str, None, None]:
    for d in dirs:
        found = glob.glob(f"{d}/**/*.cc", recursive=True, root_dir=root)
        yield from found


for file in find_sources(ROCKSDB, DIRS):
    if file.endswith("_test.cc"):
        continue
    if file.endswith("_bench.cc"):
        continue
    print(file)

for file in EXTRA:
    print(file)
