Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40FA69175E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 04:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjBJDxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 22:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjBJDxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 22:53:22 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A90A6E9A7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 19:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676001201; x=1707537201;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MwIjQMAjyNKXoXqr7P7z7HD1xnYC+lIxa3LmxiTK3pA=;
  b=I7mRSCSYS2jj0pBShnjuAUhA8+zbocrgKFzRCCC7MrWv29KeOBiXqqcu
   Jf3b//NEmh6a55Ey2faAufiam6WYN6HnHlE1fxQQP8SSeAuUsjTS23WIV
   UYjs+Y39KTGna60EDh752+yciXwEXjzKnQUSXuL8MDuL9gCpecPY6wfYw
   47fqPmO1bmvWAG68f5wcj/1nnkfa+xrBZXbzEuMooKEF0o21HrBH6iQKH
   tBv+M9bGoh8KIG4qE8e4mtawr5sABXuGP6agtApWJVBPt9YqyZygymvCt
   UKPlINEkVcjbFAEyW6IGCiKlm57sIWHMFnUz8Y6rOv2yh5YWV/jhGmH36
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="310694177"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="310694177"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 19:53:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="913391269"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="913391269"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 09 Feb 2023 19:53:18 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQKTN-0005WM-2g;
        Fri, 10 Feb 2023 03:53:17 +0000
Date:   Fri, 10 Feb 2023 11:52:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yue Hu <huyue2@coolpad.com>, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>
Subject: arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates
 bits from constant value (ffffffffe0f510cc becomes cc)
Message-ID: <202302101104.mgetTzwR-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   38c1e0c65865426676123cc9a127526fa02bcac6
commit: 2f44013e39984c127c6efedf70e6b5f4e9dcf315 erofs: fix pcluster use-after-free on UP platforms
date:   5 months ago
config: alpha-randconfig-s042-20230210 (https://download.01.org/0day-ci/archive/20230210/202302101104.mgetTzwR-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f44013e39984c127c6efedf70e6b5f4e9dcf315
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2f44013e39984c127c6efedf70e6b5f4e9dcf315
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash fs/erofs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302101104.mgetTzwR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/erofs/utils.c: note: in included file (through arch/alpha/include/asm/cmpxchg.h, arch/alpha/include/asm/atomic.h, include/linux/atomic.h, ...):
>> arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates bits from constant value (ffffffffe0f510cc becomes cc)
>> arch/alpha/include/asm/xchg.h:236:32: sparse: sparse: cast truncates bits from constant value (ffffffffe0f510cc becomes 10cc)
--
   fs/erofs/zdata.c: note: in included file (through arch/alpha/include/asm/cmpxchg.h, arch/alpha/include/asm/atomic.h, include/linux/atomic.h, ...):
>> arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates bits from constant value (ffffffffe0f510cc becomes cc)
>> arch/alpha/include/asm/xchg.h:236:32: sparse: sparse: cast truncates bits from constant value (ffffffffe0f510cc becomes 10cc)
   arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes fe)
   arch/alpha/include/asm/xchg.h:236:32: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes cafe)
   arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes fe)
   arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates bits from constant value (5f0edead becomes ad)
   arch/alpha/include/asm/xchg.h:236:32: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes cafe)
   arch/alpha/include/asm/xchg.h:236:32: sparse: sparse: cast truncates bits from constant value (5f0edead becomes dead)

vim +234 arch/alpha/include/asm/xchg.h

a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  227  
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  228  static __always_inline unsigned long
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  229  ____cmpxchg(, volatile void *ptr, unsigned long old, unsigned long new,
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  230  	      int size)
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  231  {
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  232  	switch (size) {
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  233  		case 1:
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31 @234  			return ____cmpxchg(_u8, ptr, old, new);
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  235  		case 2:
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31 @236  			return ____cmpxchg(_u16, ptr, old, new);
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  237  		case 4:
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  238  			return ____cmpxchg(_u32, ptr, old, new);
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  239  		case 8:
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  240  			return ____cmpxchg(_u64, ptr, old, new);
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  241  	}
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  242  	__cmpxchg_called_with_bad_pointer();
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  243  	return old;
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  244  }
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  245  

:::::: The code at line 234 was first introduced by commit
:::::: a6209d6d71f2ab8c63cc1587ef65490d83022baf alpha: xchg/cmpxchg cleanup and fixes

:::::: TO: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
