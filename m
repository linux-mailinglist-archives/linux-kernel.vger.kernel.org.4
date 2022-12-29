Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA28E658F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiL2RTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiL2RSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:18:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53452D2D8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 09:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672334332; x=1703870332;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QoS/6zDK+s+kndka18TEyqidUgA1zfHVQHj0McjiAcA=;
  b=NBFCIYGVJY6Rdz8a9BHlnSCVT9r/TPbmux+Iw6JstF2uDjVrPyd8EbsP
   O2aoJPnm51/7BqbR7lU7zHjwxVmVFrD67m0veKu2rTkyL5XPrc43Z4+Qz
   yfR6tjO1h6ZS0nAbxeQcL4K7zk8ZI74oRYXYuSsmqpgG+FbrjgEXG7T0N
   /g2zH2WHmeboUw0mqbRE/Q520flv4jszbUdsEQ1Ksj7u2tukQ1sZOf1Y5
   4JQp4HiFjL2+vvwFXXU1FdE7FKnJbZtjxDFRi4n6kMe/qrexc3BE9kaRa
   Gs9vFJGF4H2eoASKIM0zEeqvjdWVCpdIFQtGVLOuAZCIuegOHvT44Mkkb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="323064750"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="323064750"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 09:18:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="684268673"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="684268673"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Dec 2022 09:18:23 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pAwXu-000GuB-0u;
        Thu, 29 Dec 2022 17:18:22 +0000
Date:   Fri, 30 Dec 2022 01:17:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.12.22a] BUILD SUCCESS
 b90f0a5cfc0e880ca264d6d38eed73c9b0f3a153
Message-ID: <63adcbc6.hEhToOzIaI/dXGdU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.12.22a
branch HEAD: b90f0a5cfc0e880ca264d6d38eed73c9b0f3a153  clocksource: Permit limited-duration clocksource watchdogging

elapsed time: 9637m

configs tested: 298
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
s390                                defconfig
s390                             allmodconfig
m68k                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
s390                             allyesconfig
ia64                             allmodconfig
x86_64               randconfig-a002-20221219
x86_64               randconfig-a003-20221219
x86_64               randconfig-a001-20221219
x86_64               randconfig-a004-20221219
x86_64               randconfig-a005-20221219
x86_64               randconfig-a006-20221219
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a005-20221219
i386                 randconfig-a002-20221219
i386                 randconfig-a003-20221219
i386                 randconfig-a006-20221219
i386                 randconfig-a001-20221219
i386                 randconfig-a004-20221219
x86_64                            allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                                defconfig
arm                        trizeps4_defconfig
sh                            shmin_defconfig
um                               alldefconfig
powerpc                      makalu_defconfig
m68k                        mvme147_defconfig
i386                          randconfig-c001
s390                 randconfig-r044-20221222
arc                  randconfig-r043-20221222
riscv                randconfig-r042-20221222
openrisc                         alldefconfig
sh                        sh7785lcr_defconfig
xtensa                  cadence_csp_defconfig
sh                             espt_defconfig
xtensa                    xip_kc705_defconfig
arm                      jornada720_defconfig
sh                             sh03_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                       maple_defconfig
m68k                        m5272c3_defconfig
arm                        cerfcube_defconfig
arm                          iop32x_defconfig
xtensa                  nommu_kc705_defconfig
arm                               allnoconfig
m68k                          multi_defconfig
powerpc                 mpc8540_ads_defconfig
mips                            ar7_defconfig
openrisc                    or1ksim_defconfig
sh                          lboxre2_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
s390                 randconfig-r044-20221218
arm                  randconfig-r046-20221219
arc                  randconfig-r043-20221218
arc                  randconfig-r043-20221219
riscv                randconfig-r042-20221218
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                          landisk_defconfig
arm                           u8500_defconfig
ia64                        generic_defconfig
arm                             ezx_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221223
arm                           imxrt_defconfig
sh                               j2_defconfig
powerpc                     rainier_defconfig
powerpc                   currituck_defconfig
arm                            lart_defconfig
sh                           se7780_defconfig
mips                         cobalt_defconfig
sh                           se7724_defconfig
sh                          rsk7203_defconfig
arm                            xcep_defconfig
mips                           xway_defconfig
powerpc                     redwood_defconfig
xtensa                  audio_kc705_defconfig
arm                     eseries_pxa_defconfig
ia64                          tiger_defconfig
powerpc                     stx_gp3_defconfig
powerpc                      arches_defconfig
ia64                         bigsur_defconfig
microblaze                      mmu_defconfig
arm                            qcom_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arc                        nsim_700_defconfig
powerpc                         wii_defconfig
ia64                      gensparse_defconfig
sh                 kfr2r09-romimage_defconfig
arm                            mps2_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
m68k                       m5249evb_defconfig
powerpc                      ep88xc_defconfig
arm                         s3c6400_defconfig
arm                           sunxi_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                                  defconfig
arm                       aspeed_g5_defconfig
mips                     loongson1b_defconfig
sh                          rsk7264_defconfig
mips                 decstation_r4k_defconfig
arc                          axs101_defconfig
sh                           se7705_defconfig
mips                       bmips_be_defconfig
s390                       zfcpdump_defconfig
powerpc                      ppc40x_defconfig
m68k                          atari_defconfig
sparc64                          alldefconfig
mips                      fuloong2e_defconfig
powerpc              randconfig-c003-20221225
arm                         axm55xx_defconfig
sh                                  defconfig
mips                            gpr_defconfig
mips                      maltasmvp_defconfig
sh                           se7343_defconfig
sh                         ap325rxa_defconfig
arc                     nsimosci_hs_defconfig
arm                  randconfig-c002-20221225
arm                           h3600_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                          iss_defconfig
m68k                            mac_defconfig
powerpc                    amigaone_defconfig
powerpc                   motionpro_defconfig
arc                    vdk_hs38_smp_defconfig
sparc                            alldefconfig
powerpc                     tqm8555_defconfig
parisc                           alldefconfig
openrisc                 simple_smp_defconfig
arm                             rpc_defconfig
arm                       multi_v4t_defconfig
ia64                                defconfig
powerpc                    klondike_defconfig
arm                          pxa3xx_defconfig
nios2                            alldefconfig
sh                        edosk7705_defconfig
arm                        oxnas_v6_defconfig
arc                          axs103_defconfig
arm                           sama5_defconfig
arm                            hisi_defconfig
powerpc                      tqm8xx_defconfig
m68k                        stmark2_defconfig
sh                        apsh4ad0a_defconfig
powerpc                  storcenter_defconfig
arm                           stm32_defconfig
arm                        spear6xx_defconfig
s390                 randconfig-r044-20221226
arm                  randconfig-r046-20221227
arm                  randconfig-r046-20221225
arc                  randconfig-r043-20221227
arc                  randconfig-r043-20221226
arc                  randconfig-r043-20221225
riscv                randconfig-r042-20221226
arm                             pxa_defconfig
arm                      footbridge_defconfig
sh                          rsk7269_defconfig
x86_64               randconfig-a014-20221226
x86_64               randconfig-a012-20221226
x86_64               randconfig-a016-20221226
x86_64               randconfig-a013-20221226
x86_64               randconfig-a011-20221226
x86_64               randconfig-a015-20221226
arc                            hsdk_defconfig
sh                            migor_defconfig
sh                           se7722_defconfig
riscv             nommu_k210_sdcard_defconfig
sparc                       sparc32_defconfig
arm                        keystone_defconfig
arm                      integrator_defconfig
i386                 randconfig-a014-20221226
i386                 randconfig-a011-20221226
i386                 randconfig-a016-20221226
i386                 randconfig-a012-20221226
i386                 randconfig-a013-20221226
i386                 randconfig-a015-20221226
sparc                       sparc64_defconfig
arm                           corgi_defconfig
sh                          urquell_defconfig
arm                         nhk8815_defconfig
arc                           tb10x_defconfig
sh                        edosk7760_defconfig
mips                  maltasmvp_eva_defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
m68k                          hp300_defconfig
arc                     haps_hs_smp_defconfig
m68k                        m5407c3_defconfig
sh                        dreamcast_defconfig
nios2                         3c120_defconfig
m68k                         apollo_defconfig
powerpc                     asp8347_defconfig
s390                          debug_defconfig
mips                           gcw0_defconfig

