const std = @import("std");
const assert = std.debug.assert;

const helpers = @import("./helpers.zig");

const api = @import("rocksdb");

pub fn listColumnFamiliesDestroy(list: [*c][*c]i8, len: i64) void {
    return api.rocksdb_list_column_families_destroy(list, len);
}

pub fn createColumnFamiliesDestroy(
    list: [*c][*c]api.rocksdb_column_family_handle_t,
) void {
    return api.rocksdb_create_column_families_destroy(list);
}

pub fn loadLatestOptions(
    db_path: [*c]const i8,
    env: *RocksdbEnv,
    ignore_unknown_options: i64,
    cache: *RocksdbCache,
    db_options: [*c][*c]api.rocksdb_options_t,
    num_column_families: [*c]i64,
    column_family_names: [*c][*c][*c]i8,
    column_family_options: [*c][*c][*c]api.rocksdb_options_t,
    errptr: [*c][*c]i8,
) void {
    return api.rocksdb_load_latest_options(
        db_path,
        helpers.unwrap(env.*),
        ignore_unknown_options,
        helpers.unwrap(cache.*),
        db_options,
        num_column_families,
        column_family_names,
        column_family_options,
        errptr,
    );
}

pub fn setPerfLevel(arg0: i64) void {
    return api.rocksdb_set_perf_level(arg0);
}

pub fn free(ptr: *anyopaque) void {
    return api.rocksdb_free(ptr);
}

