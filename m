Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F58D72B031
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 06:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjFKEMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 00:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFKEMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 00:12:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9024C135
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 21:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686456768; x=1717992768;
  h=date:from:to:cc:subject:message-id;
  bh=JjAeIoEsG5Nqgaj/MrWaM9A/GuIz9KtZSeMH1ebeTwg=;
  b=ePi7oJVwzjdZxGI3ihKQxNvR0KAX2INq346staQc8d6uzCNKwjzz5mv1
   f0JTQ3Ba0Rc2nC4s0mzai2kau9coIXbJj1uDk/x8vzW47tFKf9jHaQDUl
   a9eyfmjPmW6X3HIcCrDeBbM2+vvb1uz1jlYw9B2mYqddcnzxyM5ZqwOi3
   6NwXFbOL6NlSXRTaEF2x5NmclkQImJTQCyrFFetYq+lkzr8wMdChQ7Epr
   5ateBKFPWHp/r0pxyiJrk0qWqHVmYZNY+E1R7HY74CdXiBeQS2BS5Jjem
   5ttaLrvG5uSJbYaGJxbMyvh/wQ8Bt9yiM2AgzoGq7ePC2i8dZNJEHaArQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="347472425"
X-IronPort-AV: E=Sophos;i="6.00,233,1681196400"; 
   d="scan'208";a="347472425"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 21:12:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="688200326"
X-IronPort-AV: E=Sophos;i="6.00,233,1681196400"; 
   d="scan'208";a="688200326"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2023 21:12:46 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8CRZ-000Ac4-2u;
        Sun, 11 Jun 2023 04:12:45 +0000
Date:   Sun, 11 Jun 2023 12:12:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 ad0334ffa4f9ae3dacfd89dae578df97f18a5203
Message-ID: <202306111234.AOKiIQ7D-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: ad0334ffa4f9ae3dacfd89dae578df97f18a5203  posix-timers: Add sys_ni_posix_timers() prototype

elapsed time: 721m

configs tested: 125
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r032-20230611   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230611   gcc  
arc                  randconfig-r013-20230611   gcc  
arc                  randconfig-r043-20230611   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   gcc  
arm                          ep93xx_defconfig   clang
arm                      integrator_defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                          moxart_defconfig   clang
arm                        multi_v5_defconfig   clang
arm                       netwinder_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                  randconfig-r031-20230611   clang
arm                  randconfig-r034-20230611   clang
arm                  randconfig-r046-20230611   gcc  
arm                       versatile_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r015-20230611   clang
csky                                defconfig   gcc  
csky                 randconfig-r011-20230611   gcc  
hexagon              randconfig-r001-20230611   clang
hexagon              randconfig-r041-20230611   clang
hexagon              randconfig-r045-20230611   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230611   gcc  
i386                 randconfig-i002-20230611   gcc  
i386                 randconfig-i003-20230611   gcc  
i386                 randconfig-i004-20230611   gcc  
i386                 randconfig-i005-20230611   gcc  
i386                 randconfig-i006-20230611   gcc  
i386                 randconfig-i011-20230611   clang
i386                 randconfig-i012-20230611   clang
i386                 randconfig-i013-20230611   clang
i386                 randconfig-i014-20230611   clang
i386                 randconfig-i015-20230611   clang
i386                 randconfig-i016-20230611   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k         buildonly-randconfig-r006-20230611   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r005-20230611   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                         db1xxx_defconfig   gcc  
mips                     loongson1c_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230611   gcc  
nios2                randconfig-r025-20230611   gcc  
nios2                randconfig-r036-20230611   gcc  
openrisc             randconfig-r024-20230611   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230611   clang
powerpc                   currituck_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc              randconfig-r023-20230611   clang
powerpc              randconfig-r026-20230611   clang
powerpc                  storcenter_defconfig   gcc  
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                randconfig-r021-20230611   clang
riscv                randconfig-r033-20230611   gcc  
riscv                randconfig-r042-20230611   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230611   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230611   gcc  
sh                         ecovec24_defconfig   gcc  
sh                   randconfig-r014-20230611   gcc  
sh                   randconfig-r035-20230611   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r003-20230611   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230611   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230608   gcc  
x86_64               randconfig-a002-20230608   gcc  
x86_64               randconfig-a003-20230608   gcc  
x86_64               randconfig-a004-20230608   gcc  
x86_64               randconfig-a005-20230608   gcc  
x86_64               randconfig-a006-20230608   gcc  
x86_64               randconfig-a011-20230608   clang
x86_64               randconfig-a012-20230608   clang
x86_64               randconfig-a013-20230608   clang
x86_64               randconfig-a014-20230608   clang
x86_64               randconfig-a015-20230608   clang
x86_64               randconfig-a016-20230608   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa               randconfig-r002-20230611   gcc  
xtensa               randconfig-r003-20230611   gcc  
xtensa               randconfig-r006-20230611   gcc  
xtensa               randconfig-r012-20230611   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
