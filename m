Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEA16F0CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244981AbjD0Tkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbjD0Tkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:40:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38471270F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682624427; x=1714160427;
  h=date:from:to:cc:subject:message-id;
  bh=wYA0KWnnNKTkg4NUOVza6Id8d7YkuyHkssIwLZxSJ5c=;
  b=PLZ1s665w7Zv2wYMz8XElBD7NBf69MRhtz3SPwIXYjHKVCxNBmtvSmm8
   PPtD7FVaD316L+SpdqVRDCHaCCrT6VBQJvG210FJdftgX0Gdbs/KeKa/r
   mmc5WnWWS2dEtrp4YPsb72fk8Al8F7vV3YunRTfoXtzYi6aUx0zXRpOjE
   nWE2i6UcYxGDdN4fHtZ+94IWydyR8bCimGosyIXvne7y/1fKsfsHTSpIk
   aQU3y/PfgBsVBG8LPerfShXwWoear+Fkqym/1YoUB8GpJhLJ3cIhkMBna
   0i9uAwtiRKiF1hNjprb+hOA5xnxOypvXBQg2SqhAiV5axLh+kYo08sWXB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="347570422"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="347570422"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:40:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="763965966"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="763965966"
Received: from lkp-server01.sh.intel.com (HELO b95e16499b55) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2023 12:40:25 -0700
Received: from kbuild by b95e16499b55 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ps7Tc-00005x-2Q;
        Thu, 27 Apr 2023 19:40:24 +0000
Date:   Fri, 28 Apr 2023 03:40:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.04.10a] BUILD SUCCESS
 26a29ad68271df988a813e227da98861ae3bef9e
Message-ID: <20230427194005.62cJ-%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.04.10a
branch HEAD: 26a29ad68271df988a813e227da98861ae3bef9e  Stop rcu_tasks_invoke_cbs() from using never-onlined CPUs

elapsed time: 917m

configs tested: 114
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230427   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230427   gcc  
arc                  randconfig-r033-20230427   gcc  
arc                  randconfig-r043-20230427   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r025-20230427   gcc  
arm                  randconfig-r046-20230427   gcc  
arm                        realview_defconfig   gcc  
arm                        spear3xx_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230427   gcc  
hexagon              randconfig-r021-20230427   clang
hexagon              randconfig-r036-20230427   clang
hexagon              randconfig-r041-20230427   clang
hexagon              randconfig-r045-20230427   clang
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
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230427   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230427   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                           virt_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                           rs90_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r032-20230427   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r013-20230427   gcc  
openrisc             randconfig-r014-20230427   gcc  
openrisc             randconfig-r015-20230427   gcc  
openrisc             randconfig-r031-20230427   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc               randconfig-r016-20230427   gcc  
parisc               randconfig-r022-20230427   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230427   clang
powerpc                    gamecube_defconfig   clang
powerpc                        icon_defconfig   clang
powerpc                  storcenter_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230427   clang
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230427   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230427   clang
s390                 randconfig-r044-20230427   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r026-20230427   gcc  
sh                           se7722_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sparc        buildonly-randconfig-r005-20230427   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r024-20230427   gcc  
sparc                randconfig-r034-20230427   gcc  
sparc64              randconfig-r004-20230427   gcc  
sparc64              randconfig-r006-20230427   gcc  
sparc64              randconfig-r023-20230427   gcc  
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
xtensa               randconfig-r001-20230427   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
