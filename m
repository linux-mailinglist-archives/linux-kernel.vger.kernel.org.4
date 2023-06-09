Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E35728F26
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbjFIE5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbjFIE5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:57:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B8530ED
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 21:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686286639; x=1717822639;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Mtjy/tGjVETEBVgPvQ78jLc7MD6gi/g9eGyAd8iVl3c=;
  b=Xy3GQOJnc+bTiSOmYdLzKyz3TB/qKPDOGgh798MJpC4/ODXqheeRniVY
   ucqV9AvJ/1lF3l23dBC+SptGNxuklnclqK/8wO8rHP+Nnfx4R3klScTrV
   w9lBKYTfXTVgBW5CMhwmXYnKXY6M2uCMUlBlCY7LV/IwV6InqkloZ6VdA
   9aQnrNtivEub5LT6rOPd7iKjFKPAD/ULnFdRh1k2Q1aHffJaTgLW1Wfbf
   B8ZduWCN5AX8QG6ewdVroxYQ/mqu6BJfraIZJBlUgSDFZbMp30o6I4yWR
   aNJXUHLre8yDCsHnOQFggZE/2OPbpVXXFQs28NgAqfmj1uasfg1h1zUnL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="355006398"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="355006398"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 21:57:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="780153872"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="780153872"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jun 2023 21:57:17 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7UBZ-0008ek-0N;
        Fri, 09 Jun 2023 04:57:17 +0000
Date:   Fri, 9 Jun 2023 12:56:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Christopher M. Riedl" <cmr@bluescreens.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: arch/powerpc/include/asm/book3s/32/tlbflush.h:83:2: error: call to
 '__compiletime_assert_175' declared with 'error' attribute: BUILD_BUG failed
Message-ID: <202306091215.AvKyYBc9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christopher,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8d15d5e1851b1bbb9cd3289b84c7f32399e06ac5
commit: c28c15b6d28a776538482101522cbcd9f906b15c powerpc/code-patching: Use temporary mm for Radix MMU
date:   6 months ago
config: powerpc-randconfig-r021-20230608 (https://download.01.org/0day-ci/archive/20230609/202306091215.AvKyYBc9-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c28c15b6d28a776538482101522cbcd9f906b15c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c28c15b6d28a776538482101522cbcd9f906b15c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306091215.AvKyYBc9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/lib/code-patching.c:6:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:29:
   In file included from include/linux/mm.h:29:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/powerpc/include/asm/pgtable.h:11:
   In file included from arch/powerpc/include/asm/tlbflush.h:6:
   In file included from arch/powerpc/include/asm/book3s/tlbflush.h:8:
>> arch/powerpc/include/asm/book3s/32/tlbflush.h:83:2: error: call to '__compiletime_assert_175' declared with 'error' attribute: BUILD_BUG failed
      83 |         BUILD_BUG();
         |         ^
   include/linux/build_bug.h:59:21: note: expanded from macro 'BUILD_BUG'
      59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
         |                     ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   include/linux/compiler_types.h:357:2: note: expanded from macro 'compiletime_assert'
     357 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:345:2: note: expanded from macro '_compiletime_assert'
     345 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:338:4: note: expanded from macro '__compiletime_assert'
     338 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:72:1: note: expanded from here
      72 | __compiletime_assert_175
         | ^
   1 error generated.


vim +83 arch/powerpc/include/asm/book3s/32/tlbflush.h

274d842fa1efd9 Benjamin Gray 2022-11-09  79  
274d842fa1efd9 Benjamin Gray 2022-11-09  80  static inline void local_flush_tlb_page_psize(struct mm_struct *mm,
274d842fa1efd9 Benjamin Gray 2022-11-09  81  					      unsigned long vmaddr, int psize)
274d842fa1efd9 Benjamin Gray 2022-11-09  82  {
274d842fa1efd9 Benjamin Gray 2022-11-09 @83  	BUILD_BUG();
274d842fa1efd9 Benjamin Gray 2022-11-09  84  }
274d842fa1efd9 Benjamin Gray 2022-11-09  85  

:::::: The code at line 83 was first introduced by commit
:::::: 274d842fa1efd9449e62222c8896e0be11621f1f powerpc/tlb: Add local flush for page given mm_struct and psize

:::::: TO: Benjamin Gray <bgray@linux.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
