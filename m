Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BCA723370
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjFEXAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjFEXAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:00:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5423F8F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 16:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686006032; x=1717542032;
  h=date:from:to:cc:subject:message-id;
  bh=A3HJCyjbazn3SYDDV/06v4zy9d0Y7b1b6R6LRok+DyQ=;
  b=lphoQKQR6+Ep+UTmmRijklJ37g9Q8Ml8oDsMY1THzqRDcDg9hHvexDpY
   /uUTb0j/SAIiM1egKIVc42NqWMtKWGOmJWc/7HOrBujy2VDyuhzZPOReu
   ZkdN2/5iCYoWnurEqfcpo12lDdf7NWNDSDnq+klS1qlsvtKzXhCCRufgE
   30E2E3dI8a0D7y0C1KZF4Nm0RyqSbkj9HAqAhF0R6SgaF/OSugqu3/Qh8
   fz8XANebjjKW1LMqyguFxCPSqBYRr5tWsaifOpKNmT3n3iqclxGUQ0L0A
   0Wf6TqdGciJ9SZkyg4wyxqExBAYJxJJu2hfY7DS3THbBn1PIQ2BnBxD/Y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="359819449"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="359819449"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 16:00:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="955501945"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="955501945"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jun 2023 16:00:29 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6JBd-0004W5-0n;
        Mon, 05 Jun 2023 23:00:29 +0000
Date:   Tue, 06 Jun 2023 06:59:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 497cc42bf53b55185ab3d39c634fbf09eb6681ae
Message-ID: <20230605225956.AHqQ4%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 497cc42bf53b55185ab3d39c634fbf09eb6681ae  s390/cpum_sf: Convert to cmpxchg128()

elapsed time: 849m

