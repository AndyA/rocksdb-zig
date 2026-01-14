# /// script
# requires-python = ">=3.14"
# dependencies = []
# ///
import glob
from typing import Generator

ROCKSDB = "../rocksdb"

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

EXCLUDE = {
    "cache/cache_bench_tool.cc",
    "db/db_test2.cc",
    "db/db_test_util.cc",
    "db/db_with_timestamp_test_util.cc",
    "monitoring/thread_status_updater_debug.cc",
    "table/mock_table.cc",
    "test_util/mock_time_env.cc",
    "test_util/secondary_cache_test_util.cc",
    "test_util/testharness.cc",
    "tools/blob_dump.cc",
    "tools/block_cache_analyzer/block_cache_trace_analyzer_tool.cc",
    "tools/db_bench_tool.cc",
    "tools/db_repl_stress.cc",
    "tools/dump/rocksdb_dump.cc",
    "tools/dump/rocksdb_undump.cc",
    "tools/io_tracer_parser.cc",
    "tools/ldb.cc",
    "tools/ldb_cmd.cc",
    "tools/ldb_tool.cc",
    "tools/simulated_hybrid_file_system.cc",
    "tools/sst_dump.cc",
    "tools/sst_dump_tool.cc",
    "tools/trace_analyzer.cc",
    "tools/write_stress.cc",
    "utilities/agg_merge/test_agg_merge.cc",
    "utilities/cassandra/test_utils.cc",
    "utilities/convenience/info_log_finder.cc",
    "utilities/secondary_index/faiss_ivf_index.cc",
}


def find_sources(root: str, dirs: list[str]) -> Generator[str, None, None]:
    for d in dirs:
        found = glob.glob(f"{d}/**/*.cc", recursive=True, root_dir=root)
        yield from found


for file in find_sources(ROCKSDB, DIRS):
    if file in EXCLUDE:
        continue
    if file.endswith("_test.cc"):
        continue
    if file.endswith("_bench.cc"):
        continue
    if file.endswith("_posix.cc"):
        continue
    if file.endswith("_arm64.cc"):
        continue
    print(f'"{file}",')

for file in EXTRA:
    print(f'"{file}",')
