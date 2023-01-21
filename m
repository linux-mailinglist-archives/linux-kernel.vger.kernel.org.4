Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C561676748
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 16:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjAUPtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 10:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjAUPtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 10:49:33 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F0830B1E
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 07:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674316171; x=1705852171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qXKP29H7TTX5eM4j8mswyDZwPaI8Bztl17Da0IlZWnQ=;
  b=ayimkQUUQvBH8PvWf+nTpaFcqqhWwhI7mPXtSUDuucUS+brcHwhXblzG
   fgXfuDZzi2bVVdHbdRKPy1A+NnK1y9sGGX4P95X0CYtFcBYe5uSZEsbRH
   enQpPXGLnWF7n3bMRqq7J7zQc2clLO6ftC9FMOfvL4CI1OIwPW/nQMx4U
   VUzCoi3imnjfu8zjlodhSs1edjStTRlu8gXzAUKcdVe0DBKBLR3WWNgic
   z0ivxp+oUQTPqFRpOYDejzQ+ve34dOhtaE9mb1CKFFGYielgb+/Bg5mTE
   A/wqT4V5ZI031+P4SeIg+H+MnCCZ7Ionw5yY6b9Lm6J0zBj+FfHiCzX3n
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="324481477"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="324481477"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 07:49:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="989721476"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="989721476"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jan 2023 07:49:29 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJG7U-0004Du-0v;
        Sat, 21 Jan 2023 15:49:28 +0000
Date:   Sat, 21 Jan 2023 23:49:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Christopher M. Riedl" <cmr@bluescreens.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: arch/powerpc/include/asm/book3s/32/tlbflush.h:83:2: error: call to
 '__compiletime_assert_175' declared with 'error' attribute: BUILD_BUG failed
Message-ID: <202301212348.eDkowvfF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christopher,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f883675bf6522b52cd75dc3de791680375961769
commit: c28c15b6d28a776538482101522cbcd9f906b15c powerpc/code-patching: Use temporary mm for Radix MMU
date:   7 weeks ago
config: powerpc-buildonly-randconfig-r001-20230121 (https://download.01.org/0day-ci/archive/20230121/202301212348.eDkowvfF-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/lib/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

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
           BUILD_BUG();
           ^
   include/linux/build_bug.h:59:21: note: expanded from macro 'BUILD_BUG'
   #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
                       ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:357:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:345:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:338:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:194:1: note: expanded from here
   __compiletime_assert_175
   ^
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
https://github.com/intel/lkp-tests
