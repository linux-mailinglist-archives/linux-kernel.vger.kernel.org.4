Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97DC5F4B36
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiJDVxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJDVxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:53:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDFC33E2A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 14:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664920418; x=1696456418;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ktyb4QoJN8LvED7d0S1SyEHHHNmMHJcG1o42LZlbcns=;
  b=lnQ2t0CQ+gaqu63Na7b43UiKlm2R3YLKTLgIWreljdozyKWT30hYfFi0
   kBau/ngtb1iSzTx5xX1jXQs49/PZfiTmDGiWvOIL1pBCPqXLgYVRkSJiG
   TWgbhvDmmfjC7F3M/YhCf31myIdNL5vzvbTA8jyBhsfJa1QBk+P6PDDW4
   xzI88DrQ+MMqbb77f+OrlvwgkXEoXPwCBnWLnmHeTm/jV6ikT/C5dsMUO
   mWhyB3nZjMIvbWSPuhvSlTKd9vhRnJMTFZglTwXCSF7iNVe0CF8hHl+H2
   1q27PAmo2NVD6/t7CSnzB1FXsT/iDyZ4NGTlxjuQJKefNA008GE1zgt06
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="367152527"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="367152527"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 14:53:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="654949370"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="654949370"
Received: from lkp-server01.sh.intel.com (HELO d4f44333118a) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 04 Oct 2022 14:53:36 -0700
Received: from kbuild by d4f44333118a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ofpr5-0000Zd-2X;
        Tue, 04 Oct 2022 21:53:35 +0000
Date:   Wed, 05 Oct 2022 05:52:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 36de4f94197318e45ba77badb5b07274f5bc72a9
Message-ID: <633cab28.a5Wvgy+RyqaQlkpC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 36de4f94197318e45ba77badb5b07274f5bc72a9  Merge tag 'irqchip-6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

elapsed time: 724m

configs tested: 131
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
sh                               allmodconfig
alpha                               defconfig
powerpc                           allnoconfig
i386                 randconfig-a011-20221003
x86_64                          rhel-8.3-func
i386                 randconfig-a012-20221003
x86_64                              defconfig
i386                 randconfig-a013-20221003
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a015-20221003
s390                             allmodconfig
i386                 randconfig-a016-20221003
s390                                defconfig
i386                 randconfig-a014-20221003
mips                             allyesconfig
x86_64                               rhel-8.3
powerpc                          allmodconfig
arm                                 defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
s390                             allyesconfig
arm                              allyesconfig
x86_64                           allyesconfig
i386                                defconfig
x86_64               randconfig-a011-20221003
arm64                            allyesconfig
x86_64               randconfig-a015-20221003
x86_64               randconfig-a014-20221003
riscv                randconfig-r042-20221003
x86_64               randconfig-a012-20221003
arc                  randconfig-r043-20221003
x86_64               randconfig-a013-20221003
m68k                             allmodconfig
x86_64               randconfig-a016-20221003
arc                              allyesconfig
arc                  randconfig-r043-20221002
alpha                            allyesconfig
s390                 randconfig-r044-20221003
m68k                             allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                             allyesconfig
powerpc                      mgcoge_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     mpc83xx_defconfig
sh                      rts7751r2d1_defconfig
arc                    vdk_hs38_smp_defconfig
arm                             ezx_defconfig
arm                        realview_defconfig
xtensa                           alldefconfig
sh                          kfr2r09_defconfig
arm                          exynos_defconfig
sh                           se7619_defconfig
m68k                         apollo_defconfig
m68k                          atari_defconfig
sh                   sh7770_generic_defconfig
sh                              ul2_defconfig
m68k                        stmark2_defconfig
i386                          randconfig-c001
nios2                               defconfig
m68k                          amiga_defconfig
arc                            hsdk_defconfig
loongarch                 loongson3_defconfig
powerpc                      cm5200_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc8540_ads_defconfig
arm                          simpad_defconfig
xtensa                          iss_defconfig
arm                            lart_defconfig
sh                     magicpanelr2_defconfig
sh                ecovec24-romimage_defconfig
arm64                            alldefconfig
powerpc                 mpc837x_mds_defconfig
mips                         cobalt_defconfig
mips                 randconfig-c004-20221002
m68k                          sun3x_defconfig
powerpc                     tqm8548_defconfig
arm                  randconfig-c002-20221002
x86_64                        randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                   rts7751r2dplus_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
s390                       zfcpdump_defconfig
powerpc                      chrp32_defconfig
sh                             espt_defconfig
powerpc                       maple_defconfig
sparc64                             defconfig
arc                          axs101_defconfig
powerpc                 linkstation_defconfig
arm                            pleb_defconfig
powerpc                    adder875_defconfig
powerpc                     stx_gp3_defconfig
ia64                      gensparse_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig

clang tested configs:
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
hexagon              randconfig-r041-20221003
i386                 randconfig-a001-20221003
riscv                randconfig-r042-20221002
i386                 randconfig-a006-20221003
hexagon              randconfig-r041-20221002
x86_64               randconfig-a003-20221003
s390                 randconfig-r044-20221002
x86_64               randconfig-a002-20221003
hexagon              randconfig-r045-20221002
x86_64               randconfig-a005-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a006-20221003
hexagon              randconfig-r045-20221003
x86_64                        randconfig-k001
powerpc                      walnut_defconfig
arm                  colibri_pxa300_defconfig
arm                       mainstone_defconfig
riscv                             allnoconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
