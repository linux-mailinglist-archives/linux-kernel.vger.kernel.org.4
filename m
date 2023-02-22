Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DFD69FDAC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjBVVXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjBVVXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:23:42 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FFD28D1B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677101019; x=1708637019;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UDv1T1iu2mmeq6HME6ngdE5V7O9PNSWdQoOLPnCsAkE=;
  b=RBhZ3DMZ2EqBwOnPaGH+FZ3SbZO5CGQCeb+wwU4qUsQAxhW7KCy9LaKH
   C+4JLFHrRQ6Q4m0/aJroq53xPCJgMhOHIgZLvo2sJO7D1QM1Rny+RT58c
   mVkp5is2xBfgcOIj0EiC0pNiqViY8vhrmRGoN7ukNtynvGFsmGygWKcYI
   fSUda0q9Hr+LtiMja9S0xVALsnQ6tzsDyJ8weTc8Um668/ECoWO37XipH
   HKvxaGasTNYgj8vP1Kopc5MWhAPMX+6yCbbb/Rh6aSXn0Tol3xD19pI4h
   6wk07r5+y603ExaA7sjVxjlu5Mr39iZ32bqQ0nS32lAQoij1NkchapW72
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="312667910"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="312667910"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 13:23:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="917705661"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="917705661"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Feb 2023 13:23:32 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUwaK-0000k1-0u;
        Wed, 22 Feb 2023 21:23:32 +0000
Date:   Thu, 23 Feb 2023 05:23:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: fs/btrfs/volumes.c:2703:17: warning: 'seed_devices' may be used
 uninitialized in this function
Message-ID: <202302230510.UH48lcwE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5b7c4cabbb65f5c469464da6c5f614cbd7f730f2
commit: 1ec49744ba83f0429c5c706708610f7821a7b6f4 btrfs: turn on -Wmaybe-uninitialized
date:   9 days ago
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20230223/202302230510.UH48lcwE-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1ec49744ba83f0429c5c706708610f7821a7b6f4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1ec49744ba83f0429c5c706708610f7821a7b6f4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302230510.UH48lcwE-lkp@intel.com/

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   fs/btrfs/volumes.c: In function 'btrfs_init_new_device':
>> fs/btrfs/volumes.c:2703:17: warning: 'seed_devices' may be used uninitialized in this function [-Wmaybe-uninitialized]
    2703 |                 btrfs_setup_sprout(fs_info, seed_devices);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/seed_devices +2703 fs/btrfs/volumes.c

