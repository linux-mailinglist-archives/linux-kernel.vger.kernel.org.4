Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EBC603622
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJRWnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJRWnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:43:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62658A7E8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666132987; x=1697668987;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oVA98rUz988FwOOE9rC1whOkQoDVuxmBA7a60AY2+T0=;
  b=U8P6WhGv1XQ/7CisBPeabfwB/vETEpDYJ0s+rZ512+tTyG0o6PpbKiXW
   Qyzyo8LDMeL1W+Lhm3K5PU3BUn+Qm/6j1zKvqczEN+IYd8ic/prH8EpN2
   e4QkfUhR+75SmQKll+nYMzjwrTBHOYSO8qLdSXYc+GMOqlQq0Hi/uADUB
   QNx/iFAIUPXJkImms83BcU/jT5JasInCm8WztwGBXLzrgvbjaG1uYfSVr
   u2ARjBpvewWyc/gc36jZTxob3/zOD0ULmSbCuyCmakV6XO5JD/pzya9Qw
   y7seSKaMhxnfDKYSwxcuMfKpk0Zi6PhdKoLHeSUT+iT9fNmPnbKLTKLux
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="289571047"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="289571047"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="662142013"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="662142013"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Oct 2022 15:43:05 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1okvIf-00028o-07;
        Tue, 18 Oct 2022 22:43:05 +0000
Date:   Wed, 19 Oct 2022 06:42:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 a27e292b8a54e24f85181d949fac8c51fdec8ff3
Message-ID: <634f2bc0.uApP5D62Zntwvm6P%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/misc
branch HEAD: a27e292b8a54e24f85181d949fac8c51fdec8ff3  Documentation/x86/boot: Reserve type_of_loader=13 for barebox

elapsed time: 2212m

configs tested: 195
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arc                        nsim_700_defconfig
riscv                               defconfig
powerpc                 mpc837x_mds_defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
powerpc                 mpc8540_ads_defconfig
sh                          kfr2r09_defconfig
powerpc                 linkstation_defconfig
microblaze                          defconfig
arm                          gemini_defconfig
powerpc                 mpc834x_itx_defconfig
i386                 randconfig-a005-20221017
i386                 randconfig-a003-20221017
i386                 randconfig-a004-20221017
i386                 randconfig-a001-20221017
i386                 randconfig-a006-20221017
i386                 randconfig-c001-20221017
x86_64               randconfig-a004-20221017
x86_64               randconfig-a001-20221017
x86_64               randconfig-a002-20221017
x86_64               randconfig-a006-20221017
x86_64               randconfig-a005-20221017
arc                  randconfig-r043-20221017
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                 randconfig-a002-20221017
m68k                         amcore_defconfig
mips                           ci20_defconfig
powerpc                      makalu_defconfig
m68k                             alldefconfig
powerpc                      arches_defconfig
arm                          iop32x_defconfig
openrisc                  or1klitex_defconfig
m68k                          hp300_defconfig
sh                           se7751_defconfig
sh                          rsk7203_defconfig
arm                             ezx_defconfig
powerpc                     mpc83xx_defconfig
sh                             sh03_defconfig
m68k                            q40_defconfig
arc                           tb10x_defconfig
arm                        keystone_defconfig
powerpc                        cell_defconfig
parisc                generic-32bit_defconfig
riscv             nommu_k210_sdcard_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
arc                        vdk_hs38_defconfig
powerpc                      chrp32_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64               randconfig-c001-20221017
arm                  randconfig-c002-20221017
x86_64               randconfig-a003-20221017
sh                              ul2_defconfig
powerpc                  storcenter_defconfig
mips                             allmodconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
powerpc                  iss476-smp_defconfig
arm64                            alldefconfig
sh                            hp6xx_defconfig
sh                           se7724_defconfig
arm                         lpc18xx_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                      ppc6xx_defconfig
csky                              allnoconfig
ia64                                defconfig
powerpc                          allyesconfig
i386                          randconfig-c001
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
ia64                          tiger_defconfig
alpha                            alldefconfig
mips                     loongson1b_defconfig
m68k                        m5307c3_defconfig
m68k                           sun3_defconfig
mips                           gcw0_defconfig
mips                      fuloong2e_defconfig
xtensa                  audio_kc705_defconfig
m68k                          atari_defconfig
openrisc                       virt_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
m68k                                defconfig
sparc64                             defconfig
powerpc                     taishan_defconfig
sh                        sh7757lcr_defconfig
m68k                       m5208evb_defconfig
powerpc                      pcm030_defconfig
arm                         at91_dt_defconfig
sh                   sh7724_generic_defconfig
microblaze                      mmu_defconfig
openrisc                 simple_smp_defconfig
mips                            gpr_defconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
arm                        cerfcube_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     stx_gp3_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc834x_mds_defconfig
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
s390                 randconfig-r044-20221017
hexagon              randconfig-r045-20221017
riscv                randconfig-r042-20221017
hexagon              randconfig-r041-20221017
x86_64               randconfig-k001-20221017
x86_64                        randconfig-c007
mips                 randconfig-c004-20221018
i386                          randconfig-c001
s390                 randconfig-c005-20221018
arm                  randconfig-c002-20221018
riscv                randconfig-c006-20221018
powerpc              randconfig-c003-20221018
mips                 randconfig-c004-20221017
i386                 randconfig-c001-20221017
s390                 randconfig-c005-20221017
arm                  randconfig-c002-20221017
riscv                randconfig-c006-20221017
x86_64               randconfig-c007-20221017
powerpc              randconfig-c003-20221017
arm                        mvebu_v5_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
mips                          rm200_defconfig
powerpc                      ppc44x_defconfig
riscv                             allnoconfig
powerpc                  mpc866_ads_defconfig
powerpc                 mpc832x_mds_defconfig
arm                         socfpga_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                      pxa255-idp_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                      tct_hammer_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
