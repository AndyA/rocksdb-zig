const std = @import("std");
const assert = std.debug.assert;

const helpers = @import("./helpers.zig");

const api = @import("rocksdb");

pub fn listColumnFamiliesDestroy(list: [*c][*c]i8, len: i64) void {
    api.rocksdb_list_column_families_destroy(list, len);
}

pub fn createColumnFamiliesDestroy(
    list: [*c][*c]api.rocksdb_column_family_handle_t,
) void {
    api.rocksdb_create_column_families_destroy(list);
}

pub fn loadLatestOptions(
    db_path: [*c]const i8,
    env: [*c]api.rocksdb_env_t,
    ignore_unknown_options: i64,
    cache: [*c]api.rocksdb_cache_t,
    db_options: [*c][*c]api.rocksdb_options_t,
    num_column_families: [*c]i64,
    column_family_names: [*c][*c][*c]i8,
    column_family_options: [*c][*c][*c]api.rocksdb_options_t,
    errptr: [*c][*c]i8,
) void {
    api.rocksdb_load_latest_options(
        db_path,
        env,
        ignore_unknown_options,
        cache,
        db_options,
        num_column_families,
        column_family_names,
        column_family_options,
        errptr,
    );
}

pub fn setPerfLevel(arg0: i64) void {
    api.rocksdb_set_perf_level(arg0);
}

pub fn free(ptr: *anyopaque) void {
    api.rocksdb_free(ptr);
}

