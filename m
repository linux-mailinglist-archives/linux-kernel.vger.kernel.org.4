Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A20606F28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJUFJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJUFJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:09:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C8A5F56
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 22:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666328970; x=1697864970;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=s/35MJuLlbBOgcTD95R5V8EZYgdShgWlUF3Uir/j9GQ=;
  b=NMToWhmnE1F8KxNZLtQj5QKnPjqcZwtRssxq+OT5Tb3xm9Ub2NWFVaEQ
   +a5T+0aqfZ1FBmPOSc4RV0ReYhkIP+x4BLCAUw2zXUy5+y0xsUmrym7Vh
   11H2Fl+KLOsHQyW0Cz3DE+2k0xoJQM/Fya3hYGPnImSmmJu7yzqJ9A8lB
   3HRSqfOXYelv93hqiGiSbjerjGmTqDkbEKbxQn2PkB6kjTlh4SPbhZSt0
   KNYbAh5V6WjTe5PomEAoEaflxGzwCURSof4vVpGrYXlnvQTF8vjLPWOlK
   +gc51oBSFcVOWIXioduZeZCjH4DOgNdgijuCn62lKvcMhzAQT0HQZjJ5P
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="306903745"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="306903745"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 22:09:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="699126960"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="699126960"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 20 Oct 2022 22:09:22 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1olkHZ-0002AI-1J;
        Fri, 21 Oct 2022 05:09:21 +0000
Date:   Fri, 21 Oct 2022 13:09:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:srcunmisafe.2022.10.18b] BUILD SUCCESS
 c2d158a284abd63d727dad7402a2eed650dd4233
Message-ID: <63522976.sNiteFkiCE04k83/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git srcunmisafe.2022.10.18b
branch HEAD: c2d158a284abd63d727dad7402a2eed650dd4233  srcu: Debug NMI safety even on archs that don't require it

elapsed time: 3264m

