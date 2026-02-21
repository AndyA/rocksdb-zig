# Thinks

- unshadow args (`destroy` -> `destroy_`)
- slice -> `char *, i64`
- sentinel term strings -> slice
- slice -> sentinel term string
- error handling (`errptr`)
- callback shims
- thunk between wrapper structs and RockDB handles
- is `unsigned char` always `bool`?
- handle array of slices (e.g. `rocksdb_approximate_sizes`)
- handle parallel array args (e.g. `rocksdb_open_for_read_only_column_families`)

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

We could use the above hint mechanism with some additional auto-discovery for all arg mappings - e.g. find all the functions that have `foo: *const i8, foo_len: i64` and wire an appropriate hint for them.

If necessary we could repeatedly apply all the hints for each function until a fixed point is reached.

# Bugs

- why is everything const?
