Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E4E614C49
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiKAOKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiKAOKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:10:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9011AF25
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667311809; x=1698847809;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DQIfiAUjWfwiryHfnyv093E/zYrmD4JWppIHU/Nv7vo=;
  b=ehRBaCMrIu7pKmfEUH/PxZ8yWoLm4FjVLHwt0E6VyRMmzqPIb3goj690
   pCvxY2eH2+xqGZWUmAqK0d+qBjAULU8KWyp6rwlXZ6irDX0q6AZQg8hOX
   4lU7fkN9P+txJua+NbX3tfRw2aDLVrJDEu6XS9RK6PhdEDJEDu71pWpdc
   uHn7hN+PuqO80p0P+hpx/+3QStzc0UVPP24O576t3sN2+lX3QDBqwiBIT
   jsOcwoQ79lQf/WQKojl068b92HOJ84AfEJKd5uQV96AJgtz/HwP4jFmL6
   xmLKXASWQnEOOb/3GCN1YP9wkf3nnCbxZP6AxEJOhhd9OJzSZO/dBvJnW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="289530871"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="289530871"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 07:09:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="776503105"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="776503105"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2022 07:09:55 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oprxj-000Dg5-0n;
        Tue, 01 Nov 2022 14:09:55 +0000
Date:   Tue, 01 Nov 2022 22:09:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 00ed1eabcc3b785aecf6f6cbb41d7b436bb54d28
Message-ID: <636128af.30YQ/0oOSz5nEVVu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: 00ed1eabcc3b785aecf6f6cbb41d7b436bb54d28  x86/espfix: Use get_random_long() rather than archrandom

elapsed time: 727m

configs tested: 134
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a016-20221031
i386                 randconfig-a012-20221031
i386                 randconfig-a015-20221031
i386                 randconfig-a013-20221031
i386                 randconfig-a014-20221031
i386                 randconfig-a011-20221031
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
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
x86_64               randconfig-k001-20221031
x86_64               randconfig-a016-20221031
x86_64               randconfig-a011-20221031
x86_64               randconfig-a013-20221031
x86_64               randconfig-a012-20221031
x86_64               randconfig-a014-20221031
x86_64               randconfig-a015-20221031
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allmodconfig
powerpc                           allnoconfig
m68k                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                              ul2_defconfig
powerpc                 mpc8540_ads_defconfig
openrisc                       virt_defconfig
powerpc                 canyonlands_defconfig
mips                             allyesconfig
sh                               allmodconfig
powerpc                         wii_defconfig
sh                           sh2007_defconfig
arm                         lubbock_defconfig
powerpc                      chrp32_defconfig
m68k                                defconfig
arm                            mps2_defconfig
m68k                       m5208evb_defconfig
powerpc                      bamboo_defconfig
nios2                         10m50_defconfig
sparc64                          alldefconfig
openrisc                    or1ksim_defconfig
powerpc                        warp_defconfig
m68k                            q40_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     tqm8555_defconfig
um                               alldefconfig
mips                            ar7_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
xtensa                           alldefconfig
loongarch                 loongson3_defconfig
i386                 randconfig-c001-20221031
mips                           jazz_defconfig
arm                           tegra_defconfig
mips                 decstation_r4k_defconfig
arm                          lpd270_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
mips                 randconfig-c004-20221031
arm                        mini2440_defconfig
powerpc                      mgcoge_defconfig
powerpc                 mpc834x_itx_defconfig
mips                       bmips_be_defconfig
mips                         db1xxx_defconfig
arm                          pxa910_defconfig
xtensa                generic_kc705_defconfig
m68k                            mac_defconfig
mips                            gpr_defconfig
i386                          randconfig-c001
sparc                             allnoconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                       common_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig

clang tested configs:
riscv                randconfig-r042-20221101
hexagon              randconfig-r041-20221101
hexagon              randconfig-r045-20221101
s390                 randconfig-r044-20221101
arm                       netwinder_defconfig
arm                  colibri_pxa270_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                   bluestone_defconfig
arm                        magician_defconfig
arm                     am200epdkit_defconfig
arm                       spear13xx_defconfig
x86_64               randconfig-a005-20221031
x86_64               randconfig-a006-20221031
x86_64               randconfig-a004-20221031
x86_64               randconfig-a001-20221031
x86_64               randconfig-a003-20221031
x86_64               randconfig-a002-20221031
x86_64               randconfig-c007-20221031
riscv                randconfig-c006-20221031
i386                 randconfig-c001-20221031
powerpc              randconfig-c003-20221031
mips                 randconfig-c004-20221031
arm                  randconfig-c002-20221031
s390                 randconfig-c005-20221031
mips                        bcm63xx_defconfig
powerpc                          allyesconfig
arm                    vt8500_v6_v7_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