pub const RocksdbBackupEngineInfo = packed struct {
    const Self = @This();
    ref: *api.rocksdb_backup_engine_info_t,

    pub fn count(info: Self) i64 {
        return api.rocksdb_backup_engine_info_count(helpers.unwrap(info));
    }

    pub fn timestamp(info: Self, index: i64) i64 {
        return api.rocksdb_backup_engine_info_timestamp(helpers.unwrap(info), index);
    }

    pub fn backupId(info: Self, index: i64) i64 {
        return api.rocksdb_backup_engine_info_backup_id(helpers.unwrap(info), index);
    }

    pub fn size(info: Self, index: i64) i64 {
        return api.rocksdb_backup_engine_info_size(helpers.unwrap(info), index);
    }

    pub fn numberFiles(info: Self, index: i64) i64 {
        return api.rocksdb_backup_engine_info_number_files(helpers.unwrap(info), index);
    }

    pub fn destroy(info: Self) void {
        return api.rocksdb_backup_engine_info_destroy(helpers.unwrap(info));
    }

    test RocksdbBackupEngineInfo {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbBackupEngineOptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_backup_engine_options_t,

    pub fn create(backup_dir: [*c]const i8) [*c]api.rocksdb_backup_engine_options_t {
        return api.rocksdb_backup_engine_options_create(backup_dir);
    }

    pub fn setBackupDir(options: *Self, backup_dir: [*c]const i8) void {
        return api.rocksdb_backup_engine_options_set_backup_dir(
            helpers.unwrap(options.*),
            backup_dir,
        );
    }

    pub fn setEnv(options: *Self, env: *RocksdbEnv) void {
        return api.rocksdb_backup_engine_options_set_env(
            helpers.unwrap(options.*),
            helpers.unwrap(env.*),
        );
    }

    pub fn setShareTableFiles(options: *Self, val: u8) void {
        return api.rocksdb_backup_engine_options_set_share_table_files(
            helpers.unwrap(options.*),
            val,
        );
    }

    pub fn getShareTableFiles(options: *Self) u8 {
        return api.rocksdb_backup_engine_options_get_share_table_files(
            helpers.unwrap(options.*),
        );
    }

    pub fn setSync(options: *Self, val: u8) void {
        return api.rocksdb_backup_engine_options_set_sync(helpers.unwrap(options.*), val);
    }

    pub fn getSync(options: *Self) u8 {
        return api.rocksdb_backup_engine_options_get_sync(helpers.unwrap(options.*));
    }

    pub fn setDestroyOldData(options: *Self, val: u8) void {
        return api.rocksdb_backup_engine_options_set_destroy_old_data(
            helpers.unwrap(options.*),
            val,
        );
    }

    pub fn getDestroyOldData(options: *Self) u8 {
        return api.rocksdb_backup_engine_options_get_destroy_old_data(
            helpers.unwrap(options.*),
        );
    }

    pub fn setBackupLogFiles(options: *Self, val: u8) void {
        return api.rocksdb_backup_engine_options_set_backup_log_files(
            helpers.unwrap(options.*),
            val,
        );
    }

    pub fn getBackupLogFiles(options: *Self) u8 {
        return api.rocksdb_backup_engine_options_get_backup_log_files(
            helpers.unwrap(options.*),
        );
    }

    pub fn setBackupRateLimit(options: *Self, limit: i64) void {
        return api.rocksdb_backup_engine_options_set_backup_rate_limit(
            helpers.unwrap(options.*),
            limit,
        );
    }

    pub fn getBackupRateLimit(options: *Self) i64 {
        return api.rocksdb_backup_engine_options_get_backup_rate_limit(
            helpers.unwrap(options.*),
        );
    }

    pub fn setRestoreRateLimit(options: *Self, limit: i64) void {
        return api.rocksdb_backup_engine_options_set_restore_rate_limit(
            helpers.unwrap(options.*),
            limit,
        );
    }

    pub fn getRestoreRateLimit(options: *Self) i64 {
        return api.rocksdb_backup_engine_options_get_restore_rate_limit(
            helpers.unwrap(options.*),
        );
    }

    pub fn setMaxBackgroundOperations(options: *Self, val: i64) void {
        return api.rocksdb_backup_engine_options_set_max_background_operations(
            helpers.unwrap(options.*),
            val,
        );
    }

    pub fn getMaxBackgroundOperations(options: *Self) i64 {
        return api.rocksdb_backup_engine_options_get_max_background_operations(
            helpers.unwrap(options.*),
        );
    }

    pub fn setCallbackTriggerIntervalSize(options: *Self, size: i64) void {
        return api.rocksdb_backup_engine_options_set_callback_trigger_interval_size(
            helpers.unwrap(options.*),
            size,
        );
    }

    pub fn getCallbackTriggerIntervalSize(options: *Self) i64 {
        return api.rocksdb_backup_engine_options_get_callback_trigger_interval_size(
            helpers.unwrap(options.*),
        );
    }

    pub fn setMaxValidBackupsToOpen(options: *Self, val: i64) void {
        return api.rocksdb_backup_engine_options_set_max_valid_backups_to_open(
            helpers.unwrap(options.*),
            val,
        );
    }

    pub fn getMaxValidBackupsToOpen(options: *Self) i64 {
        return api.rocksdb_backup_engine_options_get_max_valid_backups_to_open(
            helpers.unwrap(options.*),
        );
    }

    pub fn setShareFilesWithChecksumNaming(options: *Self, val: i64) void {
        return api.rocksdb_backup_engine_options_set_share_files_with_checksum_naming(
            helpers.unwrap(options.*),
            val,
        );
    }

    pub fn getShareFilesWithChecksumNaming(options: *Self) i64 {
        return api.rocksdb_backup_engine_options_get_share_files_with_checksum_naming(
            helpers.unwrap(options.*),
        );
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_backup_engine_options_destroy(helpers.unwrap(arg0.*));
    }

    test RocksdbBackupEngineOptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbBackupEngine = packed struct {
    const Self = @This();
    ref: *api.rocksdb_backup_engine_t,

    pub fn open(
        options: RocksdbOptions,
        path: [*c]const i8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_backup_engine_t {
        return api.rocksdb_backup_engine_open(helpers.unwrap(options), path, errptr);
    }

    pub fn openOpts(
        options: RocksdbBackupEngineOptions,
        env: *RocksdbEnv,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_backup_engine_t {
        return api.rocksdb_backup_engine_open_opts(
            helpers.unwrap(options),
            helpers.unwrap(env.*),
            errptr,
        );
    }

    pub fn createNewBackup(be: *Self, db: *Rocksdb, errptr: [*c][*c]i8) void {
        return api.rocksdb_backup_engine_create_new_backup(
            helpers.unwrap(be.*),
            helpers.unwrap(db.*),
            errptr,
        );
    }

    pub fn createNewBackupFlush(
        be: *Self,
        db: *Rocksdb,
        flush_before_backup: u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_backup_engine_create_new_backup_flush(
            helpers.unwrap(be.*),
            helpers.unwrap(db.*),
            flush_before_backup,
            errptr,
        );
    }

    pub fn purgeOldBackups(
        be: *Self,
        num_backups_to_keep: i64,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_backup_engine_purge_old_backups(
            helpers.unwrap(be.*),
            num_backups_to_keep,
            errptr,
        );
    }

    pub fn verifyBackup(be: *Self, backup_id: i64, errptr: [*c][*c]i8) void {
        return api.rocksdb_backup_engine_verify_backup(
            helpers.unwrap(be.*),
            backup_id,
            errptr,
        );
    }

    pub fn restoreDbFromLatestBackup(
        be: *Self,
        db_dir: [*c]const i8,
        wal_dir: [*c]const i8,
        restore_options: RocksdbRestoreOptions,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_backup_engine_restore_db_from_latest_backup(
            helpers.unwrap(be.*),
            db_dir,
            wal_dir,
            helpers.unwrap(restore_options),
            errptr,
        );
    }

    pub fn restoreDbFromBackup(
        be: *Self,
        db_dir: [*c]const i8,
        wal_dir: [*c]const i8,
        restore_options: RocksdbRestoreOptions,
        backup_id: i64,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_backup_engine_restore_db_from_backup(
            helpers.unwrap(be.*),
            db_dir,
            wal_dir,
            helpers.unwrap(restore_options),
            backup_id,
            errptr,
        );
    }

    pub fn getBackupInfo(be: *Self) [*c]const api.rocksdb_backup_engine_info_t {
        return api.rocksdb_backup_engine_get_backup_info(helpers.unwrap(be.*));
    }

    pub fn close(be: *Self) void {
        return api.rocksdb_backup_engine_close(helpers.unwrap(be.*));
    }

    test RocksdbBackupEngine {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbBlockBasedTableOptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_block_based_table_options_t,

    pub fn create() [*c]api.rocksdb_block_based_table_options_t {
        return api.rocksdb_block_based_options_create();
    }

    pub fn destroy(options: *Self) void {
        return api.rocksdb_block_based_options_destroy(helpers.unwrap(options.*));
    }

    pub fn setChecksum(arg0: *Self, arg1: i8) void {
        return api.rocksdb_block_based_options_set_checksum(helpers.unwrap(arg0.*), arg1);
    }

    pub fn setBlockSize(options: *Self, block_size: i64) void {
        return api.rocksdb_block_based_options_set_block_size(
            helpers.unwrap(options.*),
            block_size,
        );
    }

    pub fn setBlockSizeDeviation(options: *Self, block_size_deviation: i64) void {
        return api.rocksdb_block_based_options_set_block_size_deviation(
            helpers.unwrap(options.*),
            block_size_deviation,
        );
    }

    pub fn setBlockRestartInterval(
        options: *Self,
        block_restart_interval: i64,
    ) void {
        return api.rocksdb_block_based_options_set_block_restart_interval(
            helpers.unwrap(options.*),
            block_restart_interval,
        );
    }

    pub fn setIndexBlockRestartInterval(
        options: *Self,
        index_block_restart_interval: i64,
    ) void {
        return api.rocksdb_block_based_options_set_index_block_restart_interval(
            helpers.unwrap(options.*),
            index_block_restart_interval,
        );
    }

    pub fn setMetadataBlockSize(options: *Self, metadata_block_size: i64) void {
        return api.rocksdb_block_based_options_set_metadata_block_size(
            helpers.unwrap(options.*),
            metadata_block_size,
        );
    }

    pub fn setPartitionFilters(options: *Self, partition_filters: u8) void {
        return api.rocksdb_block_based_options_set_partition_filters(
            helpers.unwrap(options.*),
            partition_filters,
        );
    }

    pub fn setOptimizeFiltersForMemory(
        options: *Self,
        optimize_filters_for_memory: u8,
    ) void {
        return api.rocksdb_block_based_options_set_optimize_filters_for_memory(
            helpers.unwrap(options.*),
            optimize_filters_for_memory,
        );
    }

    pub fn setUseDeltaEncoding(options: *Self, use_delta_encoding: u8) void {
        return api.rocksdb_block_based_options_set_use_delta_encoding(
            helpers.unwrap(options.*),
            use_delta_encoding,
        );
    }

    pub fn setFilterPolicy(
        options: *Self,
        filter_policy: *RocksdbFilterpolicy,
    ) void {
        return api.rocksdb_block_based_options_set_filter_policy(
            helpers.unwrap(options.*),
            helpers.unwrap(filter_policy.*),
        );
    }

    pub fn setNoBlockCache(options: *Self, no_block_cache: u8) void {
        return api.rocksdb_block_based_options_set_no_block_cache(
            helpers.unwrap(options.*),
            no_block_cache,
        );
    }

    pub fn setBlockCache(options: *Self, block_cache: *RocksdbCache) void {
        return api.rocksdb_block_based_options_set_block_cache(
            helpers.unwrap(options.*),
            helpers.unwrap(block_cache.*),
        );
    }

    pub fn setWholeKeyFiltering(arg0: *Self, arg1: u8) void {
        return api.rocksdb_block_based_options_set_whole_key_filtering(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn setFormatVersion(arg0: *Self, arg1: i64) void {
        return api.rocksdb_block_based_options_set_format_version(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn setIndexType(arg0: *Self, arg1: i64) void {
        return api.rocksdb_block_based_options_set_index_type(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn setDataBlockIndexType(arg0: *Self, arg1: i64) void {
        return api.rocksdb_block_based_options_set_data_block_index_type(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn setDataBlockHashRatio(options: *Self, v: f64) void {
        return api.rocksdb_block_based_options_set_data_block_hash_ratio(
            helpers.unwrap(options.*),
            v,
        );
    }

    pub fn setCacheIndexAndFilterBlocks(arg0: *Self, arg1: u8) void {
        return api.rocksdb_block_based_options_set_cache_index_and_filter_blocks(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn setCacheIndexAndFilterBlocksWithHighPriority(arg0: *Self, arg1: u8) void {
        return api.rocksdb_block_based_options_set_cache_index_and_filter_blocks_with_high_priority(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn setPinL0FilterAndIndexBlocksInCache(arg0: *Self, arg1: u8) void {
        return api.rocksdb_block_based_options_set_pin_l0_filter_and_index_blocks_in_cache(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn setPinTopLevelIndexAndFilter(arg0: *Self, arg1: u8) void {
        return api.rocksdb_block_based_options_set_pin_top_level_index_and_filter(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn setTopLevelIndexPinningTier(arg0: *Self, arg1: i64) void {
        return api.rocksdb_block_based_options_set_top_level_index_pinning_tier(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn setPartitionPinningTier(arg0: *Self, arg1: i64) void {
        return api.rocksdb_block_based_options_set_partition_pinning_tier(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn setUnpartitionedPinningTier(arg0: *Self, arg1: i64) void {
        return api.rocksdb_block_based_options_set_unpartitioned_pinning_tier(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    test RocksdbBlockBasedTableOptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbCache = packed struct {
    const Self = @This();
    ref: *api.rocksdb_cache_t,

    pub fn createLru(capacity: i64) [*c]api.rocksdb_cache_t {
        return api.rocksdb_cache_create_lru(capacity);
    }

    pub fn createLruWithStrictCapacityLimit(capacity: i64) [*c]api.rocksdb_cache_t {
        return api.rocksdb_cache_create_lru_with_strict_capacity_limit(capacity);
    }

    pub fn createLruOpts(arg0: RocksdbLruCacheOptions) [*c]api.rocksdb_cache_t {
        return api.rocksdb_cache_create_lru_opts(helpers.unwrap(arg0));
    }

    pub fn destroy(cache: *Self) void {
        return api.rocksdb_cache_destroy(helpers.unwrap(cache.*));
    }

    pub fn disownData(cache: *Self) void {
        return api.rocksdb_cache_disown_data(helpers.unwrap(cache.*));
    }

    pub fn setCapacity(cache: *Self, capacity: i64) void {
        return api.rocksdb_cache_set_capacity(helpers.unwrap(cache.*), capacity);
    }

    pub fn getCapacity(cache: Self) i64 {
        return api.rocksdb_cache_get_capacity(helpers.unwrap(cache));
    }

    pub fn getUsage(cache: Self) i64 {
        return api.rocksdb_cache_get_usage(helpers.unwrap(cache));
    }

    pub fn getPinnedUsage(cache: Self) i64 {
        return api.rocksdb_cache_get_pinned_usage(helpers.unwrap(cache));
    }

    pub fn getTableAddressCount(cache: Self) i64 {
        return api.rocksdb_cache_get_table_address_count(helpers.unwrap(cache));
    }

    pub fn getOccupancyCount(cache: Self) i64 {
        return api.rocksdb_cache_get_occupancy_count(helpers.unwrap(cache));
    }

    pub fn createHyperClock(
        capacity: i64,
        estimated_entry_charge: i64,
    ) [*c]api.rocksdb_cache_t {
        return api.rocksdb_cache_create_hyper_clock(capacity, estimated_entry_charge);
    }

    pub fn createHyperClockOpts(
        arg0: RocksdbHyperClockCacheOptions,
    ) [*c]api.rocksdb_cache_t {
        return api.rocksdb_cache_create_hyper_clock_opts(helpers.unwrap(arg0));
    }

    test RocksdbCache {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbCheckpoint = packed struct {
    const Self = @This();
    ref: *api.rocksdb_checkpoint_t,

    pub fn objectCreate(
        db: *Rocksdb,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_checkpoint_t {
        return api.rocksdb_checkpoint_object_create(helpers.unwrap(db.*), errptr);
    }

    pub fn create(
        checkpoint: *Self,
        checkpoint_dir: [*c]const i8,
        log_size_for_flush: i64,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_checkpoint_create(
            helpers.unwrap(checkpoint.*),
            checkpoint_dir,
            log_size_for_flush,
            errptr,
        );
    }

    pub fn exportColumnFamily(
        checkpoint: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        export_dir: [*c]const i8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_export_import_files_metadata_t {
        return api.rocksdb_checkpoint_export_column_family(
            helpers.unwrap(checkpoint.*),
            helpers.unwrap(column_family.*),
            export_dir,
            errptr,
        );
    }

    pub fn objectDestroy(checkpoint: *Self) void {
        return api.rocksdb_checkpoint_object_destroy(helpers.unwrap(checkpoint.*));
    }

    test RocksdbCheckpoint {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbColumnFamilyHandle = packed struct {
    const Self = @This();
    ref: *api.rocksdb_column_family_handle_t,

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_column_family_handle_destroy(helpers.unwrap(arg0.*));
    }

    pub fn getId(handle: *Self) i64 {
        return api.rocksdb_column_family_handle_get_id(helpers.unwrap(handle.*));
    }

    pub fn getName(handle: *Self, name_len: [*c]i64) [*c]i8 {
        return api.rocksdb_column_family_handle_get_name(
            helpers.unwrap(handle.*),
            name_len,
        );
    }

    test RocksdbColumnFamilyHandle {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbColumnFamilyMetadata = packed struct {
    const Self = @This();
    ref: *api.rocksdb_column_family_metadata_t,

    pub fn destroy(cf_meta: *Self) void {
        return api.rocksdb_column_family_metadata_destroy(helpers.unwrap(cf_meta.*));
    }

    pub fn getSize(cf_meta: *Self) i64 {
        return api.rocksdb_column_family_metadata_get_size(helpers.unwrap(cf_meta.*));
    }

    pub fn getFileCount(cf_meta: *Self) i64 {
        return api.rocksdb_column_family_metadata_get_file_count(
            helpers.unwrap(cf_meta.*),
        );
    }

    pub fn getName(cf_meta: *Self) [*c]i8 {
        return api.rocksdb_column_family_metadata_get_name(helpers.unwrap(cf_meta.*));
    }

    pub fn getLevelCount(cf_meta: *Self) i64 {
        return api.rocksdb_column_family_metadata_get_level_count(
            helpers.unwrap(cf_meta.*),
        );
    }

    pub fn getLevelMetadata(
        cf_meta: *Self,
        i: i64,
    ) [*c]api.rocksdb_level_metadata_t {
        return api.rocksdb_column_family_metadata_get_level_metadata(
            helpers.unwrap(cf_meta.*),
            i,
        );
    }

    test RocksdbColumnFamilyMetadata {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbCompactionfilter = packed struct {
    const Self = @This();
    ref: *api.rocksdb_compactionfilter_t,

    pub fn create(
        state: *anyopaque,
        destructor: [*c]fn (
            *anyopaque,
        ) void,
        filter: [*c]fn (
            *anyopaque,
            i64,
            [*c]const i8,
            i64,
            [*c]const i8,
            i64,
            [*c][*c]i8,
            [*c]i64,
            [*c]u8,
        ) u8,
        name: [*c]fn (
            *anyopaque,
        ) [*c]const i8,
    ) [*c]api.rocksdb_compactionfilter_t {
        return api.rocksdb_compactionfilter_create(state, destructor, filter, name);
    }

    pub fn setIgnoreSnapshots(arg0: *Self, arg1: u8) void {
        return api.rocksdb_compactionfilter_set_ignore_snapshots(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_compactionfilter_destroy(helpers.unwrap(arg0.*));
    }

    test RocksdbCompactionfilter {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbCompactionfiltercontext = packed struct {
    const Self = @This();
    ref: *api.rocksdb_compactionfiltercontext_t,

    pub fn fullCompaction(context: *Self) u8 {
        return api.rocksdb_compactionfiltercontext_is_full_compaction(
            helpers.unwrap(context.*),
        );
    }

    pub fn manualCompaction(context: *Self) u8 {
        return api.rocksdb_compactionfiltercontext_is_manual_compaction(
            helpers.unwrap(context.*),
        );
    }

    test RocksdbCompactionfiltercontext {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbCompactionfilterfactory = packed struct {
    const Self = @This();
    ref: *api.rocksdb_compactionfilterfactory_t,

    pub fn create(
        state: *anyopaque,
        destructor: [*c]fn (
            *anyopaque,
        ) void,
        create_compaction_filter: [*c]fn (
            *anyopaque,
            [*c]api.rocksdb_compactionfiltercontext_t,
        ) [*c]api.rocksdb_compactionfilter_t,
        name: [*c]fn (
            *anyopaque,
        ) [*c]const i8,
    ) [*c]api.rocksdb_compactionfilterfactory_t {
        return api.rocksdb_compactionfilterfactory_create(
            state,
            destructor,
            create_compaction_filter,
            name,
        );
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_compactionfilterfactory_destroy(helpers.unwrap(arg0.*));
    }

    test RocksdbCompactionfilterfactory {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbCompactionjobinfo = packed struct {
    const Self = @This();
    ref: *api.rocksdb_compactionjobinfo_t,

    pub fn status(info: Self, errptr: [*c][*c]i8) void {
        return api.rocksdb_compactionjobinfo_status(helpers.unwrap(info), errptr);
    }

    pub fn cfName(arg0: Self, arg1: [*c]i64) [*c]const i8 {
        return api.rocksdb_compactionjobinfo_cf_name(helpers.unwrap(arg0), arg1);
    }

    pub fn inputFilesCount(arg0: Self) i64 {
        return api.rocksdb_compactionjobinfo_input_files_count(helpers.unwrap(arg0));
    }

    pub fn inputFileAt(arg0: Self, pos: i64, arg2: [*c]i64) [*c]const i8 {
        return api.rocksdb_compactionjobinfo_input_file_at(
            helpers.unwrap(arg0),
            pos,
            arg2,
        );
    }

    pub fn outputFilesCount(arg0: Self) i64 {
        return api.rocksdb_compactionjobinfo_output_files_count(helpers.unwrap(arg0));
    }

    pub fn outputFileAt(arg0: Self, pos: i64, arg2: [*c]i64) [*c]const i8 {
        return api.rocksdb_compactionjobinfo_output_file_at(
            helpers.unwrap(arg0),
            pos,
            arg2,
        );
    }

    pub fn elapsedMicros(arg0: Self) i64 {
        return api.rocksdb_compactionjobinfo_elapsed_micros(helpers.unwrap(arg0));
    }

    pub fn numCorruptKeys(arg0: Self) i64 {
        return api.rocksdb_compactionjobinfo_num_corrupt_keys(helpers.unwrap(arg0));
    }

    pub fn baseInputLevel(arg0: Self) i64 {
        return api.rocksdb_compactionjobinfo_base_input_level(helpers.unwrap(arg0));
    }

    pub fn outputLevel(arg0: Self) i64 {
        return api.rocksdb_compactionjobinfo_output_level(helpers.unwrap(arg0));
    }

    pub fn inputRecords(arg0: Self) i64 {
        return api.rocksdb_compactionjobinfo_input_records(helpers.unwrap(arg0));
    }

    pub fn outputRecords(arg0: Self) i64 {
        return api.rocksdb_compactionjobinfo_output_records(helpers.unwrap(arg0));
    }

    pub fn totalInputBytes(arg0: Self) i64 {
        return api.rocksdb_compactionjobinfo_total_input_bytes(helpers.unwrap(arg0));
    }

    pub fn totalOutputBytes(arg0: Self) i64 {
        return api.rocksdb_compactionjobinfo_total_output_bytes(helpers.unwrap(arg0));
    }

    pub fn compactionReason(info: Self) i64 {
        return api.rocksdb_compactionjobinfo_compaction_reason(helpers.unwrap(info));
    }

    pub fn numInputFiles(info: Self) i64 {
        return api.rocksdb_compactionjobinfo_num_input_files(helpers.unwrap(info));
    }

    pub fn numInputFilesAtOutputLevel(info: Self) i64 {
        return api.rocksdb_compactionjobinfo_num_input_files_at_output_level(
            helpers.unwrap(info),
        );
    }

    test RocksdbCompactionjobinfo {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbCompactoptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_compactoptions_t,

    pub fn create() [*c]api.rocksdb_compactoptions_t {
        return api.rocksdb_compactoptions_create();
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_compactoptions_destroy(helpers.unwrap(arg0.*));
    }

    pub fn setExclusiveManualCompaction(arg0: *Self, arg1: u8) void {
        return api.rocksdb_compactoptions_set_exclusive_manual_compaction(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getExclusiveManualCompaction(arg0: *Self) u8 {
        return api.rocksdb_compactoptions_get_exclusive_manual_compaction(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setBottommostLevelCompaction(arg0: *Self, arg1: u8) void {
        return api.rocksdb_compactoptions_set_bottommost_level_compaction(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getBottommostLevelCompaction(arg0: *Self) u8 {
        return api.rocksdb_compactoptions_get_bottommost_level_compaction(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setChangeLevel(arg0: *Self, arg1: u8) void {
        return api.rocksdb_compactoptions_set_change_level(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getChangeLevel(arg0: *Self) u8 {
        return api.rocksdb_compactoptions_get_change_level(helpers.unwrap(arg0.*));
    }

    pub fn setTargetLevel(arg0: *Self, arg1: i64) void {
        return api.rocksdb_compactoptions_set_target_level(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getTargetLevel(arg0: *Self) i64 {
        return api.rocksdb_compactoptions_get_target_level(helpers.unwrap(arg0.*));
    }

    pub fn setTargetPathId(arg0: *Self, arg1: i64) void {
        return api.rocksdb_compactoptions_set_target_path_id(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getTargetPathId(arg0: *Self) i64 {
        return api.rocksdb_compactoptions_get_target_path_id(helpers.unwrap(arg0.*));
    }

    pub fn setAllowWriteStall(arg0: *Self, arg1: u8) void {
        return api.rocksdb_compactoptions_set_allow_write_stall(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getAllowWriteStall(arg0: *Self) u8 {
        return api.rocksdb_compactoptions_get_allow_write_stall(helpers.unwrap(arg0.*));
    }

    pub fn setMaxSubcompactions(arg0: *Self, arg1: i64) void {
        return api.rocksdb_compactoptions_set_max_subcompactions(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getMaxSubcompactions(arg0: *Self) i64 {
        return api.rocksdb_compactoptions_get_max_subcompactions(helpers.unwrap(arg0.*));
    }

    pub fn setFullHistoryTsLow(arg0: *Self, ts: []u8) void {
        return api.rocksdb_compactoptions_set_full_history_ts_low(
            helpers.unwrap(arg0.*),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
        );
    }

    test RocksdbCompactoptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbComparator = packed struct {
    const Self = @This();
    ref: *api.rocksdb_comparator_t,

    pub fn create(
        state: *anyopaque,
        destructor: [*c]fn (
            *anyopaque,
        ) void,
        compare: [*c]fn (
            *anyopaque,
            [*c]const i8,
            i64,
            [*c]const i8,
            i64,
        ) i64,
        name: [*c]fn (
            *anyopaque,
        ) [*c]const i8,
    ) [*c]api.rocksdb_comparator_t {
        return api.rocksdb_comparator_create(state, destructor, compare, name);
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_comparator_destroy(helpers.unwrap(arg0.*));
    }

    pub fn withTsCreate(
        state: *anyopaque,
        destructor: [*c]fn (
            *anyopaque,
        ) void,
        compare: [*c]fn (
            *anyopaque,
            [*c]const i8,
            i64,
            [*c]const i8,
            i64,
        ) i64,
        compare_ts: [*c]fn (
            *anyopaque,
            [*c]const i8,
            i64,
            [*c]const i8,
            i64,
        ) i64,
        compare_without_ts: [*c]fn (
            *anyopaque,
            [*c]const i8,
            i64,
            u8,
            [*c]const i8,
            i64,
            u8,
        ) i64,
        name: [*c]fn (
            *anyopaque,
        ) [*c]const i8,
        timestamp_size: i64,
    ) [*c]api.rocksdb_comparator_t {
        return api.rocksdb_comparator_with_ts_create(
            state,
            destructor,
            compare,
            compare_ts,
            compare_without_ts,
            name,
            timestamp_size,
        );
    }

    test RocksdbComparator {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbCuckooTableOptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_cuckoo_table_options_t,

    pub fn create() [*c]api.rocksdb_cuckoo_table_options_t {
        return api.rocksdb_cuckoo_options_create();
    }

    pub fn destroy(options: *Self) void {
        return api.rocksdb_cuckoo_options_destroy(helpers.unwrap(options.*));
    }

    pub fn setHashRatio(options: *Self, v: f64) void {
        return api.rocksdb_cuckoo_options_set_hash_ratio(helpers.unwrap(options.*), v);
    }

    pub fn setMaxSearchDepth(options: *Self, v: i64) void {
        return api.rocksdb_cuckoo_options_set_max_search_depth(
            helpers.unwrap(options.*),
            v,
        );
    }

    pub fn setCuckooBlockSize(options: *Self, v: i64) void {
        return api.rocksdb_cuckoo_options_set_cuckoo_block_size(
            helpers.unwrap(options.*),
            v,
        );
    }

    pub fn setIdentityAsFirstHash(options: *Self, v: u8) void {
        return api.rocksdb_cuckoo_options_set_identity_as_first_hash(
            helpers.unwrap(options.*),
            v,
        );
    }

    pub fn setUseModuleHash(options: *Self, v: u8) void {
        return api.rocksdb_cuckoo_options_set_use_module_hash(
            helpers.unwrap(options.*),
            v,
        );
    }

    test RocksdbCuckooTableOptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbDbpath = packed struct {
    const Self = @This();
    ref: *api.rocksdb_dbpath_t,

    pub fn create(path: [*c]const i8, target_size: i64) [*c]api.rocksdb_dbpath_t {
        return api.rocksdb_dbpath_create(path, target_size);
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_dbpath_destroy(helpers.unwrap(arg0.*));
    }

    test RocksdbDbpath {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbEnv = packed struct {
    const Self = @This();
    ref: *api.rocksdb_env_t,

    pub fn createDefaultEnv() [*c]api.rocksdb_env_t {
        return api.rocksdb_create_default_env();
    }

    pub fn createMemEnv() [*c]api.rocksdb_env_t {
        return api.rocksdb_create_mem_env();
    }

    pub fn setBackgroundThreads(env: *Self, n: i64) void {
        return api.rocksdb_env_set_background_threads(helpers.unwrap(env.*), n);
    }

    pub fn getBackgroundThreads(env: *Self) i64 {
        return api.rocksdb_env_get_background_threads(helpers.unwrap(env.*));
    }

    pub fn setHighPriorityBackgroundThreads(env: *Self, n: i64) void {
        return api.rocksdb_env_set_high_priority_background_threads(
            helpers.unwrap(env.*),
            n,
        );
    }

    pub fn getHighPriorityBackgroundThreads(env: *Self) i64 {
        return api.rocksdb_env_get_high_priority_background_threads(helpers.unwrap(env.*));
    }

    pub fn setLowPriorityBackgroundThreads(env: *Self, n: i64) void {
        return api.rocksdb_env_set_low_priority_background_threads(
            helpers.unwrap(env.*),
            n,
        );
    }

    pub fn getLowPriorityBackgroundThreads(env: *Self) i64 {
        return api.rocksdb_env_get_low_priority_background_threads(helpers.unwrap(env.*));
    }

    pub fn setBottomPriorityBackgroundThreads(env: *Self, n: i64) void {
        return api.rocksdb_env_set_bottom_priority_background_threads(
            helpers.unwrap(env.*),
            n,
        );
    }

    pub fn getBottomPriorityBackgroundThreads(env: *Self) i64 {
        return api.rocksdb_env_get_bottom_priority_background_threads(
            helpers.unwrap(env.*),
        );
    }

    pub fn joinAllThreads(env: *Self) void {
        return api.rocksdb_env_join_all_threads(helpers.unwrap(env.*));
    }

    pub fn lowerThreadPoolIoPriority(env: *Self) void {
        return api.rocksdb_env_lower_thread_pool_io_priority(helpers.unwrap(env.*));
    }

    pub fn lowerHighPriorityThreadPoolIoPriority(env: *Self) void {
        return api.rocksdb_env_lower_high_priority_thread_pool_io_priority(
            helpers.unwrap(env.*),
        );
    }

    pub fn lowerThreadPoolCpuPriority(env: *Self) void {
        return api.rocksdb_env_lower_thread_pool_cpu_priority(helpers.unwrap(env.*));
    }

    pub fn lowerHighPriorityThreadPoolCpuPriority(env: *Self) void {
        return api.rocksdb_env_lower_high_priority_thread_pool_cpu_priority(
            helpers.unwrap(env.*),
        );
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_env_destroy(helpers.unwrap(arg0.*));
    }

    pub fn createDirIfMissing(
        env: *Self,
        path: [*c]const i8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_create_dir_if_missing(helpers.unwrap(env.*), path, errptr);
    }

    test RocksdbEnv {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbEnvoptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_envoptions_t,

    pub fn create() [*c]api.rocksdb_envoptions_t {
        return api.rocksdb_envoptions_create();
    }

    pub fn destroy(opt: *Self) void {
        return api.rocksdb_envoptions_destroy(helpers.unwrap(opt.*));
    }

    test RocksdbEnvoptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbEventlistener = packed struct {
    const Self = @This();
    ref: *api.rocksdb_eventlistener_t,

    pub fn create(
        state_: *anyopaque,
        destructor_: [*c]fn (
            *anyopaque,
        ) void,
        on_flush_begin: api.on_flush_begin_cb,
        on_flush_completed: api.on_flush_completed_cb,
        on_compaction_begin: api.on_compaction_begin_cb,
        on_compaction_completed: api.on_compaction_completed_cb,
        on_subcompaction_begin: api.on_subcompaction_begin_cb,
        on_subcompaction_completed: api.on_subcompaction_completed_cb,
        on_external_file_ingested: api.on_external_file_ingested_cb,
        on_background_error: api.on_background_error_cb,
        on_stall_conditions_changed: api.on_stall_conditions_changed_cb,
        on_memtable_sealed: api.on_memtable_sealed_cb,
    ) [*c]api.rocksdb_eventlistener_t {
        return api.rocksdb_eventlistener_create(
            state_,
            destructor_,
            on_flush_begin,
            on_flush_completed,
            on_compaction_begin,
            on_compaction_completed,
            on_subcompaction_begin,
            on_subcompaction_completed,
            on_external_file_ingested,
            on_background_error,
            on_stall_conditions_changed,
            on_memtable_sealed,
        );
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_eventlistener_destroy(helpers.unwrap(arg0.*));
    }

    test RocksdbEventlistener {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbExportImportFilesMetadata = packed struct {
    const Self = @This();
    ref: *api.rocksdb_export_import_files_metadata_t,

    pub fn create() [*c]api.rocksdb_export_import_files_metadata_t {
        return api.rocksdb_export_import_files_metadata_create();
    }

    pub fn getDbComparatorName(arg0: *Self) [*c]i8 {
        return api.rocksdb_export_import_files_metadata_get_db_comparator_name(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setDbComparatorName(arg0: *Self, arg1: [*c]const i8) void {
        return api.rocksdb_export_import_files_metadata_set_db_comparator_name(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getFiles(arg0: *Self) [*c]api.rocksdb_livefiles_t {
        return api.rocksdb_export_import_files_metadata_get_files(helpers.unwrap(arg0.*));
    }

    pub fn setFiles(arg0: *Self, arg1: *RocksdbLivefiles) void {
        return api.rocksdb_export_import_files_metadata_set_files(
            helpers.unwrap(arg0.*),
            helpers.unwrap(arg1.*),
        );
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_export_import_files_metadata_destroy(helpers.unwrap(arg0.*));
    }

    test RocksdbExportImportFilesMetadata {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbExternalfileingestioninfo = packed struct {
    const Self = @This();
    ref: *api.rocksdb_externalfileingestioninfo_t,

    pub fn cfName(arg0: Self, arg1: [*c]i64) [*c]const i8 {
        return api.rocksdb_externalfileingestioninfo_cf_name(helpers.unwrap(arg0), arg1);
    }

    pub fn internalFilePath(arg0: Self, arg1: [*c]i64) [*c]const i8 {
        return api.rocksdb_externalfileingestioninfo_internal_file_path(
            helpers.unwrap(arg0),
            arg1,
        );
    }

    test RocksdbExternalfileingestioninfo {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbFifoCompactionOptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_fifo_compaction_options_t,

    pub fn create() [*c]api.rocksdb_fifo_compaction_options_t {
        return api.rocksdb_fifo_compaction_options_create();
    }

    pub fn setAllowCompaction(fifo_opts: *Self, allow_compaction: u8) void {
        return api.rocksdb_fifo_compaction_options_set_allow_compaction(
            helpers.unwrap(fifo_opts.*),
            allow_compaction,
        );
    }

    pub fn getAllowCompaction(fifo_opts: *Self) u8 {
        return api.rocksdb_fifo_compaction_options_get_allow_compaction(
            helpers.unwrap(fifo_opts.*),
        );
    }

    pub fn setMaxTableFilesSize(fifo_opts: *Self, size: i64) void {
        return api.rocksdb_fifo_compaction_options_set_max_table_files_size(
            helpers.unwrap(fifo_opts.*),
            size,
        );
    }

    pub fn getMaxTableFilesSize(fifo_opts: *Self) i64 {
        return api.rocksdb_fifo_compaction_options_get_max_table_files_size(
            helpers.unwrap(fifo_opts.*),
        );
    }

    pub fn destroy(fifo_opts: *Self) void {
        return api.rocksdb_fifo_compaction_options_destroy(helpers.unwrap(fifo_opts.*));
    }

    test RocksdbFifoCompactionOptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbFilterpolicy = packed struct {
    const Self = @This();
    ref: *api.rocksdb_filterpolicy_t,

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_filterpolicy_destroy(helpers.unwrap(arg0.*));
    }

    pub fn createBloom(bits_per_key: f64) [*c]api.rocksdb_filterpolicy_t {
        return api.rocksdb_filterpolicy_create_bloom(bits_per_key);
    }

    pub fn createBloomFull(bits_per_key: f64) [*c]api.rocksdb_filterpolicy_t {
        return api.rocksdb_filterpolicy_create_bloom_full(bits_per_key);
    }

    pub fn createRibbon(
        bloom_equivalent_bits_per_key: f64,
    ) [*c]api.rocksdb_filterpolicy_t {
        return api.rocksdb_filterpolicy_create_ribbon(bloom_equivalent_bits_per_key);
    }

    pub fn createRibbonHybrid(
        bloom_equivalent_bits_per_key: f64,
        bloom_before_level: i64,
    ) [*c]api.rocksdb_filterpolicy_t {
        return api.rocksdb_filterpolicy_create_ribbon_hybrid(
            bloom_equivalent_bits_per_key,
            bloom_before_level,
        );
    }

    test RocksdbFilterpolicy {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbFlushjobinfo = packed struct {
    const Self = @This();
    ref: *api.rocksdb_flushjobinfo_t,

    pub fn cfName(arg0: Self, arg1: [*c]i64) [*c]const i8 {
        return api.rocksdb_flushjobinfo_cf_name(helpers.unwrap(arg0), arg1);
    }

    pub fn filePath(arg0: Self, arg1: [*c]i64) [*c]const i8 {
        return api.rocksdb_flushjobinfo_file_path(helpers.unwrap(arg0), arg1);
    }

    pub fn triggeredWritesSlowdown(arg0: Self) u8 {
        return api.rocksdb_flushjobinfo_triggered_writes_slowdown(helpers.unwrap(arg0));
    }

    pub fn triggeredWritesStop(arg0: Self) u8 {
        return api.rocksdb_flushjobinfo_triggered_writes_stop(helpers.unwrap(arg0));
    }

    pub fn largestSeqno(arg0: Self) i64 {
        return api.rocksdb_flushjobinfo_largest_seqno(helpers.unwrap(arg0));
    }

    pub fn smallestSeqno(arg0: Self) i64 {
        return api.rocksdb_flushjobinfo_smallest_seqno(helpers.unwrap(arg0));
    }

    pub fn flushReason(info: Self) i64 {
        return api.rocksdb_flushjobinfo_flush_reason(helpers.unwrap(info));
    }

    test RocksdbFlushjobinfo {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbFlushoptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_flushoptions_t,

    pub fn create() [*c]api.rocksdb_flushoptions_t {
        return api.rocksdb_flushoptions_create();
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_flushoptions_destroy(helpers.unwrap(arg0.*));
    }

    pub fn setWait(arg0: *Self, arg1: u8) void {
        return api.rocksdb_flushoptions_set_wait(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getWait(arg0: *Self) u8 {
        return api.rocksdb_flushoptions_get_wait(helpers.unwrap(arg0.*));
    }

    test RocksdbFlushoptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbHyperClockCacheOptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_hyper_clock_cache_options_t,

    pub fn create(
        capacity: i64,
        estimated_entry_charge: i64,
    ) [*c]api.rocksdb_hyper_clock_cache_options_t {
        return api.rocksdb_hyper_clock_cache_options_create(
            capacity,
            estimated_entry_charge,
        );
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_hyper_clock_cache_options_destroy(helpers.unwrap(arg0.*));
    }

    pub fn setCapacity(arg0: *Self, size_t: i64) void {
        return api.rocksdb_hyper_clock_cache_options_set_capacity(
            helpers.unwrap(arg0.*),
            size_t,
        );
    }

    pub fn setEstimatedEntryCharge(arg0: *Self, size_t: i64) void {
        return api.rocksdb_hyper_clock_cache_options_set_estimated_entry_charge(
            helpers.unwrap(arg0.*),
            size_t,
        );
    }

    pub fn setNumShardBits(arg0: *Self, arg1: i64) void {
        return api.rocksdb_hyper_clock_cache_options_set_num_shard_bits(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn setMemoryAllocator(arg0: *Self, arg1: *RocksdbMemoryAllocator) void {
        return api.rocksdb_hyper_clock_cache_options_set_memory_allocator(
            helpers.unwrap(arg0.*),
            helpers.unwrap(arg1.*),
        );
    }

    test RocksdbHyperClockCacheOptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbImportColumnFamilyOptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_import_column_family_options_t,

    pub fn create() [*c]api.rocksdb_import_column_family_options_t {
        return api.rocksdb_import_column_family_options_create();
    }

    pub fn setMoveFiles(arg0: *Self, arg1: u8) void {
        return api.rocksdb_import_column_family_options_set_move_files(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_import_column_family_options_destroy(helpers.unwrap(arg0.*));
    }

    test RocksdbImportColumnFamilyOptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbIngestexternalfileoptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_ingestexternalfileoptions_t,

    pub fn create() [*c]api.rocksdb_ingestexternalfileoptions_t {
        return api.rocksdb_ingestexternalfileoptions_create();
    }

    pub fn setMoveFiles(opt: *Self, move_files: u8) void {
        return api.rocksdb_ingestexternalfileoptions_set_move_files(
            helpers.unwrap(opt.*),
            move_files,
        );
    }

    pub fn setSnapshotConsistency(opt: *Self, snapshot_consistency: u8) void {
        return api.rocksdb_ingestexternalfileoptions_set_snapshot_consistency(
            helpers.unwrap(opt.*),
            snapshot_consistency,
        );
    }

    pub fn setAllowGlobalSeqno(opt: *Self, allow_global_seqno: u8) void {
        return api.rocksdb_ingestexternalfileoptions_set_allow_global_seqno(
            helpers.unwrap(opt.*),
            allow_global_seqno,
        );
    }

    pub fn setAllowBlockingFlush(opt: *Self, allow_blocking_flush: u8) void {
        return api.rocksdb_ingestexternalfileoptions_set_allow_blocking_flush(
            helpers.unwrap(opt.*),
            allow_blocking_flush,
        );
    }

    pub fn setIngestBehind(opt: *Self, ingest_behind: u8) void {
        return api.rocksdb_ingestexternalfileoptions_set_ingest_behind(
            helpers.unwrap(opt.*),
            ingest_behind,
        );
    }

    pub fn setFailIfNotBottommostLevel(
        opt: *Self,
        fail_if_not_bottommost_level: u8,
    ) void {
        return api.rocksdb_ingestexternalfileoptions_set_fail_if_not_bottommost_level(
            helpers.unwrap(opt.*),
            fail_if_not_bottommost_level,
        );
    }

    pub fn destroy(opt: *Self) void {
        return api.rocksdb_ingestexternalfileoptions_destroy(helpers.unwrap(opt.*));
    }

    test RocksdbIngestexternalfileoptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbIterator = packed struct {
    const Self = @This();
    ref: *api.rocksdb_iterator_t,

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_iter_destroy(helpers.unwrap(arg0.*));
    }

    pub fn valid(arg0: Self) u8 {
        return api.rocksdb_iter_valid(helpers.unwrap(arg0));
    }

    pub fn seekToFirst(arg0: *Self) void {
        return api.rocksdb_iter_seek_to_first(helpers.unwrap(arg0.*));
    }

    pub fn seekToLast(arg0: *Self) void {
        return api.rocksdb_iter_seek_to_last(helpers.unwrap(arg0.*));
    }

    pub fn seek(arg0: *Self, k: []const u8) void {
        return api.rocksdb_iter_seek(
            helpers.unwrap(arg0.*),
            @ptrCast(k.ptr),
            @intCast(k.len),
        );
    }

    pub fn seekForPrev(arg0: *Self, k: []const u8) void {
        return api.rocksdb_iter_seek_for_prev(
            helpers.unwrap(arg0.*),
            @ptrCast(k.ptr),
            @intCast(k.len),
        );
    }

    pub fn next(arg0: *Self) void {
        return api.rocksdb_iter_next(helpers.unwrap(arg0.*));
    }

    pub fn prev(arg0: *Self) void {
        return api.rocksdb_iter_prev(helpers.unwrap(arg0.*));
    }

    pub fn key(arg0: Self, klen: [*c]i64) [*c]const i8 {
        return api.rocksdb_iter_key(helpers.unwrap(arg0), klen);
    }

    pub fn value(arg0: Self, vlen: [*c]i64) [*c]const i8 {
        return api.rocksdb_iter_value(helpers.unwrap(arg0), vlen);
    }

    pub fn timestamp(arg0: Self, tslen: [*c]i64) [*c]const i8 {
        return api.rocksdb_iter_timestamp(helpers.unwrap(arg0), tslen);
    }

    pub fn getError(arg0: Self, errptr: [*c][*c]i8) void {
        return api.rocksdb_iter_get_error(helpers.unwrap(arg0), errptr);
    }

    pub fn refresh(iter: Self, errptr: [*c][*c]i8) void {
        return api.rocksdb_iter_refresh(helpers.unwrap(iter), errptr);
    }

    test RocksdbIterator {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbLevelMetadata = packed struct {
    const Self = @This();
    ref: *api.rocksdb_level_metadata_t,

    pub fn destroy(level_meta: *Self) void {
        return api.rocksdb_level_metadata_destroy(helpers.unwrap(level_meta.*));
    }

    pub fn getLevel(level_meta: *Self) i64 {
        return api.rocksdb_level_metadata_get_level(helpers.unwrap(level_meta.*));
    }

    pub fn getSize(level_meta: *Self) i64 {
        return api.rocksdb_level_metadata_get_size(helpers.unwrap(level_meta.*));
    }

    pub fn getFileCount(level_meta: *Self) i64 {
        return api.rocksdb_level_metadata_get_file_count(helpers.unwrap(level_meta.*));
    }

    pub fn getSstFileMetadata(
        level_meta: *Self,
        i: i64,
    ) [*c]api.rocksdb_sst_file_metadata_t {
        return api.rocksdb_level_metadata_get_sst_file_metadata(
            helpers.unwrap(level_meta.*),
            i,
        );
    }

    test RocksdbLevelMetadata {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbLivefile = packed struct {
    const Self = @This();
    ref: *api.rocksdb_livefile_t,

    pub fn create() [*c]api.rocksdb_livefile_t {
        return api.rocksdb_livefile_create();
    }

    pub fn setColumnFamilyName(arg0: *Self, arg1: [*c]const i8) void {
        return api.rocksdb_livefile_set_column_family_name(helpers.unwrap(arg0.*), arg1);
    }

    pub fn setLevel(arg0: *Self, arg1: i64) void {
        return api.rocksdb_livefile_set_level(helpers.unwrap(arg0.*), arg1);
    }

    pub fn setName(arg0: *Self, arg1: [*c]const i8) void {
        return api.rocksdb_livefile_set_name(helpers.unwrap(arg0.*), arg1);
    }

    pub fn setDirectory(arg0: *Self, arg1: [*c]const i8) void {
        return api.rocksdb_livefile_set_directory(helpers.unwrap(arg0.*), arg1);
    }

    pub fn setSize(arg0: *Self, size_t: i64) void {
        return api.rocksdb_livefile_set_size(helpers.unwrap(arg0.*), size_t);
    }

    pub fn setSmallestKey(arg0: *Self, arg1: [*c]const i8, size_t: i64) void {
        return api.rocksdb_livefile_set_smallest_key(helpers.unwrap(arg0.*), arg1, size_t);
    }

    pub fn setLargestKey(arg0: *Self, arg1: [*c]const i8, size_t: i64) void {
        return api.rocksdb_livefile_set_largest_key(helpers.unwrap(arg0.*), arg1, size_t);
    }

    pub fn setSmallestSeqno(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_livefile_set_smallest_seqno(helpers.unwrap(arg0.*), uint64_t);
    }

    pub fn setLargestSeqno(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_livefile_set_largest_seqno(helpers.unwrap(arg0.*), uint64_t);
    }

    pub fn setNumEntries(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_livefile_set_num_entries(helpers.unwrap(arg0.*), uint64_t);
    }

    pub fn setNumDeletions(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_livefile_set_num_deletions(helpers.unwrap(arg0.*), uint64_t);
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_livefile_destroy(helpers.unwrap(arg0.*));
    }

    test RocksdbLivefile {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbLivefiles = packed struct {
    const Self = @This();
    ref: *api.rocksdb_livefiles_t,

    pub fn create() [*c]api.rocksdb_livefiles_t {
        return api.rocksdb_livefiles_create();
    }

    pub fn count(arg0: Self) i64 {
        return api.rocksdb_livefiles_count(helpers.unwrap(arg0));
    }

    pub fn columnFamilyName(arg0: Self, index: i64) [*c]const i8 {
        return api.rocksdb_livefiles_column_family_name(helpers.unwrap(arg0), index);
    }

    pub fn name(arg0: Self, index: i64) [*c]const i8 {
        return api.rocksdb_livefiles_name(helpers.unwrap(arg0), index);
    }

    pub fn directory(arg0: Self, index: i64) [*c]const i8 {
        return api.rocksdb_livefiles_directory(helpers.unwrap(arg0), index);
    }

    pub fn level(arg0: Self, index: i64) i64 {
        return api.rocksdb_livefiles_level(helpers.unwrap(arg0), index);
    }

    pub fn size(arg0: Self, index: i64) i64 {
        return api.rocksdb_livefiles_size(helpers.unwrap(arg0), index);
    }

    pub fn smallestkey(arg0: Self, index: i64, size_: [*c]i64) [*c]const i8 {
        return api.rocksdb_livefiles_smallestkey(helpers.unwrap(arg0), index, size_);
    }

    pub fn largestkey(arg0: Self, index: i64, size_: [*c]i64) [*c]const i8 {
        return api.rocksdb_livefiles_largestkey(helpers.unwrap(arg0), index, size_);
    }

    pub fn smallestSeqno(arg0: Self, index: i64) i64 {
        return api.rocksdb_livefiles_smallest_seqno(helpers.unwrap(arg0), index);
    }

    pub fn largestSeqno(arg0: Self, index: i64) i64 {
        return api.rocksdb_livefiles_largest_seqno(helpers.unwrap(arg0), index);
    }

    pub fn entries(arg0: Self, index: i64) i64 {
        return api.rocksdb_livefiles_entries(helpers.unwrap(arg0), index);
    }

    pub fn deletions(arg0: Self, index: i64) i64 {
        return api.rocksdb_livefiles_deletions(helpers.unwrap(arg0), index);
    }

    pub fn destroy(arg0: Self) void {
        return api.rocksdb_livefiles_destroy(helpers.unwrap(arg0));
    }

    pub fn add(arg0: *Self, arg1: *RocksdbLivefile) void {
        return api.rocksdb_livefiles_add(helpers.unwrap(arg0.*), helpers.unwrap(arg1.*));
    }

    test RocksdbLivefiles {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbLogger = packed struct {
    const Self = @This();
    ref: *api.rocksdb_logger_t,

    pub fn createStderrLogger(
        log_level: i64,
        prefix: [*c]const i8,
    ) [*c]api.rocksdb_logger_t {
        return api.rocksdb_logger_create_stderr_logger(log_level, prefix);
    }

    pub fn createCallbackLogger(
        log_level: i64,
        arg1: [*c]fn (
            *anyopaque,
            u64,
            [*c]i8,
            i64,
        ) void,
        priv: *anyopaque,
    ) [*c]api.rocksdb_logger_t {
        return api.rocksdb_logger_create_callback_logger(log_level, arg1, priv);
    }

    pub fn destroy(logger: *Self) void {
        return api.rocksdb_logger_destroy(helpers.unwrap(logger.*));
    }

    test RocksdbLogger {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbLruCacheOptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_lru_cache_options_t,

    pub fn create() [*c]api.rocksdb_lru_cache_options_t {
        return api.rocksdb_lru_cache_options_create();
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_lru_cache_options_destroy(helpers.unwrap(arg0.*));
    }

    pub fn setCapacity(arg0: *Self, size_t: i64) void {
        return api.rocksdb_lru_cache_options_set_capacity(helpers.unwrap(arg0.*), size_t);
    }

    pub fn setNumShardBits(arg0: *Self, arg1: i64) void {
        return api.rocksdb_lru_cache_options_set_num_shard_bits(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn setMemoryAllocator(arg0: *Self, arg1: *RocksdbMemoryAllocator) void {
        return api.rocksdb_lru_cache_options_set_memory_allocator(
            helpers.unwrap(arg0.*),
            helpers.unwrap(arg1.*),
        );
    }

    test RocksdbLruCacheOptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbMemoryAllocator = packed struct {
    const Self = @This();
    ref: *api.rocksdb_memory_allocator_t,

    pub fn jemallocNodumpAllocatorCreate(
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_memory_allocator_t {
        return api.rocksdb_jemalloc_nodump_allocator_create(errptr);
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_memory_allocator_destroy(helpers.unwrap(arg0.*));
    }

    test RocksdbMemoryAllocator {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbMemoryConsumers = packed struct {
    const Self = @This();
    ref: *api.rocksdb_memory_consumers_t,

    pub fn create() [*c]api.rocksdb_memory_consumers_t {
        return api.rocksdb_memory_consumers_create();
    }

    pub fn addDb(consumers: *Self, db: *Rocksdb) void {
        return api.rocksdb_memory_consumers_add_db(
            helpers.unwrap(consumers.*),
            helpers.unwrap(db.*),
        );
    }

    pub fn addCache(consumers: *Self, cache: *RocksdbCache) void {
        return api.rocksdb_memory_consumers_add_cache(
            helpers.unwrap(consumers.*),
            helpers.unwrap(cache.*),
        );
    }

    pub fn destroy(consumers: *Self) void {
        return api.rocksdb_memory_consumers_destroy(helpers.unwrap(consumers.*));
    }

    test RocksdbMemoryConsumers {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbMemoryUsage = packed struct {
    const Self = @This();
    ref: *api.rocksdb_memory_usage_t,

    pub fn create(
        consumers: *RocksdbMemoryConsumers,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_memory_usage_t {
        return api.rocksdb_approximate_memory_usage_create(
            helpers.unwrap(consumers.*),
            errptr,
        );
    }

    pub fn destroy(usage: *Self) void {
        return api.rocksdb_approximate_memory_usage_destroy(helpers.unwrap(usage.*));
    }

    pub fn getMemTableTotal(memory_usage: *Self) i64 {
        return api.rocksdb_approximate_memory_usage_get_mem_table_total(
            helpers.unwrap(memory_usage.*),
        );
    }

    pub fn getMemTableUnflushed(memory_usage: *Self) i64 {
        return api.rocksdb_approximate_memory_usage_get_mem_table_unflushed(
            helpers.unwrap(memory_usage.*),
        );
    }

    pub fn getMemTableReadersTotal(memory_usage: *Self) i64 {
        return api.rocksdb_approximate_memory_usage_get_mem_table_readers_total(
            helpers.unwrap(memory_usage.*),
        );
    }

    pub fn getCacheTotal(memory_usage: *Self) i64 {
        return api.rocksdb_approximate_memory_usage_get_cache_total(
            helpers.unwrap(memory_usage.*),
        );
    }

    test RocksdbMemoryUsage {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbMemtableinfo = packed struct {
    const Self = @This();
    ref: *api.rocksdb_memtableinfo_t,

    pub fn cfName(arg0: Self, arg1: [*c]i64) [*c]const i8 {
        return api.rocksdb_memtableinfo_cf_name(helpers.unwrap(arg0), arg1);
    }

    pub fn firstSeqno(arg0: Self) i64 {
        return api.rocksdb_memtableinfo_first_seqno(helpers.unwrap(arg0));
    }

    pub fn earliestSeqno(arg0: Self) i64 {
        return api.rocksdb_memtableinfo_earliest_seqno(helpers.unwrap(arg0));
    }

    pub fn numEntries(arg0: Self) i64 {
        return api.rocksdb_memtableinfo_num_entries(helpers.unwrap(arg0));
    }

    pub fn numDeletes(arg0: Self) i64 {
        return api.rocksdb_memtableinfo_num_deletes(helpers.unwrap(arg0));
    }

    test RocksdbMemtableinfo {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbMergeoperator = packed struct {
    const Self = @This();
    ref: *api.rocksdb_mergeoperator_t,

    pub fn create(
        state: *anyopaque,
        destructor: [*c]fn (
            *anyopaque,
        ) void,
        full_merge: [*c]fn (
            *anyopaque,
            [*c]const i8,
            i64,
            [*c]const i8,
            i64,
            [*c]const [*c]const i8,
            [*c]const i64,
            i64,
            [*c]u8,
            [*c]i64,
        ) [*c]i8,
        partial_merge: [*c]fn (
            *anyopaque,
            [*c]const i8,
            i64,
            [*c]const [*c]const i8,
            [*c]const i64,
            i64,
            [*c]u8,
            [*c]i64,
        ) [*c]i8,
        delete_value: [*c]fn (
            *anyopaque,
            [*c]const i8,
            i64,
        ) void,
        name: [*c]fn (
            *anyopaque,
        ) [*c]const i8,
    ) [*c]api.rocksdb_mergeoperator_t {
        return api.rocksdb_mergeoperator_create(
            state,
            destructor,
            full_merge,
            partial_merge,
            delete_value,
            name,
        );
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_mergeoperator_destroy(helpers.unwrap(arg0.*));
    }

    test RocksdbMergeoperator {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbOptimistictransactionOptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_optimistictransaction_options_t,

    pub fn create() [*c]api.rocksdb_optimistictransaction_options_t {
        return api.rocksdb_optimistictransaction_options_create();
    }

    pub fn destroy(opt: *Self) void {
        return api.rocksdb_optimistictransaction_options_destroy(helpers.unwrap(opt.*));
    }

    pub fn setSetSnapshot(opt: *Self, v: u8) void {
        return api.rocksdb_optimistictransaction_options_set_set_snapshot(
            helpers.unwrap(opt.*),
            v,
        );
    }

    test RocksdbOptimistictransactionOptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbOptimistictransactiondb = packed struct {
    const Self = @This();
    ref: *api.rocksdb_optimistictransactiondb_t,

    pub fn open(
        options: RocksdbOptions,
        name: [*c]const i8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_optimistictransactiondb_t {
        return api.rocksdb_optimistictransactiondb_open(
            helpers.unwrap(options),
            name,
            errptr,
        );
    }

    pub fn openColumnFamilies(
        options: RocksdbOptions,
        name: [*c]const i8,
        num_column_families: i64,
        column_family_names: [*c]const [*c]const i8,
        column_family_options: [*c]const [*c]const api.rocksdb_options_t,
        column_family_handles: [*c][*c]api.rocksdb_column_family_handle_t,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_optimistictransactiondb_t {
        return api.rocksdb_optimistictransactiondb_open_column_families(
            helpers.unwrap(options),
            name,
            num_column_families,
            column_family_names,
            column_family_options,
            column_family_handles,
            errptr,
        );
    }

    pub fn getBaseDb(otxn_db: *Self) [*c]api.rocksdb_t {
        return api.rocksdb_optimistictransactiondb_get_base_db(helpers.unwrap(otxn_db.*));
    }

    pub fn write(
        otxn_db: *Self,
        options: RocksdbWriteoptions,
        batch: *RocksdbWritebatch,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_optimistictransactiondb_write(
            helpers.unwrap(otxn_db.*),
            helpers.unwrap(options),
            helpers.unwrap(batch.*),
            errptr,
        );
    }

    pub fn close(otxn_db: *Self) void {
        return api.rocksdb_optimistictransactiondb_close(helpers.unwrap(otxn_db.*));
    }

    pub fn checkpointObjectCreate(
        otxn_db: *Self,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_checkpoint_t {
        return api.rocksdb_optimistictransactiondb_checkpoint_object_create(
            helpers.unwrap(otxn_db.*),
            errptr,
        );
    }

    pub fn propertyValue(db: *Self, propname: [*c]const i8) [*c]i8 {
        return api.rocksdb_optimistictransactiondb_property_value(
            helpers.unwrap(db.*),
            propname,
        );
    }

    pub fn propertyInt(db: *Self, propname: [*c]const i8, out_val: [*c]i64) i64 {
        return api.rocksdb_optimistictransactiondb_property_int(
            helpers.unwrap(db.*),
            propname,
            out_val,
        );
    }

    test RocksdbOptimistictransactiondb {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbOptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_options_t,

    pub fn listColumnFamilies(
        options: Self,
        name: [*c]const i8,
        lencf: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c][*c]i8 {
        return api.rocksdb_list_column_families(
            helpers.unwrap(options),
            name,
            lencf,
            errptr,
        );
    }

    pub fn destroyDb(options: Self, name: [*c]const i8, errptr: [*c][*c]i8) void {
        return api.rocksdb_destroy_db(helpers.unwrap(options), name, errptr);
    }

    pub fn repairDb(options: Self, name: [*c]const i8, errptr: [*c][*c]i8) void {
        return api.rocksdb_repair_db(helpers.unwrap(options), name, errptr);
    }

    pub fn loadLatestOptionsDestroy(
        db_options: *Self,
        list_column_family_names: [*c][*c]i8,
        list_column_family_options: [*c][*c]api.rocksdb_options_t,
        len: i64,
    ) void {
        return api.rocksdb_load_latest_options_destroy(
            helpers.unwrap(db_options.*),
            list_column_family_names,
            list_column_family_options,
            len,
        );
    }

    pub fn setBlockBasedTableFactory(
        opt: *Self,
        table_options: *RocksdbBlockBasedTableOptions,
    ) void {
        return api.rocksdb_options_set_block_based_table_factory(
            helpers.unwrap(opt.*),
            helpers.unwrap(table_options.*),
        );
    }

    pub fn setWriteBufferManager(opt: *Self, wbm: *RocksdbWriteBufferManager) void {
        return api.rocksdb_options_set_write_buffer_manager(
            helpers.unwrap(opt.*),
            helpers.unwrap(wbm.*),
        );
    }

    pub fn setSstFileManager(opt: *Self, sfm: *RocksdbSstFileManager) void {
        return api.rocksdb_options_set_sst_file_manager(
            helpers.unwrap(opt.*),
            helpers.unwrap(sfm.*),
        );
    }

    pub fn addEventlistener(arg0: *Self, arg1: *RocksdbEventlistener) void {
        return api.rocksdb_options_add_eventlistener(
            helpers.unwrap(arg0.*),
            helpers.unwrap(arg1.*),
        );
    }

    pub fn setCuckooTableFactory(
        opt: *Self,
        table_options: *RocksdbCuckooTableOptions,
    ) void {
        return api.rocksdb_options_set_cuckoo_table_factory(
            helpers.unwrap(opt.*),
            helpers.unwrap(table_options.*),
        );
    }

    pub fn create() [*c]api.rocksdb_options_t {
        return api.rocksdb_options_create();
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_options_destroy(helpers.unwrap(arg0.*));
    }

    pub fn createCopy(arg0: *Self) [*c]api.rocksdb_options_t {
        return api.rocksdb_options_create_copy(helpers.unwrap(arg0.*));
    }

    pub fn increaseParallelism(opt: *Self, total_threads: i64) void {
        return api.rocksdb_options_increase_parallelism(
            helpers.unwrap(opt.*),
            total_threads,
        );
    }

    pub fn optimizeForPointLookup(opt: *Self, block_cache_size_mb: i64) void {
        return api.rocksdb_options_optimize_for_point_lookup(
            helpers.unwrap(opt.*),
            block_cache_size_mb,
        );
    }

    pub fn optimizeLevelStyleCompaction(
        opt: *Self,
        memtable_memory_budget: i64,
    ) void {
        return api.rocksdb_options_optimize_level_style_compaction(
            helpers.unwrap(opt.*),
            memtable_memory_budget,
        );
    }

    pub fn optimizeUniversalStyleCompaction(
        opt: *Self,
        memtable_memory_budget: i64,
    ) void {
        return api.rocksdb_options_optimize_universal_style_compaction(
            helpers.unwrap(opt.*),
            memtable_memory_budget,
        );
    }

    pub fn setAllowIngestBehind(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_allow_ingest_behind(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getAllowIngestBehind(arg0: *Self) u8 {
        return api.rocksdb_options_get_allow_ingest_behind(helpers.unwrap(arg0.*));
    }

    pub fn setCompactionFilter(arg0: *Self, arg1: *RocksdbCompactionfilter) void {
        return api.rocksdb_options_set_compaction_filter(
            helpers.unwrap(arg0.*),
            helpers.unwrap(arg1.*),
        );
    }

    pub fn setCompactionFilterFactory(
        arg0: *Self,
        arg1: *RocksdbCompactionfilterfactory,
    ) void {
        return api.rocksdb_options_set_compaction_filter_factory(
            helpers.unwrap(arg0.*),
            helpers.unwrap(arg1.*),
        );
    }

    pub fn compactionReadaheadSize(arg0: *Self, size_t: i64) void {
        return api.rocksdb_options_compaction_readahead_size(
            helpers.unwrap(arg0.*),
            size_t,
        );
    }

    pub fn getCompactionReadaheadSize(arg0: *Self) i64 {
        return api.rocksdb_options_get_compaction_readahead_size(helpers.unwrap(arg0.*));
    }

    pub fn setComparator(arg0: *Self, arg1: *RocksdbComparator) void {
        return api.rocksdb_options_set_comparator(
            helpers.unwrap(arg0.*),
            helpers.unwrap(arg1.*),
        );
    }

    pub fn setMergeOperator(arg0: *Self, arg1: *RocksdbMergeoperator) void {
        return api.rocksdb_options_set_merge_operator(
            helpers.unwrap(arg0.*),
            helpers.unwrap(arg1.*),
        );
    }

    pub fn setUint64AddMergeOperator(arg0: *Self) void {
        return api.rocksdb_options_set_uint64add_merge_operator(helpers.unwrap(arg0.*));
    }

    pub fn setCompressionPerLevel(
        opt: *Self,
        level_values: [*c]const i64,
        num_levels: i64,
    ) void {
        return api.rocksdb_options_set_compression_per_level(
            helpers.unwrap(opt.*),
            level_values,
            num_levels,
        );
    }

    pub fn setCreateIfMissing(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_create_if_missing(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getCreateIfMissing(arg0: *Self) u8 {
        return api.rocksdb_options_get_create_if_missing(helpers.unwrap(arg0.*));
    }

    pub fn setCreateMissingColumnFamilies(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_create_missing_column_families(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getCreateMissingColumnFamilies(arg0: *Self) u8 {
        return api.rocksdb_options_get_create_missing_column_families(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setErrorIfExists(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_error_if_exists(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getErrorIfExists(arg0: *Self) u8 {
        return api.rocksdb_options_get_error_if_exists(helpers.unwrap(arg0.*));
    }

    pub fn setParanoidChecks(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_paranoid_checks(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getParanoidChecks(arg0: *Self) u8 {
        return api.rocksdb_options_get_paranoid_checks(helpers.unwrap(arg0.*));
    }

    pub fn setDbPaths(
        arg0: *Self,
        path_values: [*c][*c]const api.rocksdb_dbpath_t,
        num_paths: i64,
    ) void {
        return api.rocksdb_options_set_db_paths(
            helpers.unwrap(arg0.*),
            path_values,
            num_paths,
        );
    }

    pub fn setCfPaths(
        arg0: *Self,
        path_values: [*c][*c]const api.rocksdb_dbpath_t,
        num_paths: i64,
    ) void {
        return api.rocksdb_options_set_cf_paths(
            helpers.unwrap(arg0.*),
            path_values,
            num_paths,
        );
    }

    pub fn setEnv(arg0: *Self, arg1: *RocksdbEnv) void {
        return api.rocksdb_options_set_env(helpers.unwrap(arg0.*), helpers.unwrap(arg1.*));
    }

    pub fn setInfoLog(arg0: *Self, arg1: *RocksdbLogger) void {
        return api.rocksdb_options_set_info_log(
            helpers.unwrap(arg0.*),
            helpers.unwrap(arg1.*),
        );
    }

    pub fn getInfoLog(opt: *Self) [*c]api.rocksdb_logger_t {
        return api.rocksdb_options_get_info_log(helpers.unwrap(opt.*));
    }

    pub fn setInfoLogLevel(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_info_log_level(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getInfoLogLevel(arg0: *Self) i64 {
        return api.rocksdb_options_get_info_log_level(helpers.unwrap(arg0.*));
    }

    pub fn setWriteBufferSize(arg0: *Self, size_t: i64) void {
        return api.rocksdb_options_set_write_buffer_size(helpers.unwrap(arg0.*), size_t);
    }

    pub fn getWriteBufferSize(arg0: *Self) i64 {
        return api.rocksdb_options_get_write_buffer_size(helpers.unwrap(arg0.*));
    }

    pub fn setDbWriteBufferSize(arg0: *Self, size_t: i64) void {
        return api.rocksdb_options_set_db_write_buffer_size(
            helpers.unwrap(arg0.*),
            size_t,
        );
    }

    pub fn getDbWriteBufferSize(arg0: *Self) i64 {
        return api.rocksdb_options_get_db_write_buffer_size(helpers.unwrap(arg0.*));
    }

    pub fn setMaxOpenFiles(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_max_open_files(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getMaxOpenFiles(arg0: *Self) i64 {
        return api.rocksdb_options_get_max_open_files(helpers.unwrap(arg0.*));
    }

    pub fn setMaxFileOpeningThreads(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_max_file_opening_threads(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getMaxFileOpeningThreads(arg0: *Self) i64 {
        return api.rocksdb_options_get_max_file_opening_threads(helpers.unwrap(arg0.*));
    }

    pub fn setMaxTotalWalSize(opt: *Self, n: i64) void {
        return api.rocksdb_options_set_max_total_wal_size(helpers.unwrap(opt.*), n);
    }

    pub fn getMaxTotalWalSize(opt: *Self) i64 {
        return api.rocksdb_options_get_max_total_wal_size(helpers.unwrap(opt.*));
    }

    pub fn setCompressionOptions(
        arg0: *Self,
        arg1: i64,
        arg2: i64,
        arg3: i64,
        arg4: i64,
    ) void {
        return api.rocksdb_options_set_compression_options(
            helpers.unwrap(arg0.*),
            arg1,
            arg2,
            arg3,
            arg4,
        );
    }

    pub fn setCompressionOptionsZstdMaxTrainBytes(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_compression_options_zstd_max_train_bytes(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getCompressionOptionsZstdMaxTrainBytes(opt: *Self) i64 {
        return api.rocksdb_options_get_compression_options_zstd_max_train_bytes(
            helpers.unwrap(opt.*),
        );
    }

    pub fn setCompressionOptionsUseZstdDictTrainer(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_compression_options_use_zstd_dict_trainer(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getCompressionOptionsUseZstdDictTrainer(opt: *Self) u8 {
        return api.rocksdb_options_get_compression_options_use_zstd_dict_trainer(
            helpers.unwrap(opt.*),
        );
    }

    pub fn setCompressionOptionsParallelThreads(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_compression_options_parallel_threads(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getCompressionOptionsParallelThreads(opt: *Self) i64 {
        return api.rocksdb_options_get_compression_options_parallel_threads(
            helpers.unwrap(opt.*),
        );
    }

    pub fn setCompressionOptionsMaxDictBufferBytes(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_options_set_compression_options_max_dict_buffer_bytes(
            helpers.unwrap(arg0.*),
            uint64_t,
        );
    }

    pub fn getCompressionOptionsMaxDictBufferBytes(opt: *Self) i64 {
        return api.rocksdb_options_get_compression_options_max_dict_buffer_bytes(
            helpers.unwrap(opt.*),
        );
    }

    pub fn setBottommostCompressionOptions(
        arg0: *Self,
        arg1: i64,
        arg2: i64,
        arg3: i64,
        arg4: i64,
        arg5: u8,
    ) void {
        return api.rocksdb_options_set_bottommost_compression_options(
            helpers.unwrap(arg0.*),
            arg1,
            arg2,
            arg3,
            arg4,
            arg5,
        );
    }

    pub fn setBottommostCompressionOptionsZstdMaxTrainBytes(
        arg0: *Self,
        arg1: i64,
        arg2: u8,
    ) void {
        return api.rocksdb_options_set_bottommost_compression_options_zstd_max_train_bytes(
            helpers.unwrap(arg0.*),
            arg1,
            arg2,
        );
    }

    pub fn setBottommostCompressionOptionsUseZstdDictTrainer(
        arg0: *Self,
        arg1: u8,
        arg2: u8,
    ) void {
        return api.rocksdb_options_set_bottommost_compression_options_use_zstd_dict_trainer(
            helpers.unwrap(arg0.*),
            arg1,
            arg2,
        );
    }

    pub fn getBottommostCompressionOptionsUseZstdDictTrainer(opt: *Self) u8 {
        return api.rocksdb_options_get_bottommost_compression_options_use_zstd_dict_trainer(
            helpers.unwrap(opt.*),
        );
    }

    pub fn setBottommostCompressionOptionsMaxDictBufferBytes(
        arg0: *Self,
        uint64_t: i64,
        arg2: u8,
    ) void {
        return api.rocksdb_options_set_bottommost_compression_options_max_dict_buffer_bytes(
            helpers.unwrap(arg0.*),
            uint64_t,
            arg2,
        );
    }

    pub fn setPrefixExtractor(arg0: *Self, arg1: *RocksdbSlicetransform) void {
        return api.rocksdb_options_set_prefix_extractor(
            helpers.unwrap(arg0.*),
            helpers.unwrap(arg1.*),
        );
    }

    pub fn setNumLevels(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_num_levels(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getNumLevels(arg0: *Self) i64 {
        return api.rocksdb_options_get_num_levels(helpers.unwrap(arg0.*));
    }

    pub fn setLevel0FileNumCompactionTrigger(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_level0_file_num_compaction_trigger(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getLevel0FileNumCompactionTrigger(arg0: *Self) i64 {
        return api.rocksdb_options_get_level0_file_num_compaction_trigger(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setLevel0SlowdownWritesTrigger(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_level0_slowdown_writes_trigger(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getLevel0SlowdownWritesTrigger(arg0: *Self) i64 {
        return api.rocksdb_options_get_level0_slowdown_writes_trigger(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setLevel0StopWritesTrigger(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_level0_stop_writes_trigger(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getLevel0StopWritesTrigger(arg0: *Self) i64 {
        return api.rocksdb_options_get_level0_stop_writes_trigger(helpers.unwrap(arg0.*));
    }

    pub fn setTargetFileSizeBase(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_options_set_target_file_size_base(
            helpers.unwrap(arg0.*),
            uint64_t,
        );
    }

    pub fn getTargetFileSizeBase(arg0: *Self) i64 {
        return api.rocksdb_options_get_target_file_size_base(helpers.unwrap(arg0.*));
    }

    pub fn setTargetFileSizeMultiplier(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_target_file_size_multiplier(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getTargetFileSizeMultiplier(arg0: *Self) i64 {
        return api.rocksdb_options_get_target_file_size_multiplier(helpers.unwrap(arg0.*));
    }

    pub fn setMaxBytesForLevelBase(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_options_set_max_bytes_for_level_base(
            helpers.unwrap(arg0.*),
            uint64_t,
        );
    }

    pub fn getMaxBytesForLevelBase(arg0: *Self) i64 {
        return api.rocksdb_options_get_max_bytes_for_level_base(helpers.unwrap(arg0.*));
    }

    pub fn setLevelCompactionDynamicLevelBytes(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_level_compaction_dynamic_level_bytes(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getLevelCompactionDynamicLevelBytes(arg0: *Self) u8 {
        return api.rocksdb_options_get_level_compaction_dynamic_level_bytes(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setMaxBytesForLevelMultiplier(arg0: *Self, arg1: f64) void {
        return api.rocksdb_options_set_max_bytes_for_level_multiplier(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getMaxBytesForLevelMultiplier(arg0: *Self) f64 {
        return api.rocksdb_options_get_max_bytes_for_level_multiplier(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setMaxBytesForLevelMultiplierAdditional(
        arg0: *Self,
        level_values: [*c]i64,
        num_levels: i64,
    ) void {
        return api.rocksdb_options_set_max_bytes_for_level_multiplier_additional(
            helpers.unwrap(arg0.*),
            level_values,
            num_levels,
        );
    }

    pub fn enableStatistics(arg0: *Self) void {
        return api.rocksdb_options_enable_statistics(helpers.unwrap(arg0.*));
    }

    pub fn setTtl(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_options_set_ttl(helpers.unwrap(arg0.*), uint64_t);
    }

    pub fn getTtl(arg0: *Self) i64 {
        return api.rocksdb_options_get_ttl(helpers.unwrap(arg0.*));
    }

    pub fn setPeriodicCompactionSeconds(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_options_set_periodic_compaction_seconds(
            helpers.unwrap(arg0.*),
            uint64_t,
        );
    }

    pub fn getPeriodicCompactionSeconds(arg0: *Self) i64 {
        return api.rocksdb_options_get_periodic_compaction_seconds(helpers.unwrap(arg0.*));
    }

    pub fn setMemtableOpScanFlushTrigger(arg0: *Self, uint32_t: i64) void {
        return api.rocksdb_options_set_memtable_op_scan_flush_trigger(
            helpers.unwrap(arg0.*),
            uint32_t,
        );
    }

    pub fn getMemtableOpScanFlushTrigger(arg0: *Self) i64 {
        return api.rocksdb_options_get_memtable_op_scan_flush_trigger(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setMemtableAvgOpScanFlushTrigger(arg0: *Self, uint32_t: i64) void {
        return api.rocksdb_options_set_memtable_avg_op_scan_flush_trigger(
            helpers.unwrap(arg0.*),
            uint32_t,
        );
    }

    pub fn getMemtableAvgOpScanFlushTrigger(arg0: *Self) i64 {
        return api.rocksdb_options_get_memtable_avg_op_scan_flush_trigger(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setStatisticsLevel(arg0: *Self, level: i64) void {
        return api.rocksdb_options_set_statistics_level(helpers.unwrap(arg0.*), level);
    }

    pub fn getStatisticsLevel(arg0: *Self) i64 {
        return api.rocksdb_options_get_statistics_level(helpers.unwrap(arg0.*));
    }

    pub fn setSkipStatsUpdateOnDbOpen(opt: *Self, val: u8) void {
        return api.rocksdb_options_set_skip_stats_update_on_db_open(
            helpers.unwrap(opt.*),
            val,
        );
    }

    pub fn getSkipStatsUpdateOnDbOpen(opt: *Self) u8 {
        return api.rocksdb_options_get_skip_stats_update_on_db_open(helpers.unwrap(opt.*));
    }

    pub fn setSkipCheckingSstFileSizesOnDbOpen(opt: *Self, val: u8) void {
        return api.rocksdb_options_set_skip_checking_sst_file_sizes_on_db_open(
            helpers.unwrap(opt.*),
            val,
        );
    }

    pub fn getSkipCheckingSstFileSizesOnDbOpen(opt: *Self) u8 {
        return api.rocksdb_options_get_skip_checking_sst_file_sizes_on_db_open(
            helpers.unwrap(opt.*),
        );
    }

    pub fn setEnableBlobFiles(opt: *Self, val: u8) void {
        return api.rocksdb_options_set_enable_blob_files(helpers.unwrap(opt.*), val);
    }

    pub fn getEnableBlobFiles(opt: *Self) u8 {
        return api.rocksdb_options_get_enable_blob_files(helpers.unwrap(opt.*));
    }

    pub fn setMinBlobSize(opt: *Self, val: i64) void {
        return api.rocksdb_options_set_min_blob_size(helpers.unwrap(opt.*), val);
    }

    pub fn getMinBlobSize(opt: *Self) i64 {
        return api.rocksdb_options_get_min_blob_size(helpers.unwrap(opt.*));
    }

    pub fn setBlobFileSize(opt: *Self, val: i64) void {
        return api.rocksdb_options_set_blob_file_size(helpers.unwrap(opt.*), val);
    }

    pub fn getBlobFileSize(opt: *Self) i64 {
        return api.rocksdb_options_get_blob_file_size(helpers.unwrap(opt.*));
    }

    pub fn setBlobCompressionType(opt: *Self, val: i64) void {
        return api.rocksdb_options_set_blob_compression_type(helpers.unwrap(opt.*), val);
    }

    pub fn getBlobCompressionType(opt: *Self) i64 {
        return api.rocksdb_options_get_blob_compression_type(helpers.unwrap(opt.*));
    }

    pub fn setEnableBlobGc(opt: *Self, val: u8) void {
        return api.rocksdb_options_set_enable_blob_gc(helpers.unwrap(opt.*), val);
    }

    pub fn getEnableBlobGc(opt: *Self) u8 {
        return api.rocksdb_options_get_enable_blob_gc(helpers.unwrap(opt.*));
    }

    pub fn setBlobGcAgeCutoff(opt: *Self, val: f64) void {
        return api.rocksdb_options_set_blob_gc_age_cutoff(helpers.unwrap(opt.*), val);
    }

    pub fn getBlobGcAgeCutoff(opt: *Self) f64 {
        return api.rocksdb_options_get_blob_gc_age_cutoff(helpers.unwrap(opt.*));
    }

    pub fn setBlobGcForceThreshold(opt: *Self, val: f64) void {
        return api.rocksdb_options_set_blob_gc_force_threshold(helpers.unwrap(opt.*), val);
    }

    pub fn getBlobGcForceThreshold(opt: *Self) f64 {
        return api.rocksdb_options_get_blob_gc_force_threshold(helpers.unwrap(opt.*));
    }

    pub fn setBlobCompactionReadaheadSize(opt: *Self, val: i64) void {
        return api.rocksdb_options_set_blob_compaction_readahead_size(
            helpers.unwrap(opt.*),
            val,
        );
    }

    pub fn getBlobCompactionReadaheadSize(opt: *Self) i64 {
        return api.rocksdb_options_get_blob_compaction_readahead_size(
            helpers.unwrap(opt.*),
        );
    }

    pub fn setBlobFileStartingLevel(opt: *Self, val: i64) void {
        return api.rocksdb_options_set_blob_file_starting_level(
            helpers.unwrap(opt.*),
            val,
        );
    }

    pub fn getBlobFileStartingLevel(opt: *Self) i64 {
        return api.rocksdb_options_get_blob_file_starting_level(helpers.unwrap(opt.*));
    }

    pub fn setBlobCache(opt: *Self, blob_cache: *RocksdbCache) void {
        return api.rocksdb_options_set_blob_cache(
            helpers.unwrap(opt.*),
            helpers.unwrap(blob_cache.*),
        );
    }

    pub fn setPrepopulateBlobCache(opt: *Self, val: i64) void {
        return api.rocksdb_options_set_prepopulate_blob_cache(helpers.unwrap(opt.*), val);
    }

    pub fn getPrepopulateBlobCache(opt: *Self) i64 {
        return api.rocksdb_options_get_prepopulate_blob_cache(helpers.unwrap(opt.*));
    }

    pub fn statisticsGetString(opt: *Self) [*c]i8 {
        return api.rocksdb_options_statistics_get_string(helpers.unwrap(opt.*));
    }

    pub fn statisticsGetTickerCount(opt: *Self, ticker_type: i64) i64 {
        return api.rocksdb_options_statistics_get_ticker_count(
            helpers.unwrap(opt.*),
            ticker_type,
        );
    }

    pub fn statisticsGetHistogramData(
        opt: *Self,
        histogram_type: i64,
        data: *RocksdbStatisticsHistogramData,
    ) void {
        return api.rocksdb_options_statistics_get_histogram_data(
            helpers.unwrap(opt.*),
            histogram_type,
            helpers.unwrap(data.*),
        );
    }

    pub fn setMaxWriteBufferNumber(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_max_write_buffer_number(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getMaxWriteBufferNumber(arg0: *Self) i64 {
        return api.rocksdb_options_get_max_write_buffer_number(helpers.unwrap(arg0.*));
    }

    pub fn setMinWriteBufferNumberToMerge(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_min_write_buffer_number_to_merge(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getMinWriteBufferNumberToMerge(arg0: *Self) i64 {
        return api.rocksdb_options_get_min_write_buffer_number_to_merge(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setMaxWriteBufferSizeToMaintain(arg0: *Self, int64_t: i64) void {
        return api.rocksdb_options_set_max_write_buffer_size_to_maintain(
            helpers.unwrap(arg0.*),
            int64_t,
        );
    }

    pub fn getMaxWriteBufferSizeToMaintain(arg0: *Self) i64 {
        return api.rocksdb_options_get_max_write_buffer_size_to_maintain(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setEnablePipelinedWrite(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_enable_pipelined_write(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getEnablePipelinedWrite(arg0: *Self) u8 {
        return api.rocksdb_options_get_enable_pipelined_write(helpers.unwrap(arg0.*));
    }

    pub fn setUnorderedWrite(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_unordered_write(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getUnorderedWrite(arg0: *Self) u8 {
        return api.rocksdb_options_get_unordered_write(helpers.unwrap(arg0.*));
    }

    pub fn setMaxSubcompactions(arg0: *Self, uint32_t: i64) void {
        return api.rocksdb_options_set_max_subcompactions(
            helpers.unwrap(arg0.*),
            uint32_t,
        );
    }

    pub fn getMaxSubcompactions(arg0: *Self) i64 {
        return api.rocksdb_options_get_max_subcompactions(helpers.unwrap(arg0.*));
    }

    pub fn setMaxBackgroundJobs(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_max_background_jobs(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getMaxBackgroundJobs(arg0: *Self) i64 {
        return api.rocksdb_options_get_max_background_jobs(helpers.unwrap(arg0.*));
    }

    pub fn setMaxBackgroundCompactions(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_max_background_compactions(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getMaxBackgroundCompactions(arg0: *Self) i64 {
        return api.rocksdb_options_get_max_background_compactions(helpers.unwrap(arg0.*));
    }

    pub fn setMaxBackgroundFlushes(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_max_background_flushes(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getMaxBackgroundFlushes(arg0: *Self) i64 {
        return api.rocksdb_options_get_max_background_flushes(helpers.unwrap(arg0.*));
    }

    pub fn setMaxLogFileSize(arg0: *Self, size_t: i64) void {
        return api.rocksdb_options_set_max_log_file_size(helpers.unwrap(arg0.*), size_t);
    }

    pub fn getMaxLogFileSize(arg0: *Self) i64 {
        return api.rocksdb_options_get_max_log_file_size(helpers.unwrap(arg0.*));
    }

    pub fn setLogFileTimeToRoll(arg0: *Self, size_t: i64) void {
        return api.rocksdb_options_set_log_file_time_to_roll(
            helpers.unwrap(arg0.*),
            size_t,
        );
    }

    pub fn getLogFileTimeToRoll(arg0: *Self) i64 {
        return api.rocksdb_options_get_log_file_time_to_roll(helpers.unwrap(arg0.*));
    }

    pub fn setKeepLogFileNum(arg0: *Self, size_t: i64) void {
        return api.rocksdb_options_set_keep_log_file_num(helpers.unwrap(arg0.*), size_t);
    }

    pub fn getKeepLogFileNum(arg0: *Self) i64 {
        return api.rocksdb_options_get_keep_log_file_num(helpers.unwrap(arg0.*));
    }

    pub fn setRecycleLogFileNum(arg0: *Self, size_t: i64) void {
        return api.rocksdb_options_set_recycle_log_file_num(
            helpers.unwrap(arg0.*),
            size_t,
        );
    }

    pub fn getRecycleLogFileNum(arg0: *Self) i64 {
        return api.rocksdb_options_get_recycle_log_file_num(helpers.unwrap(arg0.*));
    }

    pub fn setSoftPendingCompactionBytesLimit(opt: *Self, v: i64) void {
        return api.rocksdb_options_set_soft_pending_compaction_bytes_limit(
            helpers.unwrap(opt.*),
            v,
        );
    }

    pub fn getSoftPendingCompactionBytesLimit(opt: *Self) i64 {
        return api.rocksdb_options_get_soft_pending_compaction_bytes_limit(
            helpers.unwrap(opt.*),
        );
    }

    pub fn setHardPendingCompactionBytesLimit(opt: *Self, v: i64) void {
        return api.rocksdb_options_set_hard_pending_compaction_bytes_limit(
            helpers.unwrap(opt.*),
            v,
        );
    }

    pub fn getHardPendingCompactionBytesLimit(opt: *Self) i64 {
        return api.rocksdb_options_get_hard_pending_compaction_bytes_limit(
            helpers.unwrap(opt.*),
        );
    }

    pub fn setMaxManifestFileSize(arg0: *Self, size_t: i64) void {
        return api.rocksdb_options_set_max_manifest_file_size(
            helpers.unwrap(arg0.*),
            size_t,
        );
    }

    pub fn getMaxManifestFileSize(arg0: *Self) i64 {
        return api.rocksdb_options_get_max_manifest_file_size(helpers.unwrap(arg0.*));
    }

    pub fn setTableCacheNumshardbits(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_table_cache_numshardbits(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getTableCacheNumshardbits(arg0: *Self) i64 {
        return api.rocksdb_options_get_table_cache_numshardbits(helpers.unwrap(arg0.*));
    }

    pub fn setArenaBlockSize(arg0: *Self, size_t: i64) void {
        return api.rocksdb_options_set_arena_block_size(helpers.unwrap(arg0.*), size_t);
    }

    pub fn getArenaBlockSize(arg0: *Self) i64 {
        return api.rocksdb_options_get_arena_block_size(helpers.unwrap(arg0.*));
    }

    pub fn setUseFsync(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_use_fsync(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getUseFsync(arg0: *Self) i64 {
        return api.rocksdb_options_get_use_fsync(helpers.unwrap(arg0.*));
    }

    pub fn setDbLogDir(arg0: *Self, arg1: [*c]const i8) void {
        return api.rocksdb_options_set_db_log_dir(helpers.unwrap(arg0.*), arg1);
    }

    pub fn setWalDir(arg0: *Self, arg1: [*c]const i8) void {
        return api.rocksdb_options_set_wal_dir(helpers.unwrap(arg0.*), arg1);
    }

    pub fn setWalTtlSeconds(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_options_set_WAL_ttl_seconds(helpers.unwrap(arg0.*), uint64_t);
    }

    pub fn getWalTtlSeconds(arg0: *Self) i64 {
        return api.rocksdb_options_get_WAL_ttl_seconds(helpers.unwrap(arg0.*));
    }

    pub fn setWalSizeLimitMb(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_options_set_WAL_size_limit_MB(helpers.unwrap(arg0.*), uint64_t);
    }

    pub fn getWalSizeLimitMb(arg0: *Self) i64 {
        return api.rocksdb_options_get_WAL_size_limit_MB(helpers.unwrap(arg0.*));
    }

    pub fn setManifestPreallocationSize(arg0: *Self, size_t: i64) void {
        return api.rocksdb_options_set_manifest_preallocation_size(
            helpers.unwrap(arg0.*),
            size_t,
        );
    }

    pub fn getManifestPreallocationSize(arg0: *Self) i64 {
        return api.rocksdb_options_get_manifest_preallocation_size(helpers.unwrap(arg0.*));
    }

    pub fn setAllowMmapReads(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_allow_mmap_reads(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getAllowMmapReads(arg0: *Self) u8 {
        return api.rocksdb_options_get_allow_mmap_reads(helpers.unwrap(arg0.*));
    }

    pub fn setAllowMmapWrites(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_allow_mmap_writes(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getAllowMmapWrites(arg0: *Self) u8 {
        return api.rocksdb_options_get_allow_mmap_writes(helpers.unwrap(arg0.*));
    }

    pub fn setUseDirectReads(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_use_direct_reads(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getUseDirectReads(arg0: *Self) u8 {
        return api.rocksdb_options_get_use_direct_reads(helpers.unwrap(arg0.*));
    }

    pub fn setUseDirectIoForFlushAndCompaction(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_use_direct_io_for_flush_and_compaction(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getUseDirectIoForFlushAndCompaction(arg0: *Self) u8 {
        return api.rocksdb_options_get_use_direct_io_for_flush_and_compaction(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setIsFdCloseOnExec(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_is_fd_close_on_exec(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getIsFdCloseOnExec(arg0: *Self) u8 {
        return api.rocksdb_options_get_is_fd_close_on_exec(helpers.unwrap(arg0.*));
    }

    pub fn setStatsDumpPeriodSec(arg0: *Self, arg1: u64) void {
        return api.rocksdb_options_set_stats_dump_period_sec(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getStatsDumpPeriodSec(arg0: *Self) u64 {
        return api.rocksdb_options_get_stats_dump_period_sec(helpers.unwrap(arg0.*));
    }

    pub fn setStatsPersistPeriodSec(arg0: *Self, arg1: u64) void {
        return api.rocksdb_options_set_stats_persist_period_sec(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getStatsPersistPeriodSec(arg0: *Self) u64 {
        return api.rocksdb_options_get_stats_persist_period_sec(helpers.unwrap(arg0.*));
    }

    pub fn setAdviseRandomOnOpen(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_advise_random_on_open(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getAdviseRandomOnOpen(arg0: *Self) u8 {
        return api.rocksdb_options_get_advise_random_on_open(helpers.unwrap(arg0.*));
    }

    pub fn setUseAdaptiveMutex(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_use_adaptive_mutex(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getUseAdaptiveMutex(arg0: *Self) u8 {
        return api.rocksdb_options_get_use_adaptive_mutex(helpers.unwrap(arg0.*));
    }

    pub fn setBytesPerSync(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_options_set_bytes_per_sync(helpers.unwrap(arg0.*), uint64_t);
    }

    pub fn getBytesPerSync(arg0: *Self) i64 {
        return api.rocksdb_options_get_bytes_per_sync(helpers.unwrap(arg0.*));
    }

    pub fn setWalBytesPerSync(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_options_set_wal_bytes_per_sync(
            helpers.unwrap(arg0.*),
            uint64_t,
        );
    }

    pub fn getWalBytesPerSync(arg0: *Self) i64 {
        return api.rocksdb_options_get_wal_bytes_per_sync(helpers.unwrap(arg0.*));
    }

    pub fn setWritableFileMaxBufferSize(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_options_set_writable_file_max_buffer_size(
            helpers.unwrap(arg0.*),
            uint64_t,
        );
    }

    pub fn getWritableFileMaxBufferSize(arg0: *Self) i64 {
        return api.rocksdb_options_get_writable_file_max_buffer_size(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setAllowConcurrentMemtableWrite(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_allow_concurrent_memtable_write(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getAllowConcurrentMemtableWrite(arg0: *Self) u8 {
        return api.rocksdb_options_get_allow_concurrent_memtable_write(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setEnableWriteThreadAdaptiveYield(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_enable_write_thread_adaptive_yield(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getEnableWriteThreadAdaptiveYield(arg0: *Self) u8 {
        return api.rocksdb_options_get_enable_write_thread_adaptive_yield(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setMaxSequentialSkipInIterations(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_options_set_max_sequential_skip_in_iterations(
            helpers.unwrap(arg0.*),
            uint64_t,
        );
    }

    pub fn getMaxSequentialSkipInIterations(arg0: *Self) i64 {
        return api.rocksdb_options_get_max_sequential_skip_in_iterations(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setDisableAutoCompactions(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_disable_auto_compactions(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getDisableAutoCompactions(arg0: *Self) u8 {
        return api.rocksdb_options_get_disable_auto_compactions(helpers.unwrap(arg0.*));
    }

    pub fn setOptimizeFiltersForHits(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_optimize_filters_for_hits(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getOptimizeFiltersForHits(arg0: *Self) u8 {
        return api.rocksdb_options_get_optimize_filters_for_hits(helpers.unwrap(arg0.*));
    }

    pub fn setDeleteObsoleteFilesPeriodMicros(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_options_set_delete_obsolete_files_period_micros(
            helpers.unwrap(arg0.*),
            uint64_t,
        );
    }

    pub fn getDeleteObsoleteFilesPeriodMicros(arg0: *Self) i64 {
        return api.rocksdb_options_get_delete_obsolete_files_period_micros(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn prepareForBulkLoad(arg0: *Self) void {
        return api.rocksdb_options_prepare_for_bulk_load(helpers.unwrap(arg0.*));
    }

    pub fn setMemtableVectorRep(arg0: *Self) void {
        return api.rocksdb_options_set_memtable_vector_rep(helpers.unwrap(arg0.*));
    }

    pub fn setMemtablePrefixBloomSizeRatio(arg0: *Self, arg1: f64) void {
        return api.rocksdb_options_set_memtable_prefix_bloom_size_ratio(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getMemtablePrefixBloomSizeRatio(arg0: *Self) f64 {
        return api.rocksdb_options_get_memtable_prefix_bloom_size_ratio(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setMaxCompactionBytes(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_options_set_max_compaction_bytes(
            helpers.unwrap(arg0.*),
            uint64_t,
        );
    }

    pub fn getMaxCompactionBytes(arg0: *Self) i64 {
        return api.rocksdb_options_get_max_compaction_bytes(helpers.unwrap(arg0.*));
    }

    pub fn setHashSkipListRep(
        arg0: *Self,
        size_t: i64,
        int32_t: i64,
        arg3: i64,
    ) void {
        return api.rocksdb_options_set_hash_skip_list_rep(
            helpers.unwrap(arg0.*),
            size_t,
            int32_t,
            arg3,
        );
    }

    pub fn setHashLinkListRep(arg0: *Self, size_t: i64) void {
        return api.rocksdb_options_set_hash_link_list_rep(helpers.unwrap(arg0.*), size_t);
    }

    pub fn setPlainTableFactory(
        arg0: *Self,
        uint32_t: i64,
        arg2: i64,
        arg3: f64,
        size_t: i64,
        arg5: i64,
        arg6: i8,
        arg7: u8,
        arg8: u8,
    ) void {
        return api.rocksdb_options_set_plain_table_factory(
            helpers.unwrap(arg0.*),
            uint32_t,
            arg2,
            arg3,
            size_t,
            arg5,
            arg6,
            arg7,
            arg8,
        );
    }

    pub fn getWriteDbidToManifest(arg0: *Self) u8 {
        return api.rocksdb_options_get_write_dbid_to_manifest(helpers.unwrap(arg0.*));
    }

    pub fn setWriteDbidToManifest(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_write_dbid_to_manifest(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getWriteIdentityFile(arg0: *Self) u8 {
        return api.rocksdb_options_get_write_identity_file(helpers.unwrap(arg0.*));
    }

    pub fn setWriteIdentityFile(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_write_identity_file(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getTrackAndVerifyWalsInManifest(arg0: *Self) u8 {
        return api.rocksdb_options_get_track_and_verify_wals_in_manifest(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setTrackAndVerifyWalsInManifest(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_track_and_verify_wals_in_manifest(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn setMinLevelToCompress(opt: *Self, level: i64) void {
        return api.rocksdb_options_set_min_level_to_compress(helpers.unwrap(opt.*), level);
    }

    pub fn setMemtableHugePageSize(arg0: *Self, size_t: i64) void {
        return api.rocksdb_options_set_memtable_huge_page_size(
            helpers.unwrap(arg0.*),
            size_t,
        );
    }

    pub fn getMemtableHugePageSize(arg0: *Self) i64 {
        return api.rocksdb_options_get_memtable_huge_page_size(helpers.unwrap(arg0.*));
    }

    pub fn setMaxSuccessiveMerges(arg0: *Self, size_t: i64) void {
        return api.rocksdb_options_set_max_successive_merges(
            helpers.unwrap(arg0.*),
            size_t,
        );
    }

    pub fn getMaxSuccessiveMerges(arg0: *Self) i64 {
        return api.rocksdb_options_get_max_successive_merges(helpers.unwrap(arg0.*));
    }

    pub fn setBloomLocality(arg0: *Self, uint32_t: i64) void {
        return api.rocksdb_options_set_bloom_locality(helpers.unwrap(arg0.*), uint32_t);
    }

    pub fn getBloomLocality(arg0: *Self) i64 {
        return api.rocksdb_options_get_bloom_locality(helpers.unwrap(arg0.*));
    }

    pub fn setInplaceUpdateSupport(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_inplace_update_support(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getInplaceUpdateSupport(arg0: *Self) u8 {
        return api.rocksdb_options_get_inplace_update_support(helpers.unwrap(arg0.*));
    }

    pub fn setInplaceUpdateNumLocks(arg0: *Self, size_t: i64) void {
        return api.rocksdb_options_set_inplace_update_num_locks(
            helpers.unwrap(arg0.*),
            size_t,
        );
    }

    pub fn getInplaceUpdateNumLocks(arg0: *Self) i64 {
        return api.rocksdb_options_get_inplace_update_num_locks(helpers.unwrap(arg0.*));
    }

    pub fn setReportBgIoStats(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_report_bg_io_stats(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getReportBgIoStats(arg0: *Self) u8 {
        return api.rocksdb_options_get_report_bg_io_stats(helpers.unwrap(arg0.*));
    }

    pub fn setAvoidUnnecessaryBlockingIo(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_avoid_unnecessary_blocking_io(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getAvoidUnnecessaryBlockingIo(arg0: *Self) u8 {
        return api.rocksdb_options_get_avoid_unnecessary_blocking_io(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setExperimentalMempurgeThreshold(arg0: *Self, arg1: f64) void {
        return api.rocksdb_options_set_experimental_mempurge_threshold(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getExperimentalMempurgeThreshold(arg0: *Self) f64 {
        return api.rocksdb_options_get_experimental_mempurge_threshold(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setWalRecoveryMode(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_wal_recovery_mode(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getWalRecoveryMode(arg0: *Self) i64 {
        return api.rocksdb_options_get_wal_recovery_mode(helpers.unwrap(arg0.*));
    }

    pub fn setCompression(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_compression(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getCompression(arg0: *Self) i64 {
        return api.rocksdb_options_get_compression(helpers.unwrap(arg0.*));
    }

    pub fn setBottommostCompression(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_bottommost_compression(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getBottommostCompression(arg0: *Self) i64 {
        return api.rocksdb_options_get_bottommost_compression(helpers.unwrap(arg0.*));
    }

    pub fn setCompactionStyle(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_compaction_style(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getCompactionStyle(arg0: *Self) i64 {
        return api.rocksdb_options_get_compaction_style(helpers.unwrap(arg0.*));
    }

    pub fn setUniversalCompactionOptions(
        arg0: *Self,
        arg1: *RocksdbUniversalCompactionOptions,
    ) void {
        return api.rocksdb_options_set_universal_compaction_options(
            helpers.unwrap(arg0.*),
            helpers.unwrap(arg1.*),
        );
    }

    pub fn setFifoCompactionOptions(
        opt: *Self,
        fifo: *RocksdbFifoCompactionOptions,
    ) void {
        return api.rocksdb_options_set_fifo_compaction_options(
            helpers.unwrap(opt.*),
            helpers.unwrap(fifo.*),
        );
    }

    pub fn setRatelimiter(opt: *Self, limiter: *RocksdbRatelimiter) void {
        return api.rocksdb_options_set_ratelimiter(
            helpers.unwrap(opt.*),
            helpers.unwrap(limiter.*),
        );
    }

    pub fn setAtomicFlush(opt: *Self, arg1: u8) void {
        return api.rocksdb_options_set_atomic_flush(helpers.unwrap(opt.*), arg1);
    }

    pub fn getAtomicFlush(opt: *Self) u8 {
        return api.rocksdb_options_get_atomic_flush(helpers.unwrap(opt.*));
    }

    pub fn setRowCache(opt: *Self, cache: *RocksdbCache) void {
        return api.rocksdb_options_set_row_cache(
            helpers.unwrap(opt.*),
            helpers.unwrap(cache.*),
        );
    }

    pub fn addCompactOnDeletionCollectorFactory(
        arg0: *Self,
        window_size: i64,
        num_dels_trigger: i64,
    ) void {
        return api.rocksdb_options_add_compact_on_deletion_collector_factory(
            helpers.unwrap(arg0.*),
            window_size,
            num_dels_trigger,
        );
    }

    pub fn addCompactOnDeletionCollectorFactoryDelRatio(
        arg0: *Self,
        window_size: i64,
        num_dels_trigger: i64,
        deletion_ratio: f64,
    ) void {
        return api.rocksdb_options_add_compact_on_deletion_collector_factory_del_ratio(
            helpers.unwrap(arg0.*),
            window_size,
            num_dels_trigger,
            deletion_ratio,
        );
    }

    pub fn addCompactOnDeletionCollectorFactoryMinFileSize(
        arg0: *Self,
        window_size: i64,
        num_dels_trigger: i64,
        deletion_ratio: f64,
        min_file_size: i64,
    ) void {
        return api.rocksdb_options_add_compact_on_deletion_collector_factory_min_file_size(
            helpers.unwrap(arg0.*),
            window_size,
            num_dels_trigger,
            deletion_ratio,
            min_file_size,
        );
    }

    pub fn setManualWalFlush(opt: *Self, arg1: u8) void {
        return api.rocksdb_options_set_manual_wal_flush(helpers.unwrap(opt.*), arg1);
    }

    pub fn getManualWalFlush(opt: *Self) u8 {
        return api.rocksdb_options_get_manual_wal_flush(helpers.unwrap(opt.*));
    }

    pub fn setWalCompression(opt: *Self, arg1: i64) void {
        return api.rocksdb_options_set_wal_compression(helpers.unwrap(opt.*), arg1);
    }

    pub fn getWalCompression(opt: *Self) i64 {
        return api.rocksdb_options_get_wal_compression(helpers.unwrap(opt.*));
    }

    pub fn setCompactionPri(arg0: *Self, arg1: i64) void {
        return api.rocksdb_options_set_compaction_pri(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getCompactionPri(arg0: *Self) i64 {
        return api.rocksdb_options_get_compaction_pri(helpers.unwrap(arg0.*));
    }

    pub fn getOptionsFromString(
        base_options: Self,
        opts_str: [*c]const i8,
        new_options: *Self,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_get_options_from_string(
            helpers.unwrap(base_options),
            opts_str,
            helpers.unwrap(new_options.*),
            errptr,
        );
    }

    pub fn setDumpMallocStats(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_dump_malloc_stats(helpers.unwrap(arg0.*), arg1);
    }

    pub fn setMemtableWholeKeyFiltering(arg0: *Self, arg1: u8) void {
        return api.rocksdb_options_set_memtable_whole_key_filtering(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    test RocksdbOptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbPerfcontext = packed struct {
    const Self = @This();
    ref: *api.rocksdb_perfcontext_t,

    pub fn create() [*c]api.rocksdb_perfcontext_t {
        return api.rocksdb_perfcontext_create();
    }

    pub fn reset(context: *Self) void {
        return api.rocksdb_perfcontext_reset(helpers.unwrap(context.*));
    }

    pub fn report(context: *Self, exclude_zero_counters: u8) [*c]i8 {
        return api.rocksdb_perfcontext_report(
            helpers.unwrap(context.*),
            exclude_zero_counters,
        );
    }

    pub fn metric(context: *Self, metric_: i64) i64 {
        return api.rocksdb_perfcontext_metric(helpers.unwrap(context.*), metric_);
    }

    pub fn destroy(context: *Self) void {
        return api.rocksdb_perfcontext_destroy(helpers.unwrap(context.*));
    }

    test RocksdbPerfcontext {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbPinnableHandle = packed struct {
    const Self = @This();
    ref: *api.rocksdb_pinnable_handle_t,

    pub fn getValue(handle: Self, vallen: [*c]i64) [*c]const i8 {
        return api.rocksdb_pinnable_handle_get_value(helpers.unwrap(handle), vallen);
    }

    pub fn destroy(handle: *Self) void {
        return api.rocksdb_pinnable_handle_destroy(helpers.unwrap(handle.*));
    }

    test RocksdbPinnableHandle {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbPinnableslice = packed struct {
    const Self = @This();
    ref: *api.rocksdb_pinnableslice_t,

    pub fn destroy(v: *Self) void {
        return api.rocksdb_pinnableslice_destroy(helpers.unwrap(v.*));
    }

    pub fn value(t: Self, vlen: [*c]i64) [*c]const i8 {
        return api.rocksdb_pinnableslice_value(helpers.unwrap(t), vlen);
    }

    test RocksdbPinnableslice {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbRatelimiter = packed struct {
    const Self = @This();
    ref: *api.rocksdb_ratelimiter_t,

    pub fn create(
        rate_bytes_per_sec: i64,
        refill_period_us: i64,
        fairness: i64,
    ) [*c]api.rocksdb_ratelimiter_t {
        return api.rocksdb_ratelimiter_create(
            rate_bytes_per_sec,
            refill_period_us,
            fairness,
        );
    }

    pub fn createAutoTuned(
        rate_bytes_per_sec: i64,
        refill_period_us: i64,
        fairness: i64,
    ) [*c]api.rocksdb_ratelimiter_t {
        return api.rocksdb_ratelimiter_create_auto_tuned(
            rate_bytes_per_sec,
            refill_period_us,
            fairness,
        );
    }

    pub fn createWithMode(
        rate_bytes_per_sec: i64,
        refill_period_us: i64,
        fairness: i64,
        mode: i64,
        auto_tuned: i64,
    ) [*c]api.rocksdb_ratelimiter_t {
        return api.rocksdb_ratelimiter_create_with_mode(
            rate_bytes_per_sec,
            refill_period_us,
            fairness,
            mode,
            auto_tuned,
        );
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_ratelimiter_destroy(helpers.unwrap(arg0.*));
    }

    test RocksdbRatelimiter {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbReadoptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_readoptions_t,

    pub fn create() [*c]api.rocksdb_readoptions_t {
        return api.rocksdb_readoptions_create();
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_readoptions_destroy(helpers.unwrap(arg0.*));
    }

    pub fn setVerifyChecksums(arg0: *Self, arg1: u8) void {
        return api.rocksdb_readoptions_set_verify_checksums(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getVerifyChecksums(arg0: *Self) u8 {
        return api.rocksdb_readoptions_get_verify_checksums(helpers.unwrap(arg0.*));
    }

    pub fn setFillCache(arg0: *Self, arg1: u8) void {
        return api.rocksdb_readoptions_set_fill_cache(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getFillCache(arg0: *Self) u8 {
        return api.rocksdb_readoptions_get_fill_cache(helpers.unwrap(arg0.*));
    }

    pub fn setSnapshot(arg0: *Self, arg1: RocksdbSnapshot) void {
        return api.rocksdb_readoptions_set_snapshot(
            helpers.unwrap(arg0.*),
            helpers.unwrap(arg1),
        );
    }

    pub fn setIterateUpperBound(arg0: *Self, key: []const u8) void {
        return api.rocksdb_readoptions_set_iterate_upper_bound(
            helpers.unwrap(arg0.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn setIterateLowerBound(arg0: *Self, key: []const u8) void {
        return api.rocksdb_readoptions_set_iterate_lower_bound(
            helpers.unwrap(arg0.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn setReadTier(arg0: *Self, arg1: i64) void {
        return api.rocksdb_readoptions_set_read_tier(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getReadTier(arg0: *Self) i64 {
        return api.rocksdb_readoptions_get_read_tier(helpers.unwrap(arg0.*));
    }

    pub fn setTailing(arg0: *Self, arg1: u8) void {
        return api.rocksdb_readoptions_set_tailing(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getTailing(arg0: *Self) u8 {
        return api.rocksdb_readoptions_get_tailing(helpers.unwrap(arg0.*));
    }

    pub fn setManaged(arg0: *Self, arg1: u8) void {
        return api.rocksdb_readoptions_set_managed(helpers.unwrap(arg0.*), arg1);
    }

    pub fn setReadaheadSize(arg0: *Self, size_t: i64) void {
        return api.rocksdb_readoptions_set_readahead_size(helpers.unwrap(arg0.*), size_t);
    }

    pub fn getReadaheadSize(arg0: *Self) i64 {
        return api.rocksdb_readoptions_get_readahead_size(helpers.unwrap(arg0.*));
    }

    pub fn setPrefixSameAsStart(arg0: *Self, arg1: u8) void {
        return api.rocksdb_readoptions_set_prefix_same_as_start(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getPrefixSameAsStart(arg0: *Self) u8 {
        return api.rocksdb_readoptions_get_prefix_same_as_start(helpers.unwrap(arg0.*));
    }

    pub fn setPinData(arg0: *Self, arg1: u8) void {
        return api.rocksdb_readoptions_set_pin_data(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getPinData(arg0: *Self) u8 {
        return api.rocksdb_readoptions_get_pin_data(helpers.unwrap(arg0.*));
    }

    pub fn setTotalOrderSeek(arg0: *Self, arg1: u8) void {
        return api.rocksdb_readoptions_set_total_order_seek(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getTotalOrderSeek(arg0: *Self) u8 {
        return api.rocksdb_readoptions_get_total_order_seek(helpers.unwrap(arg0.*));
    }

    pub fn setMaxSkippableInternalKeys(arg0: *Self, uint64_t: i64) void {
        return api.rocksdb_readoptions_set_max_skippable_internal_keys(
            helpers.unwrap(arg0.*),
            uint64_t,
        );
    }

    pub fn getMaxSkippableInternalKeys(arg0: *Self) i64 {
        return api.rocksdb_readoptions_get_max_skippable_internal_keys(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setBackgroundPurgeOnIteratorCleanup(arg0: *Self, arg1: u8) void {
        return api.rocksdb_readoptions_set_background_purge_on_iterator_cleanup(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getBackgroundPurgeOnIteratorCleanup(arg0: *Self) u8 {
        return api.rocksdb_readoptions_get_background_purge_on_iterator_cleanup(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setIgnoreRangeDeletions(arg0: *Self, arg1: u8) void {
        return api.rocksdb_readoptions_set_ignore_range_deletions(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getIgnoreRangeDeletions(arg0: *Self) u8 {
        return api.rocksdb_readoptions_get_ignore_range_deletions(helpers.unwrap(arg0.*));
    }

    pub fn setDeadline(arg0: *Self, microseconds: i64) void {
        return api.rocksdb_readoptions_set_deadline(helpers.unwrap(arg0.*), microseconds);
    }

    pub fn getDeadline(arg0: *Self) i64 {
        return api.rocksdb_readoptions_get_deadline(helpers.unwrap(arg0.*));
    }

    pub fn setIoTimeout(arg0: *Self, microseconds: i64) void {
        return api.rocksdb_readoptions_set_io_timeout(
            helpers.unwrap(arg0.*),
            microseconds,
        );
    }

    pub fn getIoTimeout(arg0: *Self) i64 {
        return api.rocksdb_readoptions_get_io_timeout(helpers.unwrap(arg0.*));
    }

    pub fn setAsyncIo(arg0: *Self, arg1: u8) void {
        return api.rocksdb_readoptions_set_async_io(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getAsyncIo(arg0: *Self) u8 {
        return api.rocksdb_readoptions_get_async_io(helpers.unwrap(arg0.*));
    }

    pub fn setTimestamp(arg0: *Self, ts: []const u8) void {
        return api.rocksdb_readoptions_set_timestamp(
            helpers.unwrap(arg0.*),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
        );
    }

    pub fn setIterStartTs(arg0: *Self, ts: []const u8) void {
        return api.rocksdb_readoptions_set_iter_start_ts(
            helpers.unwrap(arg0.*),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
        );
    }

    pub fn setAutoReadaheadSize(arg0: *Self, arg1: u8) void {
        return api.rocksdb_readoptions_set_auto_readahead_size(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    test RocksdbReadoptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbRestoreOptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_restore_options_t,

    pub fn create() [*c]api.rocksdb_restore_options_t {
        return api.rocksdb_restore_options_create();
    }

    pub fn destroy(opt: *Self) void {
        return api.rocksdb_restore_options_destroy(helpers.unwrap(opt.*));
    }

    pub fn setKeepLogFiles(opt: *Self, v: i64) void {
        return api.rocksdb_restore_options_set_keep_log_files(helpers.unwrap(opt.*), v);
    }

    test RocksdbRestoreOptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbSlice = packed struct {
    const Self = @This();
    ref: *api.rocksdb_slice_t,

    pub fn keySlice(iter: RocksdbIterator) api.rocksdb_slice_t {
        return api.rocksdb_iter_key_slice(helpers.unwrap(iter));
    }

    pub fn valueSlice(iter: RocksdbIterator) api.rocksdb_slice_t {
        return api.rocksdb_iter_value_slice(helpers.unwrap(iter));
    }

    pub fn timestampSlice(iter: RocksdbIterator) api.rocksdb_slice_t {
        return api.rocksdb_iter_timestamp_slice(helpers.unwrap(iter));
    }

    test RocksdbSlice {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbSlicetransform = packed struct {
    const Self = @This();
    ref: *api.rocksdb_slicetransform_t,

    pub fn create(
        state: *anyopaque,
        destructor: [*c]fn (
            *anyopaque,
        ) void,
        transform: [*c]fn (
            *anyopaque,
            [*c]const i8,
            i64,
            [*c]i64,
        ) [*c]i8,
        in_domain: [*c]fn (
            *anyopaque,
            [*c]const i8,
            i64,
        ) u8,
        in_range: [*c]fn (
            *anyopaque,
            [*c]const i8,
            i64,
        ) u8,
        name: [*c]fn (
            *anyopaque,
        ) [*c]const i8,
    ) [*c]api.rocksdb_slicetransform_t {
        return api.rocksdb_slicetransform_create(
            state,
            destructor,
            transform,
            in_domain,
            in_range,
            name,
        );
    }

    pub fn createNoop() [*c]api.rocksdb_slicetransform_t {
        return api.rocksdb_slicetransform_create_noop();
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_slicetransform_destroy(helpers.unwrap(arg0.*));
    }

    test RocksdbSlicetransform {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbSnapshot = packed struct {
    const Self = @This();
    ref: *api.rocksdb_snapshot_t,

    pub fn getSequenceNumber(snapshot: Self) i64 {
        return api.rocksdb_snapshot_get_sequence_number(helpers.unwrap(snapshot));
    }

    test RocksdbSnapshot {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbSstFileManager = packed struct {
    const Self = @This();
    ref: *api.rocksdb_sst_file_manager_t,

    pub fn create(env: *RocksdbEnv) [*c]api.rocksdb_sst_file_manager_t {
        return api.rocksdb_sst_file_manager_create(helpers.unwrap(env.*));
    }

    pub fn destroy(sfm: *Self) void {
        return api.rocksdb_sst_file_manager_destroy(helpers.unwrap(sfm.*));
    }

    pub fn setMaxAllowedSpaceUsage(sfm: *Self, max_allowed_space: i64) void {
        return api.rocksdb_sst_file_manager_set_max_allowed_space_usage(
            helpers.unwrap(sfm.*),
            max_allowed_space,
        );
    }

    pub fn setCompactionBufferSize(sfm: *Self, compaction_buffer_size: i64) void {
        return api.rocksdb_sst_file_manager_set_compaction_buffer_size(
            helpers.unwrap(sfm.*),
            compaction_buffer_size,
        );
    }

    pub fn isMaxAllowedSpaceReached(sfm: *Self) i64 {
        return api.rocksdb_sst_file_manager_is_max_allowed_space_reached(
            helpers.unwrap(sfm.*),
        );
    }

    pub fn isMaxAllowedSpaceReachedIncludingCompactions(sfm: *Self) i64 {
        return api.rocksdb_sst_file_manager_is_max_allowed_space_reached_including_compactions(
            helpers.unwrap(sfm.*),
        );
    }

    pub fn getTotalSize(sfm: *Self) i64 {
        return api.rocksdb_sst_file_manager_get_total_size(helpers.unwrap(sfm.*));
    }

    pub fn getDeleteRateBytesPerSecond(sfm: *Self) i64 {
        return api.rocksdb_sst_file_manager_get_delete_rate_bytes_per_second(
            helpers.unwrap(sfm.*),
        );
    }

    pub fn setDeleteRateBytesPerSecond(sfm: *Self, delete_rate: i64) void {
        return api.rocksdb_sst_file_manager_set_delete_rate_bytes_per_second(
            helpers.unwrap(sfm.*),
            delete_rate,
        );
    }

    pub fn getMaxTrashDbRatio(sfm: *Self) f64 {
        return api.rocksdb_sst_file_manager_get_max_trash_db_ratio(helpers.unwrap(sfm.*));
    }

    pub fn setMaxTrashDbRatio(sfm: *Self, ratio: f64) void {
        return api.rocksdb_sst_file_manager_set_max_trash_db_ratio(
            helpers.unwrap(sfm.*),
            ratio,
        );
    }

    pub fn getTotalTrashSize(sfm: *Self) i64 {
        return api.rocksdb_sst_file_manager_get_total_trash_size(helpers.unwrap(sfm.*));
    }

    test RocksdbSstFileManager {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbSstFileMetadata = packed struct {
    const Self = @This();
    ref: *api.rocksdb_sst_file_metadata_t,

    pub fn destroy(file_meta: *Self) void {
        return api.rocksdb_sst_file_metadata_destroy(helpers.unwrap(file_meta.*));
    }

    pub fn getRelativeFilename(file_meta: *Self) [*c]i8 {
        return api.rocksdb_sst_file_metadata_get_relative_filename(
            helpers.unwrap(file_meta.*),
        );
    }

    pub fn getDirectory(file_meta: *Self) [*c]i8 {
        return api.rocksdb_sst_file_metadata_get_directory(helpers.unwrap(file_meta.*));
    }

    pub fn getSize(file_meta: *Self) i64 {
        return api.rocksdb_sst_file_metadata_get_size(helpers.unwrap(file_meta.*));
    }

    pub fn getSmallestkey(file_meta: *Self, len: [*c]i64) [*c]i8 {
        return api.rocksdb_sst_file_metadata_get_smallestkey(
            helpers.unwrap(file_meta.*),
            len,
        );
    }

    pub fn getLargestkey(file_meta: *Self, len: [*c]i64) [*c]i8 {
        return api.rocksdb_sst_file_metadata_get_largestkey(
            helpers.unwrap(file_meta.*),
            len,
        );
    }

    test RocksdbSstFileMetadata {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbSstfilewriter = packed struct {
    const Self = @This();
    ref: *api.rocksdb_sstfilewriter_t,

    pub fn create(
        env: RocksdbEnvoptions,
        io_options: RocksdbOptions,
    ) [*c]api.rocksdb_sstfilewriter_t {
        return api.rocksdb_sstfilewriter_create(
            helpers.unwrap(env),
            helpers.unwrap(io_options),
        );
    }

    pub fn createWithComparator(
        env: RocksdbEnvoptions,
        io_options: RocksdbOptions,
        comparator: RocksdbComparator,
    ) [*c]api.rocksdb_sstfilewriter_t {
        return api.rocksdb_sstfilewriter_create_with_comparator(
            helpers.unwrap(env),
            helpers.unwrap(io_options),
            helpers.unwrap(comparator),
        );
    }

    pub fn open(writer: *Self, name: [*c]const i8, errptr: [*c][*c]i8) void {
        return api.rocksdb_sstfilewriter_open(helpers.unwrap(writer.*), name, errptr);
    }

    pub fn add(
        writer: *Self,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_sstfilewriter_add(
            helpers.unwrap(writer.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn put(
        writer: *Self,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_sstfilewriter_put(
            helpers.unwrap(writer.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn putWithTs(
        writer: *Self,
        key: []const u8,
        ts: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_sstfilewriter_put_with_ts(
            helpers.unwrap(writer.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn merge(
        writer: *Self,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_sstfilewriter_merge(
            helpers.unwrap(writer.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn delete(writer: *Self, key: []const u8, errptr: [*c][*c]i8) void {
        return api.rocksdb_sstfilewriter_delete(
            helpers.unwrap(writer.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn deleteWithTs(
        writer: *Self,
        key: []const u8,
        ts: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_sstfilewriter_delete_with_ts(
            helpers.unwrap(writer.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
            errptr,
        );
    }

    pub fn deleteRange(
        writer: *Self,
        begin_key: []const u8,
        end_key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_sstfilewriter_delete_range(
            helpers.unwrap(writer.*),
            @ptrCast(begin_key.ptr),
            @intCast(begin_key.len),
            @ptrCast(end_key.ptr),
            @intCast(end_key.len),
            errptr,
        );
    }

    pub fn finish(writer: *Self, errptr: [*c][*c]i8) void {
        return api.rocksdb_sstfilewriter_finish(helpers.unwrap(writer.*), errptr);
    }

    pub fn fileSize(writer: *Self, file_size: [*c]i64) void {
        return api.rocksdb_sstfilewriter_file_size(helpers.unwrap(writer.*), file_size);
    }

    pub fn destroy(writer: *Self) void {
        return api.rocksdb_sstfilewriter_destroy(helpers.unwrap(writer.*));
    }

    test RocksdbSstfilewriter {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbStatisticsHistogramData = packed struct {
    const Self = @This();
    ref: *api.rocksdb_statistics_histogram_data_t,

    pub fn create() [*c]api.rocksdb_statistics_histogram_data_t {
        return api.rocksdb_statistics_histogram_data_create();
    }

    pub fn destroy(data: *Self) void {
        return api.rocksdb_statistics_histogram_data_destroy(helpers.unwrap(data.*));
    }

    pub fn getMedian(data: *Self) f64 {
        return api.rocksdb_statistics_histogram_data_get_median(helpers.unwrap(data.*));
    }

    pub fn getP95(data: *Self) f64 {
        return api.rocksdb_statistics_histogram_data_get_p95(helpers.unwrap(data.*));
    }

    pub fn getP99(data: *Self) f64 {
        return api.rocksdb_statistics_histogram_data_get_p99(helpers.unwrap(data.*));
    }

    pub fn getAverage(data: *Self) f64 {
        return api.rocksdb_statistics_histogram_data_get_average(helpers.unwrap(data.*));
    }

    pub fn getStdDev(data: *Self) f64 {
        return api.rocksdb_statistics_histogram_data_get_std_dev(helpers.unwrap(data.*));
    }

    pub fn getMax(data: *Self) f64 {
        return api.rocksdb_statistics_histogram_data_get_max(helpers.unwrap(data.*));
    }

    pub fn getCount(data: *Self) i64 {
        return api.rocksdb_statistics_histogram_data_get_count(helpers.unwrap(data.*));
    }

    pub fn getSum(data: *Self) i64 {
        return api.rocksdb_statistics_histogram_data_get_sum(helpers.unwrap(data.*));
    }

    pub fn getMin(data: *Self) f64 {
        return api.rocksdb_statistics_histogram_data_get_min(helpers.unwrap(data.*));
    }

    test RocksdbStatisticsHistogramData {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbStatusPtr = packed struct {
    const Self = @This();
    ref: *api.rocksdb_status_ptr_t,

    pub fn resetStatus(status_ptr: *Self) void {
        return api.rocksdb_reset_status(helpers.unwrap(status_ptr.*));
    }

    pub fn getError(status: *Self, errptr: [*c][*c]i8) void {
        return api.rocksdb_status_ptr_get_error(helpers.unwrap(status.*), errptr);
    }

    test RocksdbStatusPtr {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbSubcompactionjobinfo = packed struct {
    const Self = @This();
    ref: *api.rocksdb_subcompactionjobinfo_t,

    pub fn status(arg0: Self, arg1: [*c][*c]i8) void {
        return api.rocksdb_subcompactionjobinfo_status(helpers.unwrap(arg0), arg1);
    }

    pub fn cfName(arg0: Self, arg1: [*c]i64) [*c]const i8 {
        return api.rocksdb_subcompactionjobinfo_cf_name(helpers.unwrap(arg0), arg1);
    }

    pub fn threadId(arg0: Self) i64 {
        return api.rocksdb_subcompactionjobinfo_thread_id(helpers.unwrap(arg0));
    }

    pub fn baseInputLevel(arg0: Self) i64 {
        return api.rocksdb_subcompactionjobinfo_base_input_level(helpers.unwrap(arg0));
    }

    pub fn outputLevel(arg0: Self) i64 {
        return api.rocksdb_subcompactionjobinfo_output_level(helpers.unwrap(arg0));
    }

    pub fn compactionReason(info: Self) i64 {
        return api.rocksdb_subcompactionjobinfo_compaction_reason(helpers.unwrap(info));
    }

    test RocksdbSubcompactionjobinfo {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const Rocksdb = packed struct {
    const Self = @This();
    ref: *api.rocksdb_t,

    pub fn open(
        options: RocksdbOptions,
        name: [*c]const i8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        return api.rocksdb_open(helpers.unwrap(options), name, errptr);
    }

    pub fn openWithTtl(
        options: RocksdbOptions,
        name: [*c]const i8,
        ttl: i64,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        return api.rocksdb_open_with_ttl(helpers.unwrap(options), name, ttl, errptr);
    }

    pub fn openForReadOnly(
        options: RocksdbOptions,
        name: [*c]const i8,
        error_if_wal_file_exists: u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        return api.rocksdb_open_for_read_only(
            helpers.unwrap(options),
            name,
            error_if_wal_file_exists,
            errptr,
        );
    }

    pub fn openAsSecondary(
        options: RocksdbOptions,
        name: [*c]const i8,
        secondary_path: [*c]const i8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        return api.rocksdb_open_as_secondary(
            helpers.unwrap(options),
            name,
            secondary_path,
            errptr,
        );
    }

    pub fn putWithTs(
        db: *Self,
        options: RocksdbWriteoptions,
        key: []const u8,
        ts: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_put_with_ts(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn putCfWithTs(
        db: *Self,
        options: RocksdbWriteoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        ts: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_put_cf_with_ts(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn deleteWithTs(
        db: *Self,
        options: RocksdbWriteoptions,
        key: []const u8,
        ts: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_delete_with_ts(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
            errptr,
        );
    }

    pub fn deleteCfWithTs(
        db: *Self,
        options: RocksdbWriteoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        ts: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_delete_cf_with_ts(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
            errptr,
        );
    }

    pub fn singledelete(
        db: *Self,
        options: RocksdbWriteoptions,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_singledelete(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn singledeleteCf(
        db: *Self,
        options: RocksdbWriteoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_singledelete_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn singledeleteWithTs(
        db: *Self,
        options: RocksdbWriteoptions,
        key: []const u8,
        ts: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_singledelete_with_ts(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
            errptr,
        );
    }

    pub fn singledeleteCfWithTs(
        db: *Self,
        options: RocksdbWriteoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        ts: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_singledelete_cf_with_ts(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
            errptr,
        );
    }

    pub fn increaseFullHistoryTsLow(
        db: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        ts_low: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_increase_full_history_ts_low(
            helpers.unwrap(db.*),
            helpers.unwrap(column_family.*),
            @ptrCast(ts_low.ptr),
            @intCast(ts_low.len),
            errptr,
        );
    }

    pub fn getFullHistoryTsLow(
        db: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        ts_lowlen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        return api.rocksdb_get_full_history_ts_low(
            helpers.unwrap(db.*),
            helpers.unwrap(column_family.*),
            ts_lowlen,
            errptr,
        );
    }

    pub fn openAndTrimHistory(
        options: RocksdbOptions,
        name: [*c]const i8,
        num_column_families: i64,
        column_family_names: [*c]const [*c]const i8,
        column_family_options: [*c]const [*c]const api.rocksdb_options_t,
        column_family_handles: [*c][*c]api.rocksdb_column_family_handle_t,
        trim_ts: []u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        return api.rocksdb_open_and_trim_history(
            helpers.unwrap(options),
            name,
            num_column_families,
            column_family_names,
            column_family_options,
            column_family_handles,
            @ptrCast(trim_ts.ptr),
            @intCast(trim_ts.len),
            errptr,
        );
    }

    pub fn openColumnFamilies(
        options: RocksdbOptions,
        name: [*c]const i8,
        num_column_families: i64,
        column_family_names: [*c]const [*c]const i8,
        column_family_options: [*c]const [*c]const api.rocksdb_options_t,
        column_family_handles: [*c][*c]api.rocksdb_column_family_handle_t,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        return api.rocksdb_open_column_families(
            helpers.unwrap(options),
            name,
            num_column_families,
            column_family_names,
            column_family_options,
            column_family_handles,
            errptr,
        );
    }

    pub fn openColumnFamiliesWithTtl(
        options: RocksdbOptions,
        name: [*c]const i8,
        num_column_families: i64,
        column_family_names: [*c]const [*c]const i8,
        column_family_options: [*c]const [*c]const api.rocksdb_options_t,
        column_family_handles: [*c][*c]api.rocksdb_column_family_handle_t,
        ttls: [*c]const i64,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        return api.rocksdb_open_column_families_with_ttl(
            helpers.unwrap(options),
            name,
            num_column_families,
            column_family_names,
            column_family_options,
            column_family_handles,
            ttls,
            errptr,
        );
    }

    pub fn openForReadOnlyColumnFamilies(
        options: RocksdbOptions,
        name: [*c]const i8,
        num_column_families: i64,
        column_family_names: [*c]const [*c]const i8,
        column_family_options: [*c]const [*c]const api.rocksdb_options_t,
        column_family_handles: [*c][*c]api.rocksdb_column_family_handle_t,
        error_if_wal_file_exists: u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        return api.rocksdb_open_for_read_only_column_families(
            helpers.unwrap(options),
            name,
            num_column_families,
            column_family_names,
            column_family_options,
            column_family_handles,
            error_if_wal_file_exists,
            errptr,
        );
    }

    pub fn openAsSecondaryColumnFamilies(
        options: RocksdbOptions,
        name: [*c]const i8,
        secondary_path: [*c]const i8,
        num_column_families: i64,
        column_family_names: [*c]const [*c]const i8,
        column_family_options: [*c]const [*c]const api.rocksdb_options_t,
        column_family_handles: [*c][*c]api.rocksdb_column_family_handle_t,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        return api.rocksdb_open_as_secondary_column_families(
            helpers.unwrap(options),
            name,
            secondary_path,
            num_column_families,
            column_family_names,
            column_family_options,
            column_family_handles,
            errptr,
        );
    }

    pub fn createColumnFamily(
        db: *Self,
        column_family_options: RocksdbOptions,
        column_family_name: [*c]const i8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_column_family_handle_t {
        return api.rocksdb_create_column_family(
            helpers.unwrap(db.*),
            helpers.unwrap(column_family_options),
            column_family_name,
            errptr,
        );
    }

    pub fn createColumnFamilies(
        db: *Self,
        column_family_options: RocksdbOptions,
        num_column_families: i64,
        column_family_names: [*c]const [*c]const i8,
        lencfs: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c][*c]api.rocksdb_column_family_handle_t {
        return api.rocksdb_create_column_families(
            helpers.unwrap(db.*),
            helpers.unwrap(column_family_options),
            num_column_families,
            column_family_names,
            lencfs,
            errptr,
        );
    }

    pub fn createColumnFamilyWithImport(
        db: *Self,
        column_family_options: *RocksdbOptions,
        column_family_name: [*c]const i8,
        import_options: *RocksdbImportColumnFamilyOptions,
        metadata: *RocksdbExportImportFilesMetadata,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_column_family_handle_t {
        return api.rocksdb_create_column_family_with_import(
            helpers.unwrap(db.*),
            helpers.unwrap(column_family_options.*),
            column_family_name,
            helpers.unwrap(import_options.*),
            helpers.unwrap(metadata.*),
            errptr,
        );
    }

    pub fn createColumnFamilyWithTtl(
        db: *Self,
        column_family_options: RocksdbOptions,
        column_family_name: [*c]const i8,
        ttl: i64,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_column_family_handle_t {
        return api.rocksdb_create_column_family_with_ttl(
            helpers.unwrap(db.*),
            helpers.unwrap(column_family_options),
            column_family_name,
            ttl,
            errptr,
        );
    }

    pub fn dropColumnFamily(
        db: *Self,
        handle: *RocksdbColumnFamilyHandle,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_drop_column_family(
            helpers.unwrap(db.*),
            helpers.unwrap(handle.*),
            errptr,
        );
    }

    pub fn getDefaultColumnFamilyHandle(
        db: *Self,
    ) [*c]api.rocksdb_column_family_handle_t {
        return api.rocksdb_get_default_column_family_handle(helpers.unwrap(db.*));
    }

    pub fn close(db: *Self) void {
        return api.rocksdb_close(helpers.unwrap(db.*));
    }

    pub fn put(
        db: *Self,
        options: RocksdbWriteoptions,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_put(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn putCf(
        db: *Self,
        options: RocksdbWriteoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_put_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn delete(
        db: *Self,
        options: RocksdbWriteoptions,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_delete(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn deleteCf(
        db: *Self,
        options: RocksdbWriteoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_delete_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn deleteRangeCf(
        db: *Self,
        options: RocksdbWriteoptions,
        column_family: *RocksdbColumnFamilyHandle,
        start_key: []const u8,
        end_key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_delete_range_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(end_key.ptr),
            @intCast(end_key.len),
            errptr,
        );
    }

    pub fn merge(
        db: *Self,
        options: RocksdbWriteoptions,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_merge(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn mergeCf(
        db: *Self,
        options: RocksdbWriteoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_merge_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn write(
        db: *Self,
        options: RocksdbWriteoptions,
        batch: *RocksdbWritebatch,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_write(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(batch.*),
            errptr,
        );
    }

    pub fn get(
        db: *Self,
        options: RocksdbReadoptions,
        key: []const u8,
        vallen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        return api.rocksdb_get(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            errptr,
        );
    }

    pub fn getWithTs(
        db: *Self,
        options: RocksdbReadoptions,
        key: []const u8,
        vallen: [*c]i64,
        ts: [*c][*c]i8,
        tslen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        return api.rocksdb_get_with_ts(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            ts,
            tslen,
            errptr,
        );
    }

    pub fn getCf(
        db: *Self,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        vallen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        return api.rocksdb_get_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            errptr,
        );
    }

    pub fn getCfWithTs(
        db: *Self,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        vallen: [*c]i64,
        ts: [*c][*c]i8,
        tslen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        return api.rocksdb_get_cf_with_ts(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            ts,
            tslen,
            errptr,
        );
    }

    pub fn getDbIdentity(db: *Self, id_len: [*c]i64) [*c]i8 {
        return api.rocksdb_get_db_identity(helpers.unwrap(db.*), id_len);
    }

    pub fn multiGet(
        db: *Self,
        options: RocksdbReadoptions,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        return api.rocksdb_multi_get(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            num_keys,
            keys_list,
            keys_list_sizes,
            values_list,
            values_list_sizes,
            errs,
        );
    }

    pub fn multiGetWithTs(
        db: *Self,
        options: RocksdbReadoptions,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        timestamp_list: [*c][*c]i8,
        timestamp_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        return api.rocksdb_multi_get_with_ts(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            num_keys,
            keys_list,
            keys_list_sizes,
            values_list,
            values_list_sizes,
            timestamp_list,
            timestamp_list_sizes,
            errs,
        );
    }

    pub fn multiGetCf(
        db: *Self,
        options: RocksdbReadoptions,
        column_families: [*c]const [*c]const api.rocksdb_column_family_handle_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        return api.rocksdb_multi_get_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            column_families,
            num_keys,
            keys_list,
            keys_list_sizes,
            values_list,
            values_list_sizes,
            errs,
        );
    }

    pub fn multiGetCfWithTs(
        db: *Self,
        options: RocksdbReadoptions,
        column_families: [*c]const [*c]const api.rocksdb_column_family_handle_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        timestamps_list: [*c][*c]i8,
        timestamps_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        return api.rocksdb_multi_get_cf_with_ts(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            column_families,
            num_keys,
            keys_list,
            keys_list_sizes,
            values_list,
            values_list_sizes,
            timestamps_list,
            timestamps_list_sizes,
            errs,
        );
    }

    pub fn batchedMultiGetCf(
        db: *Self,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values: [*c][*c]api.rocksdb_pinnableslice_t,
        errs: [*c][*c]i8,
        sorted_input: i64,
    ) void {
        return api.rocksdb_batched_multi_get_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            num_keys,
            keys_list,
            keys_list_sizes,
            values,
            errs,
            sorted_input,
        );
    }

    pub fn batchedMultiGetCfSlice(
        db: *Self,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
        num_keys: i64,
        keys_list: RocksdbSlice,
        values: [*c][*c]api.rocksdb_pinnableslice_t,
        errs: [*c][*c]i8,
        sorted_input: i64,
    ) void {
        return api.rocksdb_batched_multi_get_cf_slice(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            num_keys,
            helpers.unwrap(keys_list),
            values,
            errs,
            sorted_input,
        );
    }

    pub fn keyMayExist(
        db: *Self,
        options: RocksdbReadoptions,
        key: []const u8,
        value: [*c][*c]i8,
        val_len: [*c]i64,
        timestamp: []const u8,
        value_found: [*c]u8,
    ) u8 {
        return api.rocksdb_key_may_exist(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            value,
            val_len,
            @ptrCast(timestamp.ptr),
            @intCast(timestamp.len),
            value_found,
        );
    }

    pub fn keyMayExistCf(
        db: *Self,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        value: [*c][*c]i8,
        val_len: [*c]i64,
        timestamp: []const u8,
        value_found: [*c]u8,
    ) u8 {
        return api.rocksdb_key_may_exist_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            value,
            val_len,
            @ptrCast(timestamp.ptr),
            @intCast(timestamp.len),
            value_found,
        );
    }

    pub fn createIterator(
        db: *Self,
        options: RocksdbReadoptions,
    ) [*c]api.rocksdb_iterator_t {
        return api.rocksdb_create_iterator(helpers.unwrap(db.*), helpers.unwrap(options));
    }

    pub fn getUpdatesSince(
        db: *Self,
        seq_number: i64,
        options: [*c]const api.rocksdb_wal_readoptions_t,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_wal_iterator_t {
        return api.rocksdb_get_updates_since(
            helpers.unwrap(db.*),
            seq_number,
            options,
            errptr,
        );
    }

    pub fn createIteratorCf(
        db: *Self,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
    ) [*c]api.rocksdb_iterator_t {
        return api.rocksdb_create_iterator_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
        );
    }

    pub fn createIterators(
        db: *Self,
        opts: *RocksdbReadoptions,
        column_families: [*c][*c]api.rocksdb_column_family_handle_t,
        iterators: [*c][*c]api.rocksdb_iterator_t,
        size: i64,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_create_iterators(
            helpers.unwrap(db.*),
            helpers.unwrap(opts.*),
            column_families,
            iterators,
            size,
            errptr,
        );
    }

    pub fn createSnapshot(db: *Self) [*c]const api.rocksdb_snapshot_t {
        return api.rocksdb_create_snapshot(helpers.unwrap(db.*));
    }

    pub fn releaseSnapshot(db: *Self, snapshot: RocksdbSnapshot) void {
        return api.rocksdb_release_snapshot(
            helpers.unwrap(db.*),
            helpers.unwrap(snapshot),
        );
    }

    pub fn propertyValue(db: *Self, propname: [*c]const i8) [*c]i8 {
        return api.rocksdb_property_value(helpers.unwrap(db.*), propname);
    }

    pub fn propertyInt(db: *Self, propname: [*c]const i8, out_val: [*c]i64) i64 {
        return api.rocksdb_property_int(helpers.unwrap(db.*), propname, out_val);
    }

    pub fn propertyIntCf(
        db: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        propname: [*c]const i8,
        out_val: [*c]i64,
    ) i64 {
        return api.rocksdb_property_int_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(column_family.*),
            propname,
            out_val,
        );
    }

    pub fn propertyValueCf(
        db: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        propname: [*c]const i8,
    ) [*c]i8 {
        return api.rocksdb_property_value_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(column_family.*),
            propname,
        );
    }

    pub fn approximateSizes(
        db: *Self,
        num_ranges: i64,
        range_start_key: [*c]const [*c]const i8,
        range_start_key_len: [*c]const i64,
        range_limit_key: [*c]const [*c]const i8,
        range_limit_key_len: [*c]const i64,
        sizes: [*c]i64,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_approximate_sizes(
            helpers.unwrap(db.*),
            num_ranges,
            range_start_key,
            range_start_key_len,
            range_limit_key,
            range_limit_key_len,
            sizes,
            errptr,
        );
    }

    pub fn approximateSizesCf(
        db: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        num_ranges: i64,
        range_start_key: [*c]const [*c]const i8,
        range_start_key_len: [*c]const i64,
        range_limit_key: [*c]const [*c]const i8,
        range_limit_key_len: [*c]const i64,
        sizes: [*c]i64,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_approximate_sizes_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(column_family.*),
            num_ranges,
            range_start_key,
            range_start_key_len,
            range_limit_key,
            range_limit_key_len,
            sizes,
            errptr,
        );
    }

    pub fn approximateSizesCfWithFlags(
        db: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        num_ranges: i64,
        range_start_key: [*c]const [*c]const i8,
        range_start_key_len: [*c]const i64,
        range_limit_key: [*c]const [*c]const i8,
        range_limit_key_len: [*c]const i64,
        include_flags: i64,
        sizes: [*c]i64,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_approximate_sizes_cf_with_flags(
            helpers.unwrap(db.*),
            helpers.unwrap(column_family.*),
            num_ranges,
            range_start_key,
            range_start_key_len,
            range_limit_key,
            range_limit_key_len,
            include_flags,
            sizes,
            errptr,
        );
    }

    pub fn compactRange(
        db: *Self,
        start_key: []const u8,
        limit_key: []const u8,
    ) void {
        return api.rocksdb_compact_range(
            helpers.unwrap(db.*),
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(limit_key.ptr),
            @intCast(limit_key.len),
        );
    }

    pub fn compactRangeCf(
        db: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        start_key: []const u8,
        limit_key: []const u8,
    ) void {
        return api.rocksdb_compact_range_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(column_family.*),
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(limit_key.ptr),
            @intCast(limit_key.len),
        );
    }

    pub fn suggestCompactRange(
        db: *Self,
        start_key: []const u8,
        limit_key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_suggest_compact_range(
            helpers.unwrap(db.*),
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(limit_key.ptr),
            @intCast(limit_key.len),
            errptr,
        );
    }

    pub fn suggestCompactRangeCf(
        db: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        start_key: []const u8,
        limit_key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_suggest_compact_range_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(column_family.*),
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(limit_key.ptr),
            @intCast(limit_key.len),
            errptr,
        );
    }

    pub fn compactRangeOpt(
        db: *Self,
        opt: *RocksdbCompactoptions,
        start_key: []const u8,
        limit_key: []const u8,
    ) void {
        return api.rocksdb_compact_range_opt(
            helpers.unwrap(db.*),
            helpers.unwrap(opt.*),
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(limit_key.ptr),
            @intCast(limit_key.len),
        );
    }

    pub fn compactRangeCfOpt(
        db: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        opt: *RocksdbCompactoptions,
        start_key: []const u8,
        limit_key: []const u8,
    ) void {
        return api.rocksdb_compact_range_cf_opt(
            helpers.unwrap(db.*),
            helpers.unwrap(column_family.*),
            helpers.unwrap(opt.*),
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(limit_key.ptr),
            @intCast(limit_key.len),
        );
    }

    pub fn livefiles(db: *Self) [*c]const api.rocksdb_livefiles_t {
        return api.rocksdb_livefiles(helpers.unwrap(db.*));
    }

    pub fn flush(db: *Self, options: RocksdbFlushoptions, errptr: [*c][*c]i8) void {
        return api.rocksdb_flush(helpers.unwrap(db.*), helpers.unwrap(options), errptr);
    }

    pub fn flushCf(
        db: *Self,
        options: RocksdbFlushoptions,
        column_family: *RocksdbColumnFamilyHandle,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_flush_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            errptr,
        );
    }

    pub fn flushCfs(
        db: *Self,
        options: RocksdbFlushoptions,
        column_family: [*c][*c]api.rocksdb_column_family_handle_t,
        num_column_families: i64,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_flush_cfs(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            column_family,
            num_column_families,
            errptr,
        );
    }

    pub fn flushWal(db: *Self, sync: u8, errptr: [*c][*c]i8) void {
        return api.rocksdb_flush_wal(helpers.unwrap(db.*), sync, errptr);
    }

    pub fn disableFileDeletions(db: *Self, errptr: [*c][*c]i8) void {
        return api.rocksdb_disable_file_deletions(helpers.unwrap(db.*), errptr);
    }

    pub fn enableFileDeletions(db: *Self, errptr: [*c][*c]i8) void {
        return api.rocksdb_enable_file_deletions(helpers.unwrap(db.*), errptr);
    }

    pub fn getLatestSequenceNumber(db: *Self) i64 {
        return api.rocksdb_get_latest_sequence_number(helpers.unwrap(db.*));
    }

    pub fn writeWritebatchWi(
        db: *Self,
        options: RocksdbWriteoptions,
        wbwi: *RocksdbWritebatchWi,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_write_writebatch_wi(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(wbwi.*),
            errptr,
        );
    }

    pub fn setOptions(
        db: *Self,
        count: i64,
        keys: [*]const [*c]const i8,
        values: [*]const [*c]const i8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_set_options(helpers.unwrap(db.*), count, keys, values, errptr);
    }

    pub fn setOptionsCf(
        db: *Self,
        handle: *RocksdbColumnFamilyHandle,
        count: i64,
        keys: [*]const [*c]const i8,
        values: [*]const [*c]const i8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_set_options_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(handle.*),
            count,
            keys,
            values,
            errptr,
        );
    }

    pub fn ingestExternalFile(
        db: *Self,
        file_list: [*c]const [*c]const i8,
        list_len: i64,
        opt: RocksdbIngestexternalfileoptions,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_ingest_external_file(
            helpers.unwrap(db.*),
            file_list,
            list_len,
            helpers.unwrap(opt),
            errptr,
        );
    }

    pub fn ingestExternalFileCf(
        db: *Self,
        handle: *RocksdbColumnFamilyHandle,
        file_list: [*c]const [*c]const i8,
        list_len: i64,
        opt: RocksdbIngestexternalfileoptions,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_ingest_external_file_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(handle.*),
            file_list,
            list_len,
            helpers.unwrap(opt),
            errptr,
        );
    }

    pub fn tryCatchUpWithPrimary(db: *Self, errptr: [*c][*c]i8) void {
        return api.rocksdb_try_catch_up_with_primary(helpers.unwrap(db.*), errptr);
    }

    pub fn deleteFileInRange(
        db: *Self,
        start_key: []const u8,
        limit_key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_delete_file_in_range(
            helpers.unwrap(db.*),
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(limit_key.ptr),
            @intCast(limit_key.len),
            errptr,
        );
    }

    pub fn deleteFileInRangeCf(
        db: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        start_key: []const u8,
        limit_key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_delete_file_in_range_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(column_family.*),
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(limit_key.ptr),
            @intCast(limit_key.len),
            errptr,
        );
    }

    pub fn getColumnFamilyMetadata(
        db: *Self,
    ) [*c]api.rocksdb_column_family_metadata_t {
        return api.rocksdb_get_column_family_metadata(helpers.unwrap(db.*));
    }

    pub fn getColumnFamilyMetadataCf(
        db: *Self,
        column_family: *RocksdbColumnFamilyHandle,
    ) [*c]api.rocksdb_column_family_metadata_t {
        return api.rocksdb_get_column_family_metadata_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(column_family.*),
        );
    }

    pub fn transactiondbCloseBaseDb(base_db: *Self) void {
        return api.rocksdb_transactiondb_close_base_db(helpers.unwrap(base_db.*));
    }

    pub fn optimistictransactiondbCloseBaseDb(base_db: *Self) void {
        return api.rocksdb_optimistictransactiondb_close_base_db(
            helpers.unwrap(base_db.*),
        );
    }

    pub fn getPinned(
        db: *Self,
        options: RocksdbReadoptions,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        return api.rocksdb_get_pinned(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn getPinnedCf(
        db: *Self,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        return api.rocksdb_get_pinned_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn cancelAllBackgroundWork(db: *Self, wait: u8) void {
        return api.rocksdb_cancel_all_background_work(helpers.unwrap(db.*), wait);
    }

    pub fn disableManualCompaction(db: *Self) void {
        return api.rocksdb_disable_manual_compaction(helpers.unwrap(db.*));
    }

    pub fn enableManualCompaction(db: *Self) void {
        return api.rocksdb_enable_manual_compaction(helpers.unwrap(db.*));
    }

    pub fn waitForCompact(
        db: *Self,
        options: *RocksdbWaitForCompactOptions,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_wait_for_compact(
            helpers.unwrap(db.*),
            helpers.unwrap(options.*),
            errptr,
        );
    }

    pub fn getPinnedV2(
        db: *Self,
        options: RocksdbReadoptions,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnable_handle_t {
        return api.rocksdb_get_pinned_v2(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn getPinnedCfV2(
        db: *Self,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnable_handle_t {
        return api.rocksdb_get_pinned_cf_v2(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn getIntoBuffer(
        db: *Self,
        options: RocksdbReadoptions,
        key: []const u8,
        buffer: []u8,
        vallen: [*c]i64,
        found: [*c]u8,
        errptr: [*c][*c]i8,
    ) u8 {
        return api.rocksdb_get_into_buffer(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(buffer.ptr),
            @intCast(buffer.len),
            vallen,
            found,
            errptr,
        );
    }

    pub fn getIntoBufferCf(
        db: *Self,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        buffer: []u8,
        vallen: [*c]i64,
        found: [*c]u8,
        errptr: [*c][*c]i8,
    ) u8 {
        return api.rocksdb_get_into_buffer_cf(
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(buffer.ptr),
            @intCast(buffer.len),
            vallen,
            found,
            errptr,
        );
    }

    test Rocksdb {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbTransactionOptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_transaction_options_t,

    pub fn create() [*c]api.rocksdb_transaction_options_t {
        return api.rocksdb_transaction_options_create();
    }

    pub fn destroy(opt: *Self) void {
        return api.rocksdb_transaction_options_destroy(helpers.unwrap(opt.*));
    }

    pub fn setSetSnapshot(opt: *Self, v: u8) void {
        return api.rocksdb_transaction_options_set_set_snapshot(helpers.unwrap(opt.*), v);
    }

    pub fn setDeadlockDetect(opt: *Self, v: u8) void {
        return api.rocksdb_transaction_options_set_deadlock_detect(
            helpers.unwrap(opt.*),
            v,
        );
    }

    pub fn setLockTimeout(opt: *Self, lock_timeout: i64) void {
        return api.rocksdb_transaction_options_set_lock_timeout(
            helpers.unwrap(opt.*),
            lock_timeout,
        );
    }

    pub fn setExpiration(opt: *Self, expiration: i64) void {
        return api.rocksdb_transaction_options_set_expiration(
            helpers.unwrap(opt.*),
            expiration,
        );
    }

    pub fn setDeadlockDetectDepth(opt: *Self, depth: i64) void {
        return api.rocksdb_transaction_options_set_deadlock_detect_depth(
            helpers.unwrap(opt.*),
            depth,
        );
    }

    pub fn setMaxWriteBatchSize(opt: *Self, size: i64) void {
        return api.rocksdb_transaction_options_set_max_write_batch_size(
            helpers.unwrap(opt.*),
            size,
        );
    }

    pub fn setSkipPrepare(opt: *Self, v: u8) void {
        return api.rocksdb_transaction_options_set_skip_prepare(helpers.unwrap(opt.*), v);
    }

    test RocksdbTransactionOptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbTransaction = packed struct {
    const Self = @This();
    ref: *api.rocksdb_transaction_t,

    pub fn begin(
        txn_db: *RocksdbTransactiondb,
        write_options: RocksdbWriteoptions,
        txn_options: RocksdbTransactionOptions,
        old_txn: *Self,
    ) [*c]api.rocksdb_transaction_t {
        return api.rocksdb_transaction_begin(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(write_options),
            helpers.unwrap(txn_options),
            helpers.unwrap(old_txn.*),
        );
    }

    pub fn setName(txn: *Self, name: []const u8, errptr: [*c][*c]i8) void {
        return api.rocksdb_transaction_set_name(
            helpers.unwrap(txn.*),
            @ptrCast(name.ptr),
            @intCast(name.len),
            errptr,
        );
    }

    pub fn getName(txn: *Self, name_len: [*c]i64) [*c]i8 {
        return api.rocksdb_transaction_get_name(helpers.unwrap(txn.*), name_len);
    }

    pub fn prepare(txn: *Self, errptr: [*c][*c]i8) void {
        return api.rocksdb_transaction_prepare(helpers.unwrap(txn.*), errptr);
    }

    pub fn commit(txn: *Self, errptr: [*c][*c]i8) void {
        return api.rocksdb_transaction_commit(helpers.unwrap(txn.*), errptr);
    }

    pub fn rollback(txn: *Self, errptr: [*c][*c]i8) void {
        return api.rocksdb_transaction_rollback(helpers.unwrap(txn.*), errptr);
    }

    pub fn setSavepoint(txn: *Self) void {
        return api.rocksdb_transaction_set_savepoint(helpers.unwrap(txn.*));
    }

    pub fn rollbackToSavepoint(txn: *Self, errptr: [*c][*c]i8) void {
        return api.rocksdb_transaction_rollback_to_savepoint(
            helpers.unwrap(txn.*),
            errptr,
        );
    }

    pub fn destroy(txn: *Self) void {
        return api.rocksdb_transaction_destroy(helpers.unwrap(txn.*));
    }

    pub fn getWritebatchWi(txn: *Self) [*c]api.rocksdb_writebatch_wi_t {
        return api.rocksdb_transaction_get_writebatch_wi(helpers.unwrap(txn.*));
    }

    pub fn rebuildFromWritebatch(
        txn: *Self,
        writebatch: *RocksdbWritebatch,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_transaction_rebuild_from_writebatch(
            helpers.unwrap(txn.*),
            helpers.unwrap(writebatch.*),
            errptr,
        );
    }

    pub fn rebuildFromWritebatchWi(
        txn: *Self,
        wi: *RocksdbWritebatchWi,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_transaction_rebuild_from_writebatch_wi(
            helpers.unwrap(txn.*),
            helpers.unwrap(wi.*),
            errptr,
        );
    }

    pub fn setCommitTimestamp(txn: *Self, commit_timestamp: i64) void {
        return api.rocksdb_transaction_set_commit_timestamp(
            helpers.unwrap(txn.*),
            commit_timestamp,
        );
    }

    pub fn setReadTimestampForValidation(txn: *Self, read_timestamp: i64) void {
        return api.rocksdb_transaction_set_read_timestamp_for_validation(
            helpers.unwrap(txn.*),
            read_timestamp,
        );
    }

    pub fn getSnapshot(txn: *Self) [*c]const api.rocksdb_snapshot_t {
        return api.rocksdb_transaction_get_snapshot(helpers.unwrap(txn.*));
    }

    pub fn get(
        txn: *Self,
        options: RocksdbReadoptions,
        key: []const u8,
        vlen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        return api.rocksdb_transaction_get(
            helpers.unwrap(txn.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            vlen,
            errptr,
        );
    }

    pub fn getPinned(
        txn: *Self,
        options: RocksdbReadoptions,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        return api.rocksdb_transaction_get_pinned(
            helpers.unwrap(txn.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn getCf(
        txn: *Self,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        vlen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        return api.rocksdb_transaction_get_cf(
            helpers.unwrap(txn.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            vlen,
            errptr,
        );
    }

    pub fn getPinnedCf(
        txn: *Self,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        return api.rocksdb_transaction_get_pinned_cf(
            helpers.unwrap(txn.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn getForUpdate(
        txn: *Self,
        options: RocksdbReadoptions,
        key: []const u8,
        vlen: [*c]i64,
        exclusive: u8,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        return api.rocksdb_transaction_get_for_update(
            helpers.unwrap(txn.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            vlen,
            exclusive,
            errptr,
        );
    }

    pub fn getPinnedForUpdate(
        txn: *Self,
        options: RocksdbReadoptions,
        key: []const u8,
        exclusive: u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        return api.rocksdb_transaction_get_pinned_for_update(
            helpers.unwrap(txn.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            exclusive,
            errptr,
        );
    }

    pub fn getForUpdateCf(
        txn: *Self,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        vlen: [*c]i64,
        exclusive: u8,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        return api.rocksdb_transaction_get_for_update_cf(
            helpers.unwrap(txn.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            vlen,
            exclusive,
            errptr,
        );
    }

    pub fn getPinnedForUpdateCf(
        txn: *Self,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        exclusive: u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        return api.rocksdb_transaction_get_pinned_for_update_cf(
            helpers.unwrap(txn.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            exclusive,
            errptr,
        );
    }

    pub fn multiGet(
        txn: *Self,
        options: RocksdbReadoptions,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        return api.rocksdb_transaction_multi_get(
            helpers.unwrap(txn.*),
            helpers.unwrap(options),
            num_keys,
            keys_list,
            keys_list_sizes,
            values_list,
            values_list_sizes,
            errs,
        );
    }

    pub fn multiGetForUpdate(
        txn: *Self,
        options: RocksdbReadoptions,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        return api.rocksdb_transaction_multi_get_for_update(
            helpers.unwrap(txn.*),
            helpers.unwrap(options),
            num_keys,
            keys_list,
            keys_list_sizes,
            values_list,
            values_list_sizes,
            errs,
        );
    }

    pub fn multiGetCf(
        txn: *Self,
        options: RocksdbReadoptions,
        column_families: [*c]const [*c]const api.rocksdb_column_family_handle_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        return api.rocksdb_transaction_multi_get_cf(
            helpers.unwrap(txn.*),
            helpers.unwrap(options),
            column_families,
            num_keys,
            keys_list,
            keys_list_sizes,
            values_list,
            values_list_sizes,
            errs,
        );
    }

    pub fn multiGetForUpdateCf(
        txn: *Self,
        options: RocksdbReadoptions,
        column_families: [*c]const [*c]const api.rocksdb_column_family_handle_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        return api.rocksdb_transaction_multi_get_for_update_cf(
            helpers.unwrap(txn.*),
            helpers.unwrap(options),
            column_families,
            num_keys,
            keys_list,
            keys_list_sizes,
            values_list,
            values_list_sizes,
            errs,
        );
    }

    pub fn put(
        txn: *Self,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_transaction_put(
            helpers.unwrap(txn.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn putCf(
        txn: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_transaction_put_cf(
            helpers.unwrap(txn.*),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn merge(
        txn: *Self,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_transaction_merge(
            helpers.unwrap(txn.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn mergeCf(
        txn: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_transaction_merge_cf(
            helpers.unwrap(txn.*),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn delete(txn: *Self, key: []const u8, errptr: [*c][*c]i8) void {
        return api.rocksdb_transaction_delete(
            helpers.unwrap(txn.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn deleteCf(
        txn: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_transaction_delete_cf(
            helpers.unwrap(txn.*),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn createIterator(
        txn: *Self,
        options: RocksdbReadoptions,
    ) [*c]api.rocksdb_iterator_t {
        return api.rocksdb_transaction_create_iterator(
            helpers.unwrap(txn.*),
            helpers.unwrap(options),
        );
    }

    pub fn createIteratorCf(
        txn: *Self,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
    ) [*c]api.rocksdb_iterator_t {
        return api.rocksdb_transaction_create_iterator_cf(
            helpers.unwrap(txn.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
        );
    }

    pub fn optimistictransactionBegin(
        otxn_db: *RocksdbOptimistictransactiondb,
        write_options: RocksdbWriteoptions,
        otxn_options: RocksdbOptimistictransactionOptions,
        old_txn: *Self,
    ) [*c]api.rocksdb_transaction_t {
        return api.rocksdb_optimistictransaction_begin(
            helpers.unwrap(otxn_db.*),
            helpers.unwrap(write_options),
            helpers.unwrap(otxn_options),
            helpers.unwrap(old_txn.*),
        );
    }

    test RocksdbTransaction {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbTransactiondbOptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_transactiondb_options_t,

    pub fn create() [*c]api.rocksdb_transactiondb_options_t {
        return api.rocksdb_transactiondb_options_create();
    }

    pub fn destroy(opt: *Self) void {
        return api.rocksdb_transactiondb_options_destroy(helpers.unwrap(opt.*));
    }

    pub fn setMaxNumLocks(opt: *Self, max_num_locks: i64) void {
        return api.rocksdb_transactiondb_options_set_max_num_locks(
            helpers.unwrap(opt.*),
            max_num_locks,
        );
    }

    pub fn setNumStripes(opt: *Self, num_stripes: i64) void {
        return api.rocksdb_transactiondb_options_set_num_stripes(
            helpers.unwrap(opt.*),
            num_stripes,
        );
    }

    pub fn setTransactionLockTimeout(opt: *Self, txn_lock_timeout: i64) void {
        return api.rocksdb_transactiondb_options_set_transaction_lock_timeout(
            helpers.unwrap(opt.*),
            txn_lock_timeout,
        );
    }

    pub fn setDefaultLockTimeout(opt: *Self, default_lock_timeout: i64) void {
        return api.rocksdb_transactiondb_options_set_default_lock_timeout(
            helpers.unwrap(opt.*),
            default_lock_timeout,
        );
    }

    test RocksdbTransactiondbOptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbTransactiondb = packed struct {
    const Self = @This();
    ref: *api.rocksdb_transactiondb_t,

    pub fn createColumnFamily(
        txn_db: *Self,
        column_family_options: RocksdbOptions,
        column_family_name: [*c]const i8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_column_family_handle_t {
        return api.rocksdb_transactiondb_create_column_family(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(column_family_options),
            column_family_name,
            errptr,
        );
    }

    pub fn open(
        options: RocksdbOptions,
        txn_db_options: RocksdbTransactiondbOptions,
        name: [*c]const i8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_transactiondb_t {
        return api.rocksdb_transactiondb_open(
            helpers.unwrap(options),
            helpers.unwrap(txn_db_options),
            name,
            errptr,
        );
    }

    pub fn openColumnFamilies(
        options: RocksdbOptions,
        txn_db_options: RocksdbTransactiondbOptions,
        name: [*c]const i8,
        num_column_families: i64,
        column_family_names: [*c]const [*c]const i8,
        column_family_options: [*c]const [*c]const api.rocksdb_options_t,
        column_family_handles: [*c][*c]api.rocksdb_column_family_handle_t,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_transactiondb_t {
        return api.rocksdb_transactiondb_open_column_families(
            helpers.unwrap(options),
            helpers.unwrap(txn_db_options),
            name,
            num_column_families,
            column_family_names,
            column_family_options,
            column_family_handles,
            errptr,
        );
    }

    pub fn createSnapshot(txn_db: *Self) [*c]const api.rocksdb_snapshot_t {
        return api.rocksdb_transactiondb_create_snapshot(helpers.unwrap(txn_db.*));
    }

    pub fn releaseSnapshot(txn_db: *Self, snapshot: RocksdbSnapshot) void {
        return api.rocksdb_transactiondb_release_snapshot(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(snapshot),
        );
    }

    pub fn propertyValue(db: *Self, propname: [*c]const i8) [*c]i8 {
        return api.rocksdb_transactiondb_property_value(helpers.unwrap(db.*), propname);
    }

    pub fn propertyInt(db: *Self, propname: [*c]const i8, out_val: [*c]i64) i64 {
        return api.rocksdb_transactiondb_property_int(
            helpers.unwrap(db.*),
            propname,
            out_val,
        );
    }

    pub fn getBaseDb(txn_db: *Self) [*c]api.rocksdb_t {
        return api.rocksdb_transactiondb_get_base_db(helpers.unwrap(txn_db.*));
    }

    pub fn getPreparedTransactions(
        txn_db: *Self,
        cnt: [*c]i64,
    ) [*c][*c]api.rocksdb_transaction_t {
        return api.rocksdb_transactiondb_get_prepared_transactions(
            helpers.unwrap(txn_db.*),
            cnt,
        );
    }

    pub fn get(
        txn_db: *Self,
        options: RocksdbReadoptions,
        key: []const u8,
        vlen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        return api.rocksdb_transactiondb_get(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            vlen,
            errptr,
        );
    }

    pub fn getPinned(
        txn_db: *Self,
        options: RocksdbReadoptions,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        return api.rocksdb_transactiondb_get_pinned(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn getCf(
        txn_db: *Self,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        vallen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        return api.rocksdb_transactiondb_get_cf(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            errptr,
        );
    }

    pub fn getPinnedCf(
        txn_db: *Self,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        return api.rocksdb_transactiondb_get_pinned_cf(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn multiGet(
        txn_db: *Self,
        options: RocksdbReadoptions,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        return api.rocksdb_transactiondb_multi_get(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
            num_keys,
            keys_list,
            keys_list_sizes,
            values_list,
            values_list_sizes,
            errs,
        );
    }

    pub fn multiGetCf(
        txn_db: *Self,
        options: RocksdbReadoptions,
        column_families: [*c]const [*c]const api.rocksdb_column_family_handle_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        return api.rocksdb_transactiondb_multi_get_cf(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
            column_families,
            num_keys,
            keys_list,
            keys_list_sizes,
            values_list,
            values_list_sizes,
            errs,
        );
    }

    pub fn put(
        txn_db: *Self,
        options: RocksdbWriteoptions,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_transactiondb_put(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn putCf(
        txn_db: *Self,
        options: RocksdbWriteoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_transactiondb_put_cf(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn write(
        txn_db: *Self,
        options: RocksdbWriteoptions,
        batch: *RocksdbWritebatch,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_transactiondb_write(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
            helpers.unwrap(batch.*),
            errptr,
        );
    }

    pub fn merge(
        txn_db: *Self,
        options: RocksdbWriteoptions,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_transactiondb_merge(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn mergeCf(
        txn_db: *Self,
        options: RocksdbWriteoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_transactiondb_merge_cf(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn delete(
        txn_db: *Self,
        options: RocksdbWriteoptions,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_transactiondb_delete(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn deleteCf(
        txn_db: *Self,
        options: RocksdbWriteoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_transactiondb_delete_cf(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn createIterator(
        txn_db: *Self,
        options: RocksdbReadoptions,
    ) [*c]api.rocksdb_iterator_t {
        return api.rocksdb_transactiondb_create_iterator(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
        );
    }

    pub fn createIteratorCf(
        txn_db: *Self,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
    ) [*c]api.rocksdb_iterator_t {
        return api.rocksdb_transactiondb_create_iterator_cf(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
        );
    }

    pub fn close(txn_db: *Self) void {
        return api.rocksdb_transactiondb_close(helpers.unwrap(txn_db.*));
    }

    pub fn flush(
        txn_db: *Self,
        options: RocksdbFlushoptions,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_transactiondb_flush(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
            errptr,
        );
    }

    pub fn flushCf(
        txn_db: *Self,
        options: RocksdbFlushoptions,
        column_family: *RocksdbColumnFamilyHandle,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_transactiondb_flush_cf(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            errptr,
        );
    }

    pub fn flushCfs(
        txn_db: *Self,
        options: RocksdbFlushoptions,
        column_families: [*c][*c]api.rocksdb_column_family_handle_t,
        num_column_families: i64,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_transactiondb_flush_cfs(
            helpers.unwrap(txn_db.*),
            helpers.unwrap(options),
            column_families,
            num_column_families,
            errptr,
        );
    }

    pub fn flushWal(txn_db: *Self, sync: u8, errptr: [*c][*c]i8) void {
        return api.rocksdb_transactiondb_flush_wal(helpers.unwrap(txn_db.*), sync, errptr);
    }

    pub fn checkpointObjectCreate(
        txn_db: *Self,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_checkpoint_t {
        return api.rocksdb_transactiondb_checkpoint_object_create(
            helpers.unwrap(txn_db.*),
            errptr,
        );
    }

    test RocksdbTransactiondb {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbUniversalCompactionOptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_universal_compaction_options_t,

    pub fn create() [*c]api.rocksdb_universal_compaction_options_t {
        return api.rocksdb_universal_compaction_options_create();
    }

    pub fn setSizeRatio(arg0: *Self, arg1: i64) void {
        return api.rocksdb_universal_compaction_options_set_size_ratio(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getSizeRatio(arg0: *Self) i64 {
        return api.rocksdb_universal_compaction_options_get_size_ratio(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setMinMergeWidth(arg0: *Self, arg1: i64) void {
        return api.rocksdb_universal_compaction_options_set_min_merge_width(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getMinMergeWidth(arg0: *Self) i64 {
        return api.rocksdb_universal_compaction_options_get_min_merge_width(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setMaxMergeWidth(arg0: *Self, arg1: i64) void {
        return api.rocksdb_universal_compaction_options_set_max_merge_width(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getMaxMergeWidth(arg0: *Self) i64 {
        return api.rocksdb_universal_compaction_options_get_max_merge_width(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setMaxSizeAmplificationPercent(arg0: *Self, arg1: i64) void {
        return api.rocksdb_universal_compaction_options_set_max_size_amplification_percent(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getMaxSizeAmplificationPercent(arg0: *Self) i64 {
        return api.rocksdb_universal_compaction_options_get_max_size_amplification_percent(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setCompressionSizePercent(arg0: *Self, arg1: i64) void {
        return api.rocksdb_universal_compaction_options_set_compression_size_percent(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getCompressionSizePercent(arg0: *Self) i64 {
        return api.rocksdb_universal_compaction_options_get_compression_size_percent(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setStopStyle(arg0: *Self, arg1: i64) void {
        return api.rocksdb_universal_compaction_options_set_stop_style(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getStopStyle(arg0: *Self) i64 {
        return api.rocksdb_universal_compaction_options_get_stop_style(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_universal_compaction_options_destroy(helpers.unwrap(arg0.*));
    }

    test RocksdbUniversalCompactionOptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbWaitForCompactOptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_wait_for_compact_options_t,

    pub fn create() [*c]api.rocksdb_wait_for_compact_options_t {
        return api.rocksdb_wait_for_compact_options_create();
    }

    pub fn destroy(opt: *Self) void {
        return api.rocksdb_wait_for_compact_options_destroy(helpers.unwrap(opt.*));
    }

    pub fn setAbortOnPause(opt: *Self, v: u8) void {
        return api.rocksdb_wait_for_compact_options_set_abort_on_pause(
            helpers.unwrap(opt.*),
            v,
        );
    }

    pub fn getAbortOnPause(opt: *Self) u8 {
        return api.rocksdb_wait_for_compact_options_get_abort_on_pause(
            helpers.unwrap(opt.*),
        );
    }

    pub fn setFlush(opt: *Self, v: u8) void {
        return api.rocksdb_wait_for_compact_options_set_flush(helpers.unwrap(opt.*), v);
    }

    pub fn getFlush(opt: *Self) u8 {
        return api.rocksdb_wait_for_compact_options_get_flush(helpers.unwrap(opt.*));
    }

    pub fn setCloseDb(opt: *Self, v: u8) void {
        return api.rocksdb_wait_for_compact_options_set_close_db(helpers.unwrap(opt.*), v);
    }

    pub fn getCloseDb(opt: *Self) u8 {
        return api.rocksdb_wait_for_compact_options_get_close_db(helpers.unwrap(opt.*));
    }

    pub fn setTimeout(opt: *Self, microseconds: i64) void {
        return api.rocksdb_wait_for_compact_options_set_timeout(
            helpers.unwrap(opt.*),
            microseconds,
        );
    }

    pub fn getTimeout(opt: *Self) i64 {
        return api.rocksdb_wait_for_compact_options_get_timeout(helpers.unwrap(opt.*));
    }

    test RocksdbWaitForCompactOptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbWalIterator = packed struct {
    const Self = @This();
    ref: *api.rocksdb_wal_iterator_t,

    pub fn next(iter: *Self) void {
        return api.rocksdb_wal_iter_next(helpers.unwrap(iter.*));
    }

    pub fn valid(arg0: Self) u8 {
        return api.rocksdb_wal_iter_valid(helpers.unwrap(arg0));
    }

    pub fn status(iter: Self, errptr: [*c][*c]i8) void {
        return api.rocksdb_wal_iter_status(helpers.unwrap(iter), errptr);
    }

    pub fn destroy(iter: Self) void {
        return api.rocksdb_wal_iter_destroy(helpers.unwrap(iter));
    }

    test RocksdbWalIterator {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbWriteBufferManager = packed struct {
    const Self = @This();
    ref: *api.rocksdb_write_buffer_manager_t,

    pub fn create(
        buffer_size: i64,
        allow_stall: i64,
    ) [*c]api.rocksdb_write_buffer_manager_t {
        return api.rocksdb_write_buffer_manager_create(buffer_size, allow_stall);
    }

    pub fn createWithCache(
        buffer_size: i64,
        cache: RocksdbCache,
        allow_stall: i64,
    ) [*c]api.rocksdb_write_buffer_manager_t {
        return api.rocksdb_write_buffer_manager_create_with_cache(
            buffer_size,
            helpers.unwrap(cache),
            allow_stall,
        );
    }

    pub fn destroy(wbm: *Self) void {
        return api.rocksdb_write_buffer_manager_destroy(helpers.unwrap(wbm.*));
    }

    pub fn enabled(wbm: *Self) i64 {
        return api.rocksdb_write_buffer_manager_enabled(helpers.unwrap(wbm.*));
    }

    pub fn costToCache(wbm: *Self) i64 {
        return api.rocksdb_write_buffer_manager_cost_to_cache(helpers.unwrap(wbm.*));
    }

    pub fn memoryUsage(wbm: *Self) i64 {
        return api.rocksdb_write_buffer_manager_memory_usage(helpers.unwrap(wbm.*));
    }

    pub fn mutableMemtableMemoryUsage(wbm: *Self) i64 {
        return api.rocksdb_write_buffer_manager_mutable_memtable_memory_usage(
            helpers.unwrap(wbm.*),
        );
    }

    pub fn dummyEntriesInCacheUsage(wbm: *Self) i64 {
        return api.rocksdb_write_buffer_manager_dummy_entries_in_cache_usage(
            helpers.unwrap(wbm.*),
        );
    }

    pub fn bufferSize(wbm: *Self) i64 {
        return api.rocksdb_write_buffer_manager_buffer_size(helpers.unwrap(wbm.*));
    }

    pub fn setBufferSize(wbm: *Self, new_size: i64) void {
        return api.rocksdb_write_buffer_manager_set_buffer_size(
            helpers.unwrap(wbm.*),
            new_size,
        );
    }

    pub fn setAllowStall(wbm: *Self, new_allow_stall: i64) void {
        return api.rocksdb_write_buffer_manager_set_allow_stall(
            helpers.unwrap(wbm.*),
            new_allow_stall,
        );
    }

    test RocksdbWriteBufferManager {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbWritebatch = packed struct {
    const Self = @This();
    ref: *api.rocksdb_writebatch_t,

    pub fn walIterGetBatch(
        iter: RocksdbWalIterator,
        seq: [*c]i64,
    ) [*c]api.rocksdb_writebatch_t {
        return api.rocksdb_wal_iter_get_batch(helpers.unwrap(iter), seq);
    }

    pub fn create() [*c]api.rocksdb_writebatch_t {
        return api.rocksdb_writebatch_create();
    }

    pub fn createFrom(rep: [*c]const i8, size: i64) [*c]api.rocksdb_writebatch_t {
        return api.rocksdb_writebatch_create_from(rep, size);
    }

    pub fn createWithParams(
        reserved_bytes: i64,
        max_bytes: i64,
        protection_bytes_per_key: i64,
        default_cf_ts_sz: i64,
    ) [*c]api.rocksdb_writebatch_t {
        return api.rocksdb_writebatch_create_with_params(
            reserved_bytes,
            max_bytes,
            protection_bytes_per_key,
            default_cf_ts_sz,
        );
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_writebatch_destroy(helpers.unwrap(arg0.*));
    }

    pub fn clear(arg0: *Self) void {
        return api.rocksdb_writebatch_clear(helpers.unwrap(arg0.*));
    }

    pub fn count(arg0: *Self) i64 {
        return api.rocksdb_writebatch_count(helpers.unwrap(arg0.*));
    }

    pub fn put(arg0: *Self, key: []const u8, val: []const u8) void {
        return api.rocksdb_writebatch_put(
            helpers.unwrap(arg0.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn putCf(
        arg0: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        val: []const u8,
    ) void {
        return api.rocksdb_writebatch_put_cf(
            helpers.unwrap(arg0.*),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn putCfWithTs(
        arg0: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        ts: []const u8,
        val: []const u8,
    ) void {
        return api.rocksdb_writebatch_put_cf_with_ts(
            helpers.unwrap(arg0.*),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn putv(
        b: *Self,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        num_values: i64,
        values_list: [*c]const [*c]const i8,
        values_list_sizes: [*c]const i64,
    ) void {
        return api.rocksdb_writebatch_putv(
            helpers.unwrap(b.*),
            num_keys,
            keys_list,
            keys_list_sizes,
            num_values,
            values_list,
            values_list_sizes,
        );
    }

    pub fn putvCf(
        b: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        num_values: i64,
        values_list: [*c]const [*c]const i8,
        values_list_sizes: [*c]const i64,
    ) void {
        return api.rocksdb_writebatch_putv_cf(
            helpers.unwrap(b.*),
            helpers.unwrap(column_family.*),
            num_keys,
            keys_list,
            keys_list_sizes,
            num_values,
            values_list,
            values_list_sizes,
        );
    }

    pub fn merge(arg0: *Self, key: []const u8, val: []const u8) void {
        return api.rocksdb_writebatch_merge(
            helpers.unwrap(arg0.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn mergeCf(
        arg0: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        val: []const u8,
    ) void {
        return api.rocksdb_writebatch_merge_cf(
            helpers.unwrap(arg0.*),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn mergev(
        b: *Self,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        num_values: i64,
        values_list: [*c]const [*c]const i8,
        values_list_sizes: [*c]const i64,
    ) void {
        return api.rocksdb_writebatch_mergev(
            helpers.unwrap(b.*),
            num_keys,
            keys_list,
            keys_list_sizes,
            num_values,
            values_list,
            values_list_sizes,
        );
    }

    pub fn mergevCf(
        b: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        num_values: i64,
        values_list: [*c]const [*c]const i8,
        values_list_sizes: [*c]const i64,
    ) void {
        return api.rocksdb_writebatch_mergev_cf(
            helpers.unwrap(b.*),
            helpers.unwrap(column_family.*),
            num_keys,
            keys_list,
            keys_list_sizes,
            num_values,
            values_list,
            values_list_sizes,
        );
    }

    pub fn delete(arg0: *Self, key: []const u8) void {
        return api.rocksdb_writebatch_delete(
            helpers.unwrap(arg0.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn singledelete(b: *Self, key: []const u8) void {
        return api.rocksdb_writebatch_singledelete(
            helpers.unwrap(b.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn deleteCf(
        arg0: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
    ) void {
        return api.rocksdb_writebatch_delete_cf(
            helpers.unwrap(arg0.*),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn deleteCfWithTs(
        arg0: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        ts: []const u8,
    ) void {
        return api.rocksdb_writebatch_delete_cf_with_ts(
            helpers.unwrap(arg0.*),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
        );
    }

    pub fn singledeleteCf(
        b: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
    ) void {
        return api.rocksdb_writebatch_singledelete_cf(
            helpers.unwrap(b.*),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn singledeleteCfWithTs(
        b: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        ts: []const u8,
    ) void {
        return api.rocksdb_writebatch_singledelete_cf_with_ts(
            helpers.unwrap(b.*),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
        );
    }

    pub fn deletev(
        b: *Self,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
    ) void {
        return api.rocksdb_writebatch_deletev(
            helpers.unwrap(b.*),
            num_keys,
            keys_list,
            keys_list_sizes,
        );
    }

    pub fn deletevCf(
        b: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
    ) void {
        return api.rocksdb_writebatch_deletev_cf(
            helpers.unwrap(b.*),
            helpers.unwrap(column_family.*),
            num_keys,
            keys_list,
            keys_list_sizes,
        );
    }

    pub fn deleteRange(b: *Self, start_key: []const u8, end_key: []const u8) void {
        return api.rocksdb_writebatch_delete_range(
            helpers.unwrap(b.*),
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(end_key.ptr),
            @intCast(end_key.len),
        );
    }

    pub fn deleteRangeCf(
        b: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        start_key: []const u8,
        end_key: []const u8,
    ) void {
        return api.rocksdb_writebatch_delete_range_cf(
            helpers.unwrap(b.*),
            helpers.unwrap(column_family.*),
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(end_key.ptr),
            @intCast(end_key.len),
        );
    }

    pub fn deleteRangev(
        b: *Self,
        num_keys: i64,
        start_keys_list: [*c]const [*c]const i8,
        start_keys_list_sizes: [*c]const i64,
        end_keys_list: [*c]const [*c]const i8,
        end_keys_list_sizes: [*c]const i64,
    ) void {
        return api.rocksdb_writebatch_delete_rangev(
            helpers.unwrap(b.*),
            num_keys,
            start_keys_list,
            start_keys_list_sizes,
            end_keys_list,
            end_keys_list_sizes,
        );
    }

    pub fn deleteRangevCf(
        b: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        num_keys: i64,
        start_keys_list: [*c]const [*c]const i8,
        start_keys_list_sizes: [*c]const i64,
        end_keys_list: [*c]const [*c]const i8,
        end_keys_list_sizes: [*c]const i64,
    ) void {
        return api.rocksdb_writebatch_delete_rangev_cf(
            helpers.unwrap(b.*),
            helpers.unwrap(column_family.*),
            num_keys,
            start_keys_list,
            start_keys_list_sizes,
            end_keys_list,
            end_keys_list_sizes,
        );
    }

    pub fn putLogData(arg0: *Self, blob: []const u8) void {
        return api.rocksdb_writebatch_put_log_data(
            helpers.unwrap(arg0.*),
            @ptrCast(blob.ptr),
            @intCast(blob.len),
        );
    }

    pub fn iterate(
        arg0: *Self,
        state: *anyopaque,
        put_: [*c]fn (
            *anyopaque,
            [*c]const i8,
            i64,
            [*c]const i8,
            i64,
        ) void,
        deleted: [*c]fn (
            *anyopaque,
            [*c]const i8,
            i64,
        ) void,
    ) void {
        return api.rocksdb_writebatch_iterate(
            helpers.unwrap(arg0.*),
            state,
            put_,
            deleted,
        );
    }

    pub fn iterateCf(
        arg0: *Self,
        state: *anyopaque,
        put_cf: [*c]fn (
            *anyopaque,
            i64,
            [*c]const i8,
            i64,
            [*c]const i8,
            i64,
        ) void,
        deleted_cf: [*c]fn (
            *anyopaque,
            i64,
            [*c]const i8,
            i64,
        ) void,
        merge_cf: [*c]fn (
            *anyopaque,
            i64,
            [*c]const i8,
            i64,
            [*c]const i8,
            i64,
        ) void,
    ) void {
        return api.rocksdb_writebatch_iterate_cf(
            helpers.unwrap(arg0.*),
            state,
            put_cf,
            deleted_cf,
            merge_cf,
        );
    }

    pub fn data(arg0: *Self, size: [*c]i64) [*c]const i8 {
        return api.rocksdb_writebatch_data(helpers.unwrap(arg0.*), size);
    }

    pub fn setSavePoint(arg0: *Self) void {
        return api.rocksdb_writebatch_set_save_point(helpers.unwrap(arg0.*));
    }

    pub fn rollbackToSavePoint(arg0: *Self, errptr: [*c][*c]i8) void {
        return api.rocksdb_writebatch_rollback_to_save_point(
            helpers.unwrap(arg0.*),
            errptr,
        );
    }

    pub fn popSavePoint(arg0: *Self, errptr: [*c][*c]i8) void {
        return api.rocksdb_writebatch_pop_save_point(helpers.unwrap(arg0.*), errptr);
    }

    pub fn updateTimestamps(
        wb: *Self,
        ts: []const u8,
        state: *anyopaque,
        size_t: fn (
            [*c]i64,
        ) i64,
        errptr: [*c][*c]i8,
    ) void {
        return api.rocksdb_writebatch_update_timestamps(
            helpers.unwrap(wb.*),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
            state,
            size_t,
            errptr,
        );
    }

    test RocksdbWritebatch {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbWritebatchWi = packed struct {
    const Self = @This();
    ref: *api.rocksdb_writebatch_wi_t,

    pub fn create(
        reserved_bytes: i64,
        overwrite_keys: u8,
    ) [*c]api.rocksdb_writebatch_wi_t {
        return api.rocksdb_writebatch_wi_create(reserved_bytes, overwrite_keys);
    }

    pub fn createFrom(rep: [*c]const i8, size: i64) [*c]api.rocksdb_writebatch_wi_t {
        return api.rocksdb_writebatch_wi_create_from(rep, size);
    }

    pub fn createWithParams(
        backup_index_comparator: *RocksdbComparator,
        reserved_bytes: i64,
        overwrite_key: u8,
        max_bytes: i64,
        protection_bytes_per_key: i64,
    ) [*c]api.rocksdb_writebatch_wi_t {
        return api.rocksdb_writebatch_wi_create_with_params(
            helpers.unwrap(backup_index_comparator.*),
            reserved_bytes,
            overwrite_key,
            max_bytes,
            protection_bytes_per_key,
        );
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_writebatch_wi_destroy(helpers.unwrap(arg0.*));
    }

    pub fn clear(arg0: *Self) void {
        return api.rocksdb_writebatch_wi_clear(helpers.unwrap(arg0.*));
    }

    pub fn count(b: *Self) i64 {
        return api.rocksdb_writebatch_wi_count(helpers.unwrap(b.*));
    }

    pub fn put(arg0: *Self, key: []const u8, val: []const u8) void {
        return api.rocksdb_writebatch_wi_put(
            helpers.unwrap(arg0.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn putCf(
        arg0: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        val: []const u8,
    ) void {
        return api.rocksdb_writebatch_wi_put_cf(
            helpers.unwrap(arg0.*),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn putv(
        b: *Self,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        num_values: i64,
        values_list: [*c]const [*c]const i8,
        values_list_sizes: [*c]const i64,
    ) void {
        return api.rocksdb_writebatch_wi_putv(
            helpers.unwrap(b.*),
            num_keys,
            keys_list,
            keys_list_sizes,
            num_values,
            values_list,
            values_list_sizes,
        );
    }

    pub fn putvCf(
        b: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        num_values: i64,
        values_list: [*c]const [*c]const i8,
        values_list_sizes: [*c]const i64,
    ) void {
        return api.rocksdb_writebatch_wi_putv_cf(
            helpers.unwrap(b.*),
            helpers.unwrap(column_family.*),
            num_keys,
            keys_list,
            keys_list_sizes,
            num_values,
            values_list,
            values_list_sizes,
        );
    }

    pub fn merge(arg0: *Self, key: []const u8, val: []const u8) void {
        return api.rocksdb_writebatch_wi_merge(
            helpers.unwrap(arg0.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn mergeCf(
        arg0: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        val: []const u8,
    ) void {
        return api.rocksdb_writebatch_wi_merge_cf(
            helpers.unwrap(arg0.*),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn mergev(
        b: *Self,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        num_values: i64,
        values_list: [*c]const [*c]const i8,
        values_list_sizes: [*c]const i64,
    ) void {
        return api.rocksdb_writebatch_wi_mergev(
            helpers.unwrap(b.*),
            num_keys,
            keys_list,
            keys_list_sizes,
            num_values,
            values_list,
            values_list_sizes,
        );
    }

    pub fn mergevCf(
        b: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        num_values: i64,
        values_list: [*c]const [*c]const i8,
        values_list_sizes: [*c]const i64,
    ) void {
        return api.rocksdb_writebatch_wi_mergev_cf(
            helpers.unwrap(b.*),
            helpers.unwrap(column_family.*),
            num_keys,
            keys_list,
            keys_list_sizes,
            num_values,
            values_list,
            values_list_sizes,
        );
    }

    pub fn delete(arg0: *Self, key: []const u8) void {
        return api.rocksdb_writebatch_wi_delete(
            helpers.unwrap(arg0.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn singledelete(arg0: *Self, key: []const u8) void {
        return api.rocksdb_writebatch_wi_singledelete(
            helpers.unwrap(arg0.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn deleteCf(
        arg0: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
    ) void {
        return api.rocksdb_writebatch_wi_delete_cf(
            helpers.unwrap(arg0.*),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn singledeleteCf(
        arg0: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
    ) void {
        return api.rocksdb_writebatch_wi_singledelete_cf(
            helpers.unwrap(arg0.*),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn deletev(
        b: *Self,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
    ) void {
        return api.rocksdb_writebatch_wi_deletev(
            helpers.unwrap(b.*),
            num_keys,
            keys_list,
            keys_list_sizes,
        );
    }

    pub fn deletevCf(
        b: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
    ) void {
        return api.rocksdb_writebatch_wi_deletev_cf(
            helpers.unwrap(b.*),
            helpers.unwrap(column_family.*),
            num_keys,
            keys_list,
            keys_list_sizes,
        );
    }

    pub fn deleteRange(b: *Self, start_key: []const u8, end_key: []const u8) void {
        return api.rocksdb_writebatch_wi_delete_range(
            helpers.unwrap(b.*),
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(end_key.ptr),
            @intCast(end_key.len),
        );
    }

    pub fn deleteRangeCf(
        b: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        start_key: []const u8,
        end_key: []const u8,
    ) void {
        return api.rocksdb_writebatch_wi_delete_range_cf(
            helpers.unwrap(b.*),
            helpers.unwrap(column_family.*),
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(end_key.ptr),
            @intCast(end_key.len),
        );
    }

    pub fn deleteRangev(
        b: *Self,
        num_keys: i64,
        start_keys_list: [*c]const [*c]const i8,
        start_keys_list_sizes: [*c]const i64,
        end_keys_list: [*c]const [*c]const i8,
        end_keys_list_sizes: [*c]const i64,
    ) void {
        return api.rocksdb_writebatch_wi_delete_rangev(
            helpers.unwrap(b.*),
            num_keys,
            start_keys_list,
            start_keys_list_sizes,
            end_keys_list,
            end_keys_list_sizes,
        );
    }

    pub fn deleteRangevCf(
        b: *Self,
        column_family: *RocksdbColumnFamilyHandle,
        num_keys: i64,
        start_keys_list: [*c]const [*c]const i8,
        start_keys_list_sizes: [*c]const i64,
        end_keys_list: [*c]const [*c]const i8,
        end_keys_list_sizes: [*c]const i64,
    ) void {
        return api.rocksdb_writebatch_wi_delete_rangev_cf(
            helpers.unwrap(b.*),
            helpers.unwrap(column_family.*),
            num_keys,
            start_keys_list,
            start_keys_list_sizes,
            end_keys_list,
            end_keys_list_sizes,
        );
    }

    pub fn putLogData(arg0: *Self, blob: []const u8) void {
        return api.rocksdb_writebatch_wi_put_log_data(
            helpers.unwrap(arg0.*),
            @ptrCast(blob.ptr),
            @intCast(blob.len),
        );
    }

    pub fn iterate(
        b: *Self,
        state: *anyopaque,
        put_: [*c]fn (
            *anyopaque,
            [*c]const i8,
            i64,
            [*c]const i8,
            i64,
        ) void,
        deleted: [*c]fn (
            *anyopaque,
            [*c]const i8,
            i64,
        ) void,
    ) void {
        return api.rocksdb_writebatch_wi_iterate(
            helpers.unwrap(b.*),
            state,
            put_,
            deleted,
        );
    }

    pub fn data(b: *Self, size: [*c]i64) [*c]const i8 {
        return api.rocksdb_writebatch_wi_data(helpers.unwrap(b.*), size);
    }

    pub fn setSavePoint(arg0: *Self) void {
        return api.rocksdb_writebatch_wi_set_save_point(helpers.unwrap(arg0.*));
    }

    pub fn rollbackToSavePoint(arg0: *Self, errptr: [*c][*c]i8) void {
        return api.rocksdb_writebatch_wi_rollback_to_save_point(
            helpers.unwrap(arg0.*),
            errptr,
        );
    }

    pub fn getFromBatch(
        wbwi: *Self,
        options: RocksdbOptions,
        key: []const u8,
        vallen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        return api.rocksdb_writebatch_wi_get_from_batch(
            helpers.unwrap(wbwi.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            errptr,
        );
    }

    pub fn getFromBatchCf(
        wbwi: *Self,
        options: RocksdbOptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        vallen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        return api.rocksdb_writebatch_wi_get_from_batch_cf(
            helpers.unwrap(wbwi.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            errptr,
        );
    }

    pub fn getFromBatchAndDb(
        wbwi: *Self,
        db: *Rocksdb,
        options: RocksdbReadoptions,
        key: []const u8,
        vallen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        return api.rocksdb_writebatch_wi_get_from_batch_and_db(
            helpers.unwrap(wbwi.*),
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            errptr,
        );
    }

    pub fn getPinnedFromBatchAndDb(
        wbwi: *Self,
        db: *Rocksdb,
        options: RocksdbReadoptions,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        return api.rocksdb_writebatch_wi_get_pinned_from_batch_and_db(
            helpers.unwrap(wbwi.*),
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn getFromBatchAndDbCf(
        wbwi: *Self,
        db: *Rocksdb,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        vallen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        return api.rocksdb_writebatch_wi_get_from_batch_and_db_cf(
            helpers.unwrap(wbwi.*),
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            errptr,
        );
    }

    pub fn getPinnedFromBatchAndDbCf(
        wbwi: *Self,
        db: *Rocksdb,
        options: RocksdbReadoptions,
        column_family: *RocksdbColumnFamilyHandle,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        return api.rocksdb_writebatch_wi_get_pinned_from_batch_and_db_cf(
            helpers.unwrap(wbwi.*),
            helpers.unwrap(db.*),
            helpers.unwrap(options),
            helpers.unwrap(column_family.*),
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn createIteratorWithBase(
        wbwi: *Self,
        base_iterator: *RocksdbIterator,
    ) [*c]api.rocksdb_iterator_t {
        return api.rocksdb_writebatch_wi_create_iterator_with_base(
            helpers.unwrap(wbwi.*),
            helpers.unwrap(base_iterator.*),
        );
    }

    pub fn createIteratorWithBaseReadopts(
        wbwi: *Self,
        base_iterator: *RocksdbIterator,
        options: RocksdbReadoptions,
    ) [*c]api.rocksdb_iterator_t {
        return api.rocksdb_writebatch_wi_create_iterator_with_base_readopts(
            helpers.unwrap(wbwi.*),
            helpers.unwrap(base_iterator.*),
            helpers.unwrap(options),
        );
    }

    pub fn createIteratorWithBaseCf(
        wbwi: *Self,
        base_iterator: *RocksdbIterator,
        cf: *RocksdbColumnFamilyHandle,
    ) [*c]api.rocksdb_iterator_t {
        return api.rocksdb_writebatch_wi_create_iterator_with_base_cf(
            helpers.unwrap(wbwi.*),
            helpers.unwrap(base_iterator.*),
            helpers.unwrap(cf.*),
        );
    }

    pub fn createIteratorWithBaseCfReadopts(
        wbwi: *Self,
        base_iterator: *RocksdbIterator,
        cf: *RocksdbColumnFamilyHandle,
        options: RocksdbReadoptions,
    ) [*c]api.rocksdb_iterator_t {
        return api.rocksdb_writebatch_wi_create_iterator_with_base_cf_readopts(
            helpers.unwrap(wbwi.*),
            helpers.unwrap(base_iterator.*),
            helpers.unwrap(cf.*),
            helpers.unwrap(options),
        );
    }

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

    test RocksdbWritebatchWi {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbWriteoptions = packed struct {
    const Self = @This();
    ref: *api.rocksdb_writeoptions_t,

    pub fn create() [*c]api.rocksdb_writeoptions_t {
        return api.rocksdb_writeoptions_create();
    }

    pub fn destroy(arg0: *Self) void {
        return api.rocksdb_writeoptions_destroy(helpers.unwrap(arg0.*));
    }

    pub fn setSync(arg0: *Self, arg1: u8) void {
        return api.rocksdb_writeoptions_set_sync(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getSync(arg0: *Self) u8 {
        return api.rocksdb_writeoptions_get_sync(helpers.unwrap(arg0.*));
    }

    pub fn disableWal(opt: *Self, disable: i64) void {
        return api.rocksdb_writeoptions_disable_WAL(helpers.unwrap(opt.*), disable);
    }

    pub fn getDisableWal(opt: *Self) u8 {
        return api.rocksdb_writeoptions_get_disable_WAL(helpers.unwrap(opt.*));
    }

    pub fn setIgnoreMissingColumnFamilies(arg0: *Self, arg1: u8) void {
        return api.rocksdb_writeoptions_set_ignore_missing_column_families(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getIgnoreMissingColumnFamilies(arg0: *Self) u8 {
        return api.rocksdb_writeoptions_get_ignore_missing_column_families(
            helpers.unwrap(arg0.*),
        );
    }

    pub fn setNoSlowdown(arg0: *Self, arg1: u8) void {
        return api.rocksdb_writeoptions_set_no_slowdown(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getNoSlowdown(arg0: *Self) u8 {
        return api.rocksdb_writeoptions_get_no_slowdown(helpers.unwrap(arg0.*));
    }

    pub fn setLowPri(arg0: *Self, arg1: u8) void {
        return api.rocksdb_writeoptions_set_low_pri(helpers.unwrap(arg0.*), arg1);
    }

    pub fn getLowPri(arg0: *Self) u8 {
        return api.rocksdb_writeoptions_get_low_pri(helpers.unwrap(arg0.*));
    }

    pub fn setMemtableInsertHintPerBatch(arg0: *Self, arg1: u8) void {
        return api.rocksdb_writeoptions_set_memtable_insert_hint_per_batch(
            helpers.unwrap(arg0.*),
            arg1,
        );
    }

    pub fn getMemtableInsertHintPerBatch(arg0: *Self) u8 {
        return api.rocksdb_writeoptions_get_memtable_insert_hint_per_batch(
            helpers.unwrap(arg0.*),
        );
    }

    test RocksdbWriteoptions {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};

pub const RocksdbWritestallinfo = packed struct {
    const Self = @This();
    ref: *api.rocksdb_writestallinfo_t,

    pub fn cfName(arg0: Self, arg1: [*c]i64) [*c]const i8 {
        return api.rocksdb_writestallinfo_cf_name(helpers.unwrap(arg0), arg1);
    }

    pub fn cur(arg0: Self) [*c]const api.rocksdb_writestallcondition_t {
        return api.rocksdb_writestallinfo_cur(helpers.unwrap(arg0));
    }

    pub fn prev(arg0: Self) [*c]const api.rocksdb_writestallcondition_t {
        return api.rocksdb_writestallinfo_prev(helpers.unwrap(arg0));
    }

    test RocksdbWritestallinfo {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};
