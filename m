Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B261606F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJUFPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJUFPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:15:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF577ED99F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 22:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666329332; x=1697865332;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OwujiVsPY73qUJgzVYNfCMaZryrW3pmRX6gnEm2gZYs=;
  b=dDU0znywYemRypRWAHZ5mVMQiVEUpMpn3IbpdFJouEHJb0ufSM2MAs/R
   aIWVdkUBJxndR4b1GOvaUQHX2vLqQxrZChW1n9iie14i5vQZs/ITdCMdF
   pLREH0Xg3bJJ0CZFOzGVlMLsoLFqUEsSd2L+n/fmAIlB0msC34XlDsbEI
   h2tDyMFNF/dJnom8wYahOOqGpHQoFcGA0uAl4NZhuS+4BL61ONe5GSfV3
   N+v/wazmqMEZJ+ZJdaTjDOHJ/Vr7gmir0CIJvXncZz9yH/QzF9y27PUos
   Uu1uG0Ki5RjKps1UrAcqcH9MFlDulI7JOyZOq52t7TUCi67lGgy3DcDTC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="287314789"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="287314789"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 22:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="625139260"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="625139260"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 20 Oct 2022 22:15:30 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1olkNV-0002Eg-1T;
        Fri, 21 Oct 2022 05:15:29 +0000
Date:   Fri, 21 Oct 2022 13:15:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 a545b48c2d907d6096e7bcf65d9b0681cc850e69
Message-ID: <63522ae3.y4JrOF53jWCKt3Wg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/misc
branch HEAD: a545b48c2d907d6096e7bcf65d9b0681cc850e69  x86/signal/64: Move 64-bit signal code to its own file

elapsed time: 2509m

configs tested: 236
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20221018
riscv                randconfig-r042-20221018
s390                 randconfig-r044-20221018
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
powerpc                           allnoconfig
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
arc                              allyesconfig
alpha                            allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                        randconfig-a004
m68k                             allmodconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
m68k                             allyesconfig
x86_64                           allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm                      integrator_defconfig
powerpc                      ppc6xx_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          kfr2r09_defconfig
i386                             allyesconfig
i386                                defconfig
arm                             pxa_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7712_defconfig
arm64                            alldefconfig
sh                        sh7757lcr_defconfig
mips                           jazz_defconfig
powerpc                        warp_defconfig
sh                               j2_defconfig
m68k                        m5272c3_defconfig
arm                         cm_x300_defconfig
sh                             sh03_defconfig
sh                          r7785rp_defconfig
sh                             espt_defconfig
arm                          iop32x_defconfig
sh                            hp6xx_defconfig
xtensa                  audio_kc705_defconfig
arm                          simpad_defconfig
sh                           se7206_defconfig
powerpc                 mpc834x_itx_defconfig
ia64                          tiger_defconfig
m68k                       m5475evb_defconfig
xtensa                              defconfig
powerpc                       maple_defconfig
sh                             shx3_defconfig
sh                          polaris_defconfig
mips                         cobalt_defconfig
i386                          randconfig-c001
arm                          pxa3xx_defconfig
m68k                          sun3x_defconfig
openrisc                       virt_defconfig
m68k                           virt_defconfig
xtensa                          iss_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                   currituck_defconfig
arc                        vdk_hs38_defconfig
arm                         assabet_defconfig
openrisc                            defconfig
nios2                            alldefconfig
sh                   sh7770_generic_defconfig
m68k                                defconfig
loongarch                         allnoconfig
sh                          urquell_defconfig
arm                           stm32_defconfig
openrisc                  or1klitex_defconfig
sh                        sh7763rdp_defconfig
mips                           gcw0_defconfig
sh                            shmin_defconfig
sh                         apsh4a3a_defconfig
arm                        cerfcube_defconfig
arm                        keystone_defconfig
ia64                                defconfig
arm                        clps711x_defconfig
xtensa                           alldefconfig
csky                              allnoconfig
arm                          exynos_defconfig
nios2                               defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arc                          axs101_defconfig
powerpc                   motionpro_defconfig
powerpc                     mpc83xx_defconfig
riscv                    nommu_k210_defconfig
sh                          rsk7269_defconfig
s390                          debug_defconfig
sh                     sh7710voipgw_defconfig
loongarch                           defconfig
loongarch                        allmodconfig
csky                                defconfig
arm                         s3c6400_defconfig
powerpc                     tqm8555_defconfig
xtensa                         virt_defconfig
powerpc                     sequoia_defconfig
arm                           h3600_defconfig
sparc64                          alldefconfig
m68k                       bvme6000_defconfig
sh                        dreamcast_defconfig
mips                           ip32_defconfig
sh                            titan_defconfig
arm                       aspeed_g5_defconfig
m68k                          amiga_defconfig
arc                               allnoconfig
nios2                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221019
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                  randconfig-c002-20221020
sparc                               defconfig
xtensa                           allyesconfig
sparc                            allyesconfig
x86_64                                  kexec
arc                  randconfig-r043-20221020
s390                 randconfig-r044-20221020
riscv                randconfig-r042-20221020
sparc                       sparc32_defconfig
arc                        nsimosci_defconfig
sh                           se7619_defconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
arc                  randconfig-r043-20221019
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
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
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
m68k                        mvme147_defconfig
mips                       bmips_be_defconfig

clang tested configs:
hexagon              randconfig-r041-20221018
hexagon              randconfig-r045-20221018
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a011-20221017
s390                 randconfig-r044-20221019
hexagon              randconfig-r045-20221019
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221019
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                 randconfig-a013-20221017
x86_64                        randconfig-a005
i386                 randconfig-a012-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a015-20221017
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
hexagon                             defconfig
powerpc                     tqm8540_defconfig
powerpc                      pmac32_defconfig
powerpc                     ksi8560_defconfig
powerpc               mpc834x_itxgp_defconfig
x86_64                        randconfig-c007
mips                 randconfig-c004-20221019
i386                          randconfig-c001
s390                 randconfig-c005-20221019
arm                  randconfig-c002-20221019
riscv                randconfig-c006-20221019
powerpc              randconfig-c003-20221019
hexagon              randconfig-r041-20221020
hexagon              randconfig-r045-20221020
arm                       mainstone_defconfig
powerpc                      obs600_defconfig
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
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
arm                           omap1_defconfig
mips                      malta_kvm_defconfig
arm                                 defconfig
arm                        magician_defconfig
arm                  colibri_pxa300_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
