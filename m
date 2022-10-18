Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3224603431
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJRUrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJRUrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:47:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869CE75CD2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666126019; x=1697662019;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xAISTZU5PrnGvOLvRbZpWoVuAoN++5yBROHJLs02nio=;
  b=KwHCrdRNhsA3PcCCqIRrbDjBr5AATRH2o0+F5zxWSnyBUhnTv+4GTYk5
   kj2oJ7LPFb3bI17fbmHS/3nDImLBcLF7Kjp4ZI+sLAd75qRmZEiUao3YA
   knw/PyJpHgyzG97q+ux/XZI2mB7NCINGaxwnBfYw7R3esBNZHpfG20C2R
   VXlRhHkSUFSyaXDd4kz1bBrXovuB5CQX3TPoarXtFiHN14zsjPLjBL9zR
   Yv+gmKhgIyTgW2wdGTCrZf+uo2ni1ZvkeO7LS30swXxqXJtoIk92jOR/L
   ZF5l5OzU+Sk5loF8rr1rBSmFkjUAthme4gqPXvfDkrYNA51ikD26v5Z0F
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="293627402"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="293627402"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 13:46:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="803942735"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="803942735"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Oct 2022 13:46:57 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oktUH-000216-04;
        Tue, 18 Oct 2022 20:46:57 +0000
Date:   Wed, 19 Oct 2022 04:46:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 5c9a92dec3235b0c1d51e92860f8014753161593
Message-ID: <634f108f.kUo7cj624oGwM5x7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 5c9a92dec3235b0c1d51e92860f8014753161593  x86/bugs: Add retbleed=force

elapsed time: 1770m

configs tested: 223
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                             allyesconfig
i386                                defconfig
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                 mpc8540_ads_defconfig
sh                          kfr2r09_defconfig
powerpc                 linkstation_defconfig
arm                        keystone_defconfig
powerpc                        cell_defconfig
parisc                generic-32bit_defconfig
riscv             nommu_k210_sdcard_defconfig
arc                  randconfig-r043-20221017
i386                 randconfig-a005-20221017
i386                 randconfig-a003-20221017
i386                 randconfig-a004-20221017
i386                 randconfig-a001-20221017
i386                 randconfig-a006-20221017
x86_64               randconfig-a004-20221017
x86_64               randconfig-a001-20221017
x86_64               randconfig-a002-20221017
x86_64               randconfig-a006-20221017
x86_64               randconfig-a005-20221017
arm64                            allyesconfig
arm                              allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64               randconfig-a003-20221017
arm                            lart_defconfig
sh                        edosk7760_defconfig
sh                             shx3_defconfig
parisc                generic-64bit_defconfig
sh                              ul2_defconfig
powerpc                  storcenter_defconfig
i386                 randconfig-a002-20221017
i386                 randconfig-c001-20221017
powerpc                     taishan_defconfig
arc                           tb10x_defconfig
m68k                       bvme6000_defconfig
arm                                 defconfig
sparc                       sparc32_defconfig
sparc                       sparc64_defconfig
arm                       aspeed_g5_defconfig
arm64                            alldefconfig
sh                           se7724_defconfig
powerpc                      ppc6xx_defconfig
csky                              allnoconfig
loongarch                         allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                        vdk_hs38_defconfig
arm                           h3600_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                  iss476-smp_defconfig
sh                            hp6xx_defconfig
nios2                               defconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
powerpc                      chrp32_defconfig
arm                       imx_v6_v7_defconfig
sh                          rsk7203_defconfig
m68k                          amiga_defconfig
m68k                        m5307c3_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
riscv                               defconfig
arm                             ezx_defconfig
powerpc                     mpc83xx_defconfig
arm                         lpc18xx_defconfig
powerpc                 mpc85xx_cds_defconfig
ia64                          tiger_defconfig
alpha                            alldefconfig
mips                     loongson1b_defconfig
i386                          randconfig-c001
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
mips                     decstation_defconfig
powerpc                      makalu_defconfig
powerpc                      pcm030_defconfig
arm                        shmobile_defconfig
arc                            hsdk_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                    xip_kc705_defconfig
m68k                            q40_defconfig
m68k                           sun3_defconfig
mips                           gcw0_defconfig
mips                      fuloong2e_defconfig
xtensa                  audio_kc705_defconfig
m68k                          atari_defconfig
openrisc                       virt_defconfig
sh                         ap325rxa_defconfig
xtensa                           allyesconfig
mips                           ci20_defconfig
arm                          pxa3xx_defconfig
sh                          sdk7786_defconfig
powerpc                      arches_defconfig
sh                        dreamcast_defconfig
sh                                  defconfig
m68k                                defconfig
riscv                             allnoconfig
csky                                defconfig
powerpc                      ppc40x_defconfig
powerpc                         wii_defconfig
sh                   sh7770_generic_defconfig
arc                    vdk_hs38_smp_defconfig
arc                     nsimosci_hs_defconfig
sparc64                             defconfig
sh                        sh7757lcr_defconfig
microblaze                      mmu_defconfig
sh                           se7343_defconfig
parisc                              defconfig
ia64                            zx1_defconfig
i386                          randconfig-a003
m68k                       m5208evb_defconfig
arm                         at91_dt_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-a001
i386                          randconfig-a005
arm                        cerfcube_defconfig
sh                  sh7785lcr_32bit_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                           jazz_defconfig
powerpc                     asp8347_defconfig
mips                  maltasmvp_eva_defconfig
sh                           se7751_defconfig
m68k                       m5275evb_defconfig
powerpc                     pq2fads_defconfig
arm                         cm_x300_defconfig
loongarch                           defconfig
loongarch                        allmodconfig
sh                   sh7724_generic_defconfig
openrisc                 simple_smp_defconfig
m68k                          hp300_defconfig
arm                          gemini_defconfig
mips                            gpr_defconfig
sparc                             allnoconfig
powerpc                     tqm8541_defconfig
powerpc                     stx_gp3_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        trizeps4_defconfig
m68k                        mvme16x_defconfig
ia64                                defconfig
arm                        mvebu_v7_defconfig
openrisc                         alldefconfig
arm                      jornada720_defconfig
ia64                             allmodconfig

clang tested configs:
x86_64               randconfig-a014-20221017
x86_64               randconfig-a015-20221017
x86_64               randconfig-a012-20221017
x86_64               randconfig-a011-20221017
x86_64               randconfig-a013-20221017
x86_64               randconfig-a016-20221017
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
riscv                randconfig-r042-20221017
hexagon              randconfig-r045-20221017
s390                 randconfig-r044-20221017
hexagon              randconfig-r041-20221017
x86_64               randconfig-k001-20221017
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                        maltaup_defconfig
arm                         s3c2410_defconfig
x86_64                        randconfig-c007
mips                 randconfig-c004-20221018
i386                          randconfig-c001
s390                 randconfig-c005-20221018
arm                  randconfig-c002-20221018
riscv                randconfig-c006-20221018
powerpc              randconfig-c003-20221018
powerpc                 mpc832x_mds_defconfig
mips                           rs90_defconfig
mips                          rm200_defconfig
powerpc                      ppc44x_defconfig
riscv                             allnoconfig
powerpc                  mpc866_ads_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                         socfpga_defconfig
arm                       mainstone_defconfig
arm                          sp7021_defconfig
powerpc                    mvme5100_defconfig
x86_64                        randconfig-k001
hexagon              randconfig-r045-20221018
hexagon              randconfig-r041-20221018
arm                      pxa255-idp_defconfig
mips                       lemote2f_defconfig
arm                      tct_hammer_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
