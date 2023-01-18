Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EA2671A46
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjARLQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjARLQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:16:25 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB62280156
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674037847; x=1705573847;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yTko1999lf5RXGn6zEp52uTYjEYfGOxku2ASbP9JeQM=;
  b=Mt0+wFdHjNVO7QnCuZ2ZbODKHSD5dpoSsWGue0/uo2oI8n/CnIcm3Fjo
   Aq1+5TUSpq3pi5RaBE6ooT7zvHaf2+8BTyNQg7INjP2DRrmp0ykr2U6ju
   9cHhLzNA2AmfnrBx2AWIsa+4SJvWKhcDExlxQRjVNCfh3CCwMn99bJqnt
   W7A0QCMnKaMhBWEode1eC3AovSceU+YZpxPM1GPc1/9l6vOaG8KNIdQg6
   olRjecXpyobGs5zPNQka6ynbdY2sO7zrk6r4MHL8aRW2X5VClfe0Poe6L
   /w7Qwz2j0oVJ1nNRmKbXIQxNnvWIlWTC3De/sgMnn19cc4CjFafo+7F5v
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="325003141"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="325003141"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 02:30:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="767692630"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767692630"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2023 02:30:46 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pI5iK-0000D3-0z;
        Wed, 18 Jan 2023 10:30:40 +0000
Date:   Wed, 18 Jan 2023 18:30:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 6c796996ee7033bcbbc3cd733513eb43f8160f5e
Message-ID: <63c7ca35.Uwo3UTLxAAklDTod%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 6c796996ee7033bcbbc3cd733513eb43f8160f5e  x86/pci/xen: Fixup fallout from the PCI/MSI overhaul

elapsed time: 2326m

configs tested: 208
configs skipped: 84

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                 randconfig-a014-20230116
x86_64               randconfig-a011-20230116
i386                 randconfig-a013-20230116
x86_64               randconfig-a013-20230116
i386                 randconfig-a012-20230116
x86_64               randconfig-a012-20230116
i386                 randconfig-a011-20230116
x86_64               randconfig-a014-20230116
i386                 randconfig-a015-20230116
x86_64               randconfig-a016-20230116
x86_64               randconfig-a015-20230116
i386                 randconfig-a016-20230116
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
ia64                             allmodconfig
riscv                randconfig-r042-20230116
arm                  randconfig-r046-20230117
s390                 randconfig-r044-20230116
arc                  randconfig-r043-20230117
arc                  randconfig-r043-20230116
sh                        sh7763rdp_defconfig
sh                         ap325rxa_defconfig
alpha                            alldefconfig
arc                         haps_hs_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-c001
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arm64                               defconfig
sh                        dreamcast_defconfig
arm                       multi_v4t_defconfig
s390                          debug_defconfig
x86_64               randconfig-k001-20230116
i386                 randconfig-c001-20230116
powerpc                     stx_gp3_defconfig
arm                           corgi_defconfig
arc                      axs103_smp_defconfig
powerpc                      ep88xc_defconfig
sh                          sdk7780_defconfig
arm                        clps711x_defconfig
arm                     eseries_pxa_defconfig
openrisc                    or1ksim_defconfig
m68k                           sun3_defconfig
arc                          axs101_defconfig
sh                           se7705_defconfig
powerpc                     sequoia_defconfig
loongarch                 loongson3_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
mips                     decstation_defconfig
mips                         bigsur_defconfig
openrisc                            defconfig
sh                          landisk_defconfig
arm                           sama5_defconfig
arm                  randconfig-r046-20230115
arc                  randconfig-r043-20230115
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
sh                     sh7710voipgw_defconfig
arm                      jornada720_defconfig
riscv                randconfig-r042-20230118
s390                 randconfig-r044-20230118
arc                  randconfig-r043-20230118
x86_64                        randconfig-c001
arm                  randconfig-c002-20230115
xtensa                  cadence_csp_defconfig
sh                             shx3_defconfig
sh                          kfr2r09_defconfig
sh                     magicpanelr2_defconfig
m68k                            q40_defconfig
ia64                      gensparse_defconfig
mips                  decstation_64_defconfig
m68k                          multi_defconfig
powerpc                    sam440ep_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
m68k                          hp300_defconfig
arm                            lart_defconfig
arm                  randconfig-c002-20230117
powerpc                      bamboo_defconfig
arm                           imxrt_defconfig
powerpc                      makalu_defconfig
arm                        cerfcube_defconfig
powerpc                 linkstation_defconfig
mips                  maltasmvp_eva_defconfig
ia64                        generic_defconfig
sh                 kfr2r09-romimage_defconfig
openrisc                         alldefconfig
powerpc                     tqm8548_defconfig
mips                        vocore2_defconfig

clang tested configs:
i386                 randconfig-a002-20230116
i386                 randconfig-a004-20230116
i386                 randconfig-a001-20230116
i386                 randconfig-a003-20230116
i386                 randconfig-a005-20230116
i386                 randconfig-a006-20230116
arm                     am200epdkit_defconfig
mips                           mtx1_defconfig
powerpc                     pseries_defconfig
x86_64               randconfig-a003-20230116
x86_64               randconfig-a004-20230116
x86_64               randconfig-a006-20230116
x86_64               randconfig-a005-20230116
x86_64               randconfig-a001-20230116
x86_64               randconfig-a002-20230116
riscv                randconfig-r042-20230115
arm                  randconfig-r046-20230116
s390                 randconfig-r044-20230115
hexagon              randconfig-r041-20230115
hexagon              randconfig-r041-20230116
hexagon              randconfig-r045-20230115
hexagon              randconfig-r045-20230116
i386                              allnoconfig
powerpc                   lite5200b_defconfig
mips                  cavium_octeon_defconfig
x86_64                        randconfig-k001
arm                         lpc32xx_defconfig
x86_64                        randconfig-c007
arm                  randconfig-c002-20230115
s390                 randconfig-c005-20230115
i386                          randconfig-c001
riscv                randconfig-c006-20230115
powerpc              randconfig-c003-20230115
arm                        vexpress_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     mpc5200_defconfig
powerpc                  iss476-smp_defconfig
arm                          sp7021_defconfig
powerpc                     ppa8548_defconfig
powerpc                        fsp2_defconfig
mips                           rs90_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     sequoia_defconfig
riscv                randconfig-r042-20230117
s390                 randconfig-r044-20230117
hexagon              randconfig-r041-20230117
hexagon              randconfig-r045-20230117
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                      acadia_defconfig
arm                        magician_defconfig
riscv                             allnoconfig
arm                         hackkit_defconfig
mips                          malta_defconfig
mips                        qi_lb60_defconfig
powerpc                     tqm8560_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     kmeter1_defconfig
mips                       lemote2f_defconfig
arm                            mmp2_defconfig
arm                           sama7_defconfig
riscv                          rv32_defconfig
powerpc                    mvme5100_defconfig
arm                     davinci_all_defconfig
mips                 randconfig-c004-20230115
arm                       cns3420vb_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                    ge_imp3a_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                 mpc832x_mds_defconfig
powerpc                      katmai_defconfig
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
