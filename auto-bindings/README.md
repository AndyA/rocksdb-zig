# Thinks

- ~~unshadow args (`destroy` -> `destroy_`)~~
- ~~slice -> `char *, i64`~~
- error handling (`errptr`)
- thunk between wrapper structs and RockDB handles
- sentinel term strings -> slice
- slice -> sentinel term string
- callback shims
- is `unsigned char` always `bool`?
- handle array of slices (e.g. `rocksdb_approximate_sizes`)
- handle parallel array args (e.g. `rocksdb_open_for_read_only_column_families`)
- possible nullability of return types
- setters return their invocant?

```python
rule(
    fns=[
        "rocksdb_open_for_read_only_column_families",
        "rocksdb_open_column_families_with_ttl",
    ],
    strategy=parallel_arrays,
    args={
        "count": "num_column_families",
        "arrays": [
            "column_family_names",
            "column_family_options",
            "column_family_handles",
        ],
    },
)


def parallel_arrays(
    ctx: Context, fn: Fn, *, count: str, arrays: list[str]
) -> Optional[Fn]:
    # TODO handle parallel arrays
    return None

```
