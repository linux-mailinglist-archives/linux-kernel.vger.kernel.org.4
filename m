Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D69665524
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjAKH3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbjAKH3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:29:07 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F01384
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673422146; x=1704958146;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IqPsi/ZyAuou2V8L3Z9QBmZyzwNuECrjUPBCLF7HCUU=;
  b=OVHOwwDdHoZE9yuxdPw6jAdtXbbHzNCElsyiGCNigSTjr/rEMU3irNHg
   kGs+CDMIX+Vc92zY2juaoQAlqdk4YvyCMOw0h0pSYu0mh045H7ssFghX1
   ZQ8eNIgYpCL69oLgfw9d33gSyKoKyZSX4QHePC8FKIJZY4m7z0KYkeG+W
   t8gQSFaeRo3gOf+Z0C2jxTX7tNA0M1qxiVyg7UNgutepOcssVlF1kzAEo
   26wpjuXOLThR6WZWT6FOTW4AvIlVlHDy2HrSBdQelNRoD4rdeBsr3Woq6
   P/lmpfPZEA4l/xKik2+zwuvYNSwbfDjFVWXP+BVIevB2+JT4deTMD3eV8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="325358264"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="325358264"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 23:29:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607266621"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="607266621"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2023 23:29:03 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFVXj-0008ta-08;
        Wed, 11 Jan 2023 07:29:03 +0000
Date:   Wed, 11 Jan 2023 15:28:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp] BUILD SUCCESS
 b942a520d9e43bc31f0808d2f2267a1ddba75518
Message-ID: <63be650d.yVSrbsfVwlSPTUAM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp
branch HEAD: b942a520d9e43bc31f0808d2f2267a1ddba75518  bcache: Replace zero-length arrays with DECLARE_FLEX_ARRAY() helper

elapsed time: 7596m

