Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5766C6CF849
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 02:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjC3AiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 20:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC3AiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:38:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378EA46B0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 17:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680136701; x=1711672701;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XLf3VZ5VPXuk5l1PkmuuBga56HLKuT48oalwmG4a4/4=;
  b=DFTH6aZcELe204FLaboeCC4N8TT2kTCbo4cTCxFnnHkCtKqNob9N2i6t
   KNyNpGxLiJU8m4BIqe4hHccddSQdlffJJkUGIU0IG0wEp9oIM7Y1UiAc6
   ZTpmQ3eLK5GgPk4WHJpwZtOFzFByQNb5Kxbv05ouqIwO+2Xhw82jIrTSD
   JRGkZRywWPQx1uImkZzq8/gs+hzg7M2mVA+nHL+O0QdxjIpmzsU9eE23z
   VvC/9Mhs2ntaXNv43ETMQN3NLnRllhwkfK8lGhQUgN7uMq7X6Rl4wIX3q
   YhSAZvDiAtef35cz1Ky5NeL2RQ1RPY1CGfsuCAc979Og3weFbvR2XvLkI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="427310014"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="427310014"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 17:38:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="717102232"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="717102232"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Mar 2023 17:38:19 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phgJ0-000K5s-0f;
        Thu, 30 Mar 2023 00:38:18 +0000
Date:   Thu, 30 Mar 2023 08:38:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [tip:locking/rcuref 2/2] arch/alpha/include/asm/xchg.h:234:32:
 sparse: sparse: cast truncates bits from constant value (ffffffffe0000000
 becomes 0)
Message-ID: <202303300857.c20wTtqR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/rcuref
head:   ee1ee6db07795d9637bc5e8993a8ddcf886541ef
commit: ee1ee6db07795d9637bc5e8993a8ddcf886541ef [2/2] atomics: Provide rcuref - scalable reference counting
config: alpha-randconfig-s052-20230329 (https://download.01.org/0day-ci/archive/20230330/202303300857.c20wTtqR-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=ee1ee6db07795d9637bc5e8993a8ddcf886541ef
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip locking/rcuref
        git checkout ee1ee6db07795d9637bc5e8993a8ddcf886541ef
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303300857.c20wTtqR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   lib/rcuref.c: note: in included file (through arch/alpha/include/asm/cmpxchg.h, arch/alpha/include/asm/atomic.h, include/linux/atomic.h, ...):
>> arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates bits from constant value (ffffffffe0000000 becomes 0)
   arch/alpha/include/asm/xchg.h:236:32: sparse: sparse: cast truncates bits from constant value (ffffffffe0000000 becomes 0)

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
a6209d6d71f2ab Ivan Kokshaysky 2009-03-31  236  			return ____cmpxchg(_u16, ptr, old, new);
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
