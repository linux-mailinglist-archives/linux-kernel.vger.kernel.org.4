Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A956603448
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJRUtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJRUtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:49:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEAB74E1D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666126150; x=1697662150;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=C2ytRMNRJKuyDZEawPoLqQ7hElvh+dLSn5UrGpGYcQg=;
  b=DNP59u7itwKQUGJW6wRMSwreaVncDkeI23tUnRPXA4tg9HW5r4G5BzPZ
   y1+fwI8Hpka9ZXUvaGaqes1V61GgR6lu1zixRUJRltZezPlRfzh2O2mf+
   CO4uf4Uhwo6iTQrol3knNgGOXn/f++tkxzIJq/fHeiT6mrBGEMzhIzDSM
   TPwFJn7w6ceQdXS4VY5DyvTvLsn7cF+kdfHe0WyX+1PBqhqN1U4Qxc7w1
   NC85JAXdzoVRaCjDsYzDPaoxCg6UshERwxxrEpUFza6oFfmdmss/r1Gia
   yq5o9gNcKcEheR54JQDAdSpCbafPhVhfYOefW0mxKviyZPOpGsD26IYaP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="306216575"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="306216575"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 13:49:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="718132398"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="718132398"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Oct 2022 13:48:58 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oktWE-00023H-0k;
        Tue, 18 Oct 2022 20:48:58 +0000
Date:   Wed, 19 Oct 2022 04:48:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 8e5bad7dccec2014f24497b57d8a8ee0b752c290
Message-ID: <634f110b.DIyjDxsBnfhzAf8e%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 8e5bad7dccec2014f24497b57d8a8ee0b752c290  sched: Introduce struct balance_callback to avoid CFI mismatches

elapsed time: 1803m

