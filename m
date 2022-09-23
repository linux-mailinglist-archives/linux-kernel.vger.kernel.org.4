Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD285E73BD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiIWGPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiIWGO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:14:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371401F620
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663913696; x=1695449696;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yds55nrNBjnAAYbVzo+ebOY4TxoD2LZ81oVZrn2BonU=;
  b=GeJ+ikYU5HjkKGTRCoUb57kdXrdnagU0G/v+3JZdWgNKyoJZ0g58QAh6
   GaLQSFMA0TjJcSylFYcg3+cG5KA4TcGdCVMKv3SWywOxa4KiBaTY9SLhl
   Bsi9Eks0CE8oIAHOnrzrXBWeHctq9sObZPQkzul/co+v5Y8bHzYQ9tjWQ
   cI0iGemnoN0veepimdEg1JB76VW0LHZVMevlO1oGc/a8jn8ka8sIcnRVg
   AlVJJpYB2oPDIBEFevA66VinuLq6XrsTyBNOqQY2WrnpRSxNbyy/+BCL/
   Fw2oGWjvHXHIWw/TKxwouw9u4v8Sxd1A/FegMRoOuCGkjvsmcj6zGda+j
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301964278"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301964278"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 23:14:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="948906545"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Sep 2022 23:14:36 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obbxL-0005Ng-1n;
        Fri, 23 Sep 2022 06:14:35 +0000
Date:   Fri, 23 Sep 2022 14:14:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1744:18:
 error: invalid use of undefined type 'struct cpuinfo_x86'
Message-ID: <202209232234.DkFw3520-lkp@intel.com>
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

Hi Koba,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bf682942cd26ce9cd5e87f73ae099b383041e782
commit: b3dc549986eb7b38eba4a144e979dc93f386751f drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
date:   1 year, 1 month ago
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20220923/202209232234.DkFw3520-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b3dc549986eb7b38eba4a144e979dc93f386751f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b3dc549986eb7b38eba4a144e979dc93f386751f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/spinlock_up.h:8,
                    from include/linux/spinlock.h:92,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from drivers/gpu/drm/amd/amdgpu/../pm/inc/pp_debug.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:23:
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c: In function 'intel_core_rkl_chk':
   arch/um/include/asm/processor-generic.h:104:19: error: called object is not a function or function pointer
     104 | #define cpu_data (&boot_cpu_data)
         |                  ~^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1742:34: note: in expansion of macro 'cpu_data'
    1742 |         struct cpuinfo_x86 *c = &cpu_data(0);
         |                                  ^~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1744:18: error: invalid use of undefined type 'struct cpuinfo_x86'
    1744 |         return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
         |                  ^~
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1744:33: error: invalid use of undefined type 'struct cpuinfo_x86'
    1744 |         return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
         |                                 ^~
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1748:1: error: control reaches end of non-void function [-Werror=return-type]
    1748 | }
         | ^
   cc1: some warnings being treated as errors


vim +1744 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c

  1738	
  1739	static bool intel_core_rkl_chk(void)
  1740	{
  1741	#if IS_ENABLED(CONFIG_X86_64)
  1742		struct cpuinfo_x86 *c = &cpu_data(0);
  1743	
> 1744		return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
  1745	#else
  1746		return false;
  1747	#endif
  1748	}
  1749	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
