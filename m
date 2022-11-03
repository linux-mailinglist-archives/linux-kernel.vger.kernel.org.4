Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F169617AEE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiKCKjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiKCKjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:39:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CD1EE0D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 03:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667471954; x=1699007954;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lKTs3HKC67lJRxw2Qo8sOAALkXqfnnNZFUy86V4w+k0=;
  b=BDA69GwgfMyiyuMG+cYchiLlyYoPN8ndcuX2r8J0mBWzCbX34Cna3rPm
   ZbByXQ4CZ6AhLLZ9q+i89uxAmHycgfV/Bo/g26iFf042xLw0rvG8dyyn2
   QpPepbH0tsw1xFEore69CL64tRtHflHCyZlNEJCUu3+/sr6Ii47BLUes2
   DXoATEkQO60hXEge08doc59DDdrD6aZtoVDmmNAltcEqNRgOKLeOZrmym
   yiUHtARP5ZZ3Mvt92vzxozZADlvKwpGQLyIiA9+D+W1XnenpwArZqTFhY
   Z0ZjaR7YkBKYe1DUzDxrwJlqZQwAMyjiknCelogtnAAplD2vhSFwbb3Rw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="311377029"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="311377029"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 03:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="585749639"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="585749639"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Nov 2022 03:38:56 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqXce-000Fpi-0R;
        Thu, 03 Nov 2022 10:38:56 +0000
Date:   Thu, 03 Nov 2022 18:38:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 6f8faf471446844bb9c318e0340221049d5c19f4
Message-ID: <63639a12.Zj2RMM8/Yg9KopA0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 6f8faf471446844bb9c318e0340221049d5c19f4  perf/x86/intel: Add Cooper Lake stepping to isolation_ucodes[]

elapsed time: 720m

configs tested: 107
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
ia64                             allmodconfig
alpha                               defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
mips                     decstation_defconfig
powerpc                   motionpro_defconfig
parisc                generic-32bit_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                               alldefconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                        multi_v7_defconfig
arm                         s3c6400_defconfig
sh                        apsh4ad0a_defconfig
arm                           tegra_defconfig
sh                          rsk7203_defconfig
i386                          randconfig-c001
arm                            pleb_defconfig
sh                        edosk7760_defconfig
arm                       aspeed_g5_defconfig
um                                  defconfig
riscv                               defconfig
arm                        keystone_defconfig
openrisc                    or1ksim_defconfig
powerpc                      mgcoge_defconfig
m68k                          sun3x_defconfig
arc                            hsdk_defconfig
powerpc                     mpc83xx_defconfig
riscv                            allmodconfig
sh                             sh03_defconfig
powerpc                   currituck_defconfig
sh                           se7712_defconfig
arm                        clps711x_defconfig
csky                                defconfig
powerpc                     stx_gp3_defconfig
sh                      rts7751r2d1_defconfig
mips                       bmips_be_defconfig
m68k                       m5208evb_defconfig
powerpc                         wii_defconfig
m68k                       m5275evb_defconfig
m68k                           sun3_defconfig
arm                         nhk8815_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                  randconfig-c002-20221102
x86_64                        randconfig-c001

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
riscv                    nommu_virt_defconfig
mips                       rbtx49xx_defconfig
arm                         socfpga_defconfig
riscv                randconfig-r042-20221103
hexagon              randconfig-r041-20221103
hexagon              randconfig-r045-20221103
s390                 randconfig-r044-20221103
powerpc                  mpc885_ads_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r041-20221102
hexagon              randconfig-r045-20221102
x86_64                        randconfig-k001
mips                     loongson1c_defconfig
mips                           mtx1_defconfig
powerpc               mpc834x_itxgp_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
