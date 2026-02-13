from functools import reduce


def common_prefix(names: list[str]) -> str:
    def common(a: list[str], b: list[str]) -> list[str]:
        lim = min(len(a), len(b))
        for i in range(lim):
            if a[i] != b[i]:
                return a[:i]
        return a[:lim]

    assert len(names) > 0
    parts = [n.split("_") for n in names]
    prefix = reduce(common, parts)
    return "_".join(prefix)


names = [
    "rocksdb_approximate_memory_usage_destroy",
    "rocksdb_approximate_memory_usage_get_mem_table_total",
    "rocksdb_approximate_memory_usage_get_mem_table_unflushed",
    "rocksdb_approximate_memory_usage_get_mem_table_readers_total",
    "rocksdb_approximate_memory_usage_get_cache_total",
]


print(common_prefix(names))