configs tested: 396
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
arc                  randconfig-r043-20230105
alpha                               defconfig
x86_64                            allnoconfig
s390                 randconfig-r044-20230105
sh                               allmodconfig
riscv                randconfig-r042-20230105
mips                             allyesconfig
i386                          randconfig-a001
s390                                defconfig
i386                          randconfig-a003
s390                             allmodconfig
powerpc                          allmodconfig
ia64                             allmodconfig
i386                          randconfig-a014
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a005
x86_64                        randconfig-a006
i386                          randconfig-a012
x86_64                        randconfig-a013
x86_64                        randconfig-a011
s390                             allyesconfig
i386                          randconfig-a016
x86_64                        randconfig-a015
mips                 randconfig-c004-20230105
i386                          randconfig-c001
microblaze                          defconfig
powerpc                   motionpro_defconfig
arm                          iop32x_defconfig
sh                   sh7770_generic_defconfig
sh                ecovec24-romimage_defconfig
sh                   rts7751r2dplus_defconfig
i386                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
arm                                 defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
x86_64                           allyesconfig
i386                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-bpf
arm64                            allyesconfig
csky                                defconfig
powerpc                      makalu_defconfig
sh                           se7750_defconfig
powerpc                       eiger_defconfig
powerpc                      arches_defconfig
parisc                           alldefconfig
arm                            zeus_defconfig
arm                              allyesconfig
m68k                        m5407c3_defconfig
loongarch                           defconfig
arm                          lpd270_defconfig
sh                                  defconfig
x86_64                           alldefconfig
mips                         rt305x_defconfig
powerpc                      ppc40x_defconfig
sparc                       sparc32_defconfig
sh                             shx3_defconfig
m68k                           virt_defconfig
sh                           se7724_defconfig
sh                     magicpanelr2_defconfig
arm                       omap2plus_defconfig
powerpc                  iss476-smp_defconfig
sh                        dreamcast_defconfig
sh                           se7619_defconfig
mips                            gpr_defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                         apsh4a3a_defconfig
arc                    vdk_hs38_smp_defconfig
sparc                            alldefconfig
arc                      axs103_smp_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sh                          sdk7786_defconfig
powerpc                      bamboo_defconfig
powerpc                      mgcoge_defconfig
mips                            ar7_defconfig
arm                            qcom_defconfig
arm                            lart_defconfig
arm                        cerfcube_defconfig
mips                         db1xxx_defconfig
powerpc                      ppc6xx_defconfig
mips                         cobalt_defconfig
sparc64                             defconfig
powerpc                       ppc64_defconfig
sh                            titan_defconfig
ia64                             alldefconfig
powerpc                     mpc83xx_defconfig
arc                              alldefconfig
mips                           ci20_defconfig
m68k                        mvme147_defconfig
arm                          exynos_defconfig
powerpc                 mpc837x_rdb_defconfig
openrisc                    or1ksim_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20230106
sh                        apsh4ad0a_defconfig
xtensa                  nommu_kc705_defconfig
ia64                        generic_defconfig
sh                           sh2007_defconfig
powerpc                   currituck_defconfig
powerpc                      pasemi_defconfig
powerpc                 linkstation_defconfig
sh                           se7751_defconfig
csky                             alldefconfig
powerpc                       maple_defconfig
sparc                               defconfig
xtensa                           allyesconfig
sparc                            allyesconfig
x86_64                                  kexec
arm                        clps711x_defconfig
arm                       imx_v6_v7_defconfig
mips                           xway_defconfig
sh                          rsk7264_defconfig
powerpc                      chrp32_defconfig
m68k                        stmark2_defconfig
sh                        edosk7705_defconfig
riscv                               defconfig
riscv                            allyesconfig
arc                     nsimosci_hs_defconfig
arm                           imxrt_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                          gemini_defconfig
powerpc                          allyesconfig
riscv                            allmodconfig
arm64                               defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     rainier_defconfig
arm                        oxnas_v6_defconfig
alpha                             allnoconfig
m68k                          hp300_defconfig
s390                          debug_defconfig
sh                          sdk7780_defconfig
sh                          urquell_defconfig
sh                   sh7724_generic_defconfig
ia64                             allyesconfig
sparc                             allnoconfig
arc                     haps_hs_smp_defconfig
ia64                      gensparse_defconfig
xtensa                  cadence_csp_defconfig
sh                           se7722_defconfig
arm                        trizeps4_defconfig
nios2                         3c120_defconfig
s390                       zfcpdump_defconfig
arc                            hsdk_defconfig
arm                        mini2440_defconfig
mips                           ip32_defconfig
mips                       bmips_be_defconfig
powerpc                         wii_defconfig
arm                          pxa3xx_defconfig
sh                            migor_defconfig
xtensa                          iss_defconfig
sh                           se7721_defconfig
sh                              ul2_defconfig
arm                       multi_v4t_defconfig
mips                           gcw0_defconfig
powerpc                  storcenter_defconfig
mips                     loongson1b_defconfig
ia64                            zx1_defconfig
sparc                       sparc64_defconfig
sh                     sh7710voipgw_defconfig
arm                              allmodconfig
m68k                                defconfig
mips                             allmodconfig
arm                             rpc_defconfig
powerpc                     sequoia_defconfig
sh                 kfr2r09-romimage_defconfig
arm                  randconfig-c002-20230108
mips                         bigsur_defconfig
openrisc                 simple_smp_defconfig
sh                          landisk_defconfig
xtensa                    smp_lx200_defconfig
sh                             sh03_defconfig
ia64                         bigsur_defconfig
powerpc                      cm5200_defconfig
arc                          axs101_defconfig
powerpc                 mpc8540_ads_defconfig
ia64                          tiger_defconfig
sh                          kfr2r09_defconfig
parisc                generic-32bit_defconfig
mips                           jazz_defconfig
arm                           sama5_defconfig
powerpc                     asp8347_defconfig
arm64                            alldefconfig
mips                  maltasmvp_eva_defconfig
m68k                           sun3_defconfig
sparc64                          alldefconfig
sh                          r7780mp_defconfig
arm                        mvebu_v7_defconfig
powerpc                     tqm8548_defconfig
arm                        multi_v7_defconfig
openrisc                       virt_defconfig
xtensa                generic_kc705_defconfig
xtensa                              defconfig
ia64                                defconfig
arm                         axm55xx_defconfig
mips                 decstation_r4k_defconfig
powerpc                     taishan_defconfig
powerpc                        warp_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                       common_defconfig
um                                  defconfig
openrisc                         alldefconfig
arm                           stm32_defconfig
m68k                       bvme6000_defconfig
sh                         microdev_defconfig
m68k                       m5208evb_defconfig
arm                         s3c6400_defconfig
i386                 randconfig-a015-20230109
i386                 randconfig-a011-20230109
i386                 randconfig-a013-20230109
s390                 randconfig-r044-20230109
arc                  randconfig-r043-20230108
arc                  randconfig-r043-20230109
arm                  randconfig-r046-20230108
riscv                randconfig-r042-20230109
x86_64               randconfig-a014-20230109
x86_64               randconfig-a016-20230109
x86_64               randconfig-a012-20230109
x86_64               randconfig-a011-20230109
x86_64               randconfig-a013-20230109
x86_64               randconfig-a015-20230109
i386                 randconfig-a014-20230109
i386                 randconfig-a016-20230109
i386                 randconfig-a012-20230109
arm                             pxa_defconfig
arc                           tb10x_defconfig
arc                         haps_hs_defconfig
mips                      maltasmvp_defconfig
sh                           se7712_defconfig
sh                               alldefconfig
powerpc                         ps3_defconfig
sh                          polaris_defconfig
powerpc                 canyonlands_defconfig
powerpc                 mpc834x_mds_defconfig
arm                           corgi_defconfig
xtensa                    xip_kc705_defconfig
riscv                randconfig-r042-20230110
s390                 randconfig-r044-20230110
arc                  randconfig-r043-20230110
powerpc                    amigaone_defconfig
arm                            hisi_defconfig
arm                            pleb_defconfig
sh                      rts7751r2d1_defconfig
arm                         lubbock_defconfig
powerpc                     redwood_defconfig
sh                          rsk7203_defconfig
sh                            hp6xx_defconfig
arm                         assabet_defconfig
xtensa                  audio_kc705_defconfig
m68k                            q40_defconfig
sh                           se7780_defconfig
sh                         ap325rxa_defconfig
arm                               allnoconfig
m68k                        mvme16x_defconfig
m68k                          amiga_defconfig
mips                     decstation_defconfig
powerpc                      pcm030_defconfig
arm                  randconfig-c002-20230110
arc                        nsim_700_defconfig
m68k                       m5249evb_defconfig
openrisc                            defconfig
arm                       aspeed_g5_defconfig
mips                      fuloong2e_defconfig
i386                             alldefconfig
arm                        keystone_defconfig
arm                         lpc18xx_defconfig
powerpc                     pq2fads_defconfig
arm                          pxa910_defconfig
arm                           h3600_defconfig

