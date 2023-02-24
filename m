Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189806A2150
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjBXSTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBXSTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:19:06 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AB215CA9;
        Fri, 24 Feb 2023 10:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677262745; x=1708798745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BNDdmrZdwBU8SRPX2vwNZc9jJnIBU5bmE3T6Ywe/qKQ=;
  b=MSsp7/UMUpXoWsnYLYhkuH/GW+7p77TADUUoovwovvLxXiDPbeJlWQX/
   +OVhymq8q2Ci7ocG+BpxtEtOEwbH6rBeZbbA41CfkwgpFfxsJ8CZvPLhA
   UHE11Ey83UlORSInB2o3milUXhDwiU9ahYEIivNsTbm0YGj7jTBcQNoAF
   jybAomsMfAD+G+G++vtJCD8nxH69uxnN9UA6wYDNNtdwlZKaNGkvLm3mu
   AQw2jpVo8F6271LBVhwnBx8rymg5apI+Q1B3E5LMhtZpcYmJN2Z6JiuVz
   Qm9xhf85DcTpUm4dCSkjM2xNwFraTp/ntI8PICCh0zRN97mOG11HB0dam
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="313935954"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="313935954"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 10:19:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="666240737"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="666240737"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Feb 2023 10:19:02 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVcer-0002bi-0I;
        Fri, 24 Feb 2023 18:19:01 +0000
Date:   Sat, 25 Feb 2023 02:18:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Hindborg <nmi@metaspace.dk>, linux-block@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Andreas Hindborg <nmi@metaspace.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: ublk: enable zoned storage support
Message-ID: <202302250222.XOrw9j6z-lkp@intel.com>
References: <20230224125950.214779-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224125950.214779-1-nmi@metaspace.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v6.2]
[cannot apply to axboe-block/for-next linus/master next-20230224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Hindborg/block-ublk-enable-zoned-storage-support/20230224-210205
patch link:    https://lore.kernel.org/r/20230224125950.214779-1-nmi%40metaspace.dk
patch subject: [PATCH] block: ublk: enable zoned storage support
config: ia64-buildonly-randconfig-r006-20230222 (https://download.01.org/0day-ci/archive/20230225/202302250222.XOrw9j6z-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6d088fc1b115a63e8888b12fa47aabd45be97460
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andreas-Hindborg/block-ublk-enable-zoned-storage-support/20230224-210205
        git checkout 6d088fc1b115a63e8888b12fa47aabd45be97460
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302250222.XOrw9j6z-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/block/ublk_drv.c: In function 'ublk_dev_param_basic_apply':
>> drivers/block/ublk_drv.c:221:28: error: 'struct gendisk' has no member named 'nr_zones'
     221 |                 ub->ub_disk->nr_zones = p->dev_sectors / p->chunk_sectors;
         |                            ^~
   drivers/block/ublk_drv.c: In function 'ublk_dev_param_zoned_apply':
>> drivers/block/ublk_drv.c:244:17: error: implicit declaration of function 'disk_set_max_active_zones'; did you mean 'bdev_max_active_zones'? [-Werror=implicit-function-declaration]
     244 |                 disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                 bdev_max_active_zones
>> drivers/block/ublk_drv.c:245:17: error: implicit declaration of function 'disk_set_max_open_zones'; did you mean 'bdev_max_open_zones'? [-Werror=implicit-function-declaration]
     245 |                 disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                 bdev_max_open_zones
   drivers/block/ublk_drv.c: In function 'ublk_ctrl_start_dev':
>> drivers/block/ublk_drv.c:1663:23: error: implicit declaration of function 'blk_revalidate_disk_zones' [-Werror=implicit-function-declaration]
    1663 |                 ret = blk_revalidate_disk_zones(disk, NULL);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +221 drivers/block/ublk_drv.c

   192	
   193	static void ublk_dev_param_basic_apply(struct ublk_device *ub)
   194	{
   195		struct request_queue *q = ub->ub_disk->queue;
   196		const struct ublk_param_basic *p = &ub->params.basic;
   197	
   198		blk_queue_logical_block_size(q, 1 << p->logical_bs_shift);
   199		blk_queue_physical_block_size(q, 1 << p->physical_bs_shift);
   200		blk_queue_io_min(q, 1 << p->io_min_shift);
   201		blk_queue_io_opt(q, 1 << p->io_opt_shift);
   202	
   203		blk_queue_write_cache(q, p->attrs & UBLK_ATTR_VOLATILE_CACHE,
   204				p->attrs & UBLK_ATTR_FUA);
   205		if (p->attrs & UBLK_ATTR_ROTATIONAL)
   206			blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
   207		else
   208			blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
   209	
   210		blk_queue_max_hw_sectors(q, p->max_sectors);
   211		blk_queue_chunk_sectors(q, p->chunk_sectors);
   212		blk_queue_virt_boundary(q, p->virt_boundary_mask);
   213	
   214		if (p->attrs & UBLK_ATTR_READ_ONLY)
   215			set_disk_ro(ub->ub_disk, true);
   216	
   217		set_capacity(ub->ub_disk, p->dev_sectors);
   218	
   219		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
   220		    ub->dev_info.flags & UBLK_F_ZONED && p->chunk_sectors) {
 > 221			ub->ub_disk->nr_zones = p->dev_sectors / p->chunk_sectors;
   222		}
   223	}
   224	
   225	static void ublk_dev_param_discard_apply(struct ublk_device *ub)
   226	{
   227		struct request_queue *q = ub->ub_disk->queue;
   228		const struct ublk_param_discard *p = &ub->params.discard;
   229	
   230		q->limits.discard_alignment = p->discard_alignment;
   231		q->limits.discard_granularity = p->discard_granularity;
   232		blk_queue_max_discard_sectors(q, p->max_discard_sectors);
   233		blk_queue_max_write_zeroes_sectors(q,
   234				p->max_write_zeroes_sectors);
   235		blk_queue_max_discard_segments(q, p->max_discard_segments);
   236	}
   237	
   238	static void ublk_dev_param_zoned_apply(struct ublk_device *ub)
   239	{
   240		const struct ublk_param_zoned *p = &ub->params.zoned;
   241	
   242		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
   243		    ub->dev_info.flags & UBLK_F_ZONED) {
 > 244			disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
 > 245			disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
   246			/* We do not support zone append yet */
   247			//blk_queue_max_zone_append_sectors(q, zone_size);
   248		}
   249	}
   250	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
