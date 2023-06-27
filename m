Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C2E73F040
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 03:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjF0BRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 21:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjF0BRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 21:17:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31192173C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 18:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687828661; x=1719364661;
  h=date:from:to:cc:subject:message-id;
  bh=qU2GHNi8xiKQp+VnJSs3yMT6PxpstdMHkrB/NMYK+FI=;
  b=WPT/SpjRGSSb1QAySe5Ku0SOKA9NqcGQs/CaZaVLgrfony1VTwqFnt68
   5xr6sImJLhEdYAMALhh0P9I4uxKH4KuefwbFAXTantLUB2j08DlxuCE/p
   Zm+GAQv7Iqx7ClmUBC373lJF8o+vZNUua5cxLDdJQmVMqShXWLLFqqHPl
   4Efj7HtcK16paKiQhtbPm5kb45ztqz85JEmlLJzu+bGwvOSX7HUWan28i
   J0MrsfornxFT98R7qNR2SZOq/gNzNRdbSc4WXafyj6W4KhNWu1MC0SLeq
   32z2HQAcDy17GWxV8h2N7H3dYDiv9tqyv8z13SV4HUr3P2vXgwZ/bOL4z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="447821977"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="447821977"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="693669187"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="693669187"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jun 2023 18:17:38 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDxKr-000BIR-1z;
        Tue, 27 Jun 2023 01:17:37 +0000
Date:   Tue, 27 Jun 2023 09:16:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 85d38d5810e285d5aec7fb5283107d1da70c12a9
Message-ID: <202306270939.JVTc2Jye-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 85d38d5810e285d5aec7fb5283107d1da70c12a9  x86/apic: Fix kernel panic when booting with intremap=off and x2apic_phys

elapsed time: 10432m

