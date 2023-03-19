Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312EF6C0364
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 18:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjCSRNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 13:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCSRNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 13:13:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CBA1B316
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679245996; x=1710781996;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zBcBKd7yqKi5LL8F7JWFx4ydmAhlEQ660OVKJvN6AI8=;
  b=aPYublLpRg6d8OmfVuXVuiOFP4bEMBCCmrRcrHuv2WbH/d0h6Mcp14jp
   RTbwr9xXuMKxp3t9WbpxHMwMTBUV+K1el+vB9fbHReMrqztEPyQGtXI+L
   YiYiW7ozdrb+TS6Xc9kGTL5gu9cCj9vFGHVhkQ3VdJ37li3E8uQ4Xp0/c
   /3bcR23/9eROMJgqVKp9hS4WAo1iwJNQQ1ZZX4cBGuOlA4D1lrNDBKruA
   EqUBW37mO9pZUsHW1iNP8xaO/l3Jl/xp0gBoNxVNRLv7Qz2OCBl8Je3mP
   ffeac2134vHVzfaveQ8QrfthossBO3eCGzxQgM0gXxDJVcg8QJGrkC3Hk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326895381"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326895381"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 10:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="658117924"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="658117924"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Mar 2023 10:13:12 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdwal-000Ab4-32;
        Sun, 19 Mar 2023 17:13:11 +0000
Date:   Mon, 20 Mar 2023 01:12:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.03.17a] BUILD SUCCESS WITH WARNING
 19d218a4b125a4dce12eb88097a9c55f7126ce8c
Message-ID: <6417427f.Mfng2XVG0Wi+PVxw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.03.17a
branch HEAD: 19d218a4b125a4dce12eb88097a9c55f7126ce8c  srcu: Remove extraneous parentheses from srcu_read_lock() etc.

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303191400.iO5BOqka-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303191536.XzMSyzTl-lkp@intel.com

Warning: (recently discovered and may have been fixed)

arch/arm/kernel/smp.c:385:1: warning: 'noreturn' function does return
kernel/rcu/srcutree.c:1872:22: warning: variable 'ssp' set but not used [-Wunused-but-set-variable]
kernel/rcu/srcutree.c:1872:29: warning: variable 'ssp' set but not used [-Wunused-but-set-variable]
kernel/rcu/srcutree.c:1876:22: warning: variable 'ssp' set but not used [-Wunused-but-set-variable]
kernel/rcu/srcutree.c:1876:29: warning: variable 'ssp' set but not used [-Wunused-but-set-variable]
kernel/rcu/tasks.h:140:20: warning: 'tasks_rcu_exit_srcu' defined but not used [-Wunused-variable]

Unverified Warning (likely false positive, please contact us if interested):

kernel/rcu/srcutree.c:1662 srcu_advance_state() warn: inconsistent returns '&ssp->srcu_sup->srcu_gp_mutex'.

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- arc-allyesconfig
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- arc-randconfig-r006-20230319
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- arc-randconfig-r025-20230319
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- arm-buildonly-randconfig-r002-20230319
|   |-- arch-arm-kernel-smp.c:warning:noreturn-function-does-return
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- arm-randconfig-r046-20230319
|   |-- arch-arm-kernel-smp.c:warning:noreturn-function-does-return
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- arm64-randconfig-r032-20230319
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- csky-buildonly-randconfig-r003-20230319
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- i386-allyesconfig
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- i386-randconfig-a003
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- i386-randconfig-a005
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- i386-randconfig-a014
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- i386-randconfig-m021
|   |-- kernel-rcu-srcutree.c-srcu_advance_state()-warn:inconsistent-returns-ssp-srcu_sup-srcu_gp_mutex-.
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- ia64-allmodconfig
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- ia64-allyesconfig
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- ia64-randconfig-r011-20230319
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- ia64-randconfig-r014-20230319
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- loongarch-allmodconfig
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- loongarch-allnoconfig
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- loongarch-allyesconfig
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- loongarch-defconfig
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- loongarch-randconfig-r005-20230319
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- mips-allyesconfig
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
|-- openrisc-randconfig-r022-20230319
clang_recent_errors
|-- i386-randconfig-a004
|   `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used
`-- s390-randconfig-r044-20230319
    `-- kernel-rcu-srcutree.c:warning:variable-ssp-set-but-not-used

elapsed time: 722m

configs tested: 125
configs skipped: 11

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230319   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r031-20230319   gcc  
alpha                randconfig-r036-20230319   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230319   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230319   gcc  
arc                  randconfig-r012-20230319   gcc  
arc                  randconfig-r016-20230319   gcc  
arc                  randconfig-r025-20230319   gcc  
arc                  randconfig-r043-20230319   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230319   gcc  
arm          buildonly-randconfig-r004-20230319   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230319   clang
arm                  randconfig-r016-20230319   gcc  
arm                  randconfig-r032-20230319   clang
arm                  randconfig-r046-20230319   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r024-20230319   clang
arm64                randconfig-r032-20230319   gcc  
csky         buildonly-randconfig-r003-20230319   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230319   gcc  
hexagon      buildonly-randconfig-r004-20230319   clang
hexagon              randconfig-r012-20230319   clang
hexagon              randconfig-r041-20230319   clang
hexagon              randconfig-r045-20230319   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r011-20230319   gcc  
ia64                 randconfig-r014-20230319   gcc  
ia64                 randconfig-r023-20230319   gcc  
ia64                 randconfig-r033-20230319   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230319   gcc  
loongarch            randconfig-r006-20230319   gcc  
loongarch            randconfig-r026-20230319   gcc  
loongarch            randconfig-r034-20230319   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r034-20230319   gcc  
microblaze           randconfig-r024-20230319   gcc  
microblaze           randconfig-r033-20230319   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r005-20230319   clang
nios2        buildonly-randconfig-r006-20230319   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230319   gcc  
nios2                randconfig-r035-20230319   gcc  
openrisc             randconfig-r021-20230319   gcc  
openrisc             randconfig-r022-20230319   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r031-20230319   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r036-20230319   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230319   clang
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230319   gcc  
riscv                randconfig-r004-20230319   gcc  
riscv                randconfig-r015-20230319   clang
riscv                randconfig-r035-20230319   gcc  
riscv                randconfig-r042-20230319   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230319   clang
s390                                defconfig   gcc  
s390                 randconfig-r044-20230319   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r013-20230319   gcc  
sh                   randconfig-r021-20230319   gcc  
sparc        buildonly-randconfig-r006-20230319   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230319   gcc  
sparc64              randconfig-r013-20230319   gcc  
sparc64              randconfig-r015-20230319   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230319   gcc  
xtensa               randconfig-r003-20230319   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
