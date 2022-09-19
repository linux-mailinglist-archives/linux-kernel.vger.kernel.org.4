Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FB15BC2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiISGLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiISGLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:11:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B111AF29
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 23:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663567880; x=1695103880;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ko2YrHCPrcB3KCrHs/GrxlNqDvbo19BSPi7v8JhAhdk=;
  b=S9RoYkgymm1K7/EElQIIEgvtlaRt59PWBxGW9SJAG4F28sxYdlZvFGO+
   EMVaZyZERTnsJhGyjcRYKxy/OIxxR63bvM9m4pgWQrX4LmsGYkJ23qQrT
   U9tI6MpLbzXTPMvFvt7SlwaJiuud5qlmqu4E/GfgBcKa0uZ1qn6oKKATV
   A9A9m/C5P8oB3YbcOeR7jhufh9YXHoNoWhIcF+1Rj/mmxoWU5QBp15Wno
   YSdHCfeB3TvwVCnldpSqMuXRpMfOh4l4WObDMMkYECsDZPR2nW6O6v7wx
   20y9GQv5oVEBKRYvz7EOxKnvhvMAgaHy9c6YxmSiFJ1mcOGtIg1Fs2Jgx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="363272196"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="363272196"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 23:11:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="569515584"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Sep 2022 23:11:17 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oa9zx-0001nn-0Q;
        Mon, 19 Sep 2022 06:11:17 +0000
Date:   Mon, 19 Sep 2022 14:11:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Steven Price <steven.price@arm.com>
Subject: fs/proc/task_mmu.c:743:33: warning: 'smaps_shmem_walk_ops' defined
 but not used
Message-ID: <202209191403.ovOXBsxR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   521a547ced6477c54b4b0cc206000406c221b4d6
commit: 7b86ac3371b70c3fd8fd95501719beb1faab719f pagewalk: separate function pointers from iterator data
date:   3 years ago
config: i386-buildonly-randconfig-r005-20220919 (https://download.01.org/0day-ci/archive/20220919/202209191403.ovOXBsxR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7b86ac3371b70c3fd8fd95501719beb1faab719f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7b86ac3371b70c3fd8fd95501719beb1faab719f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

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
https://01.org/lkp