configs tested: 247
configs skipped: 17

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230605   gcc  
alpha        buildonly-randconfig-r005-20230605   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230605   gcc  
alpha                randconfig-r013-20230605   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230605   gcc  
arc          buildonly-randconfig-r005-20230605   gcc  
arc          buildonly-randconfig-r006-20230605   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                  randconfig-r003-20230605   gcc  
arc                  randconfig-r016-20230605   gcc  
arc                  randconfig-r025-20230605   gcc  
arc                  randconfig-r026-20230605   gcc  
arc                  randconfig-r043-20230605   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r003-20230605   clang
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                  randconfig-r025-20230605   clang
arm                  randconfig-r032-20230605   gcc  
arm                  randconfig-r036-20230605   gcc  
arm                  randconfig-r046-20230605   clang
arm                        realview_defconfig   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           spitz_defconfig   clang
arm                       versatile_defconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r006-20230605   clang
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230605   clang
arm64                randconfig-r012-20230605   gcc  
arm64                randconfig-r013-20230605   gcc  
arm64                randconfig-r016-20230605   gcc  
arm64                randconfig-r034-20230605   clang
csky         buildonly-randconfig-r001-20230605   gcc  
csky         buildonly-randconfig-r005-20230605   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230605   gcc  
csky                 randconfig-r002-20230605   gcc  
csky                 randconfig-r004-20230605   gcc  
csky                 randconfig-r012-20230605   gcc  
csky                 randconfig-r014-20230605   gcc  
csky                 randconfig-r015-20230605   gcc  
csky                 randconfig-r031-20230605   gcc  
csky                 randconfig-r032-20230605   gcc  
csky                 randconfig-r034-20230605   gcc  
hexagon                          alldefconfig   clang
hexagon              randconfig-r004-20230605   clang
hexagon              randconfig-r025-20230605   clang
hexagon              randconfig-r036-20230605   clang
hexagon              randconfig-r041-20230605   clang
hexagon              randconfig-r045-20230605   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230605   clang
i386                 randconfig-i002-20230605   clang
i386                 randconfig-i003-20230605   clang
i386                 randconfig-i004-20230605   clang
i386                 randconfig-i005-20230605   clang
i386                 randconfig-i006-20230605   clang
i386                 randconfig-i011-20230605   gcc  
i386                 randconfig-i012-20230605   gcc  
i386                 randconfig-i013-20230605   gcc  
i386                 randconfig-i014-20230605   gcc  
i386                 randconfig-i015-20230605   gcc  
i386                 randconfig-i016-20230605   gcc  
i386                 randconfig-i051-20230605   clang
i386                 randconfig-i052-20230605   clang
i386                 randconfig-i053-20230605   clang
i386                 randconfig-i054-20230605   clang
i386                 randconfig-i055-20230605   clang
i386                 randconfig-i056-20230605   clang
i386                 randconfig-i061-20230605   clang
i386                 randconfig-i062-20230605   clang
i386                 randconfig-i063-20230605   clang
i386                 randconfig-i064-20230605   clang
i386                 randconfig-i065-20230605   clang
i386                 randconfig-i066-20230605   clang
i386                 randconfig-r011-20230605   gcc  
i386                 randconfig-r021-20230605   gcc  
i386                 randconfig-r022-20230605   gcc  
i386                 randconfig-r025-20230605   gcc  
i386                 randconfig-r026-20230605   gcc  
ia64                        generic_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230605   gcc  
loongarch    buildonly-randconfig-r004-20230605   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230605   gcc  
loongarch            randconfig-r016-20230605   gcc  
loongarch            randconfig-r023-20230605   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230605   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230605   gcc  
m68k                 randconfig-r021-20230605   gcc  
m68k                 randconfig-r023-20230605   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze           randconfig-r001-20230605   gcc  
microblaze           randconfig-r002-20230605   gcc  
microblaze           randconfig-r004-20230605   gcc  
microblaze           randconfig-r006-20230605   gcc  
microblaze           randconfig-r016-20230605   gcc  
microblaze           randconfig-r026-20230605   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r005-20230605   gcc  
mips                         cobalt_defconfig   gcc  
mips                           ip28_defconfig   clang
mips                     loongson1b_defconfig   gcc  
mips                      malta_kvm_defconfig   clang
mips                 randconfig-r003-20230605   gcc  
nios2                            alldefconfig   gcc  
nios2        buildonly-randconfig-r003-20230605   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230605   gcc  
nios2                randconfig-r003-20230605   gcc  
nios2                randconfig-r005-20230605   gcc  
nios2                randconfig-r011-20230605   gcc  
nios2                randconfig-r014-20230605   gcc  
nios2                randconfig-r016-20230605   gcc  
openrisc     buildonly-randconfig-r003-20230605   gcc  
openrisc             randconfig-r006-20230605   gcc  
openrisc             randconfig-r022-20230605   gcc  
openrisc             randconfig-r023-20230605   gcc  
parisc       buildonly-randconfig-r003-20230605   gcc  
parisc       buildonly-randconfig-r004-20230605   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230605   gcc  
parisc               randconfig-r012-20230605   gcc  
parisc               randconfig-r014-20230605   gcc  
parisc               randconfig-r015-20230605   gcc  
parisc               randconfig-r025-20230605   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230605   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                 mpc8540_ads_defconfig   gcc  
powerpc                    mvme5100_defconfig   clang
powerpc                      ppc40x_defconfig   gcc  
powerpc              randconfig-r012-20230605   gcc  
powerpc              randconfig-r013-20230605   gcc  
powerpc              randconfig-r014-20230605   gcc  
powerpc              randconfig-r015-20230605   gcc  
powerpc              randconfig-r021-20230605   gcc  
powerpc              randconfig-r035-20230605   clang
powerpc              randconfig-r036-20230605   clang
powerpc                        warp_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230605   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230605   clang
riscv                randconfig-r005-20230605   clang
riscv                randconfig-r006-20230605   clang
riscv                randconfig-r015-20230605   gcc  
riscv                randconfig-r022-20230605   gcc  
riscv                randconfig-r042-20230605   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230605   gcc  
s390                 randconfig-r016-20230605   gcc  
s390                 randconfig-r035-20230605   clang
s390                 randconfig-r044-20230605   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230605   gcc  
sh                         ecovec24_defconfig   gcc  
sh                   randconfig-r013-20230605   gcc  
sh                   randconfig-r021-20230605   gcc  
sh                   randconfig-r024-20230605   gcc  
sh                   randconfig-r034-20230605   gcc  
sh                            titan_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230605   gcc  
sparc                randconfig-r004-20230605   gcc  
sparc                randconfig-r012-20230605   gcc  
sparc                randconfig-r022-20230605   gcc  
sparc                randconfig-r024-20230605   gcc  
sparc                randconfig-r025-20230605   gcc  
sparc                randconfig-r026-20230605   gcc  
sparc                randconfig-r035-20230605   gcc  
sparc64      buildonly-randconfig-r003-20230605   gcc  
sparc64      buildonly-randconfig-r006-20230605   gcc  
sparc64              randconfig-r011-20230605   gcc  
sparc64              randconfig-r023-20230605   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230605   clang
x86_64               randconfig-a002-20230605   clang
x86_64               randconfig-a003-20230605   clang
x86_64               randconfig-a004-20230605   clang
x86_64               randconfig-a005-20230605   clang
x86_64               randconfig-a006-20230605   clang
x86_64               randconfig-a011-20230605   gcc  
x86_64               randconfig-a012-20230605   gcc  
x86_64               randconfig-a013-20230605   gcc  
x86_64               randconfig-a014-20230605   gcc  
x86_64               randconfig-a015-20230605   gcc  
x86_64               randconfig-a016-20230605   gcc  
x86_64               randconfig-r005-20230605   clang
x86_64               randconfig-r016-20230605   gcc  
x86_64               randconfig-r024-20230605   gcc  
x86_64               randconfig-r031-20230605   clang
x86_64               randconfig-x051-20230605   gcc  
x86_64               randconfig-x052-20230605   gcc  
x86_64               randconfig-x053-20230605   gcc  
x86_64               randconfig-x054-20230605   gcc  
x86_64               randconfig-x055-20230605   gcc  
x86_64               randconfig-x056-20230605   gcc  
x86_64               randconfig-x061-20230605   gcc  
x86_64               randconfig-x062-20230605   gcc  
x86_64               randconfig-x063-20230605   gcc  
x86_64               randconfig-x064-20230605   gcc  
x86_64               randconfig-x065-20230605   gcc  
x86_64               randconfig-x066-20230605   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230605   gcc  
xtensa       buildonly-randconfig-r005-20230605   gcc  
xtensa       buildonly-randconfig-r006-20230605   gcc  
xtensa               randconfig-r002-20230605   gcc  
xtensa               randconfig-r004-20230605   gcc  
xtensa               randconfig-r006-20230605   gcc  
xtensa               randconfig-r011-20230605   gcc  
xtensa               randconfig-r013-20230605   gcc  
xtensa               randconfig-r015-20230605   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
