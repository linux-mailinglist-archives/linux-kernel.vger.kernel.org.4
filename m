Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0BD6FC7A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjEINO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjEINO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:14:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0551BC9
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 06:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683638065; x=1715174065;
  h=date:from:to:cc:subject:message-id;
  bh=mOM4h0evLdcpbFY3A67JjlBgEGs2Tx2Ukw/Yz5G5s0o=;
  b=mrOeJNW87KFW0iRHw7ggQB/vDNRfO1ZeTznnLQ5jMqm/n3u8vw3TX+U5
   lAEIU1N4m0AdJ4TdD7qPnbDEKhoqRw/YCJc5oW8Z+u0vKDbbU+hj0oGZD
   xZUPQXcZA7m2uJhV+vjZDUlgSAOSvJoSbcHqjprls8G45YriX2vTeoYIn
   sH08r/HHYCZNAreG8dxD07JlXH1UV/NJ/yjf0g+rZD/bFjia2X48l2uzg
   PhKCxj7PfVPKZS60n08cno35H5USVkETYKp9yMbi0onTh8d23l0JZ7MUk
   Ir52P9NDu1BdZu9wLle8SHrsBWV/+RKGMSEMFu27BjHV2b/CYsL7uv+NF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="415489593"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="415489593"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 06:14:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="698897230"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="698897230"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 May 2023 06:14:23 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwNAc-0002Ah-2N;
        Tue, 09 May 2023 13:14:22 +0000
Date:   Tue, 09 May 2023 21:13:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.05.08b] BUILD REGRESSION
 46be07e0c635f84a3ce3a6d2d841785872bf59c9
Message-ID: <20230509131322.AfIE5%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.05.08b
branch HEAD: 46be07e0c635f84a3ce3a6d2d841785872bf59c9  locking/atomic: Refrain from generating duplicate fallbacks

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202305091109.X5CYSNZ4-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202305091239.JmqeW4ob-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