pub const RocksdbBackupEngineInfo = packed struct {
    const Self = @This();
    ref: *api.rocksdb_backup_engine_info_t,

    pub fn count(info: [*c]const api.rocksdb_backup_engine_info_t) i64 {
        api.rocksdb_backup_engine_info_count(info);
    }

    pub fn timestamp(
        info: [*c]const api.rocksdb_backup_engine_info_t,
        index: i64,
    ) i64 {
        api.rocksdb_backup_engine_info_timestamp(info, index);
    }

    pub fn backupId(
        info: [*c]const api.rocksdb_backup_engine_info_t,
        index: i64,
    ) i64 {
        api.rocksdb_backup_engine_info_backup_id(info, index);
    }

    pub fn size(info: [*c]const api.rocksdb_backup_engine_info_t, index: i64) i64 {
        api.rocksdb_backup_engine_info_size(info, index);
    }

    pub fn numberFiles(
        info: [*c]const api.rocksdb_backup_engine_info_t,
        index: i64,
    ) i64 {
        api.rocksdb_backup_engine_info_number_files(info, index);
    }

    pub fn destroy(info: [*c]const api.rocksdb_backup_engine_info_t) void {
        api.rocksdb_backup_engine_info_destroy(info);
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
        api.rocksdb_backup_engine_options_create(backup_dir);
    }

    pub fn setBackupDir(
        options: [*c]api.rocksdb_backup_engine_options_t,
        backup_dir: [*c]const i8,
    ) void {
        api.rocksdb_backup_engine_options_set_backup_dir(options, backup_dir);
    }

    pub fn setEnv(
        options: [*c]api.rocksdb_backup_engine_options_t,
        env: [*c]api.rocksdb_env_t,
    ) void {
        api.rocksdb_backup_engine_options_set_env(options, env);
    }

    pub fn setShareTableFiles(
        options: [*c]api.rocksdb_backup_engine_options_t,
        val: u8,
    ) void {
        api.rocksdb_backup_engine_options_set_share_table_files(options, val);
    }

    pub fn getShareTableFiles(options: [*c]api.rocksdb_backup_engine_options_t) u8 {
        api.rocksdb_backup_engine_options_get_share_table_files(options);
    }

    pub fn setSync(options: [*c]api.rocksdb_backup_engine_options_t, val: u8) void {
        api.rocksdb_backup_engine_options_set_sync(options, val);
    }

    pub fn getSync(options: [*c]api.rocksdb_backup_engine_options_t) u8 {
        api.rocksdb_backup_engine_options_get_sync(options);
    }

    pub fn setDestroyOldData(
        options: [*c]api.rocksdb_backup_engine_options_t,
        val: u8,
    ) void {
        api.rocksdb_backup_engine_options_set_destroy_old_data(options, val);
    }

    pub fn getDestroyOldData(options: [*c]api.rocksdb_backup_engine_options_t) u8 {
        api.rocksdb_backup_engine_options_get_destroy_old_data(options);
    }

    pub fn setBackupLogFiles(
        options: [*c]api.rocksdb_backup_engine_options_t,
        val: u8,
    ) void {
        api.rocksdb_backup_engine_options_set_backup_log_files(options, val);
    }

    pub fn getBackupLogFiles(options: [*c]api.rocksdb_backup_engine_options_t) u8 {
        api.rocksdb_backup_engine_options_get_backup_log_files(options);
    }

    pub fn setBackupRateLimit(
        options: [*c]api.rocksdb_backup_engine_options_t,
        limit: i64,
    ) void {
        api.rocksdb_backup_engine_options_set_backup_rate_limit(options, limit);
    }

    pub fn getBackupRateLimit(options: [*c]api.rocksdb_backup_engine_options_t) i64 {
        api.rocksdb_backup_engine_options_get_backup_rate_limit(options);
    }

    pub fn setRestoreRateLimit(
        options: [*c]api.rocksdb_backup_engine_options_t,
        limit: i64,
    ) void {
        api.rocksdb_backup_engine_options_set_restore_rate_limit(options, limit);
    }

    pub fn getRestoreRateLimit(
        options: [*c]api.rocksdb_backup_engine_options_t,
    ) i64 {
        api.rocksdb_backup_engine_options_get_restore_rate_limit(options);
    }

    pub fn setMaxBackgroundOperations(
        options: [*c]api.rocksdb_backup_engine_options_t,
        val: i64,
    ) void {
        api.rocksdb_backup_engine_options_set_max_background_operations(
            options,
            val,
        );
    }

    pub fn getMaxBackgroundOperations(
        options: [*c]api.rocksdb_backup_engine_options_t,
    ) i64 {
        api.rocksdb_backup_engine_options_get_max_background_operations(options);
    }

    pub fn setCallbackTriggerIntervalSize(
        options: [*c]api.rocksdb_backup_engine_options_t,
        size: i64,
    ) void {
        api.rocksdb_backup_engine_options_set_callback_trigger_interval_size(
            options,
            size,
        );
    }

    pub fn getCallbackTriggerIntervalSize(
        options: [*c]api.rocksdb_backup_engine_options_t,
    ) i64 {
        api.rocksdb_backup_engine_options_get_callback_trigger_interval_size(
            options,
        );
    }

    pub fn setMaxValidBackupsToOpen(
        options: [*c]api.rocksdb_backup_engine_options_t,
        val: i64,
    ) void {
        api.rocksdb_backup_engine_options_set_max_valid_backups_to_open(
            options,
            val,
        );
    }

    pub fn getMaxValidBackupsToOpen(
        options: [*c]api.rocksdb_backup_engine_options_t,
    ) i64 {
        api.rocksdb_backup_engine_options_get_max_valid_backups_to_open(options);
    }

    pub fn setShareFilesWithChecksumNaming(
        options: [*c]api.rocksdb_backup_engine_options_t,
        val: i64,
    ) void {
        api.rocksdb_backup_engine_options_set_share_files_with_checksum_naming(
            options,
            val,
        );
    }

    pub fn getShareFilesWithChecksumNaming(
        options: [*c]api.rocksdb_backup_engine_options_t,
    ) i64 {
        api.rocksdb_backup_engine_options_get_share_files_with_checksum_naming(
            options,
        );
    }

    pub fn destroy(arg0: [*c]api.rocksdb_backup_engine_options_t) void {
        api.rocksdb_backup_engine_options_destroy(arg0);
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
        options: [*c]const api.rocksdb_options_t,
        path: [*c]const i8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_backup_engine_t {
        api.rocksdb_backup_engine_open(options, path, errptr);
    }

    pub fn openOpts(
        options: [*c]const api.rocksdb_backup_engine_options_t,
        env: [*c]api.rocksdb_env_t,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_backup_engine_t {
        api.rocksdb_backup_engine_open_opts(options, env, errptr);
    }

    pub fn createNewBackup(
        be: [*c]api.rocksdb_backup_engine_t,
        db: [*c]api.rocksdb_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_backup_engine_create_new_backup(be, db, errptr);
    }

    pub fn createNewBackupFlush(
        be: [*c]api.rocksdb_backup_engine_t,
        db: [*c]api.rocksdb_t,
        flush_before_backup: u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_backup_engine_create_new_backup_flush(
            be,
            db,
            flush_before_backup,
            errptr,
        );
    }

    pub fn purgeOldBackups(
        be: [*c]api.rocksdb_backup_engine_t,
        num_backups_to_keep: i64,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_backup_engine_purge_old_backups(
            be,
            num_backups_to_keep,
            errptr,
        );
    }

    pub fn verifyBackup(
        be: [*c]api.rocksdb_backup_engine_t,
        backup_id: i64,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_backup_engine_verify_backup(be, backup_id, errptr);
    }

    pub fn restoreDbFromLatestBackup(
        be: [*c]api.rocksdb_backup_engine_t,
        db_dir: [*c]const i8,
        wal_dir: [*c]const i8,
        restore_options: [*c]const api.rocksdb_restore_options_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_backup_engine_restore_db_from_latest_backup(
            be,
            db_dir,
            wal_dir,
            restore_options,
            errptr,
        );
    }

    pub fn restoreDbFromBackup(
        be: [*c]api.rocksdb_backup_engine_t,
        db_dir: [*c]const i8,
        wal_dir: [*c]const i8,
        restore_options: [*c]const api.rocksdb_restore_options_t,
        backup_id: i64,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_backup_engine_restore_db_from_backup(
            be,
            db_dir,
            wal_dir,
            restore_options,
            backup_id,
            errptr,
        );
    }

    pub fn getBackupInfo(
        be: [*c]api.rocksdb_backup_engine_t,
    ) [*c]const api.rocksdb_backup_engine_info_t {
        api.rocksdb_backup_engine_get_backup_info(be);
    }

    pub fn close(be: [*c]api.rocksdb_backup_engine_t) void {
        api.rocksdb_backup_engine_close(be);
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
        api.rocksdb_block_based_options_create();
    }

    pub fn destroy(options: [*c]api.rocksdb_block_based_table_options_t) void {
        api.rocksdb_block_based_options_destroy(options);
    }

    pub fn setChecksum(
        arg0: [*c]api.rocksdb_block_based_table_options_t,
        arg1: i8,
    ) void {
        api.rocksdb_block_based_options_set_checksum(arg0, arg1);
    }

    pub fn setBlockSize(
        options: [*c]api.rocksdb_block_based_table_options_t,
        block_size: i64,
    ) void {
        api.rocksdb_block_based_options_set_block_size(options, block_size);
    }

    pub fn setBlockSizeDeviation(
        options: [*c]api.rocksdb_block_based_table_options_t,
        block_size_deviation: i64,
    ) void {
        api.rocksdb_block_based_options_set_block_size_deviation(
            options,
            block_size_deviation,
        );
    }

    pub fn setBlockRestartInterval(
        options: [*c]api.rocksdb_block_based_table_options_t,
        block_restart_interval: i64,
    ) void {
        api.rocksdb_block_based_options_set_block_restart_interval(
            options,
            block_restart_interval,
        );
    }

    pub fn setIndexBlockRestartInterval(
        options: [*c]api.rocksdb_block_based_table_options_t,
        index_block_restart_interval: i64,
    ) void {
        api.rocksdb_block_based_options_set_index_block_restart_interval(
            options,
            index_block_restart_interval,
        );
    }

    pub fn setMetadataBlockSize(
        options: [*c]api.rocksdb_block_based_table_options_t,
        metadata_block_size: i64,
    ) void {
        api.rocksdb_block_based_options_set_metadata_block_size(
            options,
            metadata_block_size,
        );
    }

    pub fn setPartitionFilters(
        options: [*c]api.rocksdb_block_based_table_options_t,
        partition_filters: u8,
    ) void {
        api.rocksdb_block_based_options_set_partition_filters(
            options,
            partition_filters,
        );
    }

    pub fn setOptimizeFiltersForMemory(
        options: [*c]api.rocksdb_block_based_table_options_t,
        optimize_filters_for_memory: u8,
    ) void {
        api.rocksdb_block_based_options_set_optimize_filters_for_memory(
            options,
            optimize_filters_for_memory,
        );
    }

    pub fn setUseDeltaEncoding(
        options: [*c]api.rocksdb_block_based_table_options_t,
        use_delta_encoding: u8,
    ) void {
        api.rocksdb_block_based_options_set_use_delta_encoding(
            options,
            use_delta_encoding,
        );
    }

    pub fn setFilterPolicy(
        options: [*c]api.rocksdb_block_based_table_options_t,
        filter_policy: [*c]api.rocksdb_filterpolicy_t,
    ) void {
        api.rocksdb_block_based_options_set_filter_policy(options, filter_policy);
    }

    pub fn setNoBlockCache(
        options: [*c]api.rocksdb_block_based_table_options_t,
        no_block_cache: u8,
    ) void {
        api.rocksdb_block_based_options_set_no_block_cache(options, no_block_cache);
    }

    pub fn setBlockCache(
        options: [*c]api.rocksdb_block_based_table_options_t,
        block_cache: [*c]api.rocksdb_cache_t,
    ) void {
        api.rocksdb_block_based_options_set_block_cache(options, block_cache);
    }

    pub fn setWholeKeyFiltering(
        arg0: [*c]api.rocksdb_block_based_table_options_t,
        arg1: u8,
    ) void {
        api.rocksdb_block_based_options_set_whole_key_filtering(arg0, arg1);
    }

    pub fn setFormatVersion(
        arg0: [*c]api.rocksdb_block_based_table_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_block_based_options_set_format_version(arg0, arg1);
    }

    pub fn setIndexType(
        arg0: [*c]api.rocksdb_block_based_table_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_block_based_options_set_index_type(arg0, arg1);
    }

    pub fn setDataBlockIndexType(
        arg0: [*c]api.rocksdb_block_based_table_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_block_based_options_set_data_block_index_type(arg0, arg1);
    }

    pub fn setDataBlockHashRatio(
        options: [*c]api.rocksdb_block_based_table_options_t,
        v: f64,
    ) void {
        api.rocksdb_block_based_options_set_data_block_hash_ratio(options, v);
    }

    pub fn setCacheIndexAndFilterBlocks(
        arg0: [*c]api.rocksdb_block_based_table_options_t,
        arg1: u8,
    ) void {
        api.rocksdb_block_based_options_set_cache_index_and_filter_blocks(
            arg0,
            arg1,
        );
    }

    pub fn setCacheIndexAndFilterBlocksWithHighPriority(
        arg0: [*c]api.rocksdb_block_based_table_options_t,
        arg1: u8,
    ) void {
        api.rocksdb_block_based_options_set_cache_index_and_filter_blocks_with_high_priority(
            arg0,
            arg1,
        );
    }

    pub fn setPinL0FilterAndIndexBlocksInCache(
        arg0: [*c]api.rocksdb_block_based_table_options_t,
        arg1: u8,
    ) void {
        api.rocksdb_block_based_options_set_pin_l0_filter_and_index_blocks_in_cache(
            arg0,
            arg1,
        );
    }

    pub fn setPinTopLevelIndexAndFilter(
        arg0: [*c]api.rocksdb_block_based_table_options_t,
        arg1: u8,
    ) void {
        api.rocksdb_block_based_options_set_pin_top_level_index_and_filter(
            arg0,
            arg1,
        );
    }

    pub fn setTopLevelIndexPinningTier(
        arg0: [*c]api.rocksdb_block_based_table_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_block_based_options_set_top_level_index_pinning_tier(
            arg0,
            arg1,
        );
    }

    pub fn setPartitionPinningTier(
        arg0: [*c]api.rocksdb_block_based_table_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_block_based_options_set_partition_pinning_tier(arg0, arg1);
    }

    pub fn setUnpartitionedPinningTier(
        arg0: [*c]api.rocksdb_block_based_table_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_block_based_options_set_unpartitioned_pinning_tier(arg0, arg1);
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
        api.rocksdb_cache_create_lru(capacity);
    }

    pub fn createLruWithStrictCapacityLimit(capacity: i64) [*c]api.rocksdb_cache_t {
        api.rocksdb_cache_create_lru_with_strict_capacity_limit(capacity);
    }

    pub fn createLruOpts(
        arg0: [*c]const api.rocksdb_lru_cache_options_t,
    ) [*c]api.rocksdb_cache_t {
        api.rocksdb_cache_create_lru_opts(arg0);
    }

    pub fn destroy(cache: [*c]api.rocksdb_cache_t) void {
        api.rocksdb_cache_destroy(cache);
    }

    pub fn disownData(cache: [*c]api.rocksdb_cache_t) void {
        api.rocksdb_cache_disown_data(cache);
    }

    pub fn setCapacity(cache: [*c]api.rocksdb_cache_t, capacity: i64) void {
        api.rocksdb_cache_set_capacity(cache, capacity);
    }

    pub fn getCapacity(cache: [*c]const api.rocksdb_cache_t) i64 {
        api.rocksdb_cache_get_capacity(cache);
    }

    pub fn getUsage(cache: [*c]const api.rocksdb_cache_t) i64 {
        api.rocksdb_cache_get_usage(cache);
    }

    pub fn getPinnedUsage(cache: [*c]const api.rocksdb_cache_t) i64 {
        api.rocksdb_cache_get_pinned_usage(cache);
    }

    pub fn getTableAddressCount(cache: [*c]const api.rocksdb_cache_t) i64 {
        api.rocksdb_cache_get_table_address_count(cache);
    }

    pub fn getOccupancyCount(cache: [*c]const api.rocksdb_cache_t) i64 {
        api.rocksdb_cache_get_occupancy_count(cache);
    }

    pub fn createHyperClock(
        capacity: i64,
        estimated_entry_charge: i64,
    ) [*c]api.rocksdb_cache_t {
        api.rocksdb_cache_create_hyper_clock(capacity, estimated_entry_charge);
    }

    pub fn createHyperClockOpts(
        arg0: [*c]const api.rocksdb_hyper_clock_cache_options_t,
    ) [*c]api.rocksdb_cache_t {
        api.rocksdb_cache_create_hyper_clock_opts(arg0);
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
        db: [*c]api.rocksdb_t,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_checkpoint_t {
        api.rocksdb_checkpoint_object_create(db, errptr);
    }

    pub fn create(
        checkpoint: [*c]api.rocksdb_checkpoint_t,
        checkpoint_dir: [*c]const i8,
        log_size_for_flush: i64,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_checkpoint_create(
            checkpoint,
            checkpoint_dir,
            log_size_for_flush,
            errptr,
        );
    }

    pub fn exportColumnFamily(
        checkpoint: [*c]api.rocksdb_checkpoint_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        export_dir: [*c]const i8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_export_import_files_metadata_t {
        api.rocksdb_checkpoint_export_column_family(
            checkpoint,
            column_family,
            export_dir,
            errptr,
        );
    }

    pub fn objectDestroy(checkpoint: [*c]api.rocksdb_checkpoint_t) void {
        api.rocksdb_checkpoint_object_destroy(checkpoint);
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

    pub fn destroy(arg0: [*c]api.rocksdb_column_family_handle_t) void {
        api.rocksdb_column_family_handle_destroy(arg0);
    }

    pub fn getId(handle: [*c]api.rocksdb_column_family_handle_t) i64 {
        api.rocksdb_column_family_handle_get_id(handle);
    }

    pub fn getName(
        handle: [*c]api.rocksdb_column_family_handle_t,
        name_len: [*c]i64,
    ) [*c]i8 {
        api.rocksdb_column_family_handle_get_name(handle, name_len);
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

    pub fn destroy(cf_meta: [*c]api.rocksdb_column_family_metadata_t) void {
        api.rocksdb_column_family_metadata_destroy(cf_meta);
    }

    pub fn getSize(cf_meta: [*c]api.rocksdb_column_family_metadata_t) i64 {
        api.rocksdb_column_family_metadata_get_size(cf_meta);
    }

    pub fn getFileCount(cf_meta: [*c]api.rocksdb_column_family_metadata_t) i64 {
        api.rocksdb_column_family_metadata_get_file_count(cf_meta);
    }

    pub fn getName(cf_meta: [*c]api.rocksdb_column_family_metadata_t) [*c]i8 {
        api.rocksdb_column_family_metadata_get_name(cf_meta);
    }

    pub fn getLevelCount(cf_meta: [*c]api.rocksdb_column_family_metadata_t) i64 {
        api.rocksdb_column_family_metadata_get_level_count(cf_meta);
    }

    pub fn getLevelMetadata(
        cf_meta: [*c]api.rocksdb_column_family_metadata_t,
        i: i64,
    ) [*c]api.rocksdb_level_metadata_t {
        api.rocksdb_column_family_metadata_get_level_metadata(cf_meta, i);
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
        api.rocksdb_compactionfilter_create(state, destructor, filter, name);
    }

    pub fn setIgnoreSnapshots(
        arg0: [*c]api.rocksdb_compactionfilter_t,
        arg1: u8,
    ) void {
        api.rocksdb_compactionfilter_set_ignore_snapshots(arg0, arg1);
    }

    pub fn destroy(arg0: [*c]api.rocksdb_compactionfilter_t) void {
        api.rocksdb_compactionfilter_destroy(arg0);
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

    pub fn fullCompaction(context: [*c]api.rocksdb_compactionfiltercontext_t) u8 {
        api.rocksdb_compactionfiltercontext_is_full_compaction(context);
    }

    pub fn manualCompaction(context: [*c]api.rocksdb_compactionfiltercontext_t) u8 {
        api.rocksdb_compactionfiltercontext_is_manual_compaction(context);
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
        api.rocksdb_compactionfilterfactory_create(
            state,
            destructor,
            create_compaction_filter,
            name,
        );
    }

    pub fn destroy(arg0: [*c]api.rocksdb_compactionfilterfactory_t) void {
        api.rocksdb_compactionfilterfactory_destroy(arg0);
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

    pub fn status(
        info: [*c]const api.rocksdb_compactionjobinfo_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_compactionjobinfo_status(info, errptr);
    }

    pub fn cfName(
        arg0: [*c]const api.rocksdb_compactionjobinfo_t,
        arg1: [*c]i64,
    ) [*c]const i8 {
        api.rocksdb_compactionjobinfo_cf_name(arg0, arg1);
    }

    pub fn inputFilesCount(arg0: [*c]const api.rocksdb_compactionjobinfo_t) i64 {
        api.rocksdb_compactionjobinfo_input_files_count(arg0);
    }

    pub fn inputFileAt(
        arg0: [*c]const api.rocksdb_compactionjobinfo_t,
        pos: i64,
        arg2: [*c]i64,
    ) [*c]const i8 {
        api.rocksdb_compactionjobinfo_input_file_at(arg0, pos, arg2);
    }

    pub fn outputFilesCount(arg0: [*c]const api.rocksdb_compactionjobinfo_t) i64 {
        api.rocksdb_compactionjobinfo_output_files_count(arg0);
    }

    pub fn outputFileAt(
        arg0: [*c]const api.rocksdb_compactionjobinfo_t,
        pos: i64,
        arg2: [*c]i64,
    ) [*c]const i8 {
        api.rocksdb_compactionjobinfo_output_file_at(arg0, pos, arg2);
    }

    pub fn elapsedMicros(arg0: [*c]const api.rocksdb_compactionjobinfo_t) i64 {
        api.rocksdb_compactionjobinfo_elapsed_micros(arg0);
    }

    pub fn numCorruptKeys(arg0: [*c]const api.rocksdb_compactionjobinfo_t) i64 {
        api.rocksdb_compactionjobinfo_num_corrupt_keys(arg0);
    }

    pub fn baseInputLevel(arg0: [*c]const api.rocksdb_compactionjobinfo_t) i64 {
        api.rocksdb_compactionjobinfo_base_input_level(arg0);
    }

    pub fn outputLevel(arg0: [*c]const api.rocksdb_compactionjobinfo_t) i64 {
        api.rocksdb_compactionjobinfo_output_level(arg0);
    }

    pub fn inputRecords(arg0: [*c]const api.rocksdb_compactionjobinfo_t) i64 {
        api.rocksdb_compactionjobinfo_input_records(arg0);
    }

    pub fn outputRecords(arg0: [*c]const api.rocksdb_compactionjobinfo_t) i64 {
        api.rocksdb_compactionjobinfo_output_records(arg0);
    }

    pub fn totalInputBytes(arg0: [*c]const api.rocksdb_compactionjobinfo_t) i64 {
        api.rocksdb_compactionjobinfo_total_input_bytes(arg0);
    }

    pub fn totalOutputBytes(arg0: [*c]const api.rocksdb_compactionjobinfo_t) i64 {
        api.rocksdb_compactionjobinfo_total_output_bytes(arg0);
    }

    pub fn compactionReason(info: [*c]const api.rocksdb_compactionjobinfo_t) i64 {
        api.rocksdb_compactionjobinfo_compaction_reason(info);
    }

    pub fn numInputFiles(info: [*c]const api.rocksdb_compactionjobinfo_t) i64 {
        api.rocksdb_compactionjobinfo_num_input_files(info);
    }

    pub fn numInputFilesAtOutputLevel(
        info: [*c]const api.rocksdb_compactionjobinfo_t,
    ) i64 {
        api.rocksdb_compactionjobinfo_num_input_files_at_output_level(info);
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
        api.rocksdb_compactoptions_create();
    }

    pub fn destroy(arg0: [*c]api.rocksdb_compactoptions_t) void {
        api.rocksdb_compactoptions_destroy(arg0);
    }

    pub fn setExclusiveManualCompaction(
        arg0: [*c]api.rocksdb_compactoptions_t,
        arg1: u8,
    ) void {
        api.rocksdb_compactoptions_set_exclusive_manual_compaction(arg0, arg1);
    }

    pub fn getExclusiveManualCompaction(arg0: [*c]api.rocksdb_compactoptions_t) u8 {
        api.rocksdb_compactoptions_get_exclusive_manual_compaction(arg0);
    }

    pub fn setBottommostLevelCompaction(
        arg0: [*c]api.rocksdb_compactoptions_t,
        arg1: u8,
    ) void {
        api.rocksdb_compactoptions_set_bottommost_level_compaction(arg0, arg1);
    }

    pub fn getBottommostLevelCompaction(arg0: [*c]api.rocksdb_compactoptions_t) u8 {
        api.rocksdb_compactoptions_get_bottommost_level_compaction(arg0);
    }

    pub fn setChangeLevel(arg0: [*c]api.rocksdb_compactoptions_t, arg1: u8) void {
        api.rocksdb_compactoptions_set_change_level(arg0, arg1);
    }

    pub fn getChangeLevel(arg0: [*c]api.rocksdb_compactoptions_t) u8 {
        api.rocksdb_compactoptions_get_change_level(arg0);
    }

    pub fn setTargetLevel(arg0: [*c]api.rocksdb_compactoptions_t, arg1: i64) void {
        api.rocksdb_compactoptions_set_target_level(arg0, arg1);
    }

    pub fn getTargetLevel(arg0: [*c]api.rocksdb_compactoptions_t) i64 {
        api.rocksdb_compactoptions_get_target_level(arg0);
    }

    pub fn setTargetPathId(arg0: [*c]api.rocksdb_compactoptions_t, arg1: i64) void {
        api.rocksdb_compactoptions_set_target_path_id(arg0, arg1);
    }

    pub fn getTargetPathId(arg0: [*c]api.rocksdb_compactoptions_t) i64 {
        api.rocksdb_compactoptions_get_target_path_id(arg0);
    }

    pub fn setAllowWriteStall(
        arg0: [*c]api.rocksdb_compactoptions_t,
        arg1: u8,
    ) void {
        api.rocksdb_compactoptions_set_allow_write_stall(arg0, arg1);
    }

    pub fn getAllowWriteStall(arg0: [*c]api.rocksdb_compactoptions_t) u8 {
        api.rocksdb_compactoptions_get_allow_write_stall(arg0);
    }

    pub fn setMaxSubcompactions(
        arg0: [*c]api.rocksdb_compactoptions_t,
        arg1: i64,
    ) void {
        api.rocksdb_compactoptions_set_max_subcompactions(arg0, arg1);
    }

    pub fn getMaxSubcompactions(arg0: [*c]api.rocksdb_compactoptions_t) i64 {
        api.rocksdb_compactoptions_get_max_subcompactions(arg0);
    }

    pub fn setFullHistoryTsLow(
        arg0: [*c]api.rocksdb_compactoptions_t,
        ts: []u8,
    ) void {
        api.rocksdb_compactoptions_set_full_history_ts_low(
            arg0,
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
        api.rocksdb_comparator_create(state, destructor, compare, name);
    }

    pub fn destroy(arg0: [*c]api.rocksdb_comparator_t) void {
        api.rocksdb_comparator_destroy(arg0);
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
        api.rocksdb_comparator_with_ts_create(
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
        api.rocksdb_cuckoo_options_create();
    }

    pub fn destroy(options: [*c]api.rocksdb_cuckoo_table_options_t) void {
        api.rocksdb_cuckoo_options_destroy(options);
    }

    pub fn setHashRatio(
        options: [*c]api.rocksdb_cuckoo_table_options_t,
        v: f64,
    ) void {
        api.rocksdb_cuckoo_options_set_hash_ratio(options, v);
    }

    pub fn setMaxSearchDepth(
        options: [*c]api.rocksdb_cuckoo_table_options_t,
        v: i64,
    ) void {
        api.rocksdb_cuckoo_options_set_max_search_depth(options, v);
    }

    pub fn setCuckooBlockSize(
        options: [*c]api.rocksdb_cuckoo_table_options_t,
        v: i64,
    ) void {
        api.rocksdb_cuckoo_options_set_cuckoo_block_size(options, v);
    }

    pub fn setIdentityAsFirstHash(
        options: [*c]api.rocksdb_cuckoo_table_options_t,
        v: u8,
    ) void {
        api.rocksdb_cuckoo_options_set_identity_as_first_hash(options, v);
    }

    pub fn setUseModuleHash(
        options: [*c]api.rocksdb_cuckoo_table_options_t,
        v: u8,
    ) void {
        api.rocksdb_cuckoo_options_set_use_module_hash(options, v);
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
        api.rocksdb_dbpath_create(path, target_size);
    }

    pub fn destroy(arg0: [*c]api.rocksdb_dbpath_t) void {
        api.rocksdb_dbpath_destroy(arg0);
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
        api.rocksdb_create_default_env();
    }

    pub fn createMemEnv() [*c]api.rocksdb_env_t {
        api.rocksdb_create_mem_env();
    }

    pub fn setBackgroundThreads(env: [*c]api.rocksdb_env_t, n: i64) void {
        api.rocksdb_env_set_background_threads(env, n);
    }

    pub fn getBackgroundThreads(env: [*c]api.rocksdb_env_t) i64 {
        api.rocksdb_env_get_background_threads(env);
    }

    pub fn setHighPriorityBackgroundThreads(
        env: [*c]api.rocksdb_env_t,
        n: i64,
    ) void {
        api.rocksdb_env_set_high_priority_background_threads(env, n);
    }

    pub fn getHighPriorityBackgroundThreads(env: [*c]api.rocksdb_env_t) i64 {
        api.rocksdb_env_get_high_priority_background_threads(env);
    }

    pub fn setLowPriorityBackgroundThreads(env: [*c]api.rocksdb_env_t, n: i64) void {
        api.rocksdb_env_set_low_priority_background_threads(env, n);
    }

    pub fn getLowPriorityBackgroundThreads(env: [*c]api.rocksdb_env_t) i64 {
        api.rocksdb_env_get_low_priority_background_threads(env);
    }

    pub fn setBottomPriorityBackgroundThreads(
        env: [*c]api.rocksdb_env_t,
        n: i64,
    ) void {
        api.rocksdb_env_set_bottom_priority_background_threads(env, n);
    }

    pub fn getBottomPriorityBackgroundThreads(env: [*c]api.rocksdb_env_t) i64 {
        api.rocksdb_env_get_bottom_priority_background_threads(env);
    }

    pub fn joinAllThreads(env: [*c]api.rocksdb_env_t) void {
        api.rocksdb_env_join_all_threads(env);
    }

    pub fn lowerThreadPoolIoPriority(env: [*c]api.rocksdb_env_t) void {
        api.rocksdb_env_lower_thread_pool_io_priority(env);
    }

    pub fn lowerHighPriorityThreadPoolIoPriority(env: [*c]api.rocksdb_env_t) void {
        api.rocksdb_env_lower_high_priority_thread_pool_io_priority(env);
    }

    pub fn lowerThreadPoolCpuPriority(env: [*c]api.rocksdb_env_t) void {
        api.rocksdb_env_lower_thread_pool_cpu_priority(env);
    }

    pub fn lowerHighPriorityThreadPoolCpuPriority(env: [*c]api.rocksdb_env_t) void {
        api.rocksdb_env_lower_high_priority_thread_pool_cpu_priority(env);
    }

    pub fn destroy(arg0: [*c]api.rocksdb_env_t) void {
        api.rocksdb_env_destroy(arg0);
    }

    pub fn createDirIfMissing(
        env: [*c]api.rocksdb_env_t,
        path: [*c]const i8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_create_dir_if_missing(env, path, errptr);
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
        api.rocksdb_envoptions_create();
    }

    pub fn destroy(opt: [*c]api.rocksdb_envoptions_t) void {
        api.rocksdb_envoptions_destroy(opt);
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
        api.rocksdb_eventlistener_create(
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

    pub fn destroy(arg0: [*c]api.rocksdb_eventlistener_t) void {
        api.rocksdb_eventlistener_destroy(arg0);
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
        api.rocksdb_export_import_files_metadata_create();
    }

    pub fn getDbComparatorName(
        arg0: [*c]api.rocksdb_export_import_files_metadata_t,
    ) [*c]i8 {
        api.rocksdb_export_import_files_metadata_get_db_comparator_name(arg0);
    }

    pub fn setDbComparatorName(
        arg0: [*c]api.rocksdb_export_import_files_metadata_t,
        arg1: [*c]const i8,
    ) void {
        api.rocksdb_export_import_files_metadata_set_db_comparator_name(arg0, arg1);
    }

    pub fn getFiles(
        arg0: [*c]api.rocksdb_export_import_files_metadata_t,
    ) [*c]api.rocksdb_livefiles_t {
        api.rocksdb_export_import_files_metadata_get_files(arg0);
    }

    pub fn setFiles(
        arg0: [*c]api.rocksdb_export_import_files_metadata_t,
        arg1: [*c]api.rocksdb_livefiles_t,
    ) void {
        api.rocksdb_export_import_files_metadata_set_files(arg0, arg1);
    }

    pub fn destroy(arg0: [*c]api.rocksdb_export_import_files_metadata_t) void {
        api.rocksdb_export_import_files_metadata_destroy(arg0);
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

    pub fn cfName(
        arg0: [*c]const api.rocksdb_externalfileingestioninfo_t,
        arg1: [*c]i64,
    ) [*c]const i8 {
        api.rocksdb_externalfileingestioninfo_cf_name(arg0, arg1);
    }

    pub fn internalFilePath(
        arg0: [*c]const api.rocksdb_externalfileingestioninfo_t,
        arg1: [*c]i64,
    ) [*c]const i8 {
        api.rocksdb_externalfileingestioninfo_internal_file_path(arg0, arg1);
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
        api.rocksdb_fifo_compaction_options_create();
    }

    pub fn setAllowCompaction(
        fifo_opts: [*c]api.rocksdb_fifo_compaction_options_t,
        allow_compaction: u8,
    ) void {
        api.rocksdb_fifo_compaction_options_set_allow_compaction(
            fifo_opts,
            allow_compaction,
        );
    }

    pub fn getAllowCompaction(
        fifo_opts: [*c]api.rocksdb_fifo_compaction_options_t,
    ) u8 {
        api.rocksdb_fifo_compaction_options_get_allow_compaction(fifo_opts);
    }

    pub fn setMaxTableFilesSize(
        fifo_opts: [*c]api.rocksdb_fifo_compaction_options_t,
        size: i64,
    ) void {
        api.rocksdb_fifo_compaction_options_set_max_table_files_size(
            fifo_opts,
            size,
        );
    }

    pub fn getMaxTableFilesSize(
        fifo_opts: [*c]api.rocksdb_fifo_compaction_options_t,
    ) i64 {
        api.rocksdb_fifo_compaction_options_get_max_table_files_size(fifo_opts);
    }

    pub fn destroy(fifo_opts: [*c]api.rocksdb_fifo_compaction_options_t) void {
        api.rocksdb_fifo_compaction_options_destroy(fifo_opts);
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

    pub fn destroy(arg0: [*c]api.rocksdb_filterpolicy_t) void {
        api.rocksdb_filterpolicy_destroy(arg0);
    }

    pub fn createBloom(bits_per_key: f64) [*c]api.rocksdb_filterpolicy_t {
        api.rocksdb_filterpolicy_create_bloom(bits_per_key);
    }

    pub fn createBloomFull(bits_per_key: f64) [*c]api.rocksdb_filterpolicy_t {
        api.rocksdb_filterpolicy_create_bloom_full(bits_per_key);
    }

    pub fn createRibbon(
        bloom_equivalent_bits_per_key: f64,
    ) [*c]api.rocksdb_filterpolicy_t {
        api.rocksdb_filterpolicy_create_ribbon(bloom_equivalent_bits_per_key);
    }

    pub fn createRibbonHybrid(
        bloom_equivalent_bits_per_key: f64,
        bloom_before_level: i64,
    ) [*c]api.rocksdb_filterpolicy_t {
        api.rocksdb_filterpolicy_create_ribbon_hybrid(
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

    pub fn cfName(
        arg0: [*c]const api.rocksdb_flushjobinfo_t,
        arg1: [*c]i64,
    ) [*c]const i8 {
        api.rocksdb_flushjobinfo_cf_name(arg0, arg1);
    }

    pub fn filePath(
        arg0: [*c]const api.rocksdb_flushjobinfo_t,
        arg1: [*c]i64,
    ) [*c]const i8 {
        api.rocksdb_flushjobinfo_file_path(arg0, arg1);
    }

    pub fn triggeredWritesSlowdown(arg0: [*c]const api.rocksdb_flushjobinfo_t) u8 {
        api.rocksdb_flushjobinfo_triggered_writes_slowdown(arg0);
    }

    pub fn triggeredWritesStop(arg0: [*c]const api.rocksdb_flushjobinfo_t) u8 {
        api.rocksdb_flushjobinfo_triggered_writes_stop(arg0);
    }

    pub fn largestSeqno(arg0: [*c]const api.rocksdb_flushjobinfo_t) i64 {
        api.rocksdb_flushjobinfo_largest_seqno(arg0);
    }

    pub fn smallestSeqno(arg0: [*c]const api.rocksdb_flushjobinfo_t) i64 {
        api.rocksdb_flushjobinfo_smallest_seqno(arg0);
    }

    pub fn flushReason(info: [*c]const api.rocksdb_flushjobinfo_t) i64 {
        api.rocksdb_flushjobinfo_flush_reason(info);
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
        api.rocksdb_flushoptions_create();
    }

    pub fn destroy(arg0: [*c]api.rocksdb_flushoptions_t) void {
        api.rocksdb_flushoptions_destroy(arg0);
    }

    pub fn setWait(arg0: [*c]api.rocksdb_flushoptions_t, arg1: u8) void {
        api.rocksdb_flushoptions_set_wait(arg0, arg1);
    }

    pub fn getWait(arg0: [*c]api.rocksdb_flushoptions_t) u8 {
        api.rocksdb_flushoptions_get_wait(arg0);
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
        api.rocksdb_hyper_clock_cache_options_create(
            capacity,
            estimated_entry_charge,
        );
    }

    pub fn destroy(arg0: [*c]api.rocksdb_hyper_clock_cache_options_t) void {
        api.rocksdb_hyper_clock_cache_options_destroy(arg0);
    }

    pub fn setCapacity(
        arg0: [*c]api.rocksdb_hyper_clock_cache_options_t,
        size_t: i64,
    ) void {
        api.rocksdb_hyper_clock_cache_options_set_capacity(arg0, size_t);
    }

    pub fn setEstimatedEntryCharge(
        arg0: [*c]api.rocksdb_hyper_clock_cache_options_t,
        size_t: i64,
    ) void {
        api.rocksdb_hyper_clock_cache_options_set_estimated_entry_charge(
            arg0,
            size_t,
        );
    }

    pub fn setNumShardBits(
        arg0: [*c]api.rocksdb_hyper_clock_cache_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_hyper_clock_cache_options_set_num_shard_bits(arg0, arg1);
    }

    pub fn setMemoryAllocator(
        arg0: [*c]api.rocksdb_hyper_clock_cache_options_t,
        arg1: [*c]api.rocksdb_memory_allocator_t,
    ) void {
        api.rocksdb_hyper_clock_cache_options_set_memory_allocator(arg0, arg1);
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
        api.rocksdb_import_column_family_options_create();
    }

    pub fn setMoveFiles(
        arg0: [*c]api.rocksdb_import_column_family_options_t,
        arg1: u8,
    ) void {
        api.rocksdb_import_column_family_options_set_move_files(arg0, arg1);
    }

    pub fn destroy(arg0: [*c]api.rocksdb_import_column_family_options_t) void {
        api.rocksdb_import_column_family_options_destroy(arg0);
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
        api.rocksdb_ingestexternalfileoptions_create();
    }

    pub fn setMoveFiles(
        opt: [*c]api.rocksdb_ingestexternalfileoptions_t,
        move_files: u8,
    ) void {
        api.rocksdb_ingestexternalfileoptions_set_move_files(opt, move_files);
    }

    pub fn setSnapshotConsistency(
        opt: [*c]api.rocksdb_ingestexternalfileoptions_t,
        snapshot_consistency: u8,
    ) void {
        api.rocksdb_ingestexternalfileoptions_set_snapshot_consistency(
            opt,
            snapshot_consistency,
        );
    }

    pub fn setAllowGlobalSeqno(
        opt: [*c]api.rocksdb_ingestexternalfileoptions_t,
        allow_global_seqno: u8,
    ) void {
        api.rocksdb_ingestexternalfileoptions_set_allow_global_seqno(
            opt,
            allow_global_seqno,
        );
    }

    pub fn setAllowBlockingFlush(
        opt: [*c]api.rocksdb_ingestexternalfileoptions_t,
        allow_blocking_flush: u8,
    ) void {
        api.rocksdb_ingestexternalfileoptions_set_allow_blocking_flush(
            opt,
            allow_blocking_flush,
        );
    }

    pub fn setIngestBehind(
        opt: [*c]api.rocksdb_ingestexternalfileoptions_t,
        ingest_behind: u8,
    ) void {
        api.rocksdb_ingestexternalfileoptions_set_ingest_behind(opt, ingest_behind);
    }

    pub fn setFailIfNotBottommostLevel(
        opt: [*c]api.rocksdb_ingestexternalfileoptions_t,
        fail_if_not_bottommost_level: u8,
    ) void {
        api.rocksdb_ingestexternalfileoptions_set_fail_if_not_bottommost_level(
            opt,
            fail_if_not_bottommost_level,
        );
    }

    pub fn destroy(opt: [*c]api.rocksdb_ingestexternalfileoptions_t) void {
        api.rocksdb_ingestexternalfileoptions_destroy(opt);
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

    pub fn destroy(arg0: [*c]api.rocksdb_iterator_t) void {
        api.rocksdb_iter_destroy(arg0);
    }

    pub fn valid(arg0: [*c]const api.rocksdb_iterator_t) u8 {
        api.rocksdb_iter_valid(arg0);
    }

    pub fn seekToFirst(arg0: [*c]api.rocksdb_iterator_t) void {
        api.rocksdb_iter_seek_to_first(arg0);
    }

    pub fn seekToLast(arg0: [*c]api.rocksdb_iterator_t) void {
        api.rocksdb_iter_seek_to_last(arg0);
    }

    pub fn seek(arg0: [*c]api.rocksdb_iterator_t, k: []const u8) void {
        api.rocksdb_iter_seek(arg0, @ptrCast(k.ptr), @intCast(k.len));
    }

    pub fn seekForPrev(arg0: [*c]api.rocksdb_iterator_t, k: []const u8) void {
        api.rocksdb_iter_seek_for_prev(arg0, @ptrCast(k.ptr), @intCast(k.len));
    }

    pub fn next(arg0: [*c]api.rocksdb_iterator_t) void {
        api.rocksdb_iter_next(arg0);
    }

    pub fn prev(arg0: [*c]api.rocksdb_iterator_t) void {
        api.rocksdb_iter_prev(arg0);
    }

    pub fn key(arg0: [*c]const api.rocksdb_iterator_t, klen: [*c]i64) [*c]const i8 {
        api.rocksdb_iter_key(arg0, klen);
    }

    pub fn value(
        arg0: [*c]const api.rocksdb_iterator_t,
        vlen: [*c]i64,
    ) [*c]const i8 {
        api.rocksdb_iter_value(arg0, vlen);
    }

    pub fn timestamp(
        arg0: [*c]const api.rocksdb_iterator_t,
        tslen: [*c]i64,
    ) [*c]const i8 {
        api.rocksdb_iter_timestamp(arg0, tslen);
    }

    pub fn getError(
        arg0: [*c]const api.rocksdb_iterator_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_iter_get_error(arg0, errptr);
    }

    pub fn refresh(iter: [*c]const api.rocksdb_iterator_t, errptr: [*c][*c]i8) void {
        api.rocksdb_iter_refresh(iter, errptr);
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

    pub fn destroy(level_meta: [*c]api.rocksdb_level_metadata_t) void {
        api.rocksdb_level_metadata_destroy(level_meta);
    }

    pub fn getLevel(level_meta: [*c]api.rocksdb_level_metadata_t) i64 {
        api.rocksdb_level_metadata_get_level(level_meta);
    }

    pub fn getSize(level_meta: [*c]api.rocksdb_level_metadata_t) i64 {
        api.rocksdb_level_metadata_get_size(level_meta);
    }

    pub fn getFileCount(level_meta: [*c]api.rocksdb_level_metadata_t) i64 {
        api.rocksdb_level_metadata_get_file_count(level_meta);
    }

    pub fn getSstFileMetadata(
        level_meta: [*c]api.rocksdb_level_metadata_t,
        i: i64,
    ) [*c]api.rocksdb_sst_file_metadata_t {
        api.rocksdb_level_metadata_get_sst_file_metadata(level_meta, i);
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
        api.rocksdb_livefile_create();
    }

    pub fn setColumnFamilyName(
        arg0: [*c]api.rocksdb_livefile_t,
        arg1: [*c]const i8,
    ) void {
        api.rocksdb_livefile_set_column_family_name(arg0, arg1);
    }

    pub fn setLevel(arg0: [*c]api.rocksdb_livefile_t, arg1: i64) void {
        api.rocksdb_livefile_set_level(arg0, arg1);
    }

    pub fn setName(arg0: [*c]api.rocksdb_livefile_t, arg1: [*c]const i8) void {
        api.rocksdb_livefile_set_name(arg0, arg1);
    }

    pub fn setDirectory(arg0: [*c]api.rocksdb_livefile_t, arg1: [*c]const i8) void {
        api.rocksdb_livefile_set_directory(arg0, arg1);
    }

    pub fn setSize(arg0: [*c]api.rocksdb_livefile_t, size_t: i64) void {
        api.rocksdb_livefile_set_size(arg0, size_t);
    }

    pub fn setSmallestKey(
        arg0: [*c]api.rocksdb_livefile_t,
        arg1: [*c]const i8,
        size_t: i64,
    ) void {
        api.rocksdb_livefile_set_smallest_key(arg0, arg1, size_t);
    }

    pub fn setLargestKey(
        arg0: [*c]api.rocksdb_livefile_t,
        arg1: [*c]const i8,
        size_t: i64,
    ) void {
        api.rocksdb_livefile_set_largest_key(arg0, arg1, size_t);
    }

    pub fn setSmallestSeqno(arg0: [*c]api.rocksdb_livefile_t, uint64_t: i64) void {
        api.rocksdb_livefile_set_smallest_seqno(arg0, uint64_t);
    }

    pub fn setLargestSeqno(arg0: [*c]api.rocksdb_livefile_t, uint64_t: i64) void {
        api.rocksdb_livefile_set_largest_seqno(arg0, uint64_t);
    }

    pub fn setNumEntries(arg0: [*c]api.rocksdb_livefile_t, uint64_t: i64) void {
        api.rocksdb_livefile_set_num_entries(arg0, uint64_t);
    }

    pub fn setNumDeletions(arg0: [*c]api.rocksdb_livefile_t, uint64_t: i64) void {
        api.rocksdb_livefile_set_num_deletions(arg0, uint64_t);
    }

    pub fn destroy(arg0: [*c]api.rocksdb_livefile_t) void {
        api.rocksdb_livefile_destroy(arg0);
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
        api.rocksdb_livefiles_create();
    }

    pub fn count(arg0: [*c]const api.rocksdb_livefiles_t) i64 {
        api.rocksdb_livefiles_count(arg0);
    }

    pub fn columnFamilyName(
        arg0: [*c]const api.rocksdb_livefiles_t,
        index: i64,
    ) [*c]const i8 {
        api.rocksdb_livefiles_column_family_name(arg0, index);
    }

    pub fn name(arg0: [*c]const api.rocksdb_livefiles_t, index: i64) [*c]const i8 {
        api.rocksdb_livefiles_name(arg0, index);
    }

    pub fn directory(
        arg0: [*c]const api.rocksdb_livefiles_t,
        index: i64,
    ) [*c]const i8 {
        api.rocksdb_livefiles_directory(arg0, index);
    }

    pub fn level(arg0: [*c]const api.rocksdb_livefiles_t, index: i64) i64 {
        api.rocksdb_livefiles_level(arg0, index);
    }

    pub fn size(arg0: [*c]const api.rocksdb_livefiles_t, index: i64) i64 {
        api.rocksdb_livefiles_size(arg0, index);
    }

    pub fn smallestkey(
        arg0: [*c]const api.rocksdb_livefiles_t,
        index: i64,
        size_: [*c]i64,
    ) [*c]const i8 {
        api.rocksdb_livefiles_smallestkey(arg0, index, size_);
    }

    pub fn largestkey(
        arg0: [*c]const api.rocksdb_livefiles_t,
        index: i64,
        size_: [*c]i64,
    ) [*c]const i8 {
        api.rocksdb_livefiles_largestkey(arg0, index, size_);
    }

    pub fn smallestSeqno(arg0: [*c]const api.rocksdb_livefiles_t, index: i64) i64 {
        api.rocksdb_livefiles_smallest_seqno(arg0, index);
    }

    pub fn largestSeqno(arg0: [*c]const api.rocksdb_livefiles_t, index: i64) i64 {
        api.rocksdb_livefiles_largest_seqno(arg0, index);
    }

    pub fn entries(arg0: [*c]const api.rocksdb_livefiles_t, index: i64) i64 {
        api.rocksdb_livefiles_entries(arg0, index);
    }

    pub fn deletions(arg0: [*c]const api.rocksdb_livefiles_t, index: i64) i64 {
        api.rocksdb_livefiles_deletions(arg0, index);
    }

    pub fn destroy(arg0: [*c]const api.rocksdb_livefiles_t) void {
        api.rocksdb_livefiles_destroy(arg0);
    }

    pub fn add(
        arg0: [*c]api.rocksdb_livefiles_t,
        arg1: [*c]api.rocksdb_livefile_t,
    ) void {
        api.rocksdb_livefiles_add(arg0, arg1);
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
        api.rocksdb_logger_create_stderr_logger(log_level, prefix);
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
        api.rocksdb_logger_create_callback_logger(log_level, arg1, priv);
    }

    pub fn destroy(logger: [*c]api.rocksdb_logger_t) void {
        api.rocksdb_logger_destroy(logger);
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
        api.rocksdb_lru_cache_options_create();
    }

    pub fn destroy(arg0: [*c]api.rocksdb_lru_cache_options_t) void {
        api.rocksdb_lru_cache_options_destroy(arg0);
    }

    pub fn setCapacity(arg0: [*c]api.rocksdb_lru_cache_options_t, size_t: i64) void {
        api.rocksdb_lru_cache_options_set_capacity(arg0, size_t);
    }

    pub fn setNumShardBits(
        arg0: [*c]api.rocksdb_lru_cache_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_lru_cache_options_set_num_shard_bits(arg0, arg1);
    }

    pub fn setMemoryAllocator(
        arg0: [*c]api.rocksdb_lru_cache_options_t,
        arg1: [*c]api.rocksdb_memory_allocator_t,
    ) void {
        api.rocksdb_lru_cache_options_set_memory_allocator(arg0, arg1);
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
        api.rocksdb_jemalloc_nodump_allocator_create(errptr);
    }

    pub fn destroy(arg0: [*c]api.rocksdb_memory_allocator_t) void {
        api.rocksdb_memory_allocator_destroy(arg0);
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
        api.rocksdb_memory_consumers_create();
    }

    pub fn addDb(
        consumers: [*c]api.rocksdb_memory_consumers_t,
        db: [*c]api.rocksdb_t,
    ) void {
        api.rocksdb_memory_consumers_add_db(consumers, db);
    }

    pub fn addCache(
        consumers: [*c]api.rocksdb_memory_consumers_t,
        cache: [*c]api.rocksdb_cache_t,
    ) void {
        api.rocksdb_memory_consumers_add_cache(consumers, cache);
    }

    pub fn destroy(consumers: [*c]api.rocksdb_memory_consumers_t) void {
        api.rocksdb_memory_consumers_destroy(consumers);
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
        consumers: [*c]api.rocksdb_memory_consumers_t,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_memory_usage_t {
        api.rocksdb_approximate_memory_usage_create(consumers, errptr);
    }

    pub fn destroy(usage: [*c]api.rocksdb_memory_usage_t) void {
        api.rocksdb_approximate_memory_usage_destroy(usage);
    }

    pub fn getMemTableTotal(memory_usage: [*c]api.rocksdb_memory_usage_t) i64 {
        api.rocksdb_approximate_memory_usage_get_mem_table_total(memory_usage);
    }

    pub fn getMemTableUnflushed(memory_usage: [*c]api.rocksdb_memory_usage_t) i64 {
        api.rocksdb_approximate_memory_usage_get_mem_table_unflushed(memory_usage);
    }

    pub fn getMemTableReadersTotal(
        memory_usage: [*c]api.rocksdb_memory_usage_t,
    ) i64 {
        api.rocksdb_approximate_memory_usage_get_mem_table_readers_total(
            memory_usage,
        );
    }

    pub fn getCacheTotal(memory_usage: [*c]api.rocksdb_memory_usage_t) i64 {
        api.rocksdb_approximate_memory_usage_get_cache_total(memory_usage);
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

    pub fn cfName(
        arg0: [*c]const api.rocksdb_memtableinfo_t,
        arg1: [*c]i64,
    ) [*c]const i8 {
        api.rocksdb_memtableinfo_cf_name(arg0, arg1);
    }

    pub fn firstSeqno(arg0: [*c]const api.rocksdb_memtableinfo_t) i64 {
        api.rocksdb_memtableinfo_first_seqno(arg0);
    }

    pub fn earliestSeqno(arg0: [*c]const api.rocksdb_memtableinfo_t) i64 {
        api.rocksdb_memtableinfo_earliest_seqno(arg0);
    }

    pub fn numEntries(arg0: [*c]const api.rocksdb_memtableinfo_t) i64 {
        api.rocksdb_memtableinfo_num_entries(arg0);
    }

    pub fn numDeletes(arg0: [*c]const api.rocksdb_memtableinfo_t) i64 {
        api.rocksdb_memtableinfo_num_deletes(arg0);
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
        api.rocksdb_mergeoperator_create(
            state,
            destructor,
            full_merge,
            partial_merge,
            delete_value,
            name,
        );
    }

    pub fn destroy(arg0: [*c]api.rocksdb_mergeoperator_t) void {
        api.rocksdb_mergeoperator_destroy(arg0);
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
        api.rocksdb_optimistictransaction_options_create();
    }

    pub fn destroy(opt: [*c]api.rocksdb_optimistictransaction_options_t) void {
        api.rocksdb_optimistictransaction_options_destroy(opt);
    }

    pub fn setSetSnapshot(
        opt: [*c]api.rocksdb_optimistictransaction_options_t,
        v: u8,
    ) void {
        api.rocksdb_optimistictransaction_options_set_set_snapshot(opt, v);
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
        options: [*c]const api.rocksdb_options_t,
        name: [*c]const i8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_optimistictransactiondb_t {
        api.rocksdb_optimistictransactiondb_open(options, name, errptr);
    }

    pub fn openColumnFamilies(
        options: [*c]const api.rocksdb_options_t,
        name: [*c]const i8,
        num_column_families: i64,
        column_family_names: [*c]const [*c]const i8,
        column_family_options: [*c]const [*c]const api.rocksdb_options_t,
        column_family_handles: [*c][*c]api.rocksdb_column_family_handle_t,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_optimistictransactiondb_t {
        api.rocksdb_optimistictransactiondb_open_column_families(
            options,
            name,
            num_column_families,
            column_family_names,
            column_family_options,
            column_family_handles,
            errptr,
        );
    }

    pub fn getBaseDb(
        otxn_db: [*c]api.rocksdb_optimistictransactiondb_t,
    ) [*c]api.rocksdb_t {
        api.rocksdb_optimistictransactiondb_get_base_db(otxn_db);
    }

    pub fn write(
        otxn_db: [*c]api.rocksdb_optimistictransactiondb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        batch: [*c]api.rocksdb_writebatch_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_optimistictransactiondb_write(otxn_db, options, batch, errptr);
    }

    pub fn close(otxn_db: [*c]api.rocksdb_optimistictransactiondb_t) void {
        api.rocksdb_optimistictransactiondb_close(otxn_db);
    }

    pub fn checkpointObjectCreate(
        otxn_db: [*c]api.rocksdb_optimistictransactiondb_t,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_checkpoint_t {
        api.rocksdb_optimistictransactiondb_checkpoint_object_create(
            otxn_db,
            errptr,
        );
    }

    pub fn propertyValue(
        db: [*c]api.rocksdb_optimistictransactiondb_t,
        propname: [*c]const i8,
    ) [*c]i8 {
        api.rocksdb_optimistictransactiondb_property_value(db, propname);
    }

    pub fn propertyInt(
        db: [*c]api.rocksdb_optimistictransactiondb_t,
        propname: [*c]const i8,
        out_val: [*c]i64,
    ) i64 {
        api.rocksdb_optimistictransactiondb_property_int(db, propname, out_val);
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
        options: [*c]const api.rocksdb_options_t,
        name: [*c]const i8,
        lencf: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c][*c]i8 {
        api.rocksdb_list_column_families(options, name, lencf, errptr);
    }

    pub fn destroyDb(
        options: [*c]const api.rocksdb_options_t,
        name: [*c]const i8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_destroy_db(options, name, errptr);
    }

    pub fn repairDb(
        options: [*c]const api.rocksdb_options_t,
        name: [*c]const i8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_repair_db(options, name, errptr);
    }

    pub fn loadLatestOptionsDestroy(
        db_options: [*c]api.rocksdb_options_t,
        list_column_family_names: [*c][*c]i8,
        list_column_family_options: [*c][*c]api.rocksdb_options_t,
        len: i64,
    ) void {
        api.rocksdb_load_latest_options_destroy(
            db_options,
            list_column_family_names,
            list_column_family_options,
            len,
        );
    }

    pub fn setBlockBasedTableFactory(
        opt: [*c]api.rocksdb_options_t,
        table_options: [*c]api.rocksdb_block_based_table_options_t,
    ) void {
        api.rocksdb_options_set_block_based_table_factory(opt, table_options);
    }

    pub fn setWriteBufferManager(
        opt: [*c]api.rocksdb_options_t,
        wbm: [*c]api.rocksdb_write_buffer_manager_t,
    ) void {
        api.rocksdb_options_set_write_buffer_manager(opt, wbm);
    }

    pub fn setSstFileManager(
        opt: [*c]api.rocksdb_options_t,
        sfm: [*c]api.rocksdb_sst_file_manager_t,
    ) void {
        api.rocksdb_options_set_sst_file_manager(opt, sfm);
    }

    pub fn addEventlistener(
        arg0: [*c]api.rocksdb_options_t,
        arg1: [*c]api.rocksdb_eventlistener_t,
    ) void {
        api.rocksdb_options_add_eventlistener(arg0, arg1);
    }

    pub fn setCuckooTableFactory(
        opt: [*c]api.rocksdb_options_t,
        table_options: [*c]api.rocksdb_cuckoo_table_options_t,
    ) void {
        api.rocksdb_options_set_cuckoo_table_factory(opt, table_options);
    }

    pub fn create() [*c]api.rocksdb_options_t {
        api.rocksdb_options_create();
    }

    pub fn destroy(arg0: [*c]api.rocksdb_options_t) void {
        api.rocksdb_options_destroy(arg0);
    }

    pub fn createCopy(arg0: [*c]api.rocksdb_options_t) [*c]api.rocksdb_options_t {
        api.rocksdb_options_create_copy(arg0);
    }

    pub fn increaseParallelism(
        opt: [*c]api.rocksdb_options_t,
        total_threads: i64,
    ) void {
        api.rocksdb_options_increase_parallelism(opt, total_threads);
    }

    pub fn optimizeForPointLookup(
        opt: [*c]api.rocksdb_options_t,
        block_cache_size_mb: i64,
    ) void {
        api.rocksdb_options_optimize_for_point_lookup(opt, block_cache_size_mb);
    }

    pub fn optimizeLevelStyleCompaction(
        opt: [*c]api.rocksdb_options_t,
        memtable_memory_budget: i64,
    ) void {
        api.rocksdb_options_optimize_level_style_compaction(
            opt,
            memtable_memory_budget,
        );
    }

    pub fn optimizeUniversalStyleCompaction(
        opt: [*c]api.rocksdb_options_t,
        memtable_memory_budget: i64,
    ) void {
        api.rocksdb_options_optimize_universal_style_compaction(
            opt,
            memtable_memory_budget,
        );
    }

    pub fn setAllowIngestBehind(arg0: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_allow_ingest_behind(arg0, arg1);
    }

    pub fn getAllowIngestBehind(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_allow_ingest_behind(arg0);
    }

    pub fn setCompactionFilter(
        arg0: [*c]api.rocksdb_options_t,
        arg1: [*c]api.rocksdb_compactionfilter_t,
    ) void {
        api.rocksdb_options_set_compaction_filter(arg0, arg1);
    }

    pub fn setCompactionFilterFactory(
        arg0: [*c]api.rocksdb_options_t,
        arg1: [*c]api.rocksdb_compactionfilterfactory_t,
    ) void {
        api.rocksdb_options_set_compaction_filter_factory(arg0, arg1);
    }

    pub fn compactionReadaheadSize(
        arg0: [*c]api.rocksdb_options_t,
        size_t: i64,
    ) void {
        api.rocksdb_options_compaction_readahead_size(arg0, size_t);
    }

    pub fn getCompactionReadaheadSize(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_compaction_readahead_size(arg0);
    }

    pub fn setComparator(
        arg0: [*c]api.rocksdb_options_t,
        arg1: [*c]api.rocksdb_comparator_t,
    ) void {
        api.rocksdb_options_set_comparator(arg0, arg1);
    }

    pub fn setMergeOperator(
        arg0: [*c]api.rocksdb_options_t,
        arg1: [*c]api.rocksdb_mergeoperator_t,
    ) void {
        api.rocksdb_options_set_merge_operator(arg0, arg1);
    }

    pub fn setUint64AddMergeOperator(arg0: [*c]api.rocksdb_options_t) void {
        api.rocksdb_options_set_uint64add_merge_operator(arg0);
    }

    pub fn setCompressionPerLevel(
        opt: [*c]api.rocksdb_options_t,
        level_values: [*c]const i64,
        num_levels: i64,
    ) void {
        api.rocksdb_options_set_compression_per_level(
            opt,
            level_values,
            num_levels,
        );
    }

    pub fn setCreateIfMissing(arg0: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_create_if_missing(arg0, arg1);
    }

    pub fn getCreateIfMissing(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_create_if_missing(arg0);
    }

    pub fn setCreateMissingColumnFamilies(
        arg0: [*c]api.rocksdb_options_t,
        arg1: u8,
    ) void {
        api.rocksdb_options_set_create_missing_column_families(arg0, arg1);
    }

    pub fn getCreateMissingColumnFamilies(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_create_missing_column_families(arg0);
    }

    pub fn setErrorIfExists(arg0: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_error_if_exists(arg0, arg1);
    }

    pub fn getErrorIfExists(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_error_if_exists(arg0);
    }

    pub fn setParanoidChecks(arg0: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_paranoid_checks(arg0, arg1);
    }

    pub fn getParanoidChecks(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_paranoid_checks(arg0);
    }

    pub fn setDbPaths(
        arg0: [*c]api.rocksdb_options_t,
        path_values: [*c][*c]const api.rocksdb_dbpath_t,
        num_paths: i64,
    ) void {
        api.rocksdb_options_set_db_paths(arg0, path_values, num_paths);
    }

    pub fn setCfPaths(
        arg0: [*c]api.rocksdb_options_t,
        path_values: [*c][*c]const api.rocksdb_dbpath_t,
        num_paths: i64,
    ) void {
        api.rocksdb_options_set_cf_paths(arg0, path_values, num_paths);
    }

    pub fn setEnv(
        arg0: [*c]api.rocksdb_options_t,
        arg1: [*c]api.rocksdb_env_t,
    ) void {
        api.rocksdb_options_set_env(arg0, arg1);
    }

    pub fn setInfoLog(
        arg0: [*c]api.rocksdb_options_t,
        arg1: [*c]api.rocksdb_logger_t,
    ) void {
        api.rocksdb_options_set_info_log(arg0, arg1);
    }

    pub fn getInfoLog(opt: [*c]api.rocksdb_options_t) [*c]api.rocksdb_logger_t {
        api.rocksdb_options_get_info_log(opt);
    }

    pub fn setInfoLogLevel(arg0: [*c]api.rocksdb_options_t, arg1: i64) void {
        api.rocksdb_options_set_info_log_level(arg0, arg1);
    }

    pub fn getInfoLogLevel(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_info_log_level(arg0);
    }

    pub fn setWriteBufferSize(arg0: [*c]api.rocksdb_options_t, size_t: i64) void {
        api.rocksdb_options_set_write_buffer_size(arg0, size_t);
    }

    pub fn getWriteBufferSize(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_write_buffer_size(arg0);
    }

    pub fn setDbWriteBufferSize(arg0: [*c]api.rocksdb_options_t, size_t: i64) void {
        api.rocksdb_options_set_db_write_buffer_size(arg0, size_t);
    }

    pub fn getDbWriteBufferSize(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_db_write_buffer_size(arg0);
    }

    pub fn setMaxOpenFiles(arg0: [*c]api.rocksdb_options_t, arg1: i64) void {
        api.rocksdb_options_set_max_open_files(arg0, arg1);
    }

    pub fn getMaxOpenFiles(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_max_open_files(arg0);
    }

    pub fn setMaxFileOpeningThreads(
        arg0: [*c]api.rocksdb_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_options_set_max_file_opening_threads(arg0, arg1);
    }

    pub fn getMaxFileOpeningThreads(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_max_file_opening_threads(arg0);
    }

    pub fn setMaxTotalWalSize(opt: [*c]api.rocksdb_options_t, n: i64) void {
        api.rocksdb_options_set_max_total_wal_size(opt, n);
    }

    pub fn getMaxTotalWalSize(opt: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_max_total_wal_size(opt);
    }

    pub fn setCompressionOptions(
        arg0: [*c]api.rocksdb_options_t,
        arg1: i64,
        arg2: i64,
        arg3: i64,
        arg4: i64,
    ) void {
        api.rocksdb_options_set_compression_options(arg0, arg1, arg2, arg3, arg4);
    }

    pub fn setCompressionOptionsZstdMaxTrainBytes(
        arg0: [*c]api.rocksdb_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_options_set_compression_options_zstd_max_train_bytes(
            arg0,
            arg1,
        );
    }

    pub fn getCompressionOptionsZstdMaxTrainBytes(
        opt: [*c]api.rocksdb_options_t,
    ) i64 {
        api.rocksdb_options_get_compression_options_zstd_max_train_bytes(opt);
    }

    pub fn setCompressionOptionsUseZstdDictTrainer(
        arg0: [*c]api.rocksdb_options_t,
        arg1: u8,
    ) void {
        api.rocksdb_options_set_compression_options_use_zstd_dict_trainer(
            arg0,
            arg1,
        );
    }

    pub fn getCompressionOptionsUseZstdDictTrainer(
        opt: [*c]api.rocksdb_options_t,
    ) u8 {
        api.rocksdb_options_get_compression_options_use_zstd_dict_trainer(opt);
    }

    pub fn setCompressionOptionsParallelThreads(
        arg0: [*c]api.rocksdb_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_options_set_compression_options_parallel_threads(arg0, arg1);
    }

    pub fn getCompressionOptionsParallelThreads(opt: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_compression_options_parallel_threads(opt);
    }

    pub fn setCompressionOptionsMaxDictBufferBytes(
        arg0: [*c]api.rocksdb_options_t,
        uint64_t: i64,
    ) void {
        api.rocksdb_options_set_compression_options_max_dict_buffer_bytes(
            arg0,
            uint64_t,
        );
    }

    pub fn getCompressionOptionsMaxDictBufferBytes(
        opt: [*c]api.rocksdb_options_t,
    ) i64 {
        api.rocksdb_options_get_compression_options_max_dict_buffer_bytes(opt);
    }

    pub fn setBottommostCompressionOptions(
        arg0: [*c]api.rocksdb_options_t,
        arg1: i64,
        arg2: i64,
        arg3: i64,
        arg4: i64,
        arg5: u8,
    ) void {
        api.rocksdb_options_set_bottommost_compression_options(
            arg0,
            arg1,
            arg2,
            arg3,
            arg4,
            arg5,
        );
    }

    pub fn setBottommostCompressionOptionsZstdMaxTrainBytes(
        arg0: [*c]api.rocksdb_options_t,
        arg1: i64,
        arg2: u8,
    ) void {
        api.rocksdb_options_set_bottommost_compression_options_zstd_max_train_bytes(
            arg0,
            arg1,
            arg2,
        );
    }

    pub fn setBottommostCompressionOptionsUseZstdDictTrainer(
        arg0: [*c]api.rocksdb_options_t,
        arg1: u8,
        arg2: u8,
    ) void {
        api.rocksdb_options_set_bottommost_compression_options_use_zstd_dict_trainer(
            arg0,
            arg1,
            arg2,
        );
    }

    pub fn getBottommostCompressionOptionsUseZstdDictTrainer(
        opt: [*c]api.rocksdb_options_t,
    ) u8 {
        api.rocksdb_options_get_bottommost_compression_options_use_zstd_dict_trainer(
            opt,
        );
    }

    pub fn setBottommostCompressionOptionsMaxDictBufferBytes(
        arg0: [*c]api.rocksdb_options_t,
        uint64_t: i64,
        arg2: u8,
    ) void {
        api.rocksdb_options_set_bottommost_compression_options_max_dict_buffer_bytes(
            arg0,
            uint64_t,
            arg2,
        );
    }

    pub fn setPrefixExtractor(
        arg0: [*c]api.rocksdb_options_t,
        arg1: [*c]api.rocksdb_slicetransform_t,
    ) void {
        api.rocksdb_options_set_prefix_extractor(arg0, arg1);
    }

    pub fn setNumLevels(arg0: [*c]api.rocksdb_options_t, arg1: i64) void {
        api.rocksdb_options_set_num_levels(arg0, arg1);
    }

    pub fn getNumLevels(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_num_levels(arg0);
    }

    pub fn setLevel0FileNumCompactionTrigger(
        arg0: [*c]api.rocksdb_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_options_set_level0_file_num_compaction_trigger(arg0, arg1);
    }

    pub fn getLevel0FileNumCompactionTrigger(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_level0_file_num_compaction_trigger(arg0);
    }

    pub fn setLevel0SlowdownWritesTrigger(
        arg0: [*c]api.rocksdb_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_options_set_level0_slowdown_writes_trigger(arg0, arg1);
    }

    pub fn getLevel0SlowdownWritesTrigger(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_level0_slowdown_writes_trigger(arg0);
    }

    pub fn setLevel0StopWritesTrigger(
        arg0: [*c]api.rocksdb_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_options_set_level0_stop_writes_trigger(arg0, arg1);
    }

    pub fn getLevel0StopWritesTrigger(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_level0_stop_writes_trigger(arg0);
    }

    pub fn setTargetFileSizeBase(
        arg0: [*c]api.rocksdb_options_t,
        uint64_t: i64,
    ) void {
        api.rocksdb_options_set_target_file_size_base(arg0, uint64_t);
    }

    pub fn getTargetFileSizeBase(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_target_file_size_base(arg0);
    }

    pub fn setTargetFileSizeMultiplier(
        arg0: [*c]api.rocksdb_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_options_set_target_file_size_multiplier(arg0, arg1);
    }

    pub fn getTargetFileSizeMultiplier(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_target_file_size_multiplier(arg0);
    }

    pub fn setMaxBytesForLevelBase(
        arg0: [*c]api.rocksdb_options_t,
        uint64_t: i64,
    ) void {
        api.rocksdb_options_set_max_bytes_for_level_base(arg0, uint64_t);
    }

    pub fn getMaxBytesForLevelBase(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_max_bytes_for_level_base(arg0);
    }

    pub fn setLevelCompactionDynamicLevelBytes(
        arg0: [*c]api.rocksdb_options_t,
        arg1: u8,
    ) void {
        api.rocksdb_options_set_level_compaction_dynamic_level_bytes(arg0, arg1);
    }

    pub fn getLevelCompactionDynamicLevelBytes(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_level_compaction_dynamic_level_bytes(arg0);
    }

    pub fn setMaxBytesForLevelMultiplier(
        arg0: [*c]api.rocksdb_options_t,
        arg1: f64,
    ) void {
        api.rocksdb_options_set_max_bytes_for_level_multiplier(arg0, arg1);
    }

    pub fn getMaxBytesForLevelMultiplier(arg0: [*c]api.rocksdb_options_t) f64 {
        api.rocksdb_options_get_max_bytes_for_level_multiplier(arg0);
    }

    pub fn setMaxBytesForLevelMultiplierAdditional(
        arg0: [*c]api.rocksdb_options_t,
        level_values: [*c]i64,
        num_levels: i64,
    ) void {
        api.rocksdb_options_set_max_bytes_for_level_multiplier_additional(
            arg0,
            level_values,
            num_levels,
        );
    }

    pub fn enableStatistics(arg0: [*c]api.rocksdb_options_t) void {
        api.rocksdb_options_enable_statistics(arg0);
    }

    pub fn setTtl(arg0: [*c]api.rocksdb_options_t, uint64_t: i64) void {
        api.rocksdb_options_set_ttl(arg0, uint64_t);
    }

    pub fn getTtl(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_ttl(arg0);
    }

    pub fn setPeriodicCompactionSeconds(
        arg0: [*c]api.rocksdb_options_t,
        uint64_t: i64,
    ) void {
        api.rocksdb_options_set_periodic_compaction_seconds(arg0, uint64_t);
    }

    pub fn getPeriodicCompactionSeconds(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_periodic_compaction_seconds(arg0);
    }

    pub fn setMemtableOpScanFlushTrigger(
        arg0: [*c]api.rocksdb_options_t,
        uint32_t: i64,
    ) void {
        api.rocksdb_options_set_memtable_op_scan_flush_trigger(arg0, uint32_t);
    }

    pub fn getMemtableOpScanFlushTrigger(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_memtable_op_scan_flush_trigger(arg0);
    }

    pub fn setMemtableAvgOpScanFlushTrigger(
        arg0: [*c]api.rocksdb_options_t,
        uint32_t: i64,
    ) void {
        api.rocksdb_options_set_memtable_avg_op_scan_flush_trigger(arg0, uint32_t);
    }

    pub fn getMemtableAvgOpScanFlushTrigger(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_memtable_avg_op_scan_flush_trigger(arg0);
    }

    pub fn setStatisticsLevel(arg0: [*c]api.rocksdb_options_t, level: i64) void {
        api.rocksdb_options_set_statistics_level(arg0, level);
    }

    pub fn getStatisticsLevel(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_statistics_level(arg0);
    }

    pub fn setSkipStatsUpdateOnDbOpen(opt: [*c]api.rocksdb_options_t, val: u8) void {
        api.rocksdb_options_set_skip_stats_update_on_db_open(opt, val);
    }

    pub fn getSkipStatsUpdateOnDbOpen(opt: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_skip_stats_update_on_db_open(opt);
    }

    pub fn setSkipCheckingSstFileSizesOnDbOpen(
        opt: [*c]api.rocksdb_options_t,
        val: u8,
    ) void {
        api.rocksdb_options_set_skip_checking_sst_file_sizes_on_db_open(opt, val);
    }

    pub fn getSkipCheckingSstFileSizesOnDbOpen(opt: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_skip_checking_sst_file_sizes_on_db_open(opt);
    }

    pub fn setEnableBlobFiles(opt: [*c]api.rocksdb_options_t, val: u8) void {
        api.rocksdb_options_set_enable_blob_files(opt, val);
    }

    pub fn getEnableBlobFiles(opt: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_enable_blob_files(opt);
    }

    pub fn setMinBlobSize(opt: [*c]api.rocksdb_options_t, val: i64) void {
        api.rocksdb_options_set_min_blob_size(opt, val);
    }

    pub fn getMinBlobSize(opt: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_min_blob_size(opt);
    }

    pub fn setBlobFileSize(opt: [*c]api.rocksdb_options_t, val: i64) void {
        api.rocksdb_options_set_blob_file_size(opt, val);
    }

    pub fn getBlobFileSize(opt: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_blob_file_size(opt);
    }

    pub fn setBlobCompressionType(opt: [*c]api.rocksdb_options_t, val: i64) void {
        api.rocksdb_options_set_blob_compression_type(opt, val);
    }

    pub fn getBlobCompressionType(opt: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_blob_compression_type(opt);
    }

    pub fn setEnableBlobGc(opt: [*c]api.rocksdb_options_t, val: u8) void {
        api.rocksdb_options_set_enable_blob_gc(opt, val);
    }

    pub fn getEnableBlobGc(opt: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_enable_blob_gc(opt);
    }

    pub fn setBlobGcAgeCutoff(opt: [*c]api.rocksdb_options_t, val: f64) void {
        api.rocksdb_options_set_blob_gc_age_cutoff(opt, val);
    }

    pub fn getBlobGcAgeCutoff(opt: [*c]api.rocksdb_options_t) f64 {
        api.rocksdb_options_get_blob_gc_age_cutoff(opt);
    }

    pub fn setBlobGcForceThreshold(opt: [*c]api.rocksdb_options_t, val: f64) void {
        api.rocksdb_options_set_blob_gc_force_threshold(opt, val);
    }

    pub fn getBlobGcForceThreshold(opt: [*c]api.rocksdb_options_t) f64 {
        api.rocksdb_options_get_blob_gc_force_threshold(opt);
    }

    pub fn setBlobCompactionReadaheadSize(
        opt: [*c]api.rocksdb_options_t,
        val: i64,
    ) void {
        api.rocksdb_options_set_blob_compaction_readahead_size(opt, val);
    }

    pub fn getBlobCompactionReadaheadSize(opt: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_blob_compaction_readahead_size(opt);
    }

    pub fn setBlobFileStartingLevel(opt: [*c]api.rocksdb_options_t, val: i64) void {
        api.rocksdb_options_set_blob_file_starting_level(opt, val);
    }

    pub fn getBlobFileStartingLevel(opt: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_blob_file_starting_level(opt);
    }

    pub fn setBlobCache(
        opt: [*c]api.rocksdb_options_t,
        blob_cache: [*c]api.rocksdb_cache_t,
    ) void {
        api.rocksdb_options_set_blob_cache(opt, blob_cache);
    }

    pub fn setPrepopulateBlobCache(opt: [*c]api.rocksdb_options_t, val: i64) void {
        api.rocksdb_options_set_prepopulate_blob_cache(opt, val);
    }

    pub fn getPrepopulateBlobCache(opt: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_prepopulate_blob_cache(opt);
    }

    pub fn statisticsGetString(opt: [*c]api.rocksdb_options_t) [*c]i8 {
        api.rocksdb_options_statistics_get_string(opt);
    }

    pub fn statisticsGetTickerCount(
        opt: [*c]api.rocksdb_options_t,
        ticker_type: i64,
    ) i64 {
        api.rocksdb_options_statistics_get_ticker_count(opt, ticker_type);
    }

    pub fn statisticsGetHistogramData(
        opt: [*c]api.rocksdb_options_t,
        histogram_type: i64,
        data: [*c]api.rocksdb_statistics_histogram_data_t,
    ) void {
        api.rocksdb_options_statistics_get_histogram_data(
            opt,
            histogram_type,
            data,
        );
    }

    pub fn setMaxWriteBufferNumber(arg0: [*c]api.rocksdb_options_t, arg1: i64) void {
        api.rocksdb_options_set_max_write_buffer_number(arg0, arg1);
    }

    pub fn getMaxWriteBufferNumber(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_max_write_buffer_number(arg0);
    }

    pub fn setMinWriteBufferNumberToMerge(
        arg0: [*c]api.rocksdb_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_options_set_min_write_buffer_number_to_merge(arg0, arg1);
    }

    pub fn getMinWriteBufferNumberToMerge(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_min_write_buffer_number_to_merge(arg0);
    }

    pub fn setMaxWriteBufferSizeToMaintain(
        arg0: [*c]api.rocksdb_options_t,
        int64_t: i64,
    ) void {
        api.rocksdb_options_set_max_write_buffer_size_to_maintain(arg0, int64_t);
    }

    pub fn getMaxWriteBufferSizeToMaintain(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_max_write_buffer_size_to_maintain(arg0);
    }

    pub fn setEnablePipelinedWrite(arg0: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_enable_pipelined_write(arg0, arg1);
    }

    pub fn getEnablePipelinedWrite(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_enable_pipelined_write(arg0);
    }

    pub fn setUnorderedWrite(arg0: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_unordered_write(arg0, arg1);
    }

    pub fn getUnorderedWrite(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_unordered_write(arg0);
    }

    pub fn setMaxSubcompactions(
        arg0: [*c]api.rocksdb_options_t,
        uint32_t: i64,
    ) void {
        api.rocksdb_options_set_max_subcompactions(arg0, uint32_t);
    }

    pub fn getMaxSubcompactions(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_max_subcompactions(arg0);
    }

    pub fn setMaxBackgroundJobs(arg0: [*c]api.rocksdb_options_t, arg1: i64) void {
        api.rocksdb_options_set_max_background_jobs(arg0, arg1);
    }

    pub fn getMaxBackgroundJobs(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_max_background_jobs(arg0);
    }

    pub fn setMaxBackgroundCompactions(
        arg0: [*c]api.rocksdb_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_options_set_max_background_compactions(arg0, arg1);
    }

    pub fn getMaxBackgroundCompactions(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_max_background_compactions(arg0);
    }

    pub fn setMaxBackgroundFlushes(arg0: [*c]api.rocksdb_options_t, arg1: i64) void {
        api.rocksdb_options_set_max_background_flushes(arg0, arg1);
    }

    pub fn getMaxBackgroundFlushes(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_max_background_flushes(arg0);
    }

    pub fn setMaxLogFileSize(arg0: [*c]api.rocksdb_options_t, size_t: i64) void {
        api.rocksdb_options_set_max_log_file_size(arg0, size_t);
    }

    pub fn getMaxLogFileSize(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_max_log_file_size(arg0);
    }

    pub fn setLogFileTimeToRoll(arg0: [*c]api.rocksdb_options_t, size_t: i64) void {
        api.rocksdb_options_set_log_file_time_to_roll(arg0, size_t);
    }

    pub fn getLogFileTimeToRoll(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_log_file_time_to_roll(arg0);
    }

    pub fn setKeepLogFileNum(arg0: [*c]api.rocksdb_options_t, size_t: i64) void {
        api.rocksdb_options_set_keep_log_file_num(arg0, size_t);
    }

    pub fn getKeepLogFileNum(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_keep_log_file_num(arg0);
    }

    pub fn setRecycleLogFileNum(arg0: [*c]api.rocksdb_options_t, size_t: i64) void {
        api.rocksdb_options_set_recycle_log_file_num(arg0, size_t);
    }

    pub fn getRecycleLogFileNum(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_recycle_log_file_num(arg0);
    }

    pub fn setSoftPendingCompactionBytesLimit(
        opt: [*c]api.rocksdb_options_t,
        v: i64,
    ) void {
        api.rocksdb_options_set_soft_pending_compaction_bytes_limit(opt, v);
    }

    pub fn getSoftPendingCompactionBytesLimit(opt: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_soft_pending_compaction_bytes_limit(opt);
    }

    pub fn setHardPendingCompactionBytesLimit(
        opt: [*c]api.rocksdb_options_t,
        v: i64,
    ) void {
        api.rocksdb_options_set_hard_pending_compaction_bytes_limit(opt, v);
    }

    pub fn getHardPendingCompactionBytesLimit(opt: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_hard_pending_compaction_bytes_limit(opt);
    }

    pub fn setMaxManifestFileSize(
        arg0: [*c]api.rocksdb_options_t,
        size_t: i64,
    ) void {
        api.rocksdb_options_set_max_manifest_file_size(arg0, size_t);
    }

    pub fn getMaxManifestFileSize(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_max_manifest_file_size(arg0);
    }

    pub fn setTableCacheNumshardbits(
        arg0: [*c]api.rocksdb_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_options_set_table_cache_numshardbits(arg0, arg1);
    }

    pub fn getTableCacheNumshardbits(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_table_cache_numshardbits(arg0);
    }

    pub fn setArenaBlockSize(arg0: [*c]api.rocksdb_options_t, size_t: i64) void {
        api.rocksdb_options_set_arena_block_size(arg0, size_t);
    }

    pub fn getArenaBlockSize(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_arena_block_size(arg0);
    }

    pub fn setUseFsync(arg0: [*c]api.rocksdb_options_t, arg1: i64) void {
        api.rocksdb_options_set_use_fsync(arg0, arg1);
    }

    pub fn getUseFsync(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_use_fsync(arg0);
    }

    pub fn setDbLogDir(arg0: [*c]api.rocksdb_options_t, arg1: [*c]const i8) void {
        api.rocksdb_options_set_db_log_dir(arg0, arg1);
    }

    pub fn setWalDir(arg0: [*c]api.rocksdb_options_t, arg1: [*c]const i8) void {
        api.rocksdb_options_set_wal_dir(arg0, arg1);
    }

    pub fn setWalTtlSeconds(arg0: [*c]api.rocksdb_options_t, uint64_t: i64) void {
        api.rocksdb_options_set_WAL_ttl_seconds(arg0, uint64_t);
    }

    pub fn getWalTtlSeconds(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_WAL_ttl_seconds(arg0);
    }

    pub fn setWalSizeLimitMb(arg0: [*c]api.rocksdb_options_t, uint64_t: i64) void {
        api.rocksdb_options_set_WAL_size_limit_MB(arg0, uint64_t);
    }

    pub fn getWalSizeLimitMb(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_WAL_size_limit_MB(arg0);
    }

    pub fn setManifestPreallocationSize(
        arg0: [*c]api.rocksdb_options_t,
        size_t: i64,
    ) void {
        api.rocksdb_options_set_manifest_preallocation_size(arg0, size_t);
    }

    pub fn getManifestPreallocationSize(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_manifest_preallocation_size(arg0);
    }

    pub fn setAllowMmapReads(arg0: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_allow_mmap_reads(arg0, arg1);
    }

    pub fn getAllowMmapReads(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_allow_mmap_reads(arg0);
    }

    pub fn setAllowMmapWrites(arg0: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_allow_mmap_writes(arg0, arg1);
    }

    pub fn getAllowMmapWrites(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_allow_mmap_writes(arg0);
    }

    pub fn setUseDirectReads(arg0: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_use_direct_reads(arg0, arg1);
    }

    pub fn getUseDirectReads(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_use_direct_reads(arg0);
    }

    pub fn setUseDirectIoForFlushAndCompaction(
        arg0: [*c]api.rocksdb_options_t,
        arg1: u8,
    ) void {
        api.rocksdb_options_set_use_direct_io_for_flush_and_compaction(arg0, arg1);
    }

    pub fn getUseDirectIoForFlushAndCompaction(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_use_direct_io_for_flush_and_compaction(arg0);
    }

    pub fn setIsFdCloseOnExec(arg0: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_is_fd_close_on_exec(arg0, arg1);
    }

    pub fn getIsFdCloseOnExec(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_is_fd_close_on_exec(arg0);
    }

    pub fn setStatsDumpPeriodSec(arg0: [*c]api.rocksdb_options_t, arg1: u64) void {
        api.rocksdb_options_set_stats_dump_period_sec(arg0, arg1);
    }

    pub fn getStatsDumpPeriodSec(arg0: [*c]api.rocksdb_options_t) u64 {
        api.rocksdb_options_get_stats_dump_period_sec(arg0);
    }

    pub fn setStatsPersistPeriodSec(
        arg0: [*c]api.rocksdb_options_t,
        arg1: u64,
    ) void {
        api.rocksdb_options_set_stats_persist_period_sec(arg0, arg1);
    }

    pub fn getStatsPersistPeriodSec(arg0: [*c]api.rocksdb_options_t) u64 {
        api.rocksdb_options_get_stats_persist_period_sec(arg0);
    }

    pub fn setAdviseRandomOnOpen(arg0: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_advise_random_on_open(arg0, arg1);
    }

    pub fn getAdviseRandomOnOpen(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_advise_random_on_open(arg0);
    }

    pub fn setUseAdaptiveMutex(arg0: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_use_adaptive_mutex(arg0, arg1);
    }

    pub fn getUseAdaptiveMutex(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_use_adaptive_mutex(arg0);
    }

    pub fn setBytesPerSync(arg0: [*c]api.rocksdb_options_t, uint64_t: i64) void {
        api.rocksdb_options_set_bytes_per_sync(arg0, uint64_t);
    }

    pub fn getBytesPerSync(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_bytes_per_sync(arg0);
    }

    pub fn setWalBytesPerSync(arg0: [*c]api.rocksdb_options_t, uint64_t: i64) void {
        api.rocksdb_options_set_wal_bytes_per_sync(arg0, uint64_t);
    }

    pub fn getWalBytesPerSync(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_wal_bytes_per_sync(arg0);
    }

    pub fn setWritableFileMaxBufferSize(
        arg0: [*c]api.rocksdb_options_t,
        uint64_t: i64,
    ) void {
        api.rocksdb_options_set_writable_file_max_buffer_size(arg0, uint64_t);
    }

    pub fn getWritableFileMaxBufferSize(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_writable_file_max_buffer_size(arg0);
    }

    pub fn setAllowConcurrentMemtableWrite(
        arg0: [*c]api.rocksdb_options_t,
        arg1: u8,
    ) void {
        api.rocksdb_options_set_allow_concurrent_memtable_write(arg0, arg1);
    }

    pub fn getAllowConcurrentMemtableWrite(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_allow_concurrent_memtable_write(arg0);
    }

    pub fn setEnableWriteThreadAdaptiveYield(
        arg0: [*c]api.rocksdb_options_t,
        arg1: u8,
    ) void {
        api.rocksdb_options_set_enable_write_thread_adaptive_yield(arg0, arg1);
    }

    pub fn getEnableWriteThreadAdaptiveYield(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_enable_write_thread_adaptive_yield(arg0);
    }

    pub fn setMaxSequentialSkipInIterations(
        arg0: [*c]api.rocksdb_options_t,
        uint64_t: i64,
    ) void {
        api.rocksdb_options_set_max_sequential_skip_in_iterations(arg0, uint64_t);
    }

    pub fn getMaxSequentialSkipInIterations(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_max_sequential_skip_in_iterations(arg0);
    }

    pub fn setDisableAutoCompactions(
        arg0: [*c]api.rocksdb_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_options_set_disable_auto_compactions(arg0, arg1);
    }

    pub fn getDisableAutoCompactions(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_disable_auto_compactions(arg0);
    }

    pub fn setOptimizeFiltersForHits(
        arg0: [*c]api.rocksdb_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_options_set_optimize_filters_for_hits(arg0, arg1);
    }

    pub fn getOptimizeFiltersForHits(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_optimize_filters_for_hits(arg0);
    }

    pub fn setDeleteObsoleteFilesPeriodMicros(
        arg0: [*c]api.rocksdb_options_t,
        uint64_t: i64,
    ) void {
        api.rocksdb_options_set_delete_obsolete_files_period_micros(arg0, uint64_t);
    }

    pub fn getDeleteObsoleteFilesPeriodMicros(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_delete_obsolete_files_period_micros(arg0);
    }

    pub fn prepareForBulkLoad(arg0: [*c]api.rocksdb_options_t) void {
        api.rocksdb_options_prepare_for_bulk_load(arg0);
    }

    pub fn setMemtableVectorRep(arg0: [*c]api.rocksdb_options_t) void {
        api.rocksdb_options_set_memtable_vector_rep(arg0);
    }

    pub fn setMemtablePrefixBloomSizeRatio(
        arg0: [*c]api.rocksdb_options_t,
        arg1: f64,
    ) void {
        api.rocksdb_options_set_memtable_prefix_bloom_size_ratio(arg0, arg1);
    }

    pub fn getMemtablePrefixBloomSizeRatio(arg0: [*c]api.rocksdb_options_t) f64 {
        api.rocksdb_options_get_memtable_prefix_bloom_size_ratio(arg0);
    }

    pub fn setMaxCompactionBytes(
        arg0: [*c]api.rocksdb_options_t,
        uint64_t: i64,
    ) void {
        api.rocksdb_options_set_max_compaction_bytes(arg0, uint64_t);
    }

    pub fn getMaxCompactionBytes(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_max_compaction_bytes(arg0);
    }

    pub fn setHashSkipListRep(
        arg0: [*c]api.rocksdb_options_t,
        size_t: i64,
        int32_t: i64,
        arg3: i64,
    ) void {
        api.rocksdb_options_set_hash_skip_list_rep(arg0, size_t, int32_t, arg3);
    }

    pub fn setHashLinkListRep(arg0: [*c]api.rocksdb_options_t, size_t: i64) void {
        api.rocksdb_options_set_hash_link_list_rep(arg0, size_t);
    }

    pub fn setPlainTableFactory(
        arg0: [*c]api.rocksdb_options_t,
        uint32_t: i64,
        arg2: i64,
        arg3: f64,
        size_t: i64,
        arg5: i64,
        arg6: i8,
        arg7: u8,
        arg8: u8,
    ) void {
        api.rocksdb_options_set_plain_table_factory(
            arg0,
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

    pub fn getWriteDbidToManifest(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_write_dbid_to_manifest(arg0);
    }

    pub fn setWriteDbidToManifest(arg0: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_write_dbid_to_manifest(arg0, arg1);
    }

    pub fn getWriteIdentityFile(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_write_identity_file(arg0);
    }

    pub fn setWriteIdentityFile(arg0: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_write_identity_file(arg0, arg1);
    }

    pub fn getTrackAndVerifyWalsInManifest(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_track_and_verify_wals_in_manifest(arg0);
    }

    pub fn setTrackAndVerifyWalsInManifest(
        arg0: [*c]api.rocksdb_options_t,
        arg1: u8,
    ) void {
        api.rocksdb_options_set_track_and_verify_wals_in_manifest(arg0, arg1);
    }

    pub fn setMinLevelToCompress(opt: [*c]api.rocksdb_options_t, level: i64) void {
        api.rocksdb_options_set_min_level_to_compress(opt, level);
    }

    pub fn setMemtableHugePageSize(
        arg0: [*c]api.rocksdb_options_t,
        size_t: i64,
    ) void {
        api.rocksdb_options_set_memtable_huge_page_size(arg0, size_t);
    }

    pub fn getMemtableHugePageSize(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_memtable_huge_page_size(arg0);
    }

    pub fn setMaxSuccessiveMerges(
        arg0: [*c]api.rocksdb_options_t,
        size_t: i64,
    ) void {
        api.rocksdb_options_set_max_successive_merges(arg0, size_t);
    }

    pub fn getMaxSuccessiveMerges(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_max_successive_merges(arg0);
    }

    pub fn setBloomLocality(arg0: [*c]api.rocksdb_options_t, uint32_t: i64) void {
        api.rocksdb_options_set_bloom_locality(arg0, uint32_t);
    }

    pub fn getBloomLocality(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_bloom_locality(arg0);
    }

    pub fn setInplaceUpdateSupport(arg0: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_inplace_update_support(arg0, arg1);
    }

    pub fn getInplaceUpdateSupport(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_inplace_update_support(arg0);
    }

    pub fn setInplaceUpdateNumLocks(
        arg0: [*c]api.rocksdb_options_t,
        size_t: i64,
    ) void {
        api.rocksdb_options_set_inplace_update_num_locks(arg0, size_t);
    }

    pub fn getInplaceUpdateNumLocks(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_inplace_update_num_locks(arg0);
    }

    pub fn setReportBgIoStats(arg0: [*c]api.rocksdb_options_t, arg1: i64) void {
        api.rocksdb_options_set_report_bg_io_stats(arg0, arg1);
    }

    pub fn getReportBgIoStats(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_report_bg_io_stats(arg0);
    }

    pub fn setAvoidUnnecessaryBlockingIo(
        arg0: [*c]api.rocksdb_options_t,
        arg1: u8,
    ) void {
        api.rocksdb_options_set_avoid_unnecessary_blocking_io(arg0, arg1);
    }

    pub fn getAvoidUnnecessaryBlockingIo(arg0: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_avoid_unnecessary_blocking_io(arg0);
    }

    pub fn setExperimentalMempurgeThreshold(
        arg0: [*c]api.rocksdb_options_t,
        arg1: f64,
    ) void {
        api.rocksdb_options_set_experimental_mempurge_threshold(arg0, arg1);
    }

    pub fn getExperimentalMempurgeThreshold(arg0: [*c]api.rocksdb_options_t) f64 {
        api.rocksdb_options_get_experimental_mempurge_threshold(arg0);
    }

    pub fn setWalRecoveryMode(arg0: [*c]api.rocksdb_options_t, arg1: i64) void {
        api.rocksdb_options_set_wal_recovery_mode(arg0, arg1);
    }

    pub fn getWalRecoveryMode(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_wal_recovery_mode(arg0);
    }

    pub fn setCompression(arg0: [*c]api.rocksdb_options_t, arg1: i64) void {
        api.rocksdb_options_set_compression(arg0, arg1);
    }

    pub fn getCompression(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_compression(arg0);
    }

    pub fn setBottommostCompression(
        arg0: [*c]api.rocksdb_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_options_set_bottommost_compression(arg0, arg1);
    }

    pub fn getBottommostCompression(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_bottommost_compression(arg0);
    }

    pub fn setCompactionStyle(arg0: [*c]api.rocksdb_options_t, arg1: i64) void {
        api.rocksdb_options_set_compaction_style(arg0, arg1);
    }

    pub fn getCompactionStyle(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_compaction_style(arg0);
    }

    pub fn setUniversalCompactionOptions(
        arg0: [*c]api.rocksdb_options_t,
        arg1: [*c]api.rocksdb_universal_compaction_options_t,
    ) void {
        api.rocksdb_options_set_universal_compaction_options(arg0, arg1);
    }

    pub fn setFifoCompactionOptions(
        opt: [*c]api.rocksdb_options_t,
        fifo: [*c]api.rocksdb_fifo_compaction_options_t,
    ) void {
        api.rocksdb_options_set_fifo_compaction_options(opt, fifo);
    }

    pub fn setRatelimiter(
        opt: [*c]api.rocksdb_options_t,
        limiter: [*c]api.rocksdb_ratelimiter_t,
    ) void {
        api.rocksdb_options_set_ratelimiter(opt, limiter);
    }

    pub fn setAtomicFlush(opt: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_atomic_flush(opt, arg1);
    }

    pub fn getAtomicFlush(opt: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_atomic_flush(opt);
    }

    pub fn setRowCache(
        opt: [*c]api.rocksdb_options_t,
        cache: [*c]api.rocksdb_cache_t,
    ) void {
        api.rocksdb_options_set_row_cache(opt, cache);
    }

    pub fn addCompactOnDeletionCollectorFactory(
        arg0: [*c]api.rocksdb_options_t,
        window_size: i64,
        num_dels_trigger: i64,
    ) void {
        api.rocksdb_options_add_compact_on_deletion_collector_factory(
            arg0,
            window_size,
            num_dels_trigger,
        );
    }

    pub fn addCompactOnDeletionCollectorFactoryDelRatio(
        arg0: [*c]api.rocksdb_options_t,
        window_size: i64,
        num_dels_trigger: i64,
        deletion_ratio: f64,
    ) void {
        api.rocksdb_options_add_compact_on_deletion_collector_factory_del_ratio(
            arg0,
            window_size,
            num_dels_trigger,
            deletion_ratio,
        );
    }

    pub fn addCompactOnDeletionCollectorFactoryMinFileSize(
        arg0: [*c]api.rocksdb_options_t,
        window_size: i64,
        num_dels_trigger: i64,
        deletion_ratio: f64,
        min_file_size: i64,
    ) void {
        api.rocksdb_options_add_compact_on_deletion_collector_factory_min_file_size(
            arg0,
            window_size,
            num_dels_trigger,
            deletion_ratio,
            min_file_size,
        );
    }

    pub fn setManualWalFlush(opt: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_manual_wal_flush(opt, arg1);
    }

    pub fn getManualWalFlush(opt: [*c]api.rocksdb_options_t) u8 {
        api.rocksdb_options_get_manual_wal_flush(opt);
    }

    pub fn setWalCompression(opt: [*c]api.rocksdb_options_t, arg1: i64) void {
        api.rocksdb_options_set_wal_compression(opt, arg1);
    }

    pub fn getWalCompression(opt: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_wal_compression(opt);
    }

    pub fn setCompactionPri(arg0: [*c]api.rocksdb_options_t, arg1: i64) void {
        api.rocksdb_options_set_compaction_pri(arg0, arg1);
    }

    pub fn getCompactionPri(arg0: [*c]api.rocksdb_options_t) i64 {
        api.rocksdb_options_get_compaction_pri(arg0);
    }

    pub fn getOptionsFromString(
        base_options: [*c]const api.rocksdb_options_t,
        opts_str: [*c]const i8,
        new_options: [*c]api.rocksdb_options_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_get_options_from_string(
            base_options,
            opts_str,
            new_options,
            errptr,
        );
    }

    pub fn setDumpMallocStats(arg0: [*c]api.rocksdb_options_t, arg1: u8) void {
        api.rocksdb_options_set_dump_malloc_stats(arg0, arg1);
    }

    pub fn setMemtableWholeKeyFiltering(
        arg0: [*c]api.rocksdb_options_t,
        arg1: u8,
    ) void {
        api.rocksdb_options_set_memtable_whole_key_filtering(arg0, arg1);
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
        api.rocksdb_perfcontext_create();
    }

    pub fn reset(context: [*c]api.rocksdb_perfcontext_t) void {
        api.rocksdb_perfcontext_reset(context);
    }

    pub fn report(
        context: [*c]api.rocksdb_perfcontext_t,
        exclude_zero_counters: u8,
    ) [*c]i8 {
        api.rocksdb_perfcontext_report(context, exclude_zero_counters);
    }

    pub fn metric(context: [*c]api.rocksdb_perfcontext_t, metric_: i64) i64 {
        api.rocksdb_perfcontext_metric(context, metric_);
    }

    pub fn destroy(context: [*c]api.rocksdb_perfcontext_t) void {
        api.rocksdb_perfcontext_destroy(context);
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

    pub fn getValue(
        handle: [*c]const api.rocksdb_pinnable_handle_t,
        vallen: [*c]i64,
    ) [*c]const i8 {
        api.rocksdb_pinnable_handle_get_value(handle, vallen);
    }

    pub fn destroy(handle: [*c]api.rocksdb_pinnable_handle_t) void {
        api.rocksdb_pinnable_handle_destroy(handle);
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

    pub fn destroy(v: [*c]api.rocksdb_pinnableslice_t) void {
        api.rocksdb_pinnableslice_destroy(v);
    }

    pub fn value(
        t: [*c]const api.rocksdb_pinnableslice_t,
        vlen: [*c]i64,
    ) [*c]const i8 {
        api.rocksdb_pinnableslice_value(t, vlen);
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
        api.rocksdb_ratelimiter_create(
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
        api.rocksdb_ratelimiter_create_auto_tuned(
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
        api.rocksdb_ratelimiter_create_with_mode(
            rate_bytes_per_sec,
            refill_period_us,
            fairness,
            mode,
            auto_tuned,
        );
    }

    pub fn destroy(arg0: [*c]api.rocksdb_ratelimiter_t) void {
        api.rocksdb_ratelimiter_destroy(arg0);
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
        api.rocksdb_readoptions_create();
    }

    pub fn destroy(arg0: [*c]api.rocksdb_readoptions_t) void {
        api.rocksdb_readoptions_destroy(arg0);
    }

    pub fn setVerifyChecksums(arg0: [*c]api.rocksdb_readoptions_t, arg1: u8) void {
        api.rocksdb_readoptions_set_verify_checksums(arg0, arg1);
    }

    pub fn getVerifyChecksums(arg0: [*c]api.rocksdb_readoptions_t) u8 {
        api.rocksdb_readoptions_get_verify_checksums(arg0);
    }

    pub fn setFillCache(arg0: [*c]api.rocksdb_readoptions_t, arg1: u8) void {
        api.rocksdb_readoptions_set_fill_cache(arg0, arg1);
    }

    pub fn getFillCache(arg0: [*c]api.rocksdb_readoptions_t) u8 {
        api.rocksdb_readoptions_get_fill_cache(arg0);
    }

    pub fn setSnapshot(
        arg0: [*c]api.rocksdb_readoptions_t,
        arg1: [*c]const api.rocksdb_snapshot_t,
    ) void {
        api.rocksdb_readoptions_set_snapshot(arg0, arg1);
    }

    pub fn setIterateUpperBound(
        arg0: [*c]api.rocksdb_readoptions_t,
        key: []const u8,
    ) void {
        api.rocksdb_readoptions_set_iterate_upper_bound(
            arg0,
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn setIterateLowerBound(
        arg0: [*c]api.rocksdb_readoptions_t,
        key: []const u8,
    ) void {
        api.rocksdb_readoptions_set_iterate_lower_bound(
            arg0,
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn setReadTier(arg0: [*c]api.rocksdb_readoptions_t, arg1: i64) void {
        api.rocksdb_readoptions_set_read_tier(arg0, arg1);
    }

    pub fn getReadTier(arg0: [*c]api.rocksdb_readoptions_t) i64 {
        api.rocksdb_readoptions_get_read_tier(arg0);
    }

    pub fn setTailing(arg0: [*c]api.rocksdb_readoptions_t, arg1: u8) void {
        api.rocksdb_readoptions_set_tailing(arg0, arg1);
    }

    pub fn getTailing(arg0: [*c]api.rocksdb_readoptions_t) u8 {
        api.rocksdb_readoptions_get_tailing(arg0);
    }

    pub fn setManaged(arg0: [*c]api.rocksdb_readoptions_t, arg1: u8) void {
        api.rocksdb_readoptions_set_managed(arg0, arg1);
    }

    pub fn setReadaheadSize(arg0: [*c]api.rocksdb_readoptions_t, size_t: i64) void {
        api.rocksdb_readoptions_set_readahead_size(arg0, size_t);
    }

    pub fn getReadaheadSize(arg0: [*c]api.rocksdb_readoptions_t) i64 {
        api.rocksdb_readoptions_get_readahead_size(arg0);
    }

    pub fn setPrefixSameAsStart(arg0: [*c]api.rocksdb_readoptions_t, arg1: u8) void {
        api.rocksdb_readoptions_set_prefix_same_as_start(arg0, arg1);
    }

    pub fn getPrefixSameAsStart(arg0: [*c]api.rocksdb_readoptions_t) u8 {
        api.rocksdb_readoptions_get_prefix_same_as_start(arg0);
    }

    pub fn setPinData(arg0: [*c]api.rocksdb_readoptions_t, arg1: u8) void {
        api.rocksdb_readoptions_set_pin_data(arg0, arg1);
    }

    pub fn getPinData(arg0: [*c]api.rocksdb_readoptions_t) u8 {
        api.rocksdb_readoptions_get_pin_data(arg0);
    }

    pub fn setTotalOrderSeek(arg0: [*c]api.rocksdb_readoptions_t, arg1: u8) void {
        api.rocksdb_readoptions_set_total_order_seek(arg0, arg1);
    }

    pub fn getTotalOrderSeek(arg0: [*c]api.rocksdb_readoptions_t) u8 {
        api.rocksdb_readoptions_get_total_order_seek(arg0);
    }

    pub fn setMaxSkippableInternalKeys(
        arg0: [*c]api.rocksdb_readoptions_t,
        uint64_t: i64,
    ) void {
        api.rocksdb_readoptions_set_max_skippable_internal_keys(arg0, uint64_t);
    }

    pub fn getMaxSkippableInternalKeys(arg0: [*c]api.rocksdb_readoptions_t) i64 {
        api.rocksdb_readoptions_get_max_skippable_internal_keys(arg0);
    }

    pub fn setBackgroundPurgeOnIteratorCleanup(
        arg0: [*c]api.rocksdb_readoptions_t,
        arg1: u8,
    ) void {
        api.rocksdb_readoptions_set_background_purge_on_iterator_cleanup(
            arg0,
            arg1,
        );
    }

    pub fn getBackgroundPurgeOnIteratorCleanup(
        arg0: [*c]api.rocksdb_readoptions_t,
    ) u8 {
        api.rocksdb_readoptions_get_background_purge_on_iterator_cleanup(arg0);
    }

    pub fn setIgnoreRangeDeletions(
        arg0: [*c]api.rocksdb_readoptions_t,
        arg1: u8,
    ) void {
        api.rocksdb_readoptions_set_ignore_range_deletions(arg0, arg1);
    }

    pub fn getIgnoreRangeDeletions(arg0: [*c]api.rocksdb_readoptions_t) u8 {
        api.rocksdb_readoptions_get_ignore_range_deletions(arg0);
    }

    pub fn setDeadline(arg0: [*c]api.rocksdb_readoptions_t, microseconds: i64) void {
        api.rocksdb_readoptions_set_deadline(arg0, microseconds);
    }

    pub fn getDeadline(arg0: [*c]api.rocksdb_readoptions_t) i64 {
        api.rocksdb_readoptions_get_deadline(arg0);
    }

    pub fn setIoTimeout(
        arg0: [*c]api.rocksdb_readoptions_t,
        microseconds: i64,
    ) void {
        api.rocksdb_readoptions_set_io_timeout(arg0, microseconds);
    }

    pub fn getIoTimeout(arg0: [*c]api.rocksdb_readoptions_t) i64 {
        api.rocksdb_readoptions_get_io_timeout(arg0);
    }

    pub fn setAsyncIo(arg0: [*c]api.rocksdb_readoptions_t, arg1: u8) void {
        api.rocksdb_readoptions_set_async_io(arg0, arg1);
    }

    pub fn getAsyncIo(arg0: [*c]api.rocksdb_readoptions_t) u8 {
        api.rocksdb_readoptions_get_async_io(arg0);
    }

    pub fn setTimestamp(arg0: [*c]api.rocksdb_readoptions_t, ts: []const u8) void {
        api.rocksdb_readoptions_set_timestamp(
            arg0,
            @ptrCast(ts.ptr),
            @intCast(ts.len),
        );
    }

    pub fn setIterStartTs(arg0: [*c]api.rocksdb_readoptions_t, ts: []const u8) void {
        api.rocksdb_readoptions_set_iter_start_ts(
            arg0,
            @ptrCast(ts.ptr),
            @intCast(ts.len),
        );
    }

    pub fn setAutoReadaheadSize(arg0: [*c]api.rocksdb_readoptions_t, arg1: u8) void {
        api.rocksdb_readoptions_set_auto_readahead_size(arg0, arg1);
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
        api.rocksdb_restore_options_create();
    }

    pub fn destroy(opt: [*c]api.rocksdb_restore_options_t) void {
        api.rocksdb_restore_options_destroy(opt);
    }

    pub fn setKeepLogFiles(opt: [*c]api.rocksdb_restore_options_t, v: i64) void {
        api.rocksdb_restore_options_set_keep_log_files(opt, v);
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

    pub fn keySlice(iter: [*c]const api.rocksdb_iterator_t) api.rocksdb_slice_t {
        api.rocksdb_iter_key_slice(iter);
    }

    pub fn valueSlice(iter: [*c]const api.rocksdb_iterator_t) api.rocksdb_slice_t {
        api.rocksdb_iter_value_slice(iter);
    }

    pub fn timestampSlice(
        iter: [*c]const api.rocksdb_iterator_t,
    ) api.rocksdb_slice_t {
        api.rocksdb_iter_timestamp_slice(iter);
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
        api.rocksdb_slicetransform_create(
            state,
            destructor,
            transform,
            in_domain,
            in_range,
            name,
        );
    }

    pub fn createNoop() [*c]api.rocksdb_slicetransform_t {
        api.rocksdb_slicetransform_create_noop();
    }

    pub fn destroy(arg0: [*c]api.rocksdb_slicetransform_t) void {
        api.rocksdb_slicetransform_destroy(arg0);
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

    pub fn getSequenceNumber(snapshot: [*c]const api.rocksdb_snapshot_t) i64 {
        api.rocksdb_snapshot_get_sequence_number(snapshot);
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

    pub fn create(env: [*c]api.rocksdb_env_t) [*c]api.rocksdb_sst_file_manager_t {
        api.rocksdb_sst_file_manager_create(env);
    }

    pub fn destroy(sfm: [*c]api.rocksdb_sst_file_manager_t) void {
        api.rocksdb_sst_file_manager_destroy(sfm);
    }

    pub fn setMaxAllowedSpaceUsage(
        sfm: [*c]api.rocksdb_sst_file_manager_t,
        max_allowed_space: i64,
    ) void {
        api.rocksdb_sst_file_manager_set_max_allowed_space_usage(
            sfm,
            max_allowed_space,
        );
    }

    pub fn setCompactionBufferSize(
        sfm: [*c]api.rocksdb_sst_file_manager_t,
        compaction_buffer_size: i64,
    ) void {
        api.rocksdb_sst_file_manager_set_compaction_buffer_size(
            sfm,
            compaction_buffer_size,
        );
    }

    pub fn isMaxAllowedSpaceReached(sfm: [*c]api.rocksdb_sst_file_manager_t) i64 {
        api.rocksdb_sst_file_manager_is_max_allowed_space_reached(sfm);
    }

    pub fn isMaxAllowedSpaceReachedIncludingCompactions(
        sfm: [*c]api.rocksdb_sst_file_manager_t,
    ) i64 {
        api.rocksdb_sst_file_manager_is_max_allowed_space_reached_including_compactions(
            sfm,
        );
    }

    pub fn getTotalSize(sfm: [*c]api.rocksdb_sst_file_manager_t) i64 {
        api.rocksdb_sst_file_manager_get_total_size(sfm);
    }

    pub fn getDeleteRateBytesPerSecond(sfm: [*c]api.rocksdb_sst_file_manager_t) i64 {
        api.rocksdb_sst_file_manager_get_delete_rate_bytes_per_second(sfm);
    }

    pub fn setDeleteRateBytesPerSecond(
        sfm: [*c]api.rocksdb_sst_file_manager_t,
        delete_rate: i64,
    ) void {
        api.rocksdb_sst_file_manager_set_delete_rate_bytes_per_second(
            sfm,
            delete_rate,
        );
    }

    pub fn getMaxTrashDbRatio(sfm: [*c]api.rocksdb_sst_file_manager_t) f64 {
        api.rocksdb_sst_file_manager_get_max_trash_db_ratio(sfm);
    }

    pub fn setMaxTrashDbRatio(
        sfm: [*c]api.rocksdb_sst_file_manager_t,
        ratio: f64,
    ) void {
        api.rocksdb_sst_file_manager_set_max_trash_db_ratio(sfm, ratio);
    }

    pub fn getTotalTrashSize(sfm: [*c]api.rocksdb_sst_file_manager_t) i64 {
        api.rocksdb_sst_file_manager_get_total_trash_size(sfm);
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

    pub fn destroy(file_meta: [*c]api.rocksdb_sst_file_metadata_t) void {
        api.rocksdb_sst_file_metadata_destroy(file_meta);
    }

    pub fn getRelativeFilename(
        file_meta: [*c]api.rocksdb_sst_file_metadata_t,
    ) [*c]i8 {
        api.rocksdb_sst_file_metadata_get_relative_filename(file_meta);
    }

    pub fn getDirectory(file_meta: [*c]api.rocksdb_sst_file_metadata_t) [*c]i8 {
        api.rocksdb_sst_file_metadata_get_directory(file_meta);
    }

    pub fn getSize(file_meta: [*c]api.rocksdb_sst_file_metadata_t) i64 {
        api.rocksdb_sst_file_metadata_get_size(file_meta);
    }

    pub fn getSmallestkey(
        file_meta: [*c]api.rocksdb_sst_file_metadata_t,
        len: [*c]i64,
    ) [*c]i8 {
        api.rocksdb_sst_file_metadata_get_smallestkey(file_meta, len);
    }

    pub fn getLargestkey(
        file_meta: [*c]api.rocksdb_sst_file_metadata_t,
        len: [*c]i64,
    ) [*c]i8 {
        api.rocksdb_sst_file_metadata_get_largestkey(file_meta, len);
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
        env: [*c]const api.rocksdb_envoptions_t,
        io_options: [*c]const api.rocksdb_options_t,
    ) [*c]api.rocksdb_sstfilewriter_t {
        api.rocksdb_sstfilewriter_create(env, io_options);
    }

    pub fn createWithComparator(
        env: [*c]const api.rocksdb_envoptions_t,
        io_options: [*c]const api.rocksdb_options_t,
        comparator: [*c]const api.rocksdb_comparator_t,
    ) [*c]api.rocksdb_sstfilewriter_t {
        api.rocksdb_sstfilewriter_create_with_comparator(
            env,
            io_options,
            comparator,
        );
    }

    pub fn open(
        writer: [*c]api.rocksdb_sstfilewriter_t,
        name: [*c]const i8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_sstfilewriter_open(writer, name, errptr);
    }

    pub fn add(
        writer: [*c]api.rocksdb_sstfilewriter_t,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_sstfilewriter_add(
            writer,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn put(
        writer: [*c]api.rocksdb_sstfilewriter_t,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_sstfilewriter_put(
            writer,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn putWithTs(
        writer: [*c]api.rocksdb_sstfilewriter_t,
        key: []const u8,
        ts: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_sstfilewriter_put_with_ts(
            writer,
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
        writer: [*c]api.rocksdb_sstfilewriter_t,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_sstfilewriter_merge(
            writer,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn delete(
        writer: [*c]api.rocksdb_sstfilewriter_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_sstfilewriter_delete(
            writer,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn deleteWithTs(
        writer: [*c]api.rocksdb_sstfilewriter_t,
        key: []const u8,
        ts: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_sstfilewriter_delete_with_ts(
            writer,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
            errptr,
        );
    }

    pub fn deleteRange(
        writer: [*c]api.rocksdb_sstfilewriter_t,
        begin_key: []const u8,
        end_key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_sstfilewriter_delete_range(
            writer,
            @ptrCast(begin_key.ptr),
            @intCast(begin_key.len),
            @ptrCast(end_key.ptr),
            @intCast(end_key.len),
            errptr,
        );
    }

    pub fn finish(writer: [*c]api.rocksdb_sstfilewriter_t, errptr: [*c][*c]i8) void {
        api.rocksdb_sstfilewriter_finish(writer, errptr);
    }

    pub fn fileSize(
        writer: [*c]api.rocksdb_sstfilewriter_t,
        file_size: [*c]i64,
    ) void {
        api.rocksdb_sstfilewriter_file_size(writer, file_size);
    }

    pub fn destroy(writer: [*c]api.rocksdb_sstfilewriter_t) void {
        api.rocksdb_sstfilewriter_destroy(writer);
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
        api.rocksdb_statistics_histogram_data_create();
    }

    pub fn destroy(data: [*c]api.rocksdb_statistics_histogram_data_t) void {
        api.rocksdb_statistics_histogram_data_destroy(data);
    }

    pub fn getMedian(data: [*c]api.rocksdb_statistics_histogram_data_t) f64 {
        api.rocksdb_statistics_histogram_data_get_median(data);
    }

    pub fn getP95(data: [*c]api.rocksdb_statistics_histogram_data_t) f64 {
        api.rocksdb_statistics_histogram_data_get_p95(data);
    }

    pub fn getP99(data: [*c]api.rocksdb_statistics_histogram_data_t) f64 {
        api.rocksdb_statistics_histogram_data_get_p99(data);
    }

    pub fn getAverage(data: [*c]api.rocksdb_statistics_histogram_data_t) f64 {
        api.rocksdb_statistics_histogram_data_get_average(data);
    }

    pub fn getStdDev(data: [*c]api.rocksdb_statistics_histogram_data_t) f64 {
        api.rocksdb_statistics_histogram_data_get_std_dev(data);
    }

    pub fn getMax(data: [*c]api.rocksdb_statistics_histogram_data_t) f64 {
        api.rocksdb_statistics_histogram_data_get_max(data);
    }

    pub fn getCount(data: [*c]api.rocksdb_statistics_histogram_data_t) i64 {
        api.rocksdb_statistics_histogram_data_get_count(data);
    }

    pub fn getSum(data: [*c]api.rocksdb_statistics_histogram_data_t) i64 {
        api.rocksdb_statistics_histogram_data_get_sum(data);
    }

    pub fn getMin(data: [*c]api.rocksdb_statistics_histogram_data_t) f64 {
        api.rocksdb_statistics_histogram_data_get_min(data);
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

    pub fn resetStatus(status_ptr: [*c]api.rocksdb_status_ptr_t) void {
        api.rocksdb_reset_status(status_ptr);
    }

    pub fn getError(status: [*c]api.rocksdb_status_ptr_t, errptr: [*c][*c]i8) void {
        api.rocksdb_status_ptr_get_error(status, errptr);
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

    pub fn status(
        arg0: [*c]const api.rocksdb_subcompactionjobinfo_t,
        arg1: [*c][*c]i8,
    ) void {
        api.rocksdb_subcompactionjobinfo_status(arg0, arg1);
    }

    pub fn cfName(
        arg0: [*c]const api.rocksdb_subcompactionjobinfo_t,
        arg1: [*c]i64,
    ) [*c]const i8 {
        api.rocksdb_subcompactionjobinfo_cf_name(arg0, arg1);
    }

    pub fn threadId(arg0: [*c]const api.rocksdb_subcompactionjobinfo_t) i64 {
        api.rocksdb_subcompactionjobinfo_thread_id(arg0);
    }

    pub fn baseInputLevel(arg0: [*c]const api.rocksdb_subcompactionjobinfo_t) i64 {
        api.rocksdb_subcompactionjobinfo_base_input_level(arg0);
    }

    pub fn outputLevel(arg0: [*c]const api.rocksdb_subcompactionjobinfo_t) i64 {
        api.rocksdb_subcompactionjobinfo_output_level(arg0);
    }

    pub fn compactionReason(info: [*c]const api.rocksdb_subcompactionjobinfo_t) i64 {
        api.rocksdb_subcompactionjobinfo_compaction_reason(info);
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
        options: [*c]const api.rocksdb_options_t,
        name: [*c]const i8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        api.rocksdb_open(options, name, errptr);
    }

    pub fn openWithTtl(
        options: [*c]const api.rocksdb_options_t,
        name: [*c]const i8,
        ttl: i64,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        api.rocksdb_open_with_ttl(options, name, ttl, errptr);
    }

    pub fn openForReadOnly(
        options: [*c]const api.rocksdb_options_t,
        name: [*c]const i8,
        error_if_wal_file_exists: u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        api.rocksdb_open_for_read_only(
            options,
            name,
            error_if_wal_file_exists,
            errptr,
        );
    }

    pub fn openAsSecondary(
        options: [*c]const api.rocksdb_options_t,
        name: [*c]const i8,
        secondary_path: [*c]const i8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        api.rocksdb_open_as_secondary(options, name, secondary_path, errptr);
    }

    pub fn putWithTs(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        key: []const u8,
        ts: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_put_with_ts(
            db,
            options,
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
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        ts: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_put_cf_with_ts(
            db,
            options,
            column_family,
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
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        key: []const u8,
        ts: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_delete_with_ts(
            db,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
            errptr,
        );
    }

    pub fn deleteCfWithTs(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        ts: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_delete_cf_with_ts(
            db,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
            errptr,
        );
    }

    pub fn singledelete(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_singledelete(
            db,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn singledeleteCf(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_singledelete_cf(
            db,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn singledeleteWithTs(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        key: []const u8,
        ts: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_singledelete_with_ts(
            db,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
            errptr,
        );
    }

    pub fn singledeleteCfWithTs(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        ts: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_singledelete_cf_with_ts(
            db,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
            errptr,
        );
    }

    pub fn increaseFullHistoryTsLow(
        db: [*c]api.rocksdb_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        ts_low: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_increase_full_history_ts_low(
            db,
            column_family,
            @ptrCast(ts_low.ptr),
            @intCast(ts_low.len),
            errptr,
        );
    }

    pub fn getFullHistoryTsLow(
        db: [*c]api.rocksdb_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        ts_lowlen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        api.rocksdb_get_full_history_ts_low(db, column_family, ts_lowlen, errptr);
    }

    pub fn openAndTrimHistory(
        options: [*c]const api.rocksdb_options_t,
        name: [*c]const i8,
        num_column_families: i64,
        column_family_names: [*c]const [*c]const i8,
        column_family_options: [*c]const [*c]const api.rocksdb_options_t,
        column_family_handles: [*c][*c]api.rocksdb_column_family_handle_t,
        trim_ts: []u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        api.rocksdb_open_and_trim_history(
            options,
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
        options: [*c]const api.rocksdb_options_t,
        name: [*c]const i8,
        num_column_families: i64,
        column_family_names: [*c]const [*c]const i8,
        column_family_options: [*c]const [*c]const api.rocksdb_options_t,
        column_family_handles: [*c][*c]api.rocksdb_column_family_handle_t,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        api.rocksdb_open_column_families(
            options,
            name,
            num_column_families,
            column_family_names,
            column_family_options,
            column_family_handles,
            errptr,
        );
    }

    pub fn openColumnFamiliesWithTtl(
        options: [*c]const api.rocksdb_options_t,
        name: [*c]const i8,
        num_column_families: i64,
        column_family_names: [*c]const [*c]const i8,
        column_family_options: [*c]const [*c]const api.rocksdb_options_t,
        column_family_handles: [*c][*c]api.rocksdb_column_family_handle_t,
        ttls: [*c]const i64,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        api.rocksdb_open_column_families_with_ttl(
            options,
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
        options: [*c]const api.rocksdb_options_t,
        name: [*c]const i8,
        num_column_families: i64,
        column_family_names: [*c]const [*c]const i8,
        column_family_options: [*c]const [*c]const api.rocksdb_options_t,
        column_family_handles: [*c][*c]api.rocksdb_column_family_handle_t,
        error_if_wal_file_exists: u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        api.rocksdb_open_for_read_only_column_families(
            options,
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
        options: [*c]const api.rocksdb_options_t,
        name: [*c]const i8,
        secondary_path: [*c]const i8,
        num_column_families: i64,
        column_family_names: [*c]const [*c]const i8,
        column_family_options: [*c]const [*c]const api.rocksdb_options_t,
        column_family_handles: [*c][*c]api.rocksdb_column_family_handle_t,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_t {
        api.rocksdb_open_as_secondary_column_families(
            options,
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
        db: [*c]api.rocksdb_t,
        column_family_options: [*c]const api.rocksdb_options_t,
        column_family_name: [*c]const i8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_column_family_handle_t {
        api.rocksdb_create_column_family(
            db,
            column_family_options,
            column_family_name,
            errptr,
        );
    }

    pub fn createColumnFamilies(
        db: [*c]api.rocksdb_t,
        column_family_options: [*c]const api.rocksdb_options_t,
        num_column_families: i64,
        column_family_names: [*c]const [*c]const i8,
        lencfs: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c][*c]api.rocksdb_column_family_handle_t {
        api.rocksdb_create_column_families(
            db,
            column_family_options,
            num_column_families,
            column_family_names,
            lencfs,
            errptr,
        );
    }

    pub fn createColumnFamilyWithImport(
        db: [*c]api.rocksdb_t,
        column_family_options: [*c]api.rocksdb_options_t,
        column_family_name: [*c]const i8,
        import_options: [*c]api.rocksdb_import_column_family_options_t,
        metadata: [*c]api.rocksdb_export_import_files_metadata_t,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_column_family_handle_t {
        api.rocksdb_create_column_family_with_import(
            db,
            column_family_options,
            column_family_name,
            import_options,
            metadata,
            errptr,
        );
    }

    pub fn createColumnFamilyWithTtl(
        db: [*c]api.rocksdb_t,
        column_family_options: [*c]const api.rocksdb_options_t,
        column_family_name: [*c]const i8,
        ttl: i64,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_column_family_handle_t {
        api.rocksdb_create_column_family_with_ttl(
            db,
            column_family_options,
            column_family_name,
            ttl,
            errptr,
        );
    }

    pub fn dropColumnFamily(
        db: [*c]api.rocksdb_t,
        handle: [*c]api.rocksdb_column_family_handle_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_drop_column_family(db, handle, errptr);
    }

    pub fn getDefaultColumnFamilyHandle(
        db: [*c]api.rocksdb_t,
    ) [*c]api.rocksdb_column_family_handle_t {
        api.rocksdb_get_default_column_family_handle(db);
    }

    pub fn close(db: [*c]api.rocksdb_t) void {
        api.rocksdb_close(db);
    }

    pub fn put(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_put(
            db,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn putCf(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_put_cf(
            db,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn delete(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_delete(
            db,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn deleteCf(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_delete_cf(
            db,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn deleteRangeCf(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        start_key: []const u8,
        end_key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_delete_range_cf(
            db,
            options,
            column_family,
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(end_key.ptr),
            @intCast(end_key.len),
            errptr,
        );
    }

    pub fn merge(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_merge(
            db,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn mergeCf(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_merge_cf(
            db,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn write(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        batch: [*c]api.rocksdb_writebatch_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_write(db, options, batch, errptr);
    }

    pub fn get(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        key: []const u8,
        vallen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        api.rocksdb_get(
            db,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            errptr,
        );
    }

    pub fn getWithTs(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        key: []const u8,
        vallen: [*c]i64,
        ts: [*c][*c]i8,
        tslen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        api.rocksdb_get_with_ts(
            db,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            ts,
            tslen,
            errptr,
        );
    }

    pub fn getCf(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        vallen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        api.rocksdb_get_cf(
            db,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            errptr,
        );
    }

    pub fn getCfWithTs(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        vallen: [*c]i64,
        ts: [*c][*c]i8,
        tslen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        api.rocksdb_get_cf_with_ts(
            db,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            ts,
            tslen,
            errptr,
        );
    }

    pub fn getDbIdentity(db: [*c]api.rocksdb_t, id_len: [*c]i64) [*c]i8 {
        api.rocksdb_get_db_identity(db, id_len);
    }

    pub fn multiGet(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        api.rocksdb_multi_get(
            db,
            options,
            num_keys,
            keys_list,
            keys_list_sizes,
            values_list,
            values_list_sizes,
            errs,
        );
    }

    pub fn multiGetWithTs(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        timestamp_list: [*c][*c]i8,
        timestamp_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        api.rocksdb_multi_get_with_ts(
            db,
            options,
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
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_families: [*c]const [*c]const api.rocksdb_column_family_handle_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        api.rocksdb_multi_get_cf(
            db,
            options,
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
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
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
        api.rocksdb_multi_get_cf_with_ts(
            db,
            options,
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
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values: [*c][*c]api.rocksdb_pinnableslice_t,
        errs: [*c][*c]i8,
        sorted_input: i64,
    ) void {
        api.rocksdb_batched_multi_get_cf(
            db,
            options,
            column_family,
            num_keys,
            keys_list,
            keys_list_sizes,
            values,
            errs,
            sorted_input,
        );
    }

    pub fn batchedMultiGetCfSlice(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        num_keys: i64,
        keys_list: [*c]const api.rocksdb_slice_t,
        values: [*c][*c]api.rocksdb_pinnableslice_t,
        errs: [*c][*c]i8,
        sorted_input: i64,
    ) void {
        api.rocksdb_batched_multi_get_cf_slice(
            db,
            options,
            column_family,
            num_keys,
            keys_list,
            values,
            errs,
            sorted_input,
        );
    }

    pub fn keyMayExist(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        key: []const u8,
        value: [*c][*c]i8,
        val_len: [*c]i64,
        timestamp: []const u8,
        value_found: [*c]u8,
    ) u8 {
        api.rocksdb_key_may_exist(
            db,
            options,
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
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        value: [*c][*c]i8,
        val_len: [*c]i64,
        timestamp: []const u8,
        value_found: [*c]u8,
    ) u8 {
        api.rocksdb_key_may_exist_cf(
            db,
            options,
            column_family,
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
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
    ) [*c]api.rocksdb_iterator_t {
        api.rocksdb_create_iterator(db, options);
    }

    pub fn getUpdatesSince(
        db: [*c]api.rocksdb_t,
        seq_number: i64,
        options: [*c]const api.rocksdb_wal_readoptions_t,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_wal_iterator_t {
        api.rocksdb_get_updates_since(db, seq_number, options, errptr);
    }

    pub fn createIteratorCf(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
    ) [*c]api.rocksdb_iterator_t {
        api.rocksdb_create_iterator_cf(db, options, column_family);
    }

    pub fn createIterators(
        db: [*c]api.rocksdb_t,
        opts: [*c]api.rocksdb_readoptions_t,
        column_families: [*c][*c]api.rocksdb_column_family_handle_t,
        iterators: [*c][*c]api.rocksdb_iterator_t,
        size: i64,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_create_iterators(
            db,
            opts,
            column_families,
            iterators,
            size,
            errptr,
        );
    }

    pub fn createSnapshot(db: [*c]api.rocksdb_t) [*c]const api.rocksdb_snapshot_t {
        api.rocksdb_create_snapshot(db);
    }

    pub fn releaseSnapshot(
        db: [*c]api.rocksdb_t,
        snapshot: [*c]const api.rocksdb_snapshot_t,
    ) void {
        api.rocksdb_release_snapshot(db, snapshot);
    }

    pub fn propertyValue(db: [*c]api.rocksdb_t, propname: [*c]const i8) [*c]i8 {
        api.rocksdb_property_value(db, propname);
    }

    pub fn propertyInt(
        db: [*c]api.rocksdb_t,
        propname: [*c]const i8,
        out_val: [*c]i64,
    ) i64 {
        api.rocksdb_property_int(db, propname, out_val);
    }

    pub fn propertyIntCf(
        db: [*c]api.rocksdb_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        propname: [*c]const i8,
        out_val: [*c]i64,
    ) i64 {
        api.rocksdb_property_int_cf(db, column_family, propname, out_val);
    }

    pub fn propertyValueCf(
        db: [*c]api.rocksdb_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        propname: [*c]const i8,
    ) [*c]i8 {
        api.rocksdb_property_value_cf(db, column_family, propname);
    }

    pub fn approximateSizes(
        db: [*c]api.rocksdb_t,
        num_ranges: i64,
        range_start_key: [*c]const [*c]const i8,
        range_start_key_len: [*c]const i64,
        range_limit_key: [*c]const [*c]const i8,
        range_limit_key_len: [*c]const i64,
        sizes: [*c]i64,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_approximate_sizes(
            db,
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
        db: [*c]api.rocksdb_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        num_ranges: i64,
        range_start_key: [*c]const [*c]const i8,
        range_start_key_len: [*c]const i64,
        range_limit_key: [*c]const [*c]const i8,
        range_limit_key_len: [*c]const i64,
        sizes: [*c]i64,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_approximate_sizes_cf(
            db,
            column_family,
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
        db: [*c]api.rocksdb_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        num_ranges: i64,
        range_start_key: [*c]const [*c]const i8,
        range_start_key_len: [*c]const i64,
        range_limit_key: [*c]const [*c]const i8,
        range_limit_key_len: [*c]const i64,
        include_flags: i64,
        sizes: [*c]i64,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_approximate_sizes_cf_with_flags(
            db,
            column_family,
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
        db: [*c]api.rocksdb_t,
        start_key: []const u8,
        limit_key: []const u8,
    ) void {
        api.rocksdb_compact_range(
            db,
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(limit_key.ptr),
            @intCast(limit_key.len),
        );
    }

    pub fn compactRangeCf(
        db: [*c]api.rocksdb_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        start_key: []const u8,
        limit_key: []const u8,
    ) void {
        api.rocksdb_compact_range_cf(
            db,
            column_family,
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(limit_key.ptr),
            @intCast(limit_key.len),
        );
    }

    pub fn suggestCompactRange(
        db: [*c]api.rocksdb_t,
        start_key: []const u8,
        limit_key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_suggest_compact_range(
            db,
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(limit_key.ptr),
            @intCast(limit_key.len),
            errptr,
        );
    }

    pub fn suggestCompactRangeCf(
        db: [*c]api.rocksdb_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        start_key: []const u8,
        limit_key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_suggest_compact_range_cf(
            db,
            column_family,
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(limit_key.ptr),
            @intCast(limit_key.len),
            errptr,
        );
    }

    pub fn compactRangeOpt(
        db: [*c]api.rocksdb_t,
        opt: [*c]api.rocksdb_compactoptions_t,
        start_key: []const u8,
        limit_key: []const u8,
    ) void {
        api.rocksdb_compact_range_opt(
            db,
            opt,
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(limit_key.ptr),
            @intCast(limit_key.len),
        );
    }

    pub fn compactRangeCfOpt(
        db: [*c]api.rocksdb_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        opt: [*c]api.rocksdb_compactoptions_t,
        start_key: []const u8,
        limit_key: []const u8,
    ) void {
        api.rocksdb_compact_range_cf_opt(
            db,
            column_family,
            opt,
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(limit_key.ptr),
            @intCast(limit_key.len),
        );
    }

    pub fn livefiles(db: [*c]api.rocksdb_t) [*c]const api.rocksdb_livefiles_t {
        api.rocksdb_livefiles(db);
    }

    pub fn flush(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_flushoptions_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_flush(db, options, errptr);
    }

    pub fn flushCf(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_flushoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_flush_cf(db, options, column_family, errptr);
    }

    pub fn flushCfs(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_flushoptions_t,
        column_family: [*c][*c]api.rocksdb_column_family_handle_t,
        num_column_families: i64,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_flush_cfs(
            db,
            options,
            column_family,
            num_column_families,
            errptr,
        );
    }

    pub fn flushWal(db: [*c]api.rocksdb_t, sync: u8, errptr: [*c][*c]i8) void {
        api.rocksdb_flush_wal(db, sync, errptr);
    }

    pub fn disableFileDeletions(db: [*c]api.rocksdb_t, errptr: [*c][*c]i8) void {
        api.rocksdb_disable_file_deletions(db, errptr);
    }

    pub fn enableFileDeletions(db: [*c]api.rocksdb_t, errptr: [*c][*c]i8) void {
        api.rocksdb_enable_file_deletions(db, errptr);
    }

    pub fn getLatestSequenceNumber(db: [*c]api.rocksdb_t) i64 {
        api.rocksdb_get_latest_sequence_number(db);
    }

    pub fn writeWritebatchWi(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        wbwi: [*c]api.rocksdb_writebatch_wi_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_write_writebatch_wi(db, options, wbwi, errptr);
    }

    pub fn setOptions(
        db: [*c]api.rocksdb_t,
        count: i64,
        keys: [*]const [*c]const i8,
        values: [*]const [*c]const i8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_set_options(db, count, keys, values, errptr);
    }

    pub fn setOptionsCf(
        db: [*c]api.rocksdb_t,
        handle: [*c]api.rocksdb_column_family_handle_t,
        count: i64,
        keys: [*]const [*c]const i8,
        values: [*]const [*c]const i8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_set_options_cf(db, handle, count, keys, values, errptr);
    }

    pub fn ingestExternalFile(
        db: [*c]api.rocksdb_t,
        file_list: [*c]const [*c]const i8,
        list_len: i64,
        opt: [*c]const api.rocksdb_ingestexternalfileoptions_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_ingest_external_file(db, file_list, list_len, opt, errptr);
    }

    pub fn ingestExternalFileCf(
        db: [*c]api.rocksdb_t,
        handle: [*c]api.rocksdb_column_family_handle_t,
        file_list: [*c]const [*c]const i8,
        list_len: i64,
        opt: [*c]const api.rocksdb_ingestexternalfileoptions_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_ingest_external_file_cf(
            db,
            handle,
            file_list,
            list_len,
            opt,
            errptr,
        );
    }

    pub fn tryCatchUpWithPrimary(db: [*c]api.rocksdb_t, errptr: [*c][*c]i8) void {
        api.rocksdb_try_catch_up_with_primary(db, errptr);
    }

    pub fn deleteFileInRange(
        db: [*c]api.rocksdb_t,
        start_key: []const u8,
        limit_key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_delete_file_in_range(
            db,
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(limit_key.ptr),
            @intCast(limit_key.len),
            errptr,
        );
    }

    pub fn deleteFileInRangeCf(
        db: [*c]api.rocksdb_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        start_key: []const u8,
        limit_key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_delete_file_in_range_cf(
            db,
            column_family,
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(limit_key.ptr),
            @intCast(limit_key.len),
            errptr,
        );
    }

    pub fn getColumnFamilyMetadata(
        db: [*c]api.rocksdb_t,
    ) [*c]api.rocksdb_column_family_metadata_t {
        api.rocksdb_get_column_family_metadata(db);
    }

    pub fn getColumnFamilyMetadataCf(
        db: [*c]api.rocksdb_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
    ) [*c]api.rocksdb_column_family_metadata_t {
        api.rocksdb_get_column_family_metadata_cf(db, column_family);
    }

    pub fn transactiondbCloseBaseDb(base_db: [*c]api.rocksdb_t) void {
        api.rocksdb_transactiondb_close_base_db(base_db);
    }

    pub fn optimistictransactiondbCloseBaseDb(base_db: [*c]api.rocksdb_t) void {
        api.rocksdb_optimistictransactiondb_close_base_db(base_db);
    }

    pub fn getPinned(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        api.rocksdb_get_pinned(
            db,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn getPinnedCf(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        api.rocksdb_get_pinned_cf(
            db,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn cancelAllBackgroundWork(db: [*c]api.rocksdb_t, wait: u8) void {
        api.rocksdb_cancel_all_background_work(db, wait);
    }

    pub fn disableManualCompaction(db: [*c]api.rocksdb_t) void {
        api.rocksdb_disable_manual_compaction(db);
    }

    pub fn enableManualCompaction(db: [*c]api.rocksdb_t) void {
        api.rocksdb_enable_manual_compaction(db);
    }

    pub fn waitForCompact(
        db: [*c]api.rocksdb_t,
        options: [*c]api.rocksdb_wait_for_compact_options_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_wait_for_compact(db, options, errptr);
    }

    pub fn getPinnedV2(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnable_handle_t {
        api.rocksdb_get_pinned_v2(
            db,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn getPinnedCfV2(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnable_handle_t {
        api.rocksdb_get_pinned_cf_v2(
            db,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn getIntoBuffer(
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        key: []const u8,
        buffer: []u8,
        vallen: [*c]i64,
        found: [*c]u8,
        errptr: [*c][*c]i8,
    ) u8 {
        api.rocksdb_get_into_buffer(
            db,
            options,
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
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        buffer: []u8,
        vallen: [*c]i64,
        found: [*c]u8,
        errptr: [*c][*c]i8,
    ) u8 {
        api.rocksdb_get_into_buffer_cf(
            db,
            options,
            column_family,
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
        api.rocksdb_transaction_options_create();
    }

    pub fn destroy(opt: [*c]api.rocksdb_transaction_options_t) void {
        api.rocksdb_transaction_options_destroy(opt);
    }

    pub fn setSetSnapshot(opt: [*c]api.rocksdb_transaction_options_t, v: u8) void {
        api.rocksdb_transaction_options_set_set_snapshot(opt, v);
    }

    pub fn setDeadlockDetect(
        opt: [*c]api.rocksdb_transaction_options_t,
        v: u8,
    ) void {
        api.rocksdb_transaction_options_set_deadlock_detect(opt, v);
    }

    pub fn setLockTimeout(
        opt: [*c]api.rocksdb_transaction_options_t,
        lock_timeout: i64,
    ) void {
        api.rocksdb_transaction_options_set_lock_timeout(opt, lock_timeout);
    }

    pub fn setExpiration(
        opt: [*c]api.rocksdb_transaction_options_t,
        expiration: i64,
    ) void {
        api.rocksdb_transaction_options_set_expiration(opt, expiration);
    }

    pub fn setDeadlockDetectDepth(
        opt: [*c]api.rocksdb_transaction_options_t,
        depth: i64,
    ) void {
        api.rocksdb_transaction_options_set_deadlock_detect_depth(opt, depth);
    }

    pub fn setMaxWriteBatchSize(
        opt: [*c]api.rocksdb_transaction_options_t,
        size: i64,
    ) void {
        api.rocksdb_transaction_options_set_max_write_batch_size(opt, size);
    }

    pub fn setSkipPrepare(opt: [*c]api.rocksdb_transaction_options_t, v: u8) void {
        api.rocksdb_transaction_options_set_skip_prepare(opt, v);
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
        txn_db: [*c]api.rocksdb_transactiondb_t,
        write_options: [*c]const api.rocksdb_writeoptions_t,
        txn_options: [*c]const api.rocksdb_transaction_options_t,
        old_txn: [*c]api.rocksdb_transaction_t,
    ) [*c]api.rocksdb_transaction_t {
        api.rocksdb_transaction_begin(txn_db, write_options, txn_options, old_txn);
    }

    pub fn setName(
        txn: [*c]api.rocksdb_transaction_t,
        name: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transaction_set_name(
            txn,
            @ptrCast(name.ptr),
            @intCast(name.len),
            errptr,
        );
    }

    pub fn getName(txn: [*c]api.rocksdb_transaction_t, name_len: [*c]i64) [*c]i8 {
        api.rocksdb_transaction_get_name(txn, name_len);
    }

    pub fn prepare(txn: [*c]api.rocksdb_transaction_t, errptr: [*c][*c]i8) void {
        api.rocksdb_transaction_prepare(txn, errptr);
    }

    pub fn commit(txn: [*c]api.rocksdb_transaction_t, errptr: [*c][*c]i8) void {
        api.rocksdb_transaction_commit(txn, errptr);
    }

    pub fn rollback(txn: [*c]api.rocksdb_transaction_t, errptr: [*c][*c]i8) void {
        api.rocksdb_transaction_rollback(txn, errptr);
    }

    pub fn setSavepoint(txn: [*c]api.rocksdb_transaction_t) void {
        api.rocksdb_transaction_set_savepoint(txn);
    }

    pub fn rollbackToSavepoint(
        txn: [*c]api.rocksdb_transaction_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transaction_rollback_to_savepoint(txn, errptr);
    }

    pub fn destroy(txn: [*c]api.rocksdb_transaction_t) void {
        api.rocksdb_transaction_destroy(txn);
    }

    pub fn getWritebatchWi(
        txn: [*c]api.rocksdb_transaction_t,
    ) [*c]api.rocksdb_writebatch_wi_t {
        api.rocksdb_transaction_get_writebatch_wi(txn);
    }

    pub fn rebuildFromWritebatch(
        txn: [*c]api.rocksdb_transaction_t,
        writebatch: [*c]api.rocksdb_writebatch_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transaction_rebuild_from_writebatch(txn, writebatch, errptr);
    }

    pub fn rebuildFromWritebatchWi(
        txn: [*c]api.rocksdb_transaction_t,
        wi: [*c]api.rocksdb_writebatch_wi_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transaction_rebuild_from_writebatch_wi(txn, wi, errptr);
    }

    pub fn setCommitTimestamp(
        txn: [*c]api.rocksdb_transaction_t,
        commit_timestamp: i64,
    ) void {
        api.rocksdb_transaction_set_commit_timestamp(txn, commit_timestamp);
    }

    pub fn setReadTimestampForValidation(
        txn: [*c]api.rocksdb_transaction_t,
        read_timestamp: i64,
    ) void {
        api.rocksdb_transaction_set_read_timestamp_for_validation(
            txn,
            read_timestamp,
        );
    }

    pub fn getSnapshot(
        txn: [*c]api.rocksdb_transaction_t,
    ) [*c]const api.rocksdb_snapshot_t {
        api.rocksdb_transaction_get_snapshot(txn);
    }

    pub fn get(
        txn: [*c]api.rocksdb_transaction_t,
        options: [*c]const api.rocksdb_readoptions_t,
        key: []const u8,
        vlen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        api.rocksdb_transaction_get(
            txn,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            vlen,
            errptr,
        );
    }

    pub fn getPinned(
        txn: [*c]api.rocksdb_transaction_t,
        options: [*c]const api.rocksdb_readoptions_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        api.rocksdb_transaction_get_pinned(
            txn,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn getCf(
        txn: [*c]api.rocksdb_transaction_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        vlen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        api.rocksdb_transaction_get_cf(
            txn,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            vlen,
            errptr,
        );
    }

    pub fn getPinnedCf(
        txn: [*c]api.rocksdb_transaction_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        api.rocksdb_transaction_get_pinned_cf(
            txn,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn getForUpdate(
        txn: [*c]api.rocksdb_transaction_t,
        options: [*c]const api.rocksdb_readoptions_t,
        key: []const u8,
        vlen: [*c]i64,
        exclusive: u8,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        api.rocksdb_transaction_get_for_update(
            txn,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            vlen,
            exclusive,
            errptr,
        );
    }

    pub fn getPinnedForUpdate(
        txn: [*c]api.rocksdb_transaction_t,
        options: [*c]const api.rocksdb_readoptions_t,
        key: []const u8,
        exclusive: u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        api.rocksdb_transaction_get_pinned_for_update(
            txn,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            exclusive,
            errptr,
        );
    }

    pub fn getForUpdateCf(
        txn: [*c]api.rocksdb_transaction_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        vlen: [*c]i64,
        exclusive: u8,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        api.rocksdb_transaction_get_for_update_cf(
            txn,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            vlen,
            exclusive,
            errptr,
        );
    }

    pub fn getPinnedForUpdateCf(
        txn: [*c]api.rocksdb_transaction_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        exclusive: u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        api.rocksdb_transaction_get_pinned_for_update_cf(
            txn,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            exclusive,
            errptr,
        );
    }

    pub fn multiGet(
        txn: [*c]api.rocksdb_transaction_t,
        options: [*c]const api.rocksdb_readoptions_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        api.rocksdb_transaction_multi_get(
            txn,
            options,
            num_keys,
            keys_list,
            keys_list_sizes,
            values_list,
            values_list_sizes,
            errs,
        );
    }

    pub fn multiGetForUpdate(
        txn: [*c]api.rocksdb_transaction_t,
        options: [*c]const api.rocksdb_readoptions_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        api.rocksdb_transaction_multi_get_for_update(
            txn,
            options,
            num_keys,
            keys_list,
            keys_list_sizes,
            values_list,
            values_list_sizes,
            errs,
        );
    }

    pub fn multiGetCf(
        txn: [*c]api.rocksdb_transaction_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_families: [*c]const [*c]const api.rocksdb_column_family_handle_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        api.rocksdb_transaction_multi_get_cf(
            txn,
            options,
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
        txn: [*c]api.rocksdb_transaction_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_families: [*c]const [*c]const api.rocksdb_column_family_handle_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        api.rocksdb_transaction_multi_get_for_update_cf(
            txn,
            options,
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
        txn: [*c]api.rocksdb_transaction_t,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transaction_put(
            txn,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn putCf(
        txn: [*c]api.rocksdb_transaction_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transaction_put_cf(
            txn,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn merge(
        txn: [*c]api.rocksdb_transaction_t,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transaction_merge(
            txn,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn mergeCf(
        txn: [*c]api.rocksdb_transaction_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transaction_merge_cf(
            txn,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn delete(
        txn: [*c]api.rocksdb_transaction_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transaction_delete(
            txn,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn deleteCf(
        txn: [*c]api.rocksdb_transaction_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transaction_delete_cf(
            txn,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn createIterator(
        txn: [*c]api.rocksdb_transaction_t,
        options: [*c]const api.rocksdb_readoptions_t,
    ) [*c]api.rocksdb_iterator_t {
        api.rocksdb_transaction_create_iterator(txn, options);
    }

    pub fn createIteratorCf(
        txn: [*c]api.rocksdb_transaction_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
    ) [*c]api.rocksdb_iterator_t {
        api.rocksdb_transaction_create_iterator_cf(txn, options, column_family);
    }

    pub fn optimistictransactionBegin(
        otxn_db: [*c]api.rocksdb_optimistictransactiondb_t,
        write_options: [*c]const api.rocksdb_writeoptions_t,
        otxn_options: [*c]const api.rocksdb_optimistictransaction_options_t,
        old_txn: [*c]api.rocksdb_transaction_t,
    ) [*c]api.rocksdb_transaction_t {
        api.rocksdb_optimistictransaction_begin(
            otxn_db,
            write_options,
            otxn_options,
            old_txn,
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
        api.rocksdb_transactiondb_options_create();
    }

    pub fn destroy(opt: [*c]api.rocksdb_transactiondb_options_t) void {
        api.rocksdb_transactiondb_options_destroy(opt);
    }

    pub fn setMaxNumLocks(
        opt: [*c]api.rocksdb_transactiondb_options_t,
        max_num_locks: i64,
    ) void {
        api.rocksdb_transactiondb_options_set_max_num_locks(opt, max_num_locks);
    }

    pub fn setNumStripes(
        opt: [*c]api.rocksdb_transactiondb_options_t,
        num_stripes: i64,
    ) void {
        api.rocksdb_transactiondb_options_set_num_stripes(opt, num_stripes);
    }

    pub fn setTransactionLockTimeout(
        opt: [*c]api.rocksdb_transactiondb_options_t,
        txn_lock_timeout: i64,
    ) void {
        api.rocksdb_transactiondb_options_set_transaction_lock_timeout(
            opt,
            txn_lock_timeout,
        );
    }

    pub fn setDefaultLockTimeout(
        opt: [*c]api.rocksdb_transactiondb_options_t,
        default_lock_timeout: i64,
    ) void {
        api.rocksdb_transactiondb_options_set_default_lock_timeout(
            opt,
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
        txn_db: [*c]api.rocksdb_transactiondb_t,
        column_family_options: [*c]const api.rocksdb_options_t,
        column_family_name: [*c]const i8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_column_family_handle_t {
        api.rocksdb_transactiondb_create_column_family(
            txn_db,
            column_family_options,
            column_family_name,
            errptr,
        );
    }

    pub fn open(
        options: [*c]const api.rocksdb_options_t,
        txn_db_options: [*c]const api.rocksdb_transactiondb_options_t,
        name: [*c]const i8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_transactiondb_t {
        api.rocksdb_transactiondb_open(options, txn_db_options, name, errptr);
    }

    pub fn openColumnFamilies(
        options: [*c]const api.rocksdb_options_t,
        txn_db_options: [*c]const api.rocksdb_transactiondb_options_t,
        name: [*c]const i8,
        num_column_families: i64,
        column_family_names: [*c]const [*c]const i8,
        column_family_options: [*c]const [*c]const api.rocksdb_options_t,
        column_family_handles: [*c][*c]api.rocksdb_column_family_handle_t,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_transactiondb_t {
        api.rocksdb_transactiondb_open_column_families(
            options,
            txn_db_options,
            name,
            num_column_families,
            column_family_names,
            column_family_options,
            column_family_handles,
            errptr,
        );
    }

    pub fn createSnapshot(
        txn_db: [*c]api.rocksdb_transactiondb_t,
    ) [*c]const api.rocksdb_snapshot_t {
        api.rocksdb_transactiondb_create_snapshot(txn_db);
    }

    pub fn releaseSnapshot(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        snapshot: [*c]const api.rocksdb_snapshot_t,
    ) void {
        api.rocksdb_transactiondb_release_snapshot(txn_db, snapshot);
    }

    pub fn propertyValue(
        db: [*c]api.rocksdb_transactiondb_t,
        propname: [*c]const i8,
    ) [*c]i8 {
        api.rocksdb_transactiondb_property_value(db, propname);
    }

    pub fn propertyInt(
        db: [*c]api.rocksdb_transactiondb_t,
        propname: [*c]const i8,
        out_val: [*c]i64,
    ) i64 {
        api.rocksdb_transactiondb_property_int(db, propname, out_val);
    }

    pub fn getBaseDb(txn_db: [*c]api.rocksdb_transactiondb_t) [*c]api.rocksdb_t {
        api.rocksdb_transactiondb_get_base_db(txn_db);
    }

    pub fn getPreparedTransactions(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        cnt: [*c]i64,
    ) [*c][*c]api.rocksdb_transaction_t {
        api.rocksdb_transactiondb_get_prepared_transactions(txn_db, cnt);
    }

    pub fn get(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        key: []const u8,
        vlen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        api.rocksdb_transactiondb_get(
            txn_db,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            vlen,
            errptr,
        );
    }

    pub fn getPinned(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        api.rocksdb_transactiondb_get_pinned(
            txn_db,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn getCf(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        vallen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        api.rocksdb_transactiondb_get_cf(
            txn_db,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            errptr,
        );
    }

    pub fn getPinnedCf(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        api.rocksdb_transactiondb_get_pinned_cf(
            txn_db,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn multiGet(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        api.rocksdb_transactiondb_multi_get(
            txn_db,
            options,
            num_keys,
            keys_list,
            keys_list_sizes,
            values_list,
            values_list_sizes,
            errs,
        );
    }

    pub fn multiGetCf(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_families: [*c]const [*c]const api.rocksdb_column_family_handle_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        values_list: [*c][*c]i8,
        values_list_sizes: [*c]i64,
        errs: [*c][*c]i8,
    ) void {
        api.rocksdb_transactiondb_multi_get_cf(
            txn_db,
            options,
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
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transactiondb_put(
            txn_db,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn putCf(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transactiondb_put_cf(
            txn_db,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn write(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        batch: [*c]api.rocksdb_writebatch_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transactiondb_write(txn_db, options, batch, errptr);
    }

    pub fn merge(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transactiondb_merge(
            txn_db,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn mergeCf(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        val: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transactiondb_merge_cf(
            txn_db,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
            errptr,
        );
    }

    pub fn delete(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transactiondb_delete(
            txn_db,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn deleteCf(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_writeoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transactiondb_delete_cf(
            txn_db,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn createIterator(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_readoptions_t,
    ) [*c]api.rocksdb_iterator_t {
        api.rocksdb_transactiondb_create_iterator(txn_db, options);
    }

    pub fn createIteratorCf(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
    ) [*c]api.rocksdb_iterator_t {
        api.rocksdb_transactiondb_create_iterator_cf(
            txn_db,
            options,
            column_family,
        );
    }

    pub fn close(txn_db: [*c]api.rocksdb_transactiondb_t) void {
        api.rocksdb_transactiondb_close(txn_db);
    }

    pub fn flush(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_flushoptions_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transactiondb_flush(txn_db, options, errptr);
    }

    pub fn flushCf(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_flushoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transactiondb_flush_cf(txn_db, options, column_family, errptr);
    }

    pub fn flushCfs(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        options: [*c]const api.rocksdb_flushoptions_t,
        column_families: [*c][*c]api.rocksdb_column_family_handle_t,
        num_column_families: i64,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transactiondb_flush_cfs(
            txn_db,
            options,
            column_families,
            num_column_families,
            errptr,
        );
    }

    pub fn flushWal(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        sync: u8,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_transactiondb_flush_wal(txn_db, sync, errptr);
    }

    pub fn checkpointObjectCreate(
        txn_db: [*c]api.rocksdb_transactiondb_t,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_checkpoint_t {
        api.rocksdb_transactiondb_checkpoint_object_create(txn_db, errptr);
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
        api.rocksdb_universal_compaction_options_create();
    }

    pub fn setSizeRatio(
        arg0: [*c]api.rocksdb_universal_compaction_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_universal_compaction_options_set_size_ratio(arg0, arg1);
    }

    pub fn getSizeRatio(arg0: [*c]api.rocksdb_universal_compaction_options_t) i64 {
        api.rocksdb_universal_compaction_options_get_size_ratio(arg0);
    }

    pub fn setMinMergeWidth(
        arg0: [*c]api.rocksdb_universal_compaction_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_universal_compaction_options_set_min_merge_width(arg0, arg1);
    }

    pub fn getMinMergeWidth(
        arg0: [*c]api.rocksdb_universal_compaction_options_t,
    ) i64 {
        api.rocksdb_universal_compaction_options_get_min_merge_width(arg0);
    }

    pub fn setMaxMergeWidth(
        arg0: [*c]api.rocksdb_universal_compaction_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_universal_compaction_options_set_max_merge_width(arg0, arg1);
    }

    pub fn getMaxMergeWidth(
        arg0: [*c]api.rocksdb_universal_compaction_options_t,
    ) i64 {
        api.rocksdb_universal_compaction_options_get_max_merge_width(arg0);
    }

    pub fn setMaxSizeAmplificationPercent(
        arg0: [*c]api.rocksdb_universal_compaction_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_universal_compaction_options_set_max_size_amplification_percent(
            arg0,
            arg1,
        );
    }

    pub fn getMaxSizeAmplificationPercent(
        arg0: [*c]api.rocksdb_universal_compaction_options_t,
    ) i64 {
        api.rocksdb_universal_compaction_options_get_max_size_amplification_percent(
            arg0,
        );
    }

    pub fn setCompressionSizePercent(
        arg0: [*c]api.rocksdb_universal_compaction_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_universal_compaction_options_set_compression_size_percent(
            arg0,
            arg1,
        );
    }

    pub fn getCompressionSizePercent(
        arg0: [*c]api.rocksdb_universal_compaction_options_t,
    ) i64 {
        api.rocksdb_universal_compaction_options_get_compression_size_percent(arg0);
    }

    pub fn setStopStyle(
        arg0: [*c]api.rocksdb_universal_compaction_options_t,
        arg1: i64,
    ) void {
        api.rocksdb_universal_compaction_options_set_stop_style(arg0, arg1);
    }

    pub fn getStopStyle(arg0: [*c]api.rocksdb_universal_compaction_options_t) i64 {
        api.rocksdb_universal_compaction_options_get_stop_style(arg0);
    }

    pub fn destroy(arg0: [*c]api.rocksdb_universal_compaction_options_t) void {
        api.rocksdb_universal_compaction_options_destroy(arg0);
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
        api.rocksdb_wait_for_compact_options_create();
    }

    pub fn destroy(opt: [*c]api.rocksdb_wait_for_compact_options_t) void {
        api.rocksdb_wait_for_compact_options_destroy(opt);
    }

    pub fn setAbortOnPause(
        opt: [*c]api.rocksdb_wait_for_compact_options_t,
        v: u8,
    ) void {
        api.rocksdb_wait_for_compact_options_set_abort_on_pause(opt, v);
    }

    pub fn getAbortOnPause(opt: [*c]api.rocksdb_wait_for_compact_options_t) u8 {
        api.rocksdb_wait_for_compact_options_get_abort_on_pause(opt);
    }

    pub fn setFlush(opt: [*c]api.rocksdb_wait_for_compact_options_t, v: u8) void {
        api.rocksdb_wait_for_compact_options_set_flush(opt, v);
    }

    pub fn getFlush(opt: [*c]api.rocksdb_wait_for_compact_options_t) u8 {
        api.rocksdb_wait_for_compact_options_get_flush(opt);
    }

    pub fn setCloseDb(opt: [*c]api.rocksdb_wait_for_compact_options_t, v: u8) void {
        api.rocksdb_wait_for_compact_options_set_close_db(opt, v);
    }

    pub fn getCloseDb(opt: [*c]api.rocksdb_wait_for_compact_options_t) u8 {
        api.rocksdb_wait_for_compact_options_get_close_db(opt);
    }

    pub fn setTimeout(
        opt: [*c]api.rocksdb_wait_for_compact_options_t,
        microseconds: i64,
    ) void {
        api.rocksdb_wait_for_compact_options_set_timeout(opt, microseconds);
    }

    pub fn getTimeout(opt: [*c]api.rocksdb_wait_for_compact_options_t) i64 {
        api.rocksdb_wait_for_compact_options_get_timeout(opt);
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

    pub fn next(iter: [*c]api.rocksdb_wal_iterator_t) void {
        api.rocksdb_wal_iter_next(iter);
    }

    pub fn valid(arg0: [*c]const api.rocksdb_wal_iterator_t) u8 {
        api.rocksdb_wal_iter_valid(arg0);
    }

    pub fn status(
        iter: [*c]const api.rocksdb_wal_iterator_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_wal_iter_status(iter, errptr);
    }

    pub fn destroy(iter: [*c]const api.rocksdb_wal_iterator_t) void {
        api.rocksdb_wal_iter_destroy(iter);
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
        api.rocksdb_write_buffer_manager_create(buffer_size, allow_stall);
    }

    pub fn createWithCache(
        buffer_size: i64,
        cache: [*c]const api.rocksdb_cache_t,
        allow_stall: i64,
    ) [*c]api.rocksdb_write_buffer_manager_t {
        api.rocksdb_write_buffer_manager_create_with_cache(
            buffer_size,
            cache,
            allow_stall,
        );
    }

    pub fn destroy(wbm: [*c]api.rocksdb_write_buffer_manager_t) void {
        api.rocksdb_write_buffer_manager_destroy(wbm);
    }

    pub fn enabled(wbm: [*c]api.rocksdb_write_buffer_manager_t) i64 {
        api.rocksdb_write_buffer_manager_enabled(wbm);
    }

    pub fn costToCache(wbm: [*c]api.rocksdb_write_buffer_manager_t) i64 {
        api.rocksdb_write_buffer_manager_cost_to_cache(wbm);
    }

    pub fn memoryUsage(wbm: [*c]api.rocksdb_write_buffer_manager_t) i64 {
        api.rocksdb_write_buffer_manager_memory_usage(wbm);
    }

    pub fn mutableMemtableMemoryUsage(
        wbm: [*c]api.rocksdb_write_buffer_manager_t,
    ) i64 {
        api.rocksdb_write_buffer_manager_mutable_memtable_memory_usage(wbm);
    }

    pub fn dummyEntriesInCacheUsage(
        wbm: [*c]api.rocksdb_write_buffer_manager_t,
    ) i64 {
        api.rocksdb_write_buffer_manager_dummy_entries_in_cache_usage(wbm);
    }

    pub fn bufferSize(wbm: [*c]api.rocksdb_write_buffer_manager_t) i64 {
        api.rocksdb_write_buffer_manager_buffer_size(wbm);
    }

    pub fn setBufferSize(
        wbm: [*c]api.rocksdb_write_buffer_manager_t,
        new_size: i64,
    ) void {
        api.rocksdb_write_buffer_manager_set_buffer_size(wbm, new_size);
    }

    pub fn setAllowStall(
        wbm: [*c]api.rocksdb_write_buffer_manager_t,
        new_allow_stall: i64,
    ) void {
        api.rocksdb_write_buffer_manager_set_allow_stall(wbm, new_allow_stall);
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
        iter: [*c]const api.rocksdb_wal_iterator_t,
        seq: [*c]i64,
    ) [*c]api.rocksdb_writebatch_t {
        api.rocksdb_wal_iter_get_batch(iter, seq);
    }

    pub fn create() [*c]api.rocksdb_writebatch_t {
        api.rocksdb_writebatch_create();
    }

    pub fn createFrom(rep: [*c]const i8, size: i64) [*c]api.rocksdb_writebatch_t {
        api.rocksdb_writebatch_create_from(rep, size);
    }

    pub fn createWithParams(
        reserved_bytes: i64,
        max_bytes: i64,
        protection_bytes_per_key: i64,
        default_cf_ts_sz: i64,
    ) [*c]api.rocksdb_writebatch_t {
        api.rocksdb_writebatch_create_with_params(
            reserved_bytes,
            max_bytes,
            protection_bytes_per_key,
            default_cf_ts_sz,
        );
    }

    pub fn destroy(arg0: [*c]api.rocksdb_writebatch_t) void {
        api.rocksdb_writebatch_destroy(arg0);
    }

    pub fn clear(arg0: [*c]api.rocksdb_writebatch_t) void {
        api.rocksdb_writebatch_clear(arg0);
    }

    pub fn count(arg0: [*c]api.rocksdb_writebatch_t) i64 {
        api.rocksdb_writebatch_count(arg0);
    }

    pub fn put(
        arg0: [*c]api.rocksdb_writebatch_t,
        key: []const u8,
        val: []const u8,
    ) void {
        api.rocksdb_writebatch_put(
            arg0,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn putCf(
        arg0: [*c]api.rocksdb_writebatch_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        val: []const u8,
    ) void {
        api.rocksdb_writebatch_put_cf(
            arg0,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn putCfWithTs(
        arg0: [*c]api.rocksdb_writebatch_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        ts: []const u8,
        val: []const u8,
    ) void {
        api.rocksdb_writebatch_put_cf_with_ts(
            arg0,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn putv(
        b: [*c]api.rocksdb_writebatch_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        num_values: i64,
        values_list: [*c]const [*c]const i8,
        values_list_sizes: [*c]const i64,
    ) void {
        api.rocksdb_writebatch_putv(
            b,
            num_keys,
            keys_list,
            keys_list_sizes,
            num_values,
            values_list,
            values_list_sizes,
        );
    }

    pub fn putvCf(
        b: [*c]api.rocksdb_writebatch_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        num_values: i64,
        values_list: [*c]const [*c]const i8,
        values_list_sizes: [*c]const i64,
    ) void {
        api.rocksdb_writebatch_putv_cf(
            b,
            column_family,
            num_keys,
            keys_list,
            keys_list_sizes,
            num_values,
            values_list,
            values_list_sizes,
        );
    }

    pub fn merge(
        arg0: [*c]api.rocksdb_writebatch_t,
        key: []const u8,
        val: []const u8,
    ) void {
        api.rocksdb_writebatch_merge(
            arg0,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn mergeCf(
        arg0: [*c]api.rocksdb_writebatch_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        val: []const u8,
    ) void {
        api.rocksdb_writebatch_merge_cf(
            arg0,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn mergev(
        b: [*c]api.rocksdb_writebatch_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        num_values: i64,
        values_list: [*c]const [*c]const i8,
        values_list_sizes: [*c]const i64,
    ) void {
        api.rocksdb_writebatch_mergev(
            b,
            num_keys,
            keys_list,
            keys_list_sizes,
            num_values,
            values_list,
            values_list_sizes,
        );
    }

    pub fn mergevCf(
        b: [*c]api.rocksdb_writebatch_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        num_values: i64,
        values_list: [*c]const [*c]const i8,
        values_list_sizes: [*c]const i64,
    ) void {
        api.rocksdb_writebatch_mergev_cf(
            b,
            column_family,
            num_keys,
            keys_list,
            keys_list_sizes,
            num_values,
            values_list,
            values_list_sizes,
        );
    }

    pub fn delete(arg0: [*c]api.rocksdb_writebatch_t, key: []const u8) void {
        api.rocksdb_writebatch_delete(arg0, @ptrCast(key.ptr), @intCast(key.len));
    }

    pub fn singledelete(b: [*c]api.rocksdb_writebatch_t, key: []const u8) void {
        api.rocksdb_writebatch_singledelete(
            b,
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn deleteCf(
        arg0: [*c]api.rocksdb_writebatch_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
    ) void {
        api.rocksdb_writebatch_delete_cf(
            arg0,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn deleteCfWithTs(
        arg0: [*c]api.rocksdb_writebatch_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        ts: []const u8,
    ) void {
        api.rocksdb_writebatch_delete_cf_with_ts(
            arg0,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
        );
    }

    pub fn singledeleteCf(
        b: [*c]api.rocksdb_writebatch_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
    ) void {
        api.rocksdb_writebatch_singledelete_cf(
            b,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn singledeleteCfWithTs(
        b: [*c]api.rocksdb_writebatch_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        ts: []const u8,
    ) void {
        api.rocksdb_writebatch_singledelete_cf_with_ts(
            b,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(ts.ptr),
            @intCast(ts.len),
        );
    }

    pub fn deletev(
        b: [*c]api.rocksdb_writebatch_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
    ) void {
        api.rocksdb_writebatch_deletev(b, num_keys, keys_list, keys_list_sizes);
    }

    pub fn deletevCf(
        b: [*c]api.rocksdb_writebatch_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
    ) void {
        api.rocksdb_writebatch_deletev_cf(
            b,
            column_family,
            num_keys,
            keys_list,
            keys_list_sizes,
        );
    }

    pub fn deleteRange(
        b: [*c]api.rocksdb_writebatch_t,
        start_key: []const u8,
        end_key: []const u8,
    ) void {
        api.rocksdb_writebatch_delete_range(
            b,
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(end_key.ptr),
            @intCast(end_key.len),
        );
    }

    pub fn deleteRangeCf(
        b: [*c]api.rocksdb_writebatch_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        start_key: []const u8,
        end_key: []const u8,
    ) void {
        api.rocksdb_writebatch_delete_range_cf(
            b,
            column_family,
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(end_key.ptr),
            @intCast(end_key.len),
        );
    }

    pub fn deleteRangev(
        b: [*c]api.rocksdb_writebatch_t,
        num_keys: i64,
        start_keys_list: [*c]const [*c]const i8,
        start_keys_list_sizes: [*c]const i64,
        end_keys_list: [*c]const [*c]const i8,
        end_keys_list_sizes: [*c]const i64,
    ) void {
        api.rocksdb_writebatch_delete_rangev(
            b,
            num_keys,
            start_keys_list,
            start_keys_list_sizes,
            end_keys_list,
            end_keys_list_sizes,
        );
    }

    pub fn deleteRangevCf(
        b: [*c]api.rocksdb_writebatch_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        num_keys: i64,
        start_keys_list: [*c]const [*c]const i8,
        start_keys_list_sizes: [*c]const i64,
        end_keys_list: [*c]const [*c]const i8,
        end_keys_list_sizes: [*c]const i64,
    ) void {
        api.rocksdb_writebatch_delete_rangev_cf(
            b,
            column_family,
            num_keys,
            start_keys_list,
            start_keys_list_sizes,
            end_keys_list,
            end_keys_list_sizes,
        );
    }

    pub fn putLogData(arg0: [*c]api.rocksdb_writebatch_t, blob: []const u8) void {
        api.rocksdb_writebatch_put_log_data(
            arg0,
            @ptrCast(blob.ptr),
            @intCast(blob.len),
        );
    }

    pub fn iterate(
        arg0: [*c]api.rocksdb_writebatch_t,
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
        api.rocksdb_writebatch_iterate(arg0, state, put_, deleted);
    }

    pub fn iterateCf(
        arg0: [*c]api.rocksdb_writebatch_t,
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
        api.rocksdb_writebatch_iterate_cf(
            arg0,
            state,
            put_cf,
            deleted_cf,
            merge_cf,
        );
    }

    pub fn data(arg0: [*c]api.rocksdb_writebatch_t, size: [*c]i64) [*c]const i8 {
        api.rocksdb_writebatch_data(arg0, size);
    }

    pub fn setSavePoint(arg0: [*c]api.rocksdb_writebatch_t) void {
        api.rocksdb_writebatch_set_save_point(arg0);
    }

    pub fn rollbackToSavePoint(
        arg0: [*c]api.rocksdb_writebatch_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_writebatch_rollback_to_save_point(arg0, errptr);
    }

    pub fn popSavePoint(
        arg0: [*c]api.rocksdb_writebatch_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_writebatch_pop_save_point(arg0, errptr);
    }

    pub fn updateTimestamps(
        wb: [*c]api.rocksdb_writebatch_t,
        ts: []const u8,
        state: *anyopaque,
        size_t: fn (
            [*c]i64,
        ) i64,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_writebatch_update_timestamps(
            wb,
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
        api.rocksdb_writebatch_wi_create(reserved_bytes, overwrite_keys);
    }

    pub fn createFrom(rep: [*c]const i8, size: i64) [*c]api.rocksdb_writebatch_wi_t {
        api.rocksdb_writebatch_wi_create_from(rep, size);
    }

    pub fn createWithParams(
        backup_index_comparator: [*c]api.rocksdb_comparator_t,
        reserved_bytes: i64,
        overwrite_key: u8,
        max_bytes: i64,
        protection_bytes_per_key: i64,
    ) [*c]api.rocksdb_writebatch_wi_t {
        api.rocksdb_writebatch_wi_create_with_params(
            backup_index_comparator,
            reserved_bytes,
            overwrite_key,
            max_bytes,
            protection_bytes_per_key,
        );
    }

    pub fn destroy(arg0: [*c]api.rocksdb_writebatch_wi_t) void {
        api.rocksdb_writebatch_wi_destroy(arg0);
    }

    pub fn clear(arg0: [*c]api.rocksdb_writebatch_wi_t) void {
        api.rocksdb_writebatch_wi_clear(arg0);
    }

    pub fn count(b: [*c]api.rocksdb_writebatch_wi_t) i64 {
        api.rocksdb_writebatch_wi_count(b);
    }

    pub fn put(
        arg0: [*c]api.rocksdb_writebatch_wi_t,
        key: []const u8,
        val: []const u8,
    ) void {
        api.rocksdb_writebatch_wi_put(
            arg0,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn putCf(
        arg0: [*c]api.rocksdb_writebatch_wi_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        val: []const u8,
    ) void {
        api.rocksdb_writebatch_wi_put_cf(
            arg0,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn putv(
        b: [*c]api.rocksdb_writebatch_wi_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        num_values: i64,
        values_list: [*c]const [*c]const i8,
        values_list_sizes: [*c]const i64,
    ) void {
        api.rocksdb_writebatch_wi_putv(
            b,
            num_keys,
            keys_list,
            keys_list_sizes,
            num_values,
            values_list,
            values_list_sizes,
        );
    }

    pub fn putvCf(
        b: [*c]api.rocksdb_writebatch_wi_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        num_values: i64,
        values_list: [*c]const [*c]const i8,
        values_list_sizes: [*c]const i64,
    ) void {
        api.rocksdb_writebatch_wi_putv_cf(
            b,
            column_family,
            num_keys,
            keys_list,
            keys_list_sizes,
            num_values,
            values_list,
            values_list_sizes,
        );
    }

    pub fn merge(
        arg0: [*c]api.rocksdb_writebatch_wi_t,
        key: []const u8,
        val: []const u8,
    ) void {
        api.rocksdb_writebatch_wi_merge(
            arg0,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn mergeCf(
        arg0: [*c]api.rocksdb_writebatch_wi_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        val: []const u8,
    ) void {
        api.rocksdb_writebatch_wi_merge_cf(
            arg0,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            @ptrCast(val.ptr),
            @intCast(val.len),
        );
    }

    pub fn mergev(
        b: [*c]api.rocksdb_writebatch_wi_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        num_values: i64,
        values_list: [*c]const [*c]const i8,
        values_list_sizes: [*c]const i64,
    ) void {
        api.rocksdb_writebatch_wi_mergev(
            b,
            num_keys,
            keys_list,
            keys_list_sizes,
            num_values,
            values_list,
            values_list_sizes,
        );
    }

    pub fn mergevCf(
        b: [*c]api.rocksdb_writebatch_wi_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
        num_values: i64,
        values_list: [*c]const [*c]const i8,
        values_list_sizes: [*c]const i64,
    ) void {
        api.rocksdb_writebatch_wi_mergev_cf(
            b,
            column_family,
            num_keys,
            keys_list,
            keys_list_sizes,
            num_values,
            values_list,
            values_list_sizes,
        );
    }

    pub fn delete(arg0: [*c]api.rocksdb_writebatch_wi_t, key: []const u8) void {
        api.rocksdb_writebatch_wi_delete(
            arg0,
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn singledelete(
        arg0: [*c]api.rocksdb_writebatch_wi_t,
        key: []const u8,
    ) void {
        api.rocksdb_writebatch_wi_singledelete(
            arg0,
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn deleteCf(
        arg0: [*c]api.rocksdb_writebatch_wi_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
    ) void {
        api.rocksdb_writebatch_wi_delete_cf(
            arg0,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn singledeleteCf(
        arg0: [*c]api.rocksdb_writebatch_wi_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
    ) void {
        api.rocksdb_writebatch_wi_singledelete_cf(
            arg0,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
        );
    }

    pub fn deletev(
        b: [*c]api.rocksdb_writebatch_wi_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
    ) void {
        api.rocksdb_writebatch_wi_deletev(b, num_keys, keys_list, keys_list_sizes);
    }

    pub fn deletevCf(
        b: [*c]api.rocksdb_writebatch_wi_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        num_keys: i64,
        keys_list: [*c]const [*c]const i8,
        keys_list_sizes: [*c]const i64,
    ) void {
        api.rocksdb_writebatch_wi_deletev_cf(
            b,
            column_family,
            num_keys,
            keys_list,
            keys_list_sizes,
        );
    }

    pub fn deleteRange(
        b: [*c]api.rocksdb_writebatch_wi_t,
        start_key: []const u8,
        end_key: []const u8,
    ) void {
        api.rocksdb_writebatch_wi_delete_range(
            b,
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(end_key.ptr),
            @intCast(end_key.len),
        );
    }

    pub fn deleteRangeCf(
        b: [*c]api.rocksdb_writebatch_wi_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        start_key: []const u8,
        end_key: []const u8,
    ) void {
        api.rocksdb_writebatch_wi_delete_range_cf(
            b,
            column_family,
            @ptrCast(start_key.ptr),
            @intCast(start_key.len),
            @ptrCast(end_key.ptr),
            @intCast(end_key.len),
        );
    }

    pub fn deleteRangev(
        b: [*c]api.rocksdb_writebatch_wi_t,
        num_keys: i64,
        start_keys_list: [*c]const [*c]const i8,
        start_keys_list_sizes: [*c]const i64,
        end_keys_list: [*c]const [*c]const i8,
        end_keys_list_sizes: [*c]const i64,
    ) void {
        api.rocksdb_writebatch_wi_delete_rangev(
            b,
            num_keys,
            start_keys_list,
            start_keys_list_sizes,
            end_keys_list,
            end_keys_list_sizes,
        );
    }

    pub fn deleteRangevCf(
        b: [*c]api.rocksdb_writebatch_wi_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        num_keys: i64,
        start_keys_list: [*c]const [*c]const i8,
        start_keys_list_sizes: [*c]const i64,
        end_keys_list: [*c]const [*c]const i8,
        end_keys_list_sizes: [*c]const i64,
    ) void {
        api.rocksdb_writebatch_wi_delete_rangev_cf(
            b,
            column_family,
            num_keys,
            start_keys_list,
            start_keys_list_sizes,
            end_keys_list,
            end_keys_list_sizes,
        );
    }

    pub fn putLogData(arg0: [*c]api.rocksdb_writebatch_wi_t, blob: []const u8) void {
        api.rocksdb_writebatch_wi_put_log_data(
            arg0,
            @ptrCast(blob.ptr),
            @intCast(blob.len),
        );
    }

    pub fn iterate(
        b: [*c]api.rocksdb_writebatch_wi_t,
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
        api.rocksdb_writebatch_wi_iterate(b, state, put_, deleted);
    }

    pub fn data(b: [*c]api.rocksdb_writebatch_wi_t, size: [*c]i64) [*c]const i8 {
        api.rocksdb_writebatch_wi_data(b, size);
    }

    pub fn setSavePoint(arg0: [*c]api.rocksdb_writebatch_wi_t) void {
        api.rocksdb_writebatch_wi_set_save_point(arg0);
    }

    pub fn rollbackToSavePoint(
        arg0: [*c]api.rocksdb_writebatch_wi_t,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_writebatch_wi_rollback_to_save_point(arg0, errptr);
    }

    pub fn getFromBatch(
        wbwi: [*c]api.rocksdb_writebatch_wi_t,
        options: [*c]const api.rocksdb_options_t,
        key: []const u8,
        vallen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        api.rocksdb_writebatch_wi_get_from_batch(
            wbwi,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            errptr,
        );
    }

    pub fn getFromBatchCf(
        wbwi: [*c]api.rocksdb_writebatch_wi_t,
        options: [*c]const api.rocksdb_options_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        vallen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        api.rocksdb_writebatch_wi_get_from_batch_cf(
            wbwi,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            errptr,
        );
    }

    pub fn getFromBatchAndDb(
        wbwi: [*c]api.rocksdb_writebatch_wi_t,
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        key: []const u8,
        vallen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        api.rocksdb_writebatch_wi_get_from_batch_and_db(
            wbwi,
            db,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            errptr,
        );
    }

    pub fn getPinnedFromBatchAndDb(
        wbwi: [*c]api.rocksdb_writebatch_wi_t,
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        api.rocksdb_writebatch_wi_get_pinned_from_batch_and_db(
            wbwi,
            db,
            options,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn getFromBatchAndDbCf(
        wbwi: [*c]api.rocksdb_writebatch_wi_t,
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        vallen: [*c]i64,
        errptr: [*c][*c]i8,
    ) [*c]i8 {
        api.rocksdb_writebatch_wi_get_from_batch_and_db_cf(
            wbwi,
            db,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            vallen,
            errptr,
        );
    }

    pub fn getPinnedFromBatchAndDbCf(
        wbwi: [*c]api.rocksdb_writebatch_wi_t,
        db: [*c]api.rocksdb_t,
        options: [*c]const api.rocksdb_readoptions_t,
        column_family: [*c]api.rocksdb_column_family_handle_t,
        key: []const u8,
        errptr: [*c][*c]i8,
    ) [*c]api.rocksdb_pinnableslice_t {
        api.rocksdb_writebatch_wi_get_pinned_from_batch_and_db_cf(
            wbwi,
            db,
            options,
            column_family,
            @ptrCast(key.ptr),
            @intCast(key.len),
            errptr,
        );
    }

    pub fn createIteratorWithBase(
        wbwi: [*c]api.rocksdb_writebatch_wi_t,
        base_iterator: [*c]api.rocksdb_iterator_t,
    ) [*c]api.rocksdb_iterator_t {
        api.rocksdb_writebatch_wi_create_iterator_with_base(wbwi, base_iterator);
    }

    pub fn createIteratorWithBaseReadopts(
        wbwi: [*c]api.rocksdb_writebatch_wi_t,
        base_iterator: [*c]api.rocksdb_iterator_t,
        options: [*c]const api.rocksdb_readoptions_t,
    ) [*c]api.rocksdb_iterator_t {
        api.rocksdb_writebatch_wi_create_iterator_with_base_readopts(
            wbwi,
            base_iterator,
            options,
        );
    }

    pub fn createIteratorWithBaseCf(
        wbwi: [*c]api.rocksdb_writebatch_wi_t,
        base_iterator: [*c]api.rocksdb_iterator_t,
        cf: [*c]api.rocksdb_column_family_handle_t,
    ) [*c]api.rocksdb_iterator_t {
        api.rocksdb_writebatch_wi_create_iterator_with_base_cf(
            wbwi,
            base_iterator,
            cf,
        );
    }

    pub fn createIteratorWithBaseCfReadopts(
        wbwi: [*c]api.rocksdb_writebatch_wi_t,
        base_iterator: [*c]api.rocksdb_iterator_t,
        cf: [*c]api.rocksdb_column_family_handle_t,
        options: [*c]const api.rocksdb_readoptions_t,
    ) [*c]api.rocksdb_iterator_t {
        api.rocksdb_writebatch_wi_create_iterator_with_base_cf_readopts(
            wbwi,
            base_iterator,
            cf,
            options,
        );
    }

    pub fn updateTimestamps(
        wbwi: [*c]api.rocksdb_writebatch_wi_t,
        ts: []const u8,
        state: *anyopaque,
        size_t: fn (
            [*c]i64,
        ) i64,
        errptr: [*c][*c]i8,
    ) void {
        api.rocksdb_writebatch_wi_update_timestamps(
            wbwi,
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
        api.rocksdb_writeoptions_create();
    }

    pub fn destroy(arg0: [*c]api.rocksdb_writeoptions_t) void {
        api.rocksdb_writeoptions_destroy(arg0);
    }

    pub fn setSync(arg0: [*c]api.rocksdb_writeoptions_t, arg1: u8) void {
        api.rocksdb_writeoptions_set_sync(arg0, arg1);
    }

    pub fn getSync(arg0: [*c]api.rocksdb_writeoptions_t) u8 {
        api.rocksdb_writeoptions_get_sync(arg0);
    }

    pub fn disableWal(opt: [*c]api.rocksdb_writeoptions_t, disable: i64) void {
        api.rocksdb_writeoptions_disable_WAL(opt, disable);
    }

    pub fn getDisableWal(opt: [*c]api.rocksdb_writeoptions_t) u8 {
        api.rocksdb_writeoptions_get_disable_WAL(opt);
    }

    pub fn setIgnoreMissingColumnFamilies(
        arg0: [*c]api.rocksdb_writeoptions_t,
        arg1: u8,
    ) void {
        api.rocksdb_writeoptions_set_ignore_missing_column_families(arg0, arg1);
    }

    pub fn getIgnoreMissingColumnFamilies(arg0: [*c]api.rocksdb_writeoptions_t) u8 {
        api.rocksdb_writeoptions_get_ignore_missing_column_families(arg0);
    }

    pub fn setNoSlowdown(arg0: [*c]api.rocksdb_writeoptions_t, arg1: u8) void {
        api.rocksdb_writeoptions_set_no_slowdown(arg0, arg1);
    }

    pub fn getNoSlowdown(arg0: [*c]api.rocksdb_writeoptions_t) u8 {
        api.rocksdb_writeoptions_get_no_slowdown(arg0);
    }

    pub fn setLowPri(arg0: [*c]api.rocksdb_writeoptions_t, arg1: u8) void {
        api.rocksdb_writeoptions_set_low_pri(arg0, arg1);
    }

    pub fn getLowPri(arg0: [*c]api.rocksdb_writeoptions_t) u8 {
        api.rocksdb_writeoptions_get_low_pri(arg0);
    }

    pub fn setMemtableInsertHintPerBatch(
        arg0: [*c]api.rocksdb_writeoptions_t,
        arg1: u8,
    ) void {
        api.rocksdb_writeoptions_set_memtable_insert_hint_per_batch(arg0, arg1);
    }

    pub fn getMemtableInsertHintPerBatch(arg0: [*c]api.rocksdb_writeoptions_t) u8 {
        api.rocksdb_writeoptions_get_memtable_insert_hint_per_batch(arg0);
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

    pub fn cfName(
        arg0: [*c]const api.rocksdb_writestallinfo_t,
        arg1: [*c]i64,
    ) [*c]const i8 {
        api.rocksdb_writestallinfo_cf_name(arg0, arg1);
    }

    pub fn cur(
        arg0: [*c]const api.rocksdb_writestallinfo_t,
    ) [*c]const api.rocksdb_writestallcondition_t {
        api.rocksdb_writestallinfo_cur(arg0);
    }

    pub fn prev(
        arg0: [*c]const api.rocksdb_writestallinfo_t,
    ) [*c]const api.rocksdb_writestallcondition_t {
        api.rocksdb_writestallinfo_prev(arg0);
    }

    test RocksdbWritestallinfo {
        comptime {
            std.testing.expectEqual(@sizeOf(Self), 8);
        }
        std.testing.refAllDecls(Self);
    }
};
