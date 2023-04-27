Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA08C6F0E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344256AbjD0WVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344007AbjD0WVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:21:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7AF3C01
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682634090; x=1714170090;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xn8Q/ukJMWhDCdLH8ZxmUSJmzivcGakOmczQ0cA6aJU=;
  b=OV4sSa2uNpjPQH8lUDfawT6vhpBQkH2X6TVxDr8WT40zp4VaPPebhSQe
   B5q9ukryYrJks6t2bpJ3vVpmMNR6mrmNVrLAu4VCkoPjg2eJFnxlCl5kQ
   IABH2wF81NDnvUSB5bMGh5UD0/4WTl9AHjFJYqwk+tcOZVy/DeLnLJ9Dm
   3U3FXPHluwCtI0ZEV+1mBJCt/1ZuCMcTefyvgDImWY6sKarGXFeYbQSsG
   sbh43wFdvwnnWNmdy8acmGLz1JpXw0C2iZCc3QgZB4Bkt7O61R1RnHNtl
   +dvLH7fz/8vQxlxnrrDtEoNeWZWLf2FUlbrp5GrSf0UaXfxHcLT7Hlbjz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="347609748"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="347609748"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 15:21:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="727310403"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="727310403"
Received: from lkp-server01.sh.intel.com (HELO b95e16499b55) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Apr 2023 15:21:28 -0700
Received: from kbuild by b95e16499b55 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ps9zT-00009n-25;
        Thu, 27 Apr 2023 22:21:27 +0000