clang tested configs:
arm                  randconfig-r046-20230105
hexagon              randconfig-r041-20230105
hexagon              randconfig-r045-20230105
i386                          randconfig-a002
i386                          randconfig-a013
i386                          randconfig-a004
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a006
x86_64                        randconfig-a012
i386                          randconfig-a015
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                   milbeaut_m10v_defconfig
arm                         bcm2835_defconfig
arm                        magician_defconfig
arm                          ixp4xx_defconfig
s390                 randconfig-r044-20230106
hexagon              randconfig-r041-20230106
hexagon              randconfig-r045-20230106
riscv                randconfig-r042-20230106
mips                malta_qemu_32r6_defconfig
arm                           omap1_defconfig
arm                            dove_defconfig
x86_64                        randconfig-k001
mips                        maltaup_defconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                   bluestone_defconfig
mips                       rbtx49xx_defconfig
arm                              alldefconfig
hexagon                             defconfig
arm                       cns3420vb_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                          g5_defconfig
arm                          moxart_defconfig
arm                        neponset_defconfig
hexagon              randconfig-r041-20230107
hexagon              randconfig-r045-20230107
arm                  randconfig-r046-20230107
mips                 randconfig-c004-20230106
x86_64                        randconfig-c007
i386                          randconfig-c001
s390                 randconfig-c005-20230106
arm                  randconfig-c002-20230106
riscv                randconfig-c006-20230106
powerpc              randconfig-c003-20230106
arm                       aspeed_g4_defconfig
powerpc                     mpc5200_defconfig
arm                         palmz72_defconfig
arm                         orion5x_defconfig
arm                           spitz_defconfig
x86_64                           allyesconfig
arm                       imx_v4_v5_defconfig
i386                             allyesconfig
powerpc                      acadia_defconfig
mips                     loongson1c_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     pseries_defconfig
mips                          rm200_defconfig
arm                          collie_defconfig
powerpc                      ppc64e_defconfig
mips                  cavium_octeon_defconfig
mips                           ip28_defconfig
arm                    vt8500_v6_v7_defconfig
mips                        qi_lb60_defconfig
arm                          ep93xx_defconfig
powerpc                   microwatt_defconfig
powerpc                 mpc832x_rdb_defconfig
x86_64               randconfig-a002-20230109
x86_64               randconfig-a004-20230109
x86_64               randconfig-a006-20230109
arm                         hackkit_defconfig
i386                 randconfig-a005-20230109
i386                 randconfig-a001-20230109
i386                 randconfig-a003-20230109
x86_64               randconfig-a001-20230109
x86_64               randconfig-a003-20230109
x86_64               randconfig-a005-20230109
s390                 randconfig-r044-20230108
hexagon              randconfig-r041-20230108
hexagon              randconfig-r045-20230108
riscv                randconfig-r042-20230108
arm                          pcm027_defconfig
powerpc                       ebony_defconfig
i386                 randconfig-a006-20230109
i386                 randconfig-a002-20230109
i386                 randconfig-a004-20230109
mips                      maltaaprp_defconfig
hexagon              randconfig-r041-20230109
hexagon              randconfig-r045-20230109
arm                  randconfig-r046-20230109
arm                  colibri_pxa300_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                        multi_v5_defconfig
powerpc                     ksi8560_defconfig
powerpc                    mvme5100_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                          allyesconfig
riscv                          rv32_defconfig
powerpc                      ppc44x_defconfig
arm                  randconfig-r046-20230110
hexagon              randconfig-r041-20230110
hexagon              randconfig-r045-20230110
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