configs tested: 477
configs skipped: 118

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230620   gcc  
alpha                randconfig-r003-20230620   gcc  
alpha                randconfig-r013-20230626   gcc  
alpha                randconfig-r014-20230621   gcc  
alpha                randconfig-r015-20230620   gcc  
alpha                randconfig-r022-20230620   gcc  
alpha                randconfig-r026-20230622   gcc  
alpha                randconfig-r031-20230626   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r003-20230621   gcc  
arc                  randconfig-r004-20230622   gcc  
arc                  randconfig-r012-20230620   gcc  
arc                  randconfig-r015-20230620   gcc  
arc                  randconfig-r024-20230620   gcc  
arc                  randconfig-r024-20230622   gcc  
arc                  randconfig-r043-20230620   gcc  
arc                  randconfig-r043-20230622   gcc  
arc                  randconfig-r043-20230626   gcc  
arc                           tb10x_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              alldefconfig   clang
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                        clps711x_defconfig   gcc  
arm                          collie_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                          ep93xx_defconfig   clang
arm                      footbridge_defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                           imxrt_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                          ixp4xx_defconfig   clang
arm                        keystone_defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                            mmp2_defconfig   clang
arm                            mps2_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                        mvebu_v7_defconfig   gcc  
arm                        neponset_defconfig   clang
arm                       netwinder_defconfig   clang
arm                           omap1_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                  randconfig-r014-20230620   clang
arm                  randconfig-r016-20230620   clang
arm                  randconfig-r022-20230622   clang
arm                  randconfig-r025-20230622   clang
arm                         s5pv210_defconfig   clang
arm                        shmobile_defconfig   gcc  
arm                          sp7021_defconfig   clang
arm                       spear13xx_defconfig   clang
arm                        spear3xx_defconfig   clang
arm                        spear6xx_defconfig   gcc  
arm                           spitz_defconfig   clang
arm                           stm32_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm                        vexpress_defconfig   clang
arm                    vt8500_v6_v7_defconfig   clang
arm                         wpcm450_defconfig   gcc  
arm64                            alldefconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230626   gcc  
arm64                randconfig-r013-20230620   gcc  
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230626   gcc  
csky                 randconfig-r005-20230620   gcc  
csky                 randconfig-r006-20230620   gcc  
csky                 randconfig-r011-20230620   gcc  
csky                 randconfig-r011-20230621   gcc  
csky                 randconfig-r012-20230621   gcc  
csky                 randconfig-r013-20230626   gcc  
csky                 randconfig-r014-20230626   gcc  
csky                 randconfig-r016-20230626   gcc  
csky                 randconfig-r025-20230626   gcc  
csky                 randconfig-r026-20230626   gcc  
csky                 randconfig-r032-20230620   gcc  
csky                 randconfig-r034-20230620   gcc  
hexagon              randconfig-r003-20230622   clang
hexagon              randconfig-r006-20230620   clang
hexagon              randconfig-r016-20230620   clang
hexagon              randconfig-r023-20230622   clang
hexagon              randconfig-r033-20230620   clang
hexagon              randconfig-r036-20230620   clang
i386                             alldefconfig   gcc  
i386                             allyesconfig   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230619   gcc  
i386         buildonly-randconfig-r004-20230620   clang
i386         buildonly-randconfig-r004-20230622   clang
i386         buildonly-randconfig-r004-20230626   clang
i386         buildonly-randconfig-r005-20230619   gcc  
i386         buildonly-randconfig-r005-20230620   clang
i386         buildonly-randconfig-r005-20230621   gcc  
i386         buildonly-randconfig-r005-20230622   clang
i386         buildonly-randconfig-r005-20230626   clang
i386         buildonly-randconfig-r006-20230619   gcc  
i386         buildonly-randconfig-r006-20230620   clang
i386         buildonly-randconfig-r006-20230621   gcc  
i386         buildonly-randconfig-r006-20230622   clang
i386         buildonly-randconfig-r006-20230626   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230619   gcc  
i386                 randconfig-i001-20230620   clang
i386                 randconfig-i001-20230621   gcc  
i386                 randconfig-i001-20230622   clang
i386                 randconfig-i001-20230626   clang
i386                 randconfig-i002-20230619   gcc  
i386                 randconfig-i002-20230620   clang
i386                 randconfig-i002-20230621   gcc  
i386                 randconfig-i002-20230622   clang
i386                 randconfig-i002-20230626   clang
i386                 randconfig-i003-20230619   gcc  
i386                 randconfig-i003-20230620   clang
i386                 randconfig-i003-20230621   gcc  
i386                 randconfig-i003-20230622   clang
i386                 randconfig-i003-20230626   clang
i386                 randconfig-i004-20230619   gcc  
i386                 randconfig-i004-20230620   clang
i386                 randconfig-i004-20230621   gcc  
i386                 randconfig-i004-20230622   clang
i386                 randconfig-i004-20230626   clang
i386                 randconfig-i005-20230619   gcc  
i386                 randconfig-i005-20230620   clang
i386                 randconfig-i005-20230621   gcc  
i386                 randconfig-i005-20230622   clang
i386                 randconfig-i005-20230626   clang
i386                 randconfig-i006-20230619   gcc  
i386                 randconfig-i006-20230620   clang
i386                 randconfig-i006-20230621   gcc  
i386                 randconfig-i006-20230622   clang
i386                 randconfig-i006-20230626   clang
i386                 randconfig-i011-20230619   clang
i386                 randconfig-i011-20230620   gcc  
i386                 randconfig-i011-20230621   clang
i386                 randconfig-i011-20230622   gcc  
i386                 randconfig-i011-20230623   clang
i386                 randconfig-i011-20230624   gcc  
i386                 randconfig-i011-20230626   gcc  
i386                 randconfig-i012-20230619   clang
i386                 randconfig-i012-20230620   gcc  
i386                 randconfig-i012-20230621   clang
i386                 randconfig-i012-20230622   gcc  
i386                 randconfig-i012-20230623   clang
i386                 randconfig-i012-20230624   gcc  
i386                 randconfig-i012-20230626   gcc  
i386                 randconfig-i013-20230619   clang
i386                 randconfig-i013-20230620   gcc  
i386                 randconfig-i013-20230621   clang
i386                 randconfig-i013-20230622   gcc  
i386                 randconfig-i013-20230623   clang
i386                 randconfig-i013-20230624   gcc  
i386                 randconfig-i013-20230626   gcc  
i386                 randconfig-i014-20230619   clang
i386                 randconfig-i014-20230620   gcc  
i386                 randconfig-i014-20230621   clang
i386                 randconfig-i014-20230622   gcc  
i386                 randconfig-i014-20230623   clang
i386                 randconfig-i014-20230624   gcc  
i386                 randconfig-i014-20230626   gcc  
i386                 randconfig-i015-20230619   clang
i386                 randconfig-i015-20230620   gcc  
i386                 randconfig-i015-20230621   clang
i386                 randconfig-i015-20230622   gcc  
i386                 randconfig-i015-20230623   clang
i386                 randconfig-i015-20230624   gcc  
i386                 randconfig-i015-20230626   gcc  
i386                 randconfig-i016-20230619   clang
i386                 randconfig-i016-20230620   gcc  
i386                 randconfig-i016-20230621   clang
i386                 randconfig-i016-20230622   gcc  
i386                 randconfig-i016-20230623   clang
i386                 randconfig-i016-20230624   gcc  
i386                 randconfig-i016-20230626   gcc  
i386                 randconfig-r013-20230620   gcc  
i386                 randconfig-r022-20230620   gcc  
i386                 randconfig-r023-20230626   gcc  
i386                 randconfig-r024-20230626   gcc  
i386                 randconfig-r026-20230620   gcc  
i386                 randconfig-r026-20230621   clang
i386                 randconfig-r026-20230622   gcc  
i386                 randconfig-r032-20230626   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230622   gcc  
loongarch            randconfig-r005-20230620   gcc  
loongarch            randconfig-r021-20230622   gcc  
loongarch            randconfig-r024-20230622   gcc  
loongarch            randconfig-r036-20230620   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r004-20230620   gcc  
m68k                 randconfig-r013-20230621   gcc  
m68k                 randconfig-r021-20230620   gcc  
m68k                 randconfig-r023-20230620   gcc  
m68k                 randconfig-r023-20230626   gcc  
m68k                 randconfig-r024-20230620   gcc  
m68k                 randconfig-r033-20230626   gcc  
m68k                 randconfig-r036-20230620   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r003-20230620   gcc  
microblaze           randconfig-r006-20230622   gcc  
microblaze           randconfig-r011-20230620   gcc  
microblaze           randconfig-r011-20230621   gcc  
microblaze           randconfig-r014-20230620   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips                        bcm47xx_defconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                      bmips_stb_defconfig   clang
mips                           ci20_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                     loongson1b_defconfig   gcc  
mips                     loongson1c_defconfig   clang
mips                     loongson2k_defconfig   clang
mips                      malta_kvm_defconfig   clang
mips                malta_qemu_32r6_defconfig   clang
mips                      maltaaprp_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
mips                           mtx1_defconfig   clang
mips                        omega2p_defconfig   clang
mips                      pic32mzda_defconfig   clang
mips                 randconfig-r013-20230620   clang
mips                 randconfig-r026-20230620   clang
mips                 randconfig-r035-20230620   gcc  
mips                          rb532_defconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230620   gcc  
nios2                randconfig-r005-20230622   gcc  
nios2                randconfig-r006-20230620   gcc  
nios2                randconfig-r015-20230621   gcc  
nios2                randconfig-r015-20230626   gcc  
nios2                randconfig-r022-20230626   gcc  
openrisc                         alldefconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r001-20230622   gcc  
openrisc             randconfig-r003-20230626   gcc  
openrisc             randconfig-r005-20230622   gcc  
openrisc             randconfig-r005-20230626   gcc  
openrisc             randconfig-r025-20230620   gcc  
openrisc             randconfig-r031-20230620   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r001-20230620   gcc  
parisc               randconfig-r003-20230622   gcc  
parisc               randconfig-r011-20230626   gcc  
parisc               randconfig-r023-20230622   gcc  
parisc               randconfig-r026-20230620   gcc  
parisc               randconfig-r034-20230620   gcc  
parisc               randconfig-r035-20230626   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    amigaone_defconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                    ge_imp3a_defconfig   clang
powerpc                       holly_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                      makalu_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                 mpc832x_rdb_defconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
powerpc                 mpc8560_ads_defconfig   clang
powerpc                      obs600_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc                       ppc64_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc              randconfig-r012-20230626   gcc  
powerpc              randconfig-r014-20230620   gcc  
powerpc              randconfig-r021-20230621   clang
powerpc              randconfig-r034-20230622   clang
powerpc                     redwood_defconfig   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                     skiroot_defconfig   clang
powerpc                     stx_gp3_defconfig   gcc  
powerpc                     taishan_defconfig   gcc  
powerpc                     tqm5200_defconfig   clang
powerpc                     tqm8541_defconfig   gcc  
powerpc                      tqm8xx_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r013-20230622   gcc  
riscv                randconfig-r024-20230626   gcc  
riscv                randconfig-r031-20230620   clang
riscv                randconfig-r035-20230620   clang
riscv                randconfig-r042-20230620   gcc  
riscv                randconfig-r042-20230622   gcc  
riscv                randconfig-r042-20230626   gcc  
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230622   clang
s390                 randconfig-r011-20230622   gcc  
s390                 randconfig-r014-20230626   gcc  
s390                 randconfig-r015-20230620   gcc  
s390                 randconfig-r025-20230622   gcc  
s390                 randconfig-r033-20230620   clang
s390                 randconfig-r035-20230626   clang
s390                 randconfig-r036-20230622   clang
s390                 randconfig-r044-20230620   gcc  
s390                 randconfig-r044-20230622   gcc  
s390                 randconfig-r044-20230626   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r002-20230626   gcc  
sh                   randconfig-r012-20230620   gcc  
sh                   randconfig-r016-20230620   gcc  
sh                   randconfig-r016-20230626   gcc  
sh                   randconfig-r024-20230620   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sh                            titan_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230620   gcc  
sparc                randconfig-r012-20230622   gcc  
sparc                randconfig-r021-20230620   gcc  
sparc                randconfig-r032-20230626   gcc  
sparc                randconfig-r035-20230620   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r005-20230620   gcc  
sparc64              randconfig-r012-20230620   gcc  
sparc64              randconfig-r016-20230620   gcc  
sparc64              randconfig-r021-20230626   gcc  
sparc64              randconfig-r025-20230626   gcc  
sparc64              randconfig-r036-20230626   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r001-20230622   gcc  
um                   randconfig-r004-20230620   gcc  
um                   randconfig-r012-20230620   clang
um                   randconfig-r015-20230621   gcc  
um                   randconfig-r016-20230621   gcc  
um                   randconfig-r022-20230620   clang
um                   randconfig-r026-20230620   clang
um                   randconfig-r036-20230620   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230619   gcc  
x86_64       buildonly-randconfig-r001-20230620   clang
x86_64       buildonly-randconfig-r001-20230621   gcc  
x86_64       buildonly-randconfig-r001-20230622   clang
x86_64       buildonly-randconfig-r001-20230626   clang
x86_64       buildonly-randconfig-r002-20230619   gcc  
x86_64       buildonly-randconfig-r002-20230620   clang
x86_64       buildonly-randconfig-r002-20230621   gcc  
x86_64       buildonly-randconfig-r002-20230622   clang
x86_64       buildonly-randconfig-r002-20230626   clang
x86_64       buildonly-randconfig-r003-20230619   gcc  
x86_64       buildonly-randconfig-r003-20230620   clang
x86_64       buildonly-randconfig-r003-20230621   gcc  
x86_64       buildonly-randconfig-r003-20230622   clang
x86_64       buildonly-randconfig-r003-20230626   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r012-20230626   gcc  
x86_64               randconfig-r013-20230620   gcc  
x86_64               randconfig-r022-20230622   gcc  
x86_64               randconfig-r025-20230622   gcc  
x86_64               randconfig-r034-20230620   clang
x86_64               randconfig-r035-20230619   gcc  
x86_64               randconfig-r036-20230619   gcc  
x86_64               randconfig-r036-20230620   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r002-20230620   gcc  
xtensa               randconfig-r006-20230620   gcc  
xtensa               randconfig-r026-20230626   gcc  
xtensa               randconfig-r032-20230620   gcc  
xtensa               randconfig-r035-20230621   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