Date:   Fri, 28 Apr 2023 06:21:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: fs/ext4/super.c:1262:13: warning: unused variable 'i'
Message-ID: <202304280650.3eVEESjh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cec24b8b6bb841a19b5c5555b600a511a8988100
commit: dcbf87589d90e3bd5a5a4cf832517f22f3c55efb ext4: factor out ext4_flex_groups_free()
date:   13 days ago
config: x86_64-randconfig-a002 (https://download.01.org/0day-ci/archive/20230428/202304280650.3eVEESjh-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dcbf87589d90e3bd5a5a4cf832517f22f3c55efb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dcbf87589d90e3bd5a5a4cf832517f22f3c55efb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304280650.3eVEESjh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ext4/super.c: In function 'ext4_put_super':
>> fs/ext4/super.c:1262:13: warning: unused variable 'i' [-Wunused-variable]
    1262 |         int i, err;
         |             ^
   fs/ext4/super.c: In function '__ext4_fill_super':
   fs/ext4/super.c:5104:22: warning: unused variable 'i' [-Wunused-variable]
    5104 |         unsigned int i;
         |                      ^


vim +/i +1262 fs/ext4/super.c

dcbf87589d90e3 Jason Yan               2023-03-23  1256  
617ba13b31fbf5 Mingming Cao            2006-10-11  1257  static void ext4_put_super(struct super_block *sb)
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1258  {
617ba13b31fbf5 Mingming Cao            2006-10-11  1259  	struct ext4_sb_info *sbi = EXT4_SB(sb);
617ba13b31fbf5 Mingming Cao            2006-10-11  1260  	struct ext4_super_block *es = sbi->s_es;
97abd7d4b5d9c4 Theodore Ts'o           2017-02-04  1261  	int aborted = 0;
ef2cabf7c6d838 Hidehiro Kawai          2008-10-27 @1262  	int i, err;
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1263  
5e47868fb94b63 Ritesh Harjani          2020-03-18  1264  	/*
5e47868fb94b63 Ritesh Harjani          2020-03-18  1265  	 * Unregister sysfs before destroying jbd2 journal.
5e47868fb94b63 Ritesh Harjani          2020-03-18  1266  	 * Since we could still access attr_journal_task attribute via sysfs
5e47868fb94b63 Ritesh Harjani          2020-03-18  1267  	 * path which could have sbi->s_journal->j_task as NULL
b98535d091795a Ye Bin                  2022-03-22  1268  	 * Unregister sysfs before flush sbi->s_error_work.
b98535d091795a Ye Bin                  2022-03-22  1269  	 * Since user may read /proc/fs/ext4/xx/mb_groups during umount, If
b98535d091795a Ye Bin                  2022-03-22  1270  	 * read metadata verify failed then will queue error work.
b98535d091795a Ye Bin                  2022-03-22  1271  	 * flush_stashed_error_work will call start_this_handle may trigger
b98535d091795a Ye Bin                  2022-03-22  1272  	 * BUG_ON.
5e47868fb94b63 Ritesh Harjani          2020-03-18  1273  	 */
5e47868fb94b63 Ritesh Harjani          2020-03-18  1274  	ext4_unregister_sysfs(sb);
5e47868fb94b63 Ritesh Harjani          2020-03-18  1275  
4808cb5b98b436 Zhang Yi                2022-04-12  1276  	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs unmount"))
bb0fbc782ee9fa Lukas Czerner           2022-11-08  1277  		ext4_msg(sb, KERN_INFO, "unmounting filesystem %pU.",
bb0fbc782ee9fa Lukas Czerner           2022-11-08  1278  			 &sb->s_uuid);
4808cb5b98b436 Zhang Yi                2022-04-12  1279  
b98535d091795a Ye Bin                  2022-03-22  1280  	ext4_unregister_li_request(sb);
b98535d091795a Ye Bin                  2022-03-22  1281  	ext4_quota_off_umount(sb);
b98535d091795a Ye Bin                  2022-03-22  1282  
b98535d091795a Ye Bin                  2022-03-22  1283  	flush_work(&sbi->s_error_work);
b98535d091795a Ye Bin                  2022-03-22  1284  	destroy_workqueue(sbi->rsv_conversion_wq);
b98535d091795a Ye Bin                  2022-03-22  1285  	ext4_release_orphan_info(sb);
b98535d091795a Ye Bin                  2022-03-22  1286  
0390131ba84fd3 Frank Mayhar            2009-01-07  1287  	if (sbi->s_journal) {
97abd7d4b5d9c4 Theodore Ts'o           2017-02-04  1288  		aborted = is_journal_aborted(sbi->s_journal);
ef2cabf7c6d838 Hidehiro Kawai          2008-10-27  1289  		err = jbd2_journal_destroy(sbi->s_journal);
47b4a50bebfd34 Jan Kara                2008-07-11  1290  		sbi->s_journal = NULL;
878520ac45f9f6 Theodore Ts'o           2019-11-19  1291  		if ((err < 0) && !aborted) {
54d3adbc29f0c7 Theodore Ts'o           2020-03-28  1292  			ext4_abort(sb, -err, "Couldn't clean up the journal");
0390131ba84fd3 Frank Mayhar            2009-01-07  1293  		}
878520ac45f9f6 Theodore Ts'o           2019-11-19  1294  	}
d4edac314e9ad0 Josef Bacik             2009-12-08  1295  
d3922a777f9b4c Zheng Liu               2013-07-01  1296  	ext4_es_unregister_shrinker(sbi);
292a089d78d3e2 Steven Rostedt (Google  2022-12-20  1297) 	timer_shutdown_sync(&sbi->s_err_report);
d4edac314e9ad0 Josef Bacik             2009-12-08  1298  	ext4_release_system_zone(sb);
d4edac314e9ad0 Josef Bacik             2009-12-08  1299  	ext4_mb_release(sb);
d4edac314e9ad0 Josef Bacik             2009-12-08  1300  	ext4_ext_release(sb);
d4edac314e9ad0 Josef Bacik             2009-12-08  1301  
bc98a42c1f7d0f David Howells           2017-07-17  1302  	if (!sb_rdonly(sb) && !aborted) {
e2b911c53584a9 Darrick J. Wong         2015-10-17  1303  		ext4_clear_feature_journal_needs_recovery(sb);
02f310fcf47fa9 Jan Kara                2021-08-16  1304  		ext4_clear_feature_orphan_present(sb);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1305  		es->s_state = cpu_to_le16(sbi->s_mount_state);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1306  	}
bc98a42c1f7d0f David Howells           2017-07-17  1307  	if (!sb_rdonly(sb))
4392fbc4bab57d Jan Kara                2020-12-16  1308  		ext4_commit_super(sb);
a8e25a83245618 Artem Bityutskiy        2012-03-21  1309  
6ef684988816fd Jason Yan               2023-03-23  1310  	ext4_group_desc_free(sbi);
dcbf87589d90e3 Jason Yan               2023-03-23  1311  	ext4_flex_groups_free(sbi);
1f79467c8a6be6 Jason Yan               2023-03-23  1312  	ext4_percpu_param_destroy(sbi);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1313  #ifdef CONFIG_QUOTA
a2d4a646e61954 Jan Kara                2014-09-11  1314  	for (i = 0; i < EXT4_MAXQUOTAS; i++)
33458eaba4dfe7 Theodore Ts'o           2018-10-12  1315  		kfree(get_qf_name(sb, sbi, i));
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1316  #endif
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1317  
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1318  	/* Debugging code just in case the in-memory inode orphan list
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1319  	 * isn't empty.  The on-disk one can be non-empty if we've
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1320  	 * detected an error and taken the fs readonly, but the
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1321  	 * in-memory list had better be clean by this point. */
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1322  	if (!list_empty(&sbi->s_orphan))
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1323  		dump_orphan_list(sb, sbi);
837c23fbc1b812 Chunguang Xu            2020-11-07  1324  	ASSERT(list_empty(&sbi->s_orphan));
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1325  
89d96a6f8e6491 Theodore Ts'o           2015-06-20  1326  	sync_blockdev(sb->s_bdev);
f98393a64ca139 Peter Zijlstra          2007-05-06  1327  	invalidate_bdev(sb->s_bdev);
ee7ed3aa0f0862 Chunguang Xu            2020-09-24  1328  	if (sbi->s_journal_bdev && sbi->s_journal_bdev != sb->s_bdev) {
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1329  		/*
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1330  		 * Invalidate the journal device's buffers.  We don't want them
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1331  		 * floating about in memory - the physical journal device may
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1332  		 * hotswapped, and it breaks the `ro-after' testing code.
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1333  		 */
ee7ed3aa0f0862 Chunguang Xu            2020-09-24  1334  		sync_blockdev(sbi->s_journal_bdev);
ee7ed3aa0f0862 Chunguang Xu            2020-09-24  1335  		invalidate_bdev(sbi->s_journal_bdev);
617ba13b31fbf5 Mingming Cao            2006-10-11  1336  		ext4_blkdev_remove(sbi);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1337  	}
50c15df69e062b Chengguang Xu           2018-12-04  1338  
dec214d00e0d78 Tahsin Erdogan          2017-06-22  1339  	ext4_xattr_destroy_cache(sbi->s_ea_inode_cache);
dec214d00e0d78 Tahsin Erdogan          2017-06-22  1340  	sbi->s_ea_inode_cache = NULL;
50c15df69e062b Chengguang Xu           2018-12-04  1341  
47387409ee2e09 Tahsin Erdogan          2017-06-22  1342  	ext4_xattr_destroy_cache(sbi->s_ea_block_cache);
47387409ee2e09 Tahsin Erdogan          2017-06-22  1343  	sbi->s_ea_block_cache = NULL;
50c15df69e062b Chengguang Xu           2018-12-04  1344  
618f003199c618 Pavel Skripkin          2021-04-30  1345  	ext4_stop_mmpd(sbi);
618f003199c618 Pavel Skripkin          2021-04-30  1346  
9060dd2c5036b1 Eric Sandeen            2016-11-26  1347  	brelse(sbi->s_sbh);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1348  	sb->s_fs_info = NULL;
3197ebdb130473 Theodore Ts'o           2009-03-31  1349  	/*
3197ebdb130473 Theodore Ts'o           2009-03-31  1350  	 * Now that we are completely done shutting down the
3197ebdb130473 Theodore Ts'o           2009-03-31  1351  	 * superblock, we need to actually destroy the kobject.
3197ebdb130473 Theodore Ts'o           2009-03-31  1352  	 */
3197ebdb130473 Theodore Ts'o           2009-03-31  1353  	kobject_put(&sbi->s_kobj);
3197ebdb130473 Theodore Ts'o           2009-03-31  1354  	wait_for_completion(&sbi->s_kobj_unregister);
0441984a339897 Darrick J. Wong         2012-04-29  1355  	if (sbi->s_chksum_driver)
0441984a339897 Darrick J. Wong         2012-04-29  1356  		crypto_free_shash(sbi->s_chksum_driver);
705895b61133ef Pekka Enberg            2009-02-15  1357  	kfree(sbi->s_blockgroup_lock);
8012b866085523 Shiyang Ruan            2022-06-03  1358  	fs_put_dax(sbi->s_daxdev, NULL);
ac4acb1f4b2b6b Eric Biggers            2020-09-16  1359  	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
5298d4bfe80f6a Christoph Hellwig       2022-01-18  1360  #if IS_ENABLED(CONFIG_UNICODE)
f8f4acb6cded4e Daniel Rosenberg        2020-10-28  1361  	utf8_unload(sb->s_encoding);
c83ad55eaa91c8 Gabriel Krisman Bertazi 2019-04-25  1362  #endif
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1363  	kfree(sbi);
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1364  }
ac27a0ec112a08 Dave Kleikamp           2006-10-11  1365  

:::::: The code at line 1262 was first introduced by commit
:::::: ef2cabf7c6d838eb0ee2b4fb8ef84f7c06ce16d9 ext4: fix a bug accessing freed memory in ext4_abort

:::::: TO: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
:::::: CC: Theodore Ts'o <tytso@mit.edu>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
