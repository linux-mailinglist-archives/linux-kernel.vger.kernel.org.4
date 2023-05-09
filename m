Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B78D6FBE3A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbjEIEdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjEIEdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:33:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899595581
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 21:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683606790; x=1715142790;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CdAh3NxoXe5UEMtrfO9JENuBDYMmqMJV24NE8Y6pWaw=;
  b=oJE/dFdRZ531ZWAbY4X/ww0vHeM+rzi2wzN1Eh808AS/spDjxojmtOUq
   A5f3L+F6uZ5lmmTG2POQSxD8Fmls6MIWEDRGZZyt9IjpztlFBB5CM4qmQ
   Ye6KMMRKYg6F454kNpIAUK2Jk5fpDT1RfOH3accSrWNoA5jqYMdxtp+1h
   USmMuTaNQjqOT9mBPtAcxQv++blTqMtIteYsYS7tZF4CDOa4H/EOIjyEN
   44z5RSxxJD4G/pTsbM/WynTZH4OqHw5F1GeMtZ0j98KvdN3lJpgnk2ANa
   5chp5L7Ed5q8yBU7oWlzw4mvbX1Jpadg/U/P7X1FHOsX9tK+PZvbhEwom
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="329429512"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="329429512"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 21:32:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="692830502"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="692830502"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 May 2023 21:32:57 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwF20-0001hC-2Y;
        Tue, 09 May 2023 04:32:56 +0000
Date:   Tue, 9 May 2023 12:32:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.05.08b 71/71]
 include/linux/atomic/atomic-arch-fallback.h:1105:1: error: expected
 identifier or '('
Message-ID: <202305091239.JmqeW4ob-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.05.08b
head:   46be07e0c635f84a3ce3a6d2d841785872bf59c9
commit: 46be07e0c635f84a3ce3a6d2d841785872bf59c9 [71/71] locking/atomic: Refrain from generating duplicate fallbacks
config: arm-randconfig-r011-20230508 (https://download.01.org/0day-ci/archive/20230509/202305091239.JmqeW4ob-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b0fb98227c90adf2536c9ad644a74d5e92961111)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=46be07e0c635f84a3ce3a6d2d841785872bf59c9
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2023.05.08b
        git checkout 46be07e0c635f84a3ce3a6d2d841785872bf59c9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305091239.JmqeW4ob-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:68:
   In file included from arch/arm/include/asm/bitops.h:245:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:80:
>> include/linux/atomic/atomic-arch-fallback.h:1105:1: error: expected identifier or '('
   BUILD_BUG_ON(1) // Fallback acquire omitting duplicate arch_atomic_fetch_andnot_acquire().
   ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:397:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:385:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:369:2: note: expanded from macro '__compiletime_assert'
           do {                                                            \
           ^
   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:68:
   In file included from arch/arm/include/asm/bitops.h:245:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:80:
>> include/linux/atomic/atomic-arch-fallback.h:1105:1: error: while loop outside of a function
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:397:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:385:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:379:4: note: expanded from macro '__compiletime_assert'
           } while (0)
             ^
   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:68:
   In file included from arch/arm/include/asm/bitops.h:245:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:80:
   include/linux/atomic/atomic-arch-fallback.h:1110:1: error: while loop outside of a function
   BUILD_BUG_ON(1) // Fallback release omitting duplicate arch_atomic_fetch_andnot_release().
   ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:397:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:385:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:379:4: note: expanded from macro '__compiletime_assert'
           } while (0)
             ^
   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:68:
   In file included from arch/arm/include/asm/bitops.h:245:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:80:
   include/linux/atomic/atomic-arch-fallback.h:1115:1: error: while loop outside of a function
   BUILD_BUG_ON(1) // Fallback fence omitting duplicate arch_atomic_fetch_andnot().
   ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:397:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:385:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:379:4: note: expanded from macro '__compiletime_assert'
           } while (0)
             ^
   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:68:
   In file included from arch/arm/include/asm/bitops.h:245:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:81:
>> include/linux/atomic/atomic-long.h:817:9: error: call to undeclared function 'arch_atomic_fetch_andnot'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return arch_atomic_fetch_andnot(i, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1116:34: note: expanded from macro 'arch_atomic_fetch_andnot'
   #define arch_atomic_fetch_andnot arch_atomic_fetch_andnot
                                    ^
   include/linux/atomic/atomic-long.h:817:9: note: did you mean 'arch_atomic64_fetch_andnot'?
   include/linux/atomic/atomic-arch-fallback.h:1116:34: note: expanded from macro 'arch_atomic_fetch_andnot'
   #define arch_atomic_fetch_andnot arch_atomic_fetch_andnot
                                    ^
   include/linux/atomic/atomic-arch-fallback.h:2601:1: note: 'arch_atomic64_fetch_andnot' declared here
   arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
   ^
   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:68:
   In file included from arch/arm/include/asm/bitops.h:245:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:81:
>> include/linux/atomic/atomic-long.h:823:9: error: call to undeclared function 'arch_atomic_fetch_andnot_acquire'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return arch_atomic_fetch_andnot_acquire(i, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1106:42: note: expanded from macro 'arch_atomic_fetch_andnot_acquire'
   #define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
                                            ^
   include/linux/atomic/atomic-long.h:823:9: note: did you mean 'arch_atomic64_fetch_andnot_acquire'?
   include/linux/atomic/atomic-arch-fallback.h:1106:42: note: expanded from macro 'arch_atomic_fetch_andnot_acquire'
   #define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
                                            ^
   include/linux/atomic/atomic-arch-fallback.h:2618:1: note: 'arch_atomic64_fetch_andnot_acquire' declared here
   arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
   ^
   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:68:
   In file included from arch/arm/include/asm/bitops.h:245:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:81:
>> include/linux/atomic/atomic-long.h:829:9: error: call to undeclared function 'arch_atomic_fetch_andnot_release'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return arch_atomic_fetch_andnot_release(i, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1111:42: note: expanded from macro 'arch_atomic_fetch_andnot_release'
   #define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
                                            ^
   include/linux/atomic/atomic-long.h:829:9: note: did you mean 'arch_atomic64_fetch_andnot_release'?
   include/linux/atomic/atomic-arch-fallback.h:1111:42: note: expanded from macro 'arch_atomic_fetch_andnot_release'
   #define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
                                            ^
   include/linux/atomic/atomic-arch-fallback.h:2635:1: note: 'arch_atomic64_fetch_andnot_release' declared here
   arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
   ^
   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:68:
   In file included from arch/arm/include/asm/bitops.h:245:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:81:
>> include/linux/atomic/atomic-long.h:853:9: error: call to undeclared function 'arch_atomic_fetch_or_acquire'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return arch_atomic_fetch_or_acquire(i, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1143:38: note: expanded from macro 'arch_atomic_fetch_or_acquire'
   #define arch_atomic_fetch_or_acquire arch_atomic_fetch_or_acquire
                                        ^
   include/linux/atomic/atomic-long.h:853:9: note: did you mean 'arch_atomic_fetch_xor_acquire'?
   include/linux/atomic/atomic-arch-fallback.h:1143:38: note: expanded from macro 'arch_atomic_fetch_or_acquire'
   #define arch_atomic_fetch_or_acquire arch_atomic_fetch_or_acquire
                                        ^
   include/linux/atomic/atomic-arch-fallback.h:1203:1: note: 'arch_atomic_fetch_xor_acquire' declared here
   arch_atomic_fetch_xor_acquire(int i, atomic_t *v)
   ^
   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:68:
   In file included from arch/arm/include/asm/bitops.h:245:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:82:
>> include/linux/atomic/atomic-instrumented.h:370:9: error: call to undeclared function 'arch_atomic_fetch_andnot'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return arch_atomic_fetch_andnot(i, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1116:34: note: expanded from macro 'arch_atomic_fetch_andnot'
   #define arch_atomic_fetch_andnot arch_atomic_fetch_andnot
                                    ^
   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:68:
   In file included from arch/arm/include/asm/bitops.h:245:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:82:
>> include/linux/atomic/atomic-instrumented.h:377:9: error: call to undeclared function 'arch_atomic_fetch_andnot_acquire'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return arch_atomic_fetch_andnot_acquire(i, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1106:42: note: expanded from macro 'arch_atomic_fetch_andnot_acquire'
   #define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
                                            ^
   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:68:
   In file included from arch/arm/include/asm/bitops.h:245:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:82:
>> include/linux/atomic/atomic-instrumented.h:385:9: error: call to undeclared function 'arch_atomic_fetch_andnot_release'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return arch_atomic_fetch_andnot_release(i, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1111:42: note: expanded from macro 'arch_atomic_fetch_andnot_release'
   #define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
                                            ^
   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:68:
   In file included from arch/arm/include/asm/bitops.h:245:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:82:
>> include/linux/atomic/atomic-instrumented.h:414:9: error: call to undeclared function 'arch_atomic_fetch_or_acquire'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return arch_atomic_fetch_or_acquire(i, v);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:1143:38: note: expanded from macro 'arch_atomic_fetch_or_acquire'
   #define arch_atomic_fetch_or_acquire arch_atomic_fetch_or_acquire
                                        ^
   12 errors generated.
   make[2]: *** [scripts/Makefile.build:114: kernel/bounds.s] Error 1
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:1287: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +1105 include/linux/atomic/atomic-arch-fallback.h

  1103	
  1104	#ifndef arch_atomic_fetch_andnot_acquire
> 1105	BUILD_BUG_ON(1) // Fallback acquire omitting duplicate arch_atomic_fetch_andnot_acquire().
  1106	#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
  1107	#endif
  1108	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
