Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262136D407B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjDCJYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjDCJYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:24:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF41DAD0B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680513840; x=1712049840;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=usdf3g4r0utMo0qlvYm7gLnixp1wxVc6P6orjE21x+A=;
  b=eJLeXyApTldtB1LHhtxzmKPcWspwjefebUr+7yXnblucfxl3TTWvgVPM
   2aA08Fwk8AM7MCnkl6XPk2styH8OUxUjJTtPaC6eoKGNzc611ZMBpLKs3
   yt9msUtoWIa4YVQfRpuhw9lp3tRuQW/5RnUkvmHKiw17U/+cqXeaNA0E9
   SSOD8GiOR/44/VIz08QV/R3EzaL23N8iCV2UrBgN6QBGEGHJ7aebWmwyp
   IPVNFn32gZNxxr9ETxF1ttYKTjUaR80achkchvsD/MfhtgRmdVemaWpZC
   c4cI3DXg3g1xucej3ME1+/pEnn8pB+Psvc+dSCXGa4Vw9lPAjbWTRmWr3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="321514166"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="321514166"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 02:24:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="688446853"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="688446853"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 Apr 2023 02:23:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjGPt-000O9h-2O;
        Mon, 03 Apr 2023 09:23:57 +0000
Date:   Mon, 3 Apr 2023 17:23:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Steven Price <steven.price@arm.com>
Subject: fs/proc/task_mmu.c:743:33: warning: 'smaps_shmem_walk_ops' defined
 but not used
Message-ID: <202304031749.UiyJpxzF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7e364e56293bb98cae1b55fd835f5991c4e96e7d
commit: 7b86ac3371b70c3fd8fd95501719beb1faab719f pagewalk: separate function pointers from iterator data
date:   3 years, 7 months ago
config: i386-buildonly-randconfig-r004-20230403 (https://download.01.org/0day-ci/archive/20230403/202304031749.UiyJpxzF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7b86ac3371b70c3fd8fd95501719beb1faab719f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7b86ac3371b70c3fd8fd95501719beb1faab719f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304031749.UiyJpxzF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/proc/task_mmu.c: In function 'pagemap_pmd_range':
   fs/proc/task_mmu.c:1367:22: warning: variable 'orig_pte' set but not used [-Wunused-but-set-variable]
    1367 |         pte_t *pte, *orig_pte;
         |                      ^~~~~~~~
   At top level:
>> fs/proc/task_mmu.c:743:33: warning: 'smaps_shmem_walk_ops' defined but not used [-Wunused-const-variable=]
     743 | static const struct mm_walk_ops smaps_shmem_walk_ops = {
         |                                 ^~~~~~~~~~~~~~~~~~~~


vim +/smaps_shmem_walk_ops +743 fs/proc/task_mmu.c

   742	
 > 743	static const struct mm_walk_ops smaps_shmem_walk_ops = {
   744		.pmd_entry		= smaps_pte_range,
   745		.hugetlb_entry		= smaps_hugetlb_range,
   746		.pte_hole		= smaps_pte_hole,
   747	};
   748	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
