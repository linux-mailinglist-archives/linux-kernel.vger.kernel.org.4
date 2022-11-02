Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89C0616FFC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiKBVl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBVlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:41:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E896591
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667425285; x=1698961285;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lSB3qo006K08MzYKgmNah+zdY62e2/kYDLJU4v5HZCo=;
  b=J21Qfp2tepFgrIzoRV2Aaleed3ZduydmjNSOn9lHHr2b/p+m8xBx5AEg
   33bevU2nJ4Q3zjKvQ+3O0TR8/22PeMhuuc+oM9f8SGnkL+MjkIYNVYk9e
   96BM0IM1FTZzSI7MnAYC+sJR7v+AHBXLx7EK+fGtWBvDElbVIOaJdYNlg
   6igkHjzJCU3XF8WfliMP9OxaGlhHOgzPvrLHcDussUSjFY2I2PBUAnl8P
   yb77hZ89LX5ydETQh1jAdFqNH009z8vw8tx/rfnfXmd7wpY5pH+o6X7fI
   ePCHksJQWnRgA+TvR2thYCxZ9WGdVJ5l4eEc9pJVSpw5yVodv7p36qnJv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="289237272"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="289237272"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:41:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="703425036"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="703425036"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 02 Nov 2022 14:41:23 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqLUB-000F97-0S;
        Wed, 02 Nov 2022 21:41:23 +0000
Date:   Thu, 03 Nov 2022 05:40:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 d632bf6ff1f6f733e1de9c5331fd643f4ecbe483
Message-ID: <6362e3e0.mRSB/IEPNq5xspa6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: d632bf6ff1f6f733e1de9c5331fd643f4ecbe483  x86/boot: Repair kernel-doc for boot_kstrtoul()

elapsed time: 721m

configs tested: 102
configs skipped: 86

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
x86_64                              defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                          rhel-8.3-func
x86_64                        randconfig-a015
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a006
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                           allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                             allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
sparc                       sparc32_defconfig
mips                           xway_defconfig
arm                         vf610m4_defconfig
xtensa                       common_defconfig
arm                          lpd270_defconfig
m68k                         apollo_defconfig
mips                     decstation_defconfig
m68k                          multi_defconfig
m68k                             allmodconfig
i386                          randconfig-c001
arm                        multi_v7_defconfig
arm                         s3c6400_defconfig
sh                        apsh4ad0a_defconfig
arm                           tegra_defconfig
sh                          rsk7203_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm                            pleb_defconfig
sh                             sh03_defconfig
powerpc                   currituck_defconfig
sh                           se7712_defconfig
arm                         axm55xx_defconfig
powerpc                   motionpro_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     tqm8548_defconfig
arc                           tb10x_defconfig
sh                 kfr2r09-romimage_defconfig
mips                          rb532_defconfig
sh                        sh7757lcr_defconfig
nios2                            alldefconfig
sh                        edosk7705_defconfig
arm                        clps711x_defconfig
csky                                defconfig
powerpc                     stx_gp3_defconfig
sh                      rts7751r2d1_defconfig
mips                       bmips_be_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20221102
hexagon              randconfig-r045-20221102
riscv                randconfig-r042-20221103
hexagon              randconfig-r041-20221103
hexagon              randconfig-r045-20221103
s390                 randconfig-r044-20221103
arm                       netwinder_defconfig
arm                         bcm2835_defconfig
powerpc                      ppc44x_defconfig
riscv                    nommu_virt_defconfig
mips                       rbtx49xx_defconfig
arm                         socfpga_defconfig
powerpc                 mpc832x_mds_defconfig
arm                          pcm027_defconfig
arm                       cns3420vb_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
