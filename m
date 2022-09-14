Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8970B5B85F9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiINKKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiINKJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:09:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD5715FD5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663150197; x=1694686197;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T5mSsgn3SuJh1F7VhaEowHn9W0M5YkG3gvnG6SSQlG4=;
  b=m4YeTW3lRVQ7MTiAPLvH7V/VlLdVEQpNoWdFHLalMEwx7dABlp9dlKN+
   WjdcOy6jRKCSYqyMWLe+/RCJD6l4CVT5G8IIyKvZbAKqYuezYsDqwclmV
   JyDtG/INUy4tmzdiEob6fuR5QvANGNoSQWwtYQKjWbj/XKIUmWYP5I0Sc
   euhwB5WaxJi0zDKt7uHjwvNY4ykJXBoddGmO9EBRPFAukraUHevbusq/R
   GNCNe2b/OGWZlb5Jj1co5Hn7PfsKvjJ3iTBQYl6N1y0kA2B1vkbLXu3+K
   rySYaH5D9UP+UoVZi/9r3oRf8qEy2Ruy3AbS1kg2k9PKzawp23tEcOvEm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="297120994"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="297120994"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 03:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="685259698"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2022 03:09:56 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYPLA-00005c-0r;
        Wed, 14 Sep 2022 10:09:56 +0000
Date:   Wed, 14 Sep 2022 18:09:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [djbw-nvdimm:libnvdimm-pending 9/22] fs/xfs/xfs_super.c:734:33:
 warning: variable 'error' set but not used
Message-ID: <202209141753.agkH4L40-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git libnvdimm-pending
head:   e27a0356de15f16934325784c6b1d89cf0f13458
commit: 7df6bd39bccceef2f90dec6027a5de5c2f485dac [9/22] xfs: Add xfs_break_layouts() to the inode eviction path
config: arm-buildonly-randconfig-r003-20220914 (https://download.01.org/0day-ci/archive/20220914/202209141753.agkH4L40-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/commit/?id=7df6bd39bccceef2f90dec6027a5de5c2f485dac
        git remote add djbw-nvdimm https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git
        git fetch --no-tags djbw-nvdimm libnvdimm-pending
        git checkout 7df6bd39bccceef2f90dec6027a5de5c2f485dac
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/xfs/xfs_super.c: In function 'xfs_fs_evict_inode':
>> fs/xfs/xfs_super.c:734:33: warning: variable 'error' set but not used [-Wunused-but-set-variable]
     734 |         long                    error;
         |                                 ^~~~~


vim +/error +734 fs/xfs/xfs_super.c

   727	
   728	STATIC void
   729	xfs_fs_evict_inode(
   730		struct inode		*inode)
   731	{
   732		struct xfs_inode	*ip = XFS_I(inode);
   733		uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
 > 734		long			error;
   735	
   736		xfs_ilock(ip, iolock);
   737	
   738		error = xfs_break_layouts(inode, &iolock, BREAK_UNMAP_FINAL);
   739	
   740		/* The final layout break is uninterruptible */
   741		ASSERT(!error);
   742	
   743		truncate_inode_pages_final(&inode->i_data);
   744		clear_inode(inode);
   745	
   746		xfs_iunlock(ip, iolock);
   747	}
   748	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