clang tested configs:
x86_64                        randconfig-k001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a013-20221219
i386                 randconfig-a014-20221219
i386                 randconfig-a015-20221219
i386                 randconfig-a011-20221219
i386                 randconfig-a016-20221219
i386                 randconfig-a012-20221219
x86_64                          rhel-8.3-rust
powerpc                      ppc44x_defconfig
s390                 randconfig-r044-20221221
riscv                randconfig-r042-20221221
hexagon              randconfig-r045-20221221
x86_64               randconfig-a015-20221219
x86_64               randconfig-a013-20221219
x86_64               randconfig-a012-20221219
x86_64               randconfig-a016-20221219
x86_64               randconfig-a014-20221219
x86_64               randconfig-a011-20221219
arm                         mv78xx0_defconfig
x86_64               randconfig-k001-20221219
powerpc                 mpc8560_ads_defconfig
arm                         s3c2410_defconfig
mips                     loongson2k_defconfig
arm                    vt8500_v6_v7_defconfig
arm                         bcm2835_defconfig
powerpc                    socrates_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     mpc512x_defconfig
arm                        magician_defconfig
arm                           sama7_defconfig
x86_64                           allyesconfig
arm                     am200epdkit_defconfig
powerpc                     akebono_defconfig
arm                         socfpga_defconfig
i386                 randconfig-a004-20221226
i386                 randconfig-a001-20221226
i386                 randconfig-a006-20221226
i386                 randconfig-a003-20221226
i386                 randconfig-a005-20221226
i386                 randconfig-a002-20221226
x86_64               randconfig-a004-20221226
x86_64               randconfig-a002-20221226
x86_64               randconfig-a005-20221226
x86_64               randconfig-a001-20221226
x86_64               randconfig-a006-20221226
x86_64               randconfig-a003-20221226
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r045-20221225
riscv                randconfig-r042-20221227
hexagon              randconfig-r041-20221225
hexagon              randconfig-r041-20221227
hexagon              randconfig-r041-20221226
arm                  randconfig-r046-20221226
s390                 randconfig-r044-20221225
hexagon              randconfig-r045-20221226
riscv                randconfig-r042-20221225
hexagon              randconfig-r045-20221227
s390                 randconfig-r044-20221227

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
