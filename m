Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2F260BE68
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiJXXSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiJXXRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:17:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A199A2E16FE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666647504; x=1698183504;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0wdeCE3pOaMuQxowEXR4RnGABmZmI4AFm7slisYG+o0=;
  b=eYA6jNFMfzwmZRphd5px56GAj5fm5WjMAC0+h3qBgI4rCHi8gU6Ix1M2
   QKkI4i8C5gsf7FUh4QQj5xjjJxpsTlcBvyc4+mwBSCvgyDmLVjLloEPLG
   VekYQysBpZLfbLqKBO3u7IVnZTAMfkJhMVkBUh57Owtu7VuF/x3sw1qor
   dSwySTJUycTIdJeuyDKg1OXHvcCdJ3FJIolNcZ759C6UJBRJ4jWP7YQfk
   3jlydzHWXAO0FxrGnRuqTwRDUPuiK/c4/wfHzB2hzJng7RUpqbj0rs+ku
   CkwZE5qM454MDrluqe7Y6ZEYpvmJ0hl1Ps6x5NbdX7TNy/lpqaEeWxIpO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="290831520"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="290831520"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 14:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="582551141"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="582551141"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 24 Oct 2022 14:37:51 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1on58o-0005gB-2b;
        Mon, 24 Oct 2022 21:37:50 +0000
Date:   Tue, 25 Oct 2022 05:37:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 2d4daa549c17b6ba4845a751c7a78d3b2419d78f
Message-ID: <635705ab.GpxOIOyuFrMnwiVj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: 2d4daa549c17b6ba4845a751c7a78d3b2419d78f  x86/resctrl: Remove arch_has_empty_bitmaps

elapsed time: 723m

configs tested: 120
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
x86_64                          rhel-8.3-func
arc                                 defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
alpha                               defconfig
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
s390                             allmodconfig
x86_64                               rhel-8.3
s390                                defconfig
x86_64                           allyesconfig
i386                                defconfig
s390                             allyesconfig
mips                             allyesconfig
arm                                 defconfig
sh                               allmodconfig
powerpc                          allmodconfig
i386                             allyesconfig
x86_64                        randconfig-a013
i386                 randconfig-a011-20221024
x86_64                        randconfig-a011
i386                 randconfig-a015-20221024
i386                 randconfig-a014-20221024
x86_64                        randconfig-a015
i386                 randconfig-a013-20221024
arc                  randconfig-r043-20221024
i386                 randconfig-a012-20221024
riscv                randconfig-r042-20221024
arm                              allyesconfig
i386                 randconfig-a016-20221024
arm64                            allyesconfig
s390                 randconfig-r044-20221024
ia64                             allmodconfig
x86_64               randconfig-k001-20221024
mips                        bcm47xx_defconfig
powerpc                       eiger_defconfig
arc                  randconfig-r043-20221023
i386                             alldefconfig
mips                           jazz_defconfig
sh                           se7206_defconfig
powerpc                   motionpro_defconfig
sh                        sh7757lcr_defconfig
powerpc                        cell_defconfig
loongarch                        alldefconfig
sh                          polaris_defconfig
powerpc                 mpc8540_ads_defconfig
arc                      axs103_smp_defconfig
x86_64               randconfig-a014-20221024
x86_64               randconfig-a015-20221024
x86_64               randconfig-a016-20221024
x86_64               randconfig-a013-20221024
x86_64               randconfig-a012-20221024
x86_64               randconfig-a011-20221024
sparc64                             defconfig
sh                          sdk7786_defconfig
powerpc                      tqm8xx_defconfig
csky                             alldefconfig
powerpc                 mpc837x_rdb_defconfig
openrisc                            defconfig
arm                        mini2440_defconfig
parisc                generic-64bit_defconfig
sh                           se7712_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                 randconfig-c001-20221024
powerpc                     tqm8555_defconfig
sh                          lboxre2_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-c001
sh                         ecovec24_defconfig
m68k                            mac_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                        spear6xx_defconfig
powerpc                 mpc834x_mds_defconfig
mips                            gpr_defconfig
m68k                            q40_defconfig
m68k                        m5307c3_defconfig
powerpc                      cm5200_defconfig

clang tested configs:
x86_64                        randconfig-a012
hexagon              randconfig-r045-20221023
x86_64               randconfig-a001-20221024
hexagon              randconfig-r041-20221024
i386                 randconfig-a001-20221024
x86_64                        randconfig-a014
riscv                randconfig-r042-20221023
x86_64               randconfig-a005-20221024
x86_64                        randconfig-a016
i386                 randconfig-a002-20221024
x86_64               randconfig-a003-20221024
hexagon              randconfig-r045-20221024
x86_64               randconfig-a006-20221024
x86_64               randconfig-a004-20221024
i386                 randconfig-a005-20221024
x86_64               randconfig-a002-20221024
i386                 randconfig-a003-20221024
s390                 randconfig-r044-20221023
i386                 randconfig-a004-20221024
i386                 randconfig-a006-20221024
hexagon              randconfig-r041-20221023
powerpc                  mpc885_ads_defconfig
mips                           rs90_defconfig
arm                        mvebu_v5_defconfig
powerpc                 mpc832x_mds_defconfig
arm                        multi_v5_defconfig
arm                       spear13xx_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