configs tested: 255
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
x86_64                           rhel-8.3-kvm
mips                             allyesconfig
s390                             allyesconfig
m68k                             allmodconfig
x86_64                        randconfig-a006
sh                               allmodconfig
x86_64                              defconfig
arc                              allyesconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20221018
i386                                defconfig
alpha                            allyesconfig
x86_64                           allyesconfig
riscv                randconfig-r042-20221018
x86_64                          rhel-8.3-func
s390                 randconfig-r044-20221018
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sh                            shmin_defconfig
sh                         apsh4a3a_defconfig
arm                        cerfcube_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sh                        sh7763rdp_defconfig
sh                          sdk7780_defconfig
powerpc                    klondike_defconfig
sh                             sh03_defconfig
sh                          r7785rp_defconfig
sh                             espt_defconfig
arm                          iop32x_defconfig
sh                            hp6xx_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                             shx3_defconfig
sh                          polaris_defconfig
mips                         cobalt_defconfig
loongarch                         allnoconfig
sparc                             allnoconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-c001
x86_64                        randconfig-c001
arm                  randconfig-c002-20221019
arm                             pxa_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7712_defconfig
loongarch                           defconfig
loongarch                        allmodconfig
arm                       imx_v6_v7_defconfig
arm                        trizeps4_defconfig
arm                         axm55xx_defconfig
openrisc                            defconfig
sh                          kfr2r09_defconfig
powerpc                        warp_defconfig
m68k                        mvme147_defconfig
powerpc                     sequoia_defconfig
powerpc                     tqm8548_defconfig
sh                          lboxre2_defconfig
arc                           tb10x_defconfig
m68k                        mvme16x_defconfig
arc                         haps_hs_defconfig
microblaze                          defconfig
mips                         rt305x_defconfig
xtensa                    xip_kc705_defconfig
riscv                            allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
mips                           jazz_defconfig
sh                               j2_defconfig
m68k                        m5272c3_defconfig
arm                         cm_x300_defconfig
arm                          pxa3xx_defconfig
sh                   sh7770_generic_defconfig
m68k                                defconfig
sh                          urquell_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
arm                      integrator_defconfig
powerpc                      ppc6xx_defconfig
powerpc                 mpc834x_mds_defconfig
arm64                            alldefconfig
sh                        sh7757lcr_defconfig
xtensa                  audio_kc705_defconfig
arm                          simpad_defconfig
sh                           se7206_defconfig
powerpc                 mpc834x_itx_defconfig
ia64                          tiger_defconfig
m68k                       m5475evb_defconfig
xtensa                              defconfig
powerpc                       maple_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
m68k                          sun3x_defconfig
openrisc                       virt_defconfig
m68k                           virt_defconfig
xtensa                          iss_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                   currituck_defconfig
arc                        vdk_hs38_defconfig
arm                         assabet_defconfig
nios2                            alldefconfig
arm                           stm32_defconfig
openrisc                  or1klitex_defconfig
mips                           gcw0_defconfig
arm                        clps711x_defconfig
xtensa                           alldefconfig
csky                              allnoconfig
arm                          exynos_defconfig
arm                        keystone_defconfig
ia64                                defconfig
arc                          axs101_defconfig
powerpc                   motionpro_defconfig
powerpc                     mpc83xx_defconfig
sh                          rsk7269_defconfig
s390                          debug_defconfig
sh                     sh7710voipgw_defconfig
arm                         s3c6400_defconfig
powerpc                     tqm8555_defconfig
xtensa                         virt_defconfig
arm                           h3600_defconfig
arm64                               defconfig
arm                              allmodconfig
mips                             allmodconfig
sparc64                          alldefconfig
m68k                       bvme6000_defconfig
sh                        dreamcast_defconfig
mips                           ip32_defconfig
sh                            titan_defconfig
arm                       aspeed_g5_defconfig
m68k                          amiga_defconfig
arc                               allnoconfig
arm                  randconfig-c002-20221020
arc                  randconfig-r043-20221020
s390                 randconfig-r044-20221020
riscv                randconfig-r042-20221020
sparc                       sparc32_defconfig
arc                        nsimosci_defconfig
sh                           se7619_defconfig
mips                 randconfig-c004-20221020
ia64                         bigsur_defconfig
m68k                        stmark2_defconfig
powerpc                      cm5200_defconfig
sh                ecovec24-romimage_defconfig
arm                      footbridge_defconfig
sh                     magicpanelr2_defconfig
arm                          gemini_defconfig
mips                  maltasmvp_eva_defconfig
um                               alldefconfig
powerpc                  iss476-smp_defconfig
openrisc                         alldefconfig
powerpc                       holly_defconfig
m68k                         apollo_defconfig
arm                        oxnas_v6_defconfig
m68k                            q40_defconfig
powerpc                     tqm8541_defconfig
powerpc                      chrp32_defconfig
sparc                            alldefconfig
arm                          badge4_defconfig
sh                           se7750_defconfig
sh                           se7343_defconfig
nios2                         10m50_defconfig
mips                           ci20_defconfig
mips                       bmips_be_defconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
hexagon              randconfig-r045-20221018
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221018
i386                          randconfig-a013
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a015
x86_64                        randconfig-c007
mips                 randconfig-c004-20221019
i386                          randconfig-c001
s390                 randconfig-c005-20221019
arm                  randconfig-c002-20221019
riscv                randconfig-c006-20221019
powerpc              randconfig-c003-20221019
powerpc                          g5_defconfig
powerpc                   lite5200b_defconfig
arm                         socfpga_defconfig
x86_64                        randconfig-k001
hexagon                             defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                 mpc8560_ads_defconfig
mips                           mtx1_defconfig
s390                 randconfig-r044-20221019
hexagon              randconfig-r045-20221019
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221019
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                     tqm8540_defconfig
powerpc                      pmac32_defconfig
powerpc                     ksi8560_defconfig
powerpc               mpc834x_itxgp_defconfig
hexagon              randconfig-r041-20221020
hexagon              randconfig-r045-20221020
arm                       mainstone_defconfig
powerpc                      obs600_defconfig
powerpc                    gamecube_defconfig
mips                          ath79_defconfig
arm                         shannon_defconfig
mips                     cu1830-neo_defconfig
arm                          ep93xx_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                       lemote2f_defconfig
powerpc                    socrates_defconfig
arm                         orion5x_defconfig
powerpc                     tqm8560_defconfig
powerpc                     kmeter1_defconfig
arm                        magician_defconfig
arm                           omap1_defconfig
mips                      malta_kvm_defconfig
arm                                 defconfig
arm                  colibri_pxa300_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
