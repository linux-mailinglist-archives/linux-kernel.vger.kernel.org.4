Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A1D5E8D24
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 15:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiIXNgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 09:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiIXNgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 09:36:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864C826AE0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 06:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664026595; x=1695562595;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nrHGPQE0ebx0LSwOhgWhn3p0ahPrNolE035XO6Ua4cY=;
  b=gORyHBFXJH8DBGllO0egBwnyfCsvx9i6YE4PYrf/YOMr9wQtaWyGNRX7
   gYxREsWUmxiojPyQq9PT9UGfgC5zszeiN2J3Unb/d4DD2gVP9gUuk4qvk
   zefzKDPR09ZL5nKAlO+TZfv0tqFH6kgqVmMHLEyqC7Pi7T5chrDnMeEnt
   2vJeXdZFnJJjnKyNpGTxbeeYzbL9IfA8jzdIbrZ69axQJcnoeKSIlo+Ad
   apxaoN+T4QxQd4m1WuHrfxFtw32F5mfNfTfeGi4Pg5k+tpAUyevuaVbvl
   oU9D4miNrRI4TVcCce5dM6Dmh0EAJKKrWKCPUEtdIS5UR6GV2xqqqVOqA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10480"; a="301672707"
X-IronPort-AV: E=Sophos;i="5.93,342,1654585200"; 
   d="scan'208";a="301672707"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 06:36:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,342,1654585200"; 
   d="scan'208";a="653735372"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Sep 2022 06:36:33 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oc5Kb-0006YI-0t;
        Sat, 24 Sep 2022 13:36:33 +0000
Date:   Sat, 24 Sep 2022 21:36:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 e400ad8b7e6a1b9102123c6240289a811501f7d9
Message-ID: <632f07dd.BFP/HWxb3KugZDq3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LONGWORDS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: e400ad8b7e6a1b9102123c6240289a811501f7d9  ACPI: processor idle: Practically limit "Dummy wait" workaround to old Intel systems

elapsed time: 901m

configs tested: 123
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
arc                  randconfig-r043-20220923
s390                 randconfig-r044-20220923
riscv                randconfig-r042-20220923
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a013
powerpc                           allnoconfig
x86_64                        randconfig-a011
powerpc                          allmodconfig
sh                               allmodconfig
alpha                            allyesconfig
mips                             allyesconfig
x86_64                        randconfig-a015
arc                              allyesconfig
x86_64                              defconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                               rhel-8.3
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                           allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
arm                                 defconfig
x86_64                        randconfig-a006
i386                          randconfig-a016
i386                          randconfig-a014
i386                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
sh                        edosk7760_defconfig
sh                        sh7785lcr_defconfig
sparc                       sparc32_defconfig
mips                         bigsur_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                          randconfig-c001
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
sh                  sh7785lcr_32bit_defconfig
sh                         ap325rxa_defconfig
nios2                         10m50_defconfig
sh                          sdk7780_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
xtensa                              defconfig
powerpc                     tqm8555_defconfig
arc                      axs103_smp_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220924
arm64                               defconfig
ia64                             allyesconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                  randconfig-c002-20220923

clang tested configs:
hexagon              randconfig-r045-20220923
hexagon              randconfig-r041-20220923
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
x86_64                        randconfig-a001
i386                          randconfig-a011
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a015
arm                        multi_v5_defconfig
mips                        bcm63xx_defconfig
arm                       aspeed_g4_defconfig
powerpc                      obs600_defconfig
x86_64                        randconfig-k001
arm                           sama7_defconfig
powerpc                    gamecube_defconfig
arm                         s3c2410_defconfig
mips                          rm200_defconfig
arm                          sp7021_defconfig
x86_64                        randconfig-c007
arm                  randconfig-c002-20220923
i386                          randconfig-c001
s390                 randconfig-c005-20220923
riscv                randconfig-c006-20220923
mips                 randconfig-c004-20220923
powerpc              randconfig-c003-20220923

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