include/linux/atomic/atomic-arch-fallback.h:1105:1: error: expected identifier or '('
include/linux/atomic/atomic-arch-fallback.h:1105:1: error: while loop outside of a function
include/linux/atomic/atomic-arch-fallback.h:1106:42: error: implicit declaration of function 'arch_atomic_fetch_andnot_acquire'; did you mean 'arch_atomic64_fetch_andnot_acquire'? [-Werror=implicit-function-declaration]
include/linux/atomic/atomic-arch-fallback.h:1106:42: error: implicit declaration of function 'arch_atomic_fetch_andnot_acquire'; did you mean 'arch_atomic_fetch_and_acquire'? [-Werror=implicit-function-declaration]
include/linux/atomic/atomic-arch-fallback.h:1111:42: error: implicit declaration of function 'arch_atomic_fetch_andnot_release'; did you mean 'arch_atomic64_fetch_andnot_release'? [-Werror=implicit-function-declaration]
include/linux/atomic/atomic-arch-fallback.h:1111:42: error: implicit declaration of function 'arch_atomic_fetch_andnot_release'; did you mean 'arch_atomic_fetch_and_release'? [-Werror=implicit-function-declaration]
include/linux/atomic/atomic-arch-fallback.h:1116:34: error: implicit declaration of function 'arch_atomic_fetch_andnot'; did you mean 'arch_atomic64_fetch_andnot'? [-Werror=implicit-function-declaration]
include/linux/atomic/atomic-arch-fallback.h:1116:34: error: implicit declaration of function 'arch_atomic_fetch_andnot'; did you mean 'arch_atomic_fetch_and'? [-Werror=implicit-function-declaration]
include/linux/atomic/atomic-arch-fallback.h:1143:38: error: implicit declaration of function 'arch_atomic_fetch_or_acquire'; did you mean 'arch_atomic_fetch_xor_acquire'? [-Werror=implicit-function-declaration]
include/linux/atomic/atomic-arch-fallback.h:2663:44: error: implicit declaration of function 'arch_atomic64_fetch_andnot_acquire'; did you mean 'arch_atomic64_fetch_and_acquire'? [-Werror=implicit-function-declaration]
include/linux/atomic/atomic-arch-fallback.h:2668:44: error: implicit declaration of function 'arch_atomic64_fetch_andnot_release'; did you mean 'arch_atomic64_fetch_and_release'? [-Werror=implicit-function-declaration]
include/linux/atomic/atomic-arch-fallback.h:2673:36: error: implicit declaration of function 'arch_atomic64_fetch_andnot'; did you mean 'arch_atomic64_fetch_and'? [-Werror=implicit-function-declaration]
include/linux/atomic/atomic-arch-fallback.h:2700:40: error: implicit declaration of function 'arch_atomic64_fetch_or_acquire'; did you mean 'arch_atomic64_fetch_xor_acquire'? [-Werror=implicit-function-declaration]
include/linux/atomic/atomic-instrumented.h:1011:9: error: call to undeclared function 'arch_atomic64_fetch_andnot'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
include/linux/atomic/atomic-instrumented.h:1018:9: error: call to undeclared function 'arch_atomic64_fetch_andnot_acquire'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
include/linux/atomic/atomic-instrumented.h:1026:9: error: call to undeclared function 'arch_atomic64_fetch_andnot_release'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
include/linux/atomic/atomic-instrumented.h:370:9: error: call to undeclared function 'arch_atomic_fetch_andnot'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
include/linux/atomic/atomic-instrumented.h:377:9: error: call to undeclared function 'arch_atomic_fetch_andnot_acquire'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
include/linux/atomic/atomic-instrumented.h:385:9: error: call to undeclared function 'arch_atomic_fetch_andnot_release'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
include/linux/atomic/atomic-instrumented.h:414:9: error: call to undeclared function 'arch_atomic_fetch_or_acquire'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
include/linux/atomic/atomic-long.h:817:9: error: call to undeclared function 'arch_atomic_fetch_andnot'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
include/linux/atomic/atomic-long.h:823:9: error: call to undeclared function 'arch_atomic_fetch_andnot_acquire'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
include/linux/atomic/atomic-long.h:829:9: error: call to undeclared function 'arch_atomic_fetch_andnot_release'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
include/linux/atomic/atomic-long.h:853:9: error: call to undeclared function 'arch_atomic_fetch_or_acquire'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
include/linux/compiler_types.h:369:9: error: expected identifier or '(' before 'do'
include/linux/compiler_types.h:379:11: error: expected identifier or '(' before 'while'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic64_fetch_andnot
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic64_fetch_andnot_acquire
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic64_fetch_andnot_release
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic64_fetch_or_acquire
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_andnot
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_andnot_acquire
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_andnot_release
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_or_acquire
|   |-- include-linux-compiler_types.h:error:expected-identifier-or-(-before-do
|   `-- include-linux-compiler_types.h:error:expected-identifier-or-(-before-while
|-- alpha-allyesconfig
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic64_fetch_andnot
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic64_fetch_andnot_acquire
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic64_fetch_andnot_release
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic64_fetch_or_acquire
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_andnot
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_andnot_acquire
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_andnot_release
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_or_acquire
|   |-- include-linux-compiler_types.h:error:expected-identifier-or-(-before-do
|   `-- include-linux-compiler_types.h:error:expected-identifier-or-(-before-while
|-- alpha-randconfig-r001-20230508
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic64_fetch_andnot
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic64_fetch_andnot_acquire
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic64_fetch_andnot_release
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic64_fetch_or_acquire
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_andnot
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_andnot_acquire
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_andnot_release
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_or_acquire
|   |-- include-linux-compiler_types.h:error:expected-identifier-or-(-before-do
|   `-- include-linux-compiler_types.h:error:expected-identifier-or-(-before-while
|-- arc-randconfig-r023-20230507
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_andnot
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_andnot_acquire
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_andnot_release
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_or_acquire
|   |-- include-linux-compiler_types.h:error:expected-identifier-or-(-before-do
|   `-- include-linux-compiler_types.h:error:expected-identifier-or-(-before-while
`-- arm-randconfig-r046-20230507
    |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_andnot
    |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_andnot_acquire
    |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_andnot_release
    |-- include-linux-atomic-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_atomic_fetch_or_acquire
    |-- include-linux-compiler_types.h:error:expected-identifier-or-(-before-do
    `-- include-linux-compiler_types.h:error:expected-identifier-or-(-before-while
clang_recent_errors
|-- arm-randconfig-r003-20230507
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:expected-identifier-or-(
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:while-loop-outside-of-a-function
|   |-- include-linux-atomic-atomic-instrumented.h:error:call-to-undeclared-function-arch_atomic64_fetch_andnot-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- include-linux-atomic-atomic-instrumented.h:error:call-to-undeclared-function-arch_atomic64_fetch_andnot_acquire-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- include-linux-atomic-atomic-instrumented.h:error:call-to-undeclared-function-arch_atomic64_fetch_andnot_release-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- include-linux-atomic-atomic-instrumented.h:error:call-to-undeclared-function-arch_atomic_fetch_andnot-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- include-linux-atomic-atomic-instrumented.h:error:call-to-undeclared-function-arch_atomic_fetch_andnot_acquire-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- include-linux-atomic-atomic-instrumented.h:error:call-to-undeclared-function-arch_atomic_fetch_andnot_release-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- include-linux-atomic-atomic-instrumented.h:error:call-to-undeclared-function-arch_atomic_fetch_or_acquire-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- include-linux-atomic-atomic-long.h:error:call-to-undeclared-function-arch_atomic_fetch_andnot-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- include-linux-atomic-atomic-long.h:error:call-to-undeclared-function-arch_atomic_fetch_andnot_acquire-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- include-linux-atomic-atomic-long.h:error:call-to-undeclared-function-arch_atomic_fetch_andnot_release-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- include-linux-atomic-atomic-long.h:error:call-to-undeclared-function-arch_atomic_fetch_or_acquire-ISO-C99-and-later-do-not-support-implicit-function-declarations
`-- arm-randconfig-r011-20230508
    |-- include-linux-atomic-atomic-arch-fallback.h:error:expected-identifier-or-(
    |-- include-linux-atomic-atomic-arch-fallback.h:error:while-loop-outside-of-a-function
    |-- include-linux-atomic-atomic-instrumented.h:error:call-to-undeclared-function-arch_atomic_fetch_andnot-ISO-C99-and-later-do-not-support-implicit-function-declarations
    |-- include-linux-atomic-atomic-instrumented.h:error:call-to-undeclared-function-arch_atomic_fetch_andnot_acquire-ISO-C99-and-later-do-not-support-implicit-function-declarations
    |-- include-linux-atomic-atomic-instrumented.h:error:call-to-undeclared-function-arch_atomic_fetch_andnot_release-ISO-C99-and-later-do-not-support-implicit-function-declarations
    |-- include-linux-atomic-atomic-instrumented.h:error:call-to-undeclared-function-arch_atomic_fetch_or_acquire-ISO-C99-and-later-do-not-support-implicit-function-declarations
    |-- include-linux-atomic-atomic-long.h:error:call-to-undeclared-function-arch_atomic_fetch_andnot-ISO-C99-and-later-do-not-support-implicit-function-declarations
    |-- include-linux-atomic-atomic-long.h:error:call-to-undeclared-function-arch_atomic_fetch_andnot_acquire-ISO-C99-and-later-do-not-support-implicit-function-declarations
    |-- include-linux-atomic-atomic-long.h:error:call-to-undeclared-function-arch_atomic_fetch_andnot_release-ISO-C99-and-later-do-not-support-implicit-function-declarations
    `-- include-linux-atomic-atomic-long.h:error:call-to-undeclared-function-arch_atomic_fetch_or_acquire-ISO-C99-and-later-do-not-support-implicit-function-declarations

elapsed time: 727m

configs tested: 117
configs skipped: 7

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230508   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r005-20230507   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r023-20230507   gcc  
arc                  randconfig-r043-20230507   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230507   clang
arm                  randconfig-r011-20230508   clang
arm                  randconfig-r024-20230508   clang
arm                  randconfig-r046-20230507   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r031-20230509   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230507   gcc  
csky                 randconfig-r036-20230509   gcc  
hexagon      buildonly-randconfig-r004-20230508   clang
hexagon              randconfig-r005-20230508   clang
hexagon              randconfig-r012-20230508   clang
hexagon              randconfig-r041-20230507   clang
hexagon              randconfig-r045-20230507   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r001-20230508   clang
i386         buildonly-randconfig-r005-20230508   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230508   clang
i386                 randconfig-a002-20230508   clang
i386                 randconfig-a003-20230508   clang
i386                 randconfig-a004-20230508   clang
i386                 randconfig-a005-20230508   clang
i386                 randconfig-a006-20230508   clang
i386                 randconfig-a011-20230508   gcc  
i386                 randconfig-a012-20230508   gcc  
i386                 randconfig-a013-20230508   gcc  
i386                 randconfig-a014-20230508   gcc  
i386                 randconfig-a015-20230508   gcc  
i386                 randconfig-a016-20230508   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r021-20230507   gcc  
ia64                 randconfig-r022-20230507   gcc  
ia64                 randconfig-r035-20230509   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230508   gcc  
microblaze           randconfig-r002-20230507   gcc  
microblaze           randconfig-r004-20230507   gcc  
microblaze           randconfig-r005-20230507   gcc  
microblaze           randconfig-r014-20230508   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230507   clang
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230508   gcc  
nios2                randconfig-r006-20230508   gcc  
openrisc     buildonly-randconfig-r001-20230507   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r015-20230508   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230507   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230507   gcc  
riscv                randconfig-r026-20230508   gcc  
riscv                randconfig-r042-20230507   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r022-20230508   gcc  
s390                 randconfig-r044-20230507   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230507   gcc  
sh                   randconfig-r025-20230507   gcc  
sh                   randconfig-r033-20230509   gcc  
sh                   randconfig-r034-20230509   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230508   gcc  
sparc                randconfig-r024-20230507   gcc  
sparc64      buildonly-randconfig-r006-20230507   gcc  
sparc64              randconfig-r013-20230508   gcc  
sparc64              randconfig-r021-20230508   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r002-20230508   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230508   clang
x86_64               randconfig-a002-20230508   clang
x86_64               randconfig-a003-20230508   clang
x86_64               randconfig-a004-20230508   clang
x86_64               randconfig-a005-20230508   clang
x86_64               randconfig-a006-20230508   clang
x86_64               randconfig-a011-20230508   gcc  
x86_64               randconfig-a012-20230508   gcc  
x86_64               randconfig-a013-20230508   gcc  
x86_64               randconfig-a014-20230508   gcc  
x86_64               randconfig-a015-20230508   gcc  
x86_64               randconfig-a016-20230508   gcc  
x86_64               randconfig-r003-20230508   clang
x86_64               randconfig-r023-20230508   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r032-20230509   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
