# Thinks

- ~~unshadow args (`destroy` -> `destroy_`)~~
- ~~slice -> `char *, i64`~~
- thunk between wrapper structs and RockDB handles
- rename `Self` arg as `self`
- error handling (`errptr`)
- sentinel term strings -> slice
- slice -> sentinel term string
- callback shims
- is `unsigned char` always `bool`?
- handle array of slices (e.g. `rocksdb_approximate_sizes`)
- handle parallel array args (e.g. `rocksdb_open_for_read_only_column_families`)
- setters return their invocant?
- classifying `[*c]` pointers
  - nullable
  - array
  - ref to additional return value

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

# Bugs

`getFullHistoryTsLow` has `ts_lowlen` but no `ts_low`

Odd `size_t` must be wrong:

```zig
   pub fn updateTimestamps(
        wbwi: *Self,
        ts: []const u8,
        state: *anyopaque,
        size_t: fn (
            [*c]i64,
        ) i64,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_writebatch_wi_update_timestamps(
            helpers.unwrap(wbwi.*),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
            state,
            size_t,
            errptr,
        );
    }
```

```c
extern ROCKSDB_LIBRARY_API void rocksdb_writebatch_wi_update_timestamps(
    rocksdb_writebatch_wi_t* wbwi,
    const char* ts,
    size_t tslen,
    void* state,
    size_t (*get_ts_size)(void*, uint32_t), char** errptr);
```

Turns out we're picking up the return type of the callback rather than its name.