2b82032c34ec40 Yan Zheng          2008-11-17  2603  
da353f6b30bc02 David Sterba       2017-02-14  2604  int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path)
788f20eb5affef Chris Mason        2008-04-28  2605  {
5112febbc77283 Jeff Mahoney       2016-06-21  2606  	struct btrfs_root *root = fs_info->dev_root;
788f20eb5affef Chris Mason        2008-04-28  2607  	struct btrfs_trans_handle *trans;
788f20eb5affef Chris Mason        2008-04-28  2608  	struct btrfs_device *device;
788f20eb5affef Chris Mason        2008-04-28  2609  	struct block_device *bdev;
0b246afa62b0cf Jeff Mahoney       2016-06-22  2610  	struct super_block *sb = fs_info->sb;
5da54bc13801d3 Anand Jain         2018-07-03  2611  	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
849eae5e57a703 Anand Jain         2021-11-09  2612  	struct btrfs_fs_devices *seed_devices;
39379faaad79e3 Naohiro Aota       2018-07-27  2613  	u64 orig_super_total_bytes;
39379faaad79e3 Naohiro Aota       2018-07-27  2614  	u64 orig_super_num_devices;
788f20eb5affef Chris Mason        2008-04-28  2615  	int ret = 0;
fd8808097ad23a Anand Jain         2021-09-21  2616  	bool seeding_dev = false;
44cab9ba374a03 Nikolay Borisov    2020-07-22  2617  	bool locked = false;
788f20eb5affef Chris Mason        2008-04-28  2618  
5da54bc13801d3 Anand Jain         2018-07-03  2619  	if (sb_rdonly(sb) && !fs_devices->seeding)
f8c5d0b443ff87 Liu Bo             2012-05-10  2620  		return -EROFS;
788f20eb5affef Chris Mason        2008-04-28  2621  
a5d16333612718 Li Zefan           2011-12-07  2622  	bdev = blkdev_get_by_path(device_path, FMODE_WRITE | FMODE_EXCL,
0b246afa62b0cf Jeff Mahoney       2016-06-22  2623  				  fs_info->bdev_holder);
7f59203abeaf18 Josef Bacik        2010-01-27  2624  	if (IS_ERR(bdev))
7f59203abeaf18 Josef Bacik        2010-01-27  2625  		return PTR_ERR(bdev);
a213501153fd66 Chris Mason        2008-06-25  2626  
b70f509774ad4b Naohiro Aota       2020-11-10  2627  	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
b70f509774ad4b Naohiro Aota       2020-11-10  2628  		ret = -EINVAL;
b70f509774ad4b Naohiro Aota       2020-11-10  2629  		goto error;
b70f509774ad4b Naohiro Aota       2020-11-10  2630  	}
b70f509774ad4b Naohiro Aota       2020-11-10  2631  
5da54bc13801d3 Anand Jain         2018-07-03  2632  	if (fs_devices->seeding) {
fd8808097ad23a Anand Jain         2021-09-21  2633  		seeding_dev = true;
2b82032c34ec40 Yan Zheng          2008-11-17  2634  		down_write(&sb->s_umount);
2b82032c34ec40 Yan Zheng          2008-11-17  2635  		mutex_lock(&uuid_mutex);
44cab9ba374a03 Nikolay Borisov    2020-07-22  2636  		locked = true;
2b82032c34ec40 Yan Zheng          2008-11-17  2637  	}
2b82032c34ec40 Yan Zheng          2008-11-17  2638  
b9ba017fb0771f Nikolay Borisov    2020-07-22  2639  	sync_blockdev(bdev);
a213501153fd66 Chris Mason        2008-06-25  2640  
f4cfa9bdd40c03 Nikolay Borisov    2020-07-22  2641  	rcu_read_lock();
f4cfa9bdd40c03 Nikolay Borisov    2020-07-22  2642  	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
788f20eb5affef Chris Mason        2008-04-28  2643  		if (device->bdev == bdev) {
788f20eb5affef Chris Mason        2008-04-28  2644  			ret = -EEXIST;
f4cfa9bdd40c03 Nikolay Borisov    2020-07-22  2645  			rcu_read_unlock();
2b82032c34ec40 Yan Zheng          2008-11-17  2646  			goto error;
788f20eb5affef Chris Mason        2008-04-28  2647  		}
788f20eb5affef Chris Mason        2008-04-28  2648  	}
f4cfa9bdd40c03 Nikolay Borisov    2020-07-22  2649  	rcu_read_unlock();
788f20eb5affef Chris Mason        2008-04-28  2650  
bb21e30260a672 Anand Jain         2022-11-07  2651  	device = btrfs_alloc_device(fs_info, NULL, NULL, device_path);
12bd2fc0d2f589 Ilya Dryomov       2013-08-23  2652  	if (IS_ERR(device)) {
788f20eb5affef Chris Mason        2008-04-28  2653  		/* we can safely leave the fs_devices entry around */
12bd2fc0d2f589 Ilya Dryomov       2013-08-23  2654  		ret = PTR_ERR(device);
2b82032c34ec40 Yan Zheng          2008-11-17  2655  		goto error;
788f20eb5affef Chris Mason        2008-04-28  2656  	}
788f20eb5affef Chris Mason        2008-04-28  2657  
5b316468983dfa Naohiro Aota       2020-11-10  2658  	device->fs_info = fs_info;
5b316468983dfa Naohiro Aota       2020-11-10  2659  	device->bdev = bdev;
4889bc05a96e03 Anand Jain         2022-01-12  2660  	ret = lookup_bdev(device_path, &device->devt);
4889bc05a96e03 Anand Jain         2022-01-12  2661  	if (ret)
4889bc05a96e03 Anand Jain         2022-01-12  2662  		goto error_free_device;
5b316468983dfa Naohiro Aota       2020-11-10  2663  
16beac87e95e2f Naohiro Aota       2021-11-11  2664  	ret = btrfs_get_dev_zone_info(device, false);
5b316468983dfa Naohiro Aota       2020-11-10  2665  	if (ret)
5b316468983dfa Naohiro Aota       2020-11-10  2666  		goto error_free_device;
5b316468983dfa Naohiro Aota       2020-11-10  2667  
a22285a6a32390 Yan, Zheng         2010-05-16  2668  	trans = btrfs_start_transaction(root, 0);
98d5dc13e7e74b Tsutomu Itoh       2011-01-20  2669  	if (IS_ERR(trans)) {
98d5dc13e7e74b Tsutomu Itoh       2011-01-20  2670  		ret = PTR_ERR(trans);
5b316468983dfa Naohiro Aota       2020-11-10  2671  		goto error_free_zone;
98d5dc13e7e74b Tsutomu Itoh       2011-01-20  2672  	}
98d5dc13e7e74b Tsutomu Itoh       2011-01-20  2673  
ebbede42d47dc7 Anand Jain         2017-12-04  2674  	set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
2b82032c34ec40 Yan Zheng          2008-11-17  2675  	device->generation = trans->transid;
0b246afa62b0cf Jeff Mahoney       2016-06-22  2676  	device->io_width = fs_info->sectorsize;
0b246afa62b0cf Jeff Mahoney       2016-06-22  2677  	device->io_align = fs_info->sectorsize;
0b246afa62b0cf Jeff Mahoney       2016-06-22  2678  	device->sector_size = fs_info->sectorsize;
cda00eba022d6a Christoph Hellwig  2021-10-18  2679  	device->total_bytes =
cda00eba022d6a Christoph Hellwig  2021-10-18  2680  		round_down(bdev_nr_bytes(bdev), fs_info->sectorsize);
2cc3c559fb2fe8 Yan Zheng          2009-06-04  2681  	device->disk_total_bytes = device->total_bytes;
935e5cc935bcbf Miao Xie           2014-09-03  2682  	device->commit_total_bytes = device->total_bytes;
e12c96214d28f9 Anand Jain         2017-12-04  2683  	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
401e29c124eac2 Anand Jain         2017-12-04  2684  	clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
fb01aa85b8b29c Ilya Dryomov       2011-02-15  2685  	device->mode = FMODE_EXCL;
27087f370174eb Stefan Behrens     2013-10-11  2686  	device->dev_stats_valid = 1;
9f6d251033bc5b David Sterba       2017-06-16  2687  	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
788f20eb5affef Chris Mason        2008-04-28  2688  
2b82032c34ec40 Yan Zheng          2008-11-17  2689  	if (seeding_dev) {
a0a1db70df5f48 Filipe Manana      2020-12-14  2690  		btrfs_clear_sb_rdonly(sb);
849eae5e57a703 Anand Jain         2021-11-09  2691  
849eae5e57a703 Anand Jain         2021-11-09  2692  		/* GFP_KERNEL allocation must not be under device_list_mutex */
849eae5e57a703 Anand Jain         2021-11-09  2693  		seed_devices = btrfs_init_sprout(fs_info);
849eae5e57a703 Anand Jain         2021-11-09  2694  		if (IS_ERR(seed_devices)) {
849eae5e57a703 Anand Jain         2021-11-09  2695  			ret = PTR_ERR(seed_devices);
d31c32f6745a64 Anand Jain         2017-09-28  2696  			btrfs_abort_transaction(trans, ret);
d31c32f6745a64 Anand Jain         2017-09-28  2697  			goto error_trans;
d31c32f6745a64 Anand Jain         2017-09-28  2698  		}
849eae5e57a703 Anand Jain         2021-11-09  2699  	}
849eae5e57a703 Anand Jain         2021-11-09  2700  
849eae5e57a703 Anand Jain         2021-11-09  2701  	mutex_lock(&fs_devices->device_list_mutex);
849eae5e57a703 Anand Jain         2021-11-09  2702  	if (seeding_dev) {
849eae5e57a703 Anand Jain         2021-11-09 @2703  		btrfs_setup_sprout(fs_info, seed_devices);
b7cb29e666fe79 Anand Jain         2021-08-24  2704  		btrfs_assign_next_active_device(fs_info->fs_devices->latest_dev,
b7cb29e666fe79 Anand Jain         2021-08-24  2705  						device);
2b82032c34ec40 Yan Zheng          2008-11-17  2706  	}
788f20eb5affef Chris Mason        2008-04-28  2707  
5da54bc13801d3 Anand Jain         2018-07-03  2708  	device->fs_devices = fs_devices;
e5e9a5206a171b Chris Mason        2009-06-10  2709  
34441361c4f52a David Sterba       2016-10-04  2710  	mutex_lock(&fs_info->chunk_mutex);
5da54bc13801d3 Anand Jain         2018-07-03  2711  	list_add_rcu(&device->dev_list, &fs_devices->devices);
5da54bc13801d3 Anand Jain         2018-07-03  2712  	list_add(&device->dev_alloc_list, &fs_devices->alloc_list);
5da54bc13801d3 Anand Jain         2018-07-03  2713  	fs_devices->num_devices++;
5da54bc13801d3 Anand Jain         2018-07-03  2714  	fs_devices->open_devices++;
5da54bc13801d3 Anand Jain         2018-07-03  2715  	fs_devices->rw_devices++;
5da54bc13801d3 Anand Jain         2018-07-03  2716  	fs_devices->total_devices++;
5da54bc13801d3 Anand Jain         2018-07-03  2717  	fs_devices->total_rw_bytes += device->total_bytes;
325cd4bafeb6cf Zheng Yan          2008-09-05  2718  
a5ed45f8224f2c Nikolay Borisov    2017-05-11  2719  	atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
2bf64758fd6290 Josef Bacik        2011-09-26  2720  
10f0d2a517796b Christoph Hellwig  2022-04-15  2721  	if (!bdev_nonrot(bdev))
7f0432d0d8dc1d Johannes Thumshirn 2019-11-13  2722  		fs_devices->rotating = true;
c289811cc096c5 Chris Mason        2009-06-10  2723  
39379faaad79e3 Naohiro Aota       2018-07-27  2724  	orig_super_total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
0b246afa62b0cf Jeff Mahoney       2016-06-22  2725  	btrfs_set_super_total_bytes(fs_info->super_copy,
39379faaad79e3 Naohiro Aota       2018-07-27  2726  		round_down(orig_super_total_bytes + device->total_bytes,
39379faaad79e3 Naohiro Aota       2018-07-27  2727  			   fs_info->sectorsize));
788f20eb5affef Chris Mason        2008-04-28  2728  
39379faaad79e3 Naohiro Aota       2018-07-27  2729  	orig_super_num_devices = btrfs_super_num_devices(fs_info->super_copy);
39379faaad79e3 Naohiro Aota       2018-07-27  2730  	btrfs_set_super_num_devices(fs_info->super_copy,
39379faaad79e3 Naohiro Aota       2018-07-27  2731  				    orig_super_num_devices + 1);
0d39376aa28eba Anand Jain         2014-06-03  2732  
2196d6e8a71fc9 Miao Xie           2014-09-03  2733  	/*
2196d6e8a71fc9 Miao Xie           2014-09-03  2734  	 * we've got more storage, clear any full flags on the space
2196d6e8a71fc9 Miao Xie           2014-09-03  2735  	 * infos
2196d6e8a71fc9 Miao Xie           2014-09-03  2736  	 */
0b246afa62b0cf Jeff Mahoney       2016-06-22  2737  	btrfs_clear_space_info_full(fs_info);
2196d6e8a71fc9 Miao Xie           2014-09-03  2738  
34441361c4f52a David Sterba       2016-10-04  2739  	mutex_unlock(&fs_info->chunk_mutex);
ca10845a56856f Josef Bacik        2020-09-01  2740  
ca10845a56856f Josef Bacik        2020-09-01  2741  	/* Add sysfs device entry */
cd36da2e7ec67f Anand Jain         2020-09-05  2742  	btrfs_sysfs_add_device(device);
ca10845a56856f Josef Bacik        2020-09-01  2743  
5da54bc13801d3 Anand Jain         2018-07-03  2744  	mutex_unlock(&fs_devices->device_list_mutex);
788f20eb5affef Chris Mason        2008-04-28  2745  
2b82032c34ec40 Yan Zheng          2008-11-17  2746  	if (seeding_dev) {
34441361c4f52a David Sterba       2016-10-04  2747  		mutex_lock(&fs_info->chunk_mutex);
6f8e0fc77cd553 David Sterba       2019-03-20  2748  		ret = init_first_rw_device(trans);
34441361c4f52a David Sterba       2016-10-04  2749  		mutex_unlock(&fs_info->chunk_mutex);
005d6427ac4f27 David Sterba       2012-09-18  2750  		if (ret) {
66642832f06a43 Jeff Mahoney       2016-06-10  2751  			btrfs_abort_transaction(trans, ret);
d31c32f6745a64 Anand Jain         2017-09-28  2752  			goto error_sysfs;
005d6427ac4f27 David Sterba       2012-09-18  2753  		}
2196d6e8a71fc9 Miao Xie           2014-09-03  2754  	}
2196d6e8a71fc9 Miao Xie           2014-09-03  2755  
8e87e8562744e2 Nikolay Borisov    2018-07-20  2756  	ret = btrfs_add_dev_item(trans, device);
2196d6e8a71fc9 Miao Xie           2014-09-03  2757  	if (ret) {
66642832f06a43 Jeff Mahoney       2016-06-10  2758  		btrfs_abort_transaction(trans, ret);
d31c32f6745a64 Anand Jain         2017-09-28  2759  		goto error_sysfs;
2196d6e8a71fc9 Miao Xie           2014-09-03  2760  	}
2196d6e8a71fc9 Miao Xie           2014-09-03  2761  
2196d6e8a71fc9 Miao Xie           2014-09-03  2762  	if (seeding_dev) {
5c466629e27a34 David Sterba       2019-03-20  2763  		ret = btrfs_finish_sprout(trans);
005d6427ac4f27 David Sterba       2012-09-18  2764  		if (ret) {
66642832f06a43 Jeff Mahoney       2016-06-10  2765  			btrfs_abort_transaction(trans, ret);
d31c32f6745a64 Anand Jain         2017-09-28  2766  			goto error_sysfs;
005d6427ac4f27 David Sterba       2012-09-18  2767  		}
b2373f255cacdc Anand Jain         2014-06-03  2768  
8e5600818022bd Nikolay Borisov    2020-08-12  2769  		/*
8e5600818022bd Nikolay Borisov    2020-08-12  2770  		 * fs_devices now represents the newly sprouted filesystem and
849eae5e57a703 Anand Jain         2021-11-09  2771  		 * its fsid has been changed by btrfs_sprout_splice().
8e5600818022bd Nikolay Borisov    2020-08-12  2772  		 */
8e5600818022bd Nikolay Borisov    2020-08-12  2773  		btrfs_sysfs_update_sprout_fsid(fs_devices);
005d6427ac4f27 David Sterba       2012-09-18  2774  	}
2b82032c34ec40 Yan Zheng          2008-11-17  2775  
3a45bb207ee2c5 Jeff Mahoney       2016-09-09  2776  	ret = btrfs_commit_transaction(trans);
a213501153fd66 Chris Mason        2008-06-25  2777  
2b82032c34ec40 Yan Zheng          2008-11-17  2778  	if (seeding_dev) {
2b82032c34ec40 Yan Zheng          2008-11-17  2779  		mutex_unlock(&uuid_mutex);
2b82032c34ec40 Yan Zheng          2008-11-17  2780  		up_write(&sb->s_umount);
44cab9ba374a03 Nikolay Borisov    2020-07-22  2781  		locked = false;
788f20eb5affef Chris Mason        2008-04-28  2782  
79787eaab46121 Jeff Mahoney       2012-03-12  2783  		if (ret) /* transaction commit */
79787eaab46121 Jeff Mahoney       2012-03-12  2784  			return ret;
79787eaab46121 Jeff Mahoney       2012-03-12  2785  
2ff7e61e0d30ff Jeff Mahoney       2016-06-22  2786  		ret = btrfs_relocate_sys_chunks(fs_info);
79787eaab46121 Jeff Mahoney       2012-03-12  2787  		if (ret < 0)
0b246afa62b0cf Jeff Mahoney       2016-06-22  2788  			btrfs_handle_fs_error(fs_info, ret,
5d163e0e68ce74 Jeff Mahoney       2016-09-20  2789  				    "Failed to relocate sys chunks after device initialization. This can be fixed using the \"btrfs balance\" command.");
671415b7db49f6 Miao Xie           2012-10-16  2790  		trans = btrfs_attach_transaction(root);
671415b7db49f6 Miao Xie           2012-10-16  2791  		if (IS_ERR(trans)) {
671415b7db49f6 Miao Xie           2012-10-16  2792  			if (PTR_ERR(trans) == -ENOENT)
671415b7db49f6 Miao Xie           2012-10-16  2793  				return 0;
7132a262595a43 Anand Jain         2017-09-28  2794  			ret = PTR_ERR(trans);
7132a262595a43 Anand Jain         2017-09-28  2795  			trans = NULL;
7132a262595a43 Anand Jain         2017-09-28  2796  			goto error_sysfs;
671415b7db49f6 Miao Xie           2012-10-16  2797  		}
3a45bb207ee2c5 Jeff Mahoney       2016-09-09  2798  		ret = btrfs_commit_transaction(trans);
2b82032c34ec40 Yan Zheng          2008-11-17  2799  	}
c9e9f97bdfb64d Ilya Dryomov       2012-01-16  2800  
7f551d969037cc Anand Jain         2020-05-05  2801  	/*
7f551d969037cc Anand Jain         2020-05-05  2802  	 * Now that we have written a new super block to this device, check all
7f551d969037cc Anand Jain         2020-05-05  2803  	 * other fs_devices list if device_path alienates any other scanned
7f551d969037cc Anand Jain         2020-05-05  2804  	 * device.
7f551d969037cc Anand Jain         2020-05-05  2805  	 * We can ignore the return value as it typically returns -EINVAL and
7f551d969037cc Anand Jain         2020-05-05  2806  	 * only succeeds if the device was an alien.
7f551d969037cc Anand Jain         2020-05-05  2807  	 */
4889bc05a96e03 Anand Jain         2022-01-12  2808  	btrfs_forget_devices(device->devt);
7f551d969037cc Anand Jain         2020-05-05  2809  
7f551d969037cc Anand Jain         2020-05-05  2810  	/* Update ctime/mtime for blkid or udev */
54fde91f52f515 Josef Bacik        2021-10-14  2811  	update_dev_time(device_path);
7f551d969037cc Anand Jain         2020-05-05  2812  
2b82032c34ec40 Yan Zheng          2008-11-17  2813  	return ret;
79787eaab46121 Jeff Mahoney       2012-03-12  2814  
d31c32f6745a64 Anand Jain         2017-09-28  2815  error_sysfs:
53f8a74cbeffd4 Anand Jain         2020-09-05  2816  	btrfs_sysfs_remove_device(device);
39379faaad79e3 Naohiro Aota       2018-07-27  2817  	mutex_lock(&fs_info->fs_devices->device_list_mutex);
39379faaad79e3 Naohiro Aota       2018-07-27  2818  	mutex_lock(&fs_info->chunk_mutex);
39379faaad79e3 Naohiro Aota       2018-07-27  2819  	list_del_rcu(&device->dev_list);
39379faaad79e3 Naohiro Aota       2018-07-27  2820  	list_del(&device->dev_alloc_list);
39379faaad79e3 Naohiro Aota       2018-07-27  2821  	fs_info->fs_devices->num_devices--;
39379faaad79e3 Naohiro Aota       2018-07-27  2822  	fs_info->fs_devices->open_devices--;
39379faaad79e3 Naohiro Aota       2018-07-27  2823  	fs_info->fs_devices->rw_devices--;
39379faaad79e3 Naohiro Aota       2018-07-27  2824  	fs_info->fs_devices->total_devices--;
39379faaad79e3 Naohiro Aota       2018-07-27  2825  	fs_info->fs_devices->total_rw_bytes -= device->total_bytes;
39379faaad79e3 Naohiro Aota       2018-07-27  2826  	atomic64_sub(device->total_bytes, &fs_info->free_chunk_space);
39379faaad79e3 Naohiro Aota       2018-07-27  2827  	btrfs_set_super_total_bytes(fs_info->super_copy,
39379faaad79e3 Naohiro Aota       2018-07-27  2828  				    orig_super_total_bytes);
39379faaad79e3 Naohiro Aota       2018-07-27  2829  	btrfs_set_super_num_devices(fs_info->super_copy,
39379faaad79e3 Naohiro Aota       2018-07-27  2830  				    orig_super_num_devices);
39379faaad79e3 Naohiro Aota       2018-07-27  2831  	mutex_unlock(&fs_info->chunk_mutex);
39379faaad79e3 Naohiro Aota       2018-07-27  2832  	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
79787eaab46121 Jeff Mahoney       2012-03-12  2833  error_trans:
0af2c4bf5a012a Anand Jain         2017-09-28  2834  	if (seeding_dev)
a0a1db70df5f48 Filipe Manana      2020-12-14  2835  		btrfs_set_sb_rdonly(sb);
7132a262595a43 Anand Jain         2017-09-28  2836  	if (trans)
3a45bb207ee2c5 Jeff Mahoney       2016-09-09  2837  		btrfs_end_transaction(trans);
5b316468983dfa Naohiro Aota       2020-11-10  2838  error_free_zone:
5b316468983dfa Naohiro Aota       2020-11-10  2839  	btrfs_destroy_dev_zone_info(device);
5c4cf6c91d717b David Sterba       2017-10-30  2840  error_free_device:
a425f9d4755a14 David Sterba       2018-03-20  2841  	btrfs_free_device(device);
2b82032c34ec40 Yan Zheng          2008-11-17  2842  error:
e525fd89d380c4 Tejun Heo          2010-11-13  2843  	blkdev_put(bdev, FMODE_EXCL);
44cab9ba374a03 Nikolay Borisov    2020-07-22  2844  	if (locked) {
2b82032c34ec40 Yan Zheng          2008-11-17  2845  		mutex_unlock(&uuid_mutex);
2b82032c34ec40 Yan Zheng          2008-11-17  2846  		up_write(&sb->s_umount);
2b82032c34ec40 Yan Zheng          2008-11-17  2847  	}
c9e9f97bdfb64d Ilya Dryomov       2012-01-16  2848  	return ret;
788f20eb5affef Chris Mason        2008-04-28  2849  }
788f20eb5affef Chris Mason        2008-04-28  2850  

:::::: The code at line 2703 was first introduced by commit
:::::: 849eae5e57a703105aa6cdce0d860ab95f44d81c btrfs: consolidate device_list_mutex in prepare_sprout to its parent

:::::: TO: Anand Jain <anand.jain@oracle.com>
:::::: CC: David Sterba <dsterba@suse.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