configs tested: 253
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                  randconfig-r043-20221017
i386                             allyesconfig
i386                                defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a004-20221017
x86_64               randconfig-a001-20221017
x86_64               randconfig-a002-20221017
x86_64               randconfig-a006-20221017
x86_64               randconfig-a005-20221017
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                 randconfig-a005-20221017
i386                 randconfig-a003-20221017
i386                 randconfig-a004-20221017
i386                 randconfig-a001-20221017
i386                 randconfig-a006-20221017
arm                        keystone_defconfig
powerpc                        cell_defconfig
parisc                generic-32bit_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                 mpc8540_ads_defconfig
sh                          kfr2r09_defconfig
powerpc                 linkstation_defconfig
arm64                            allyesconfig
arm                              allyesconfig
m68k                         amcore_defconfig
mips                           ci20_defconfig
powerpc                      makalu_defconfig
m68k                             alldefconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                 randconfig-c001-20221017
arm                                 defconfig
sh                             sh03_defconfig
ia64                            zx1_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      arches_defconfig
arm                          iop32x_defconfig
openrisc                  or1klitex_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                          hp300_defconfig
sh                           se7751_defconfig
powerpc                        warp_defconfig
sh                          polaris_defconfig
powerpc                    adder875_defconfig
parisc                           alldefconfig
nios2                               defconfig
mips                        vocore2_defconfig
sh                          rsk7203_defconfig
arm                             ezx_defconfig
powerpc                     mpc83xx_defconfig
arm                            lart_defconfig
sh                        edosk7760_defconfig
sh                             shx3_defconfig
parisc                generic-64bit_defconfig
sh                              ul2_defconfig
powerpc                  storcenter_defconfig
arm                        cerfcube_defconfig
sh                          r7785rp_defconfig
m68k                            q40_defconfig
arc                           tb10x_defconfig
i386                 randconfig-a002-20221017
x86_64               randconfig-a003-20221017
powerpc                         wii_defconfig
arm                        realview_defconfig
arc                        vdk_hs38_defconfig
powerpc                      chrp32_defconfig
m68k                       m5208evb_defconfig
mips                     decstation_defconfig
mips                        bcm47xx_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7705_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                           h3600_defconfig
riscv                               defconfig
x86_64               randconfig-c001-20221017
arm                  randconfig-c002-20221017
powerpc                     taishan_defconfig
m68k                       bvme6000_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
sparc                       sparc32_defconfig
sparc                       sparc64_defconfig
arm                       aspeed_g5_defconfig
arm64                            alldefconfig
sh                           se7724_defconfig
powerpc                      ppc6xx_defconfig
csky                              allnoconfig
loongarch                         allnoconfig
loongarch                           defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                  iss476-smp_defconfig
sh                            hp6xx_defconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arm                       imx_v6_v7_defconfig
m68k                          amiga_defconfig
m68k                        m5307c3_defconfig
arm                         lpc18xx_defconfig
powerpc                 mpc85xx_cds_defconfig
ia64                                defconfig
ia64                          tiger_defconfig
alpha                            alldefconfig
mips                     loongson1b_defconfig
i386                          randconfig-c001
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
powerpc                      pcm030_defconfig
arm                        shmobile_defconfig
arc                            hsdk_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                    xip_kc705_defconfig
m68k                           sun3_defconfig
mips                           gcw0_defconfig
mips                      fuloong2e_defconfig
xtensa                  audio_kc705_defconfig
m68k                          atari_defconfig
openrisc                       virt_defconfig
sh                         ap325rxa_defconfig
arm                          pxa3xx_defconfig
sh                          sdk7786_defconfig
sh                        dreamcast_defconfig
sh                                  defconfig
m68k                                defconfig
powerpc                          allyesconfig
powerpc                      ppc40x_defconfig
sparc64                             defconfig
sh                        sh7757lcr_defconfig
sh                   sh7770_generic_defconfig
arc                    vdk_hs38_smp_defconfig
microblaze                      mmu_defconfig
sh                           se7343_defconfig
parisc                              defconfig
arm                         at91_dt_defconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
sh                  sh7785lcr_32bit_defconfig
mips                           jazz_defconfig
powerpc                     asp8347_defconfig
mips                  maltasmvp_eva_defconfig
m68k                       m5275evb_defconfig
powerpc                     pq2fads_defconfig
arm                         cm_x300_defconfig
loongarch                        allmodconfig
sh                   sh7724_generic_defconfig
openrisc                 simple_smp_defconfig
arm                          gemini_defconfig
mips                            gpr_defconfig
sparc                             allnoconfig
powerpc                     tqm8541_defconfig
powerpc                     stx_gp3_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        trizeps4_defconfig
m68k                        mvme16x_defconfig
arm                        mvebu_v7_defconfig
openrisc                         alldefconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221018

clang tested configs:
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
x86_64               randconfig-a014-20221017
x86_64               randconfig-a015-20221017
x86_64               randconfig-a012-20221017
x86_64               randconfig-a011-20221017
x86_64               randconfig-a013-20221017
x86_64               randconfig-a016-20221017
mips                 randconfig-c004-20221017
i386                 randconfig-c001-20221017
s390                 randconfig-c005-20221017
arm                  randconfig-c002-20221017
riscv                randconfig-c006-20221017
x86_64               randconfig-c007-20221017
powerpc              randconfig-c003-20221017
x86_64               randconfig-k001-20221017
s390                 randconfig-r044-20221017
hexagon              randconfig-r045-20221017
riscv                randconfig-r042-20221017
hexagon              randconfig-r041-20221017
arm                          collie_defconfig
x86_64                        randconfig-c007
mips                 randconfig-c004-20221018
i386                          randconfig-c001
s390                 randconfig-c005-20221018
arm                  randconfig-c002-20221018
riscv                randconfig-c006-20221018
powerpc              randconfig-c003-20221018
arm                        mvebu_v5_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                        maltaup_defconfig
arm                         s3c2410_defconfig
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
arm                      pxa255-idp_defconfig
mips                       lemote2f_defconfig
hexagon              randconfig-r045-20221018
hexagon              randconfig-r041-20221018
arm                      tct_hammer_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
