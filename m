Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AB6626784
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 07:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbiKLGjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 01:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbiKLGjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 01:39:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FCF1A82A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668235177; x=1699771177;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Pa2XvA2u2i8BhkIu3tuLakvF1eA2XXZbbcFYeMrEwYQ=;
  b=F28qs5GfW/+c3b6LK+wrm6kvCK4VII6cXaZk3L+CKGEWx5xVxKUKpyiH
   zCU4o1faMG/nh36+0tbK9pj/0sG8DVyUC2MCSqzSOqW26xqu1UVt/a8Jb
   r5QtuiDmlh83pe2QPhJTs8or6ywJjLQRe4PtELRpJINzYG02Hf+8b+yvE
   7K8Oq/xw9uG2XGwUSbyMp6haHZ1HzHfrsLRjKV+GesF0omftH/rRlRo65
   RwGfiocwjsEXWXjMTieDcNAMS3odO4mysOQEWLxJz22fSpXlrT05PxLPa
   fbk214sqjR6tkrr4iLevHgFRZvWpsV9USH5EEEB/DGujNRBHeXQZ1NhsE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="338483545"
X-IronPort-AV: E=Sophos;i="5.96,158,1665471600"; 
   d="scan'208";a="338483545"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 22:39:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="726976872"
X-IronPort-AV: E=Sophos;i="5.96,158,1665471600"; 
   d="scan'208";a="726976872"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Nov 2022 22:39:36 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otkAx-0004eb-0b;
        Sat, 12 Nov 2022 06:39:35 +0000
Date:   Sat, 12 Nov 2022 14:39:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 dacca1e5e75d7c1297f1334cdc10491dcdd1b2b8
Message-ID: <636f3f8d.ek7TJj0KPP9Ns+vK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: dacca1e5e75d7c1297f1334cdc10491dcdd1b2b8  x86/acpi/cstate: Optimize ARB_DISABLE on Centaur CPUs

elapsed time: 753m

configs tested: 86
configs skipped: 76

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
s390                 randconfig-r044-20221111
riscv                randconfig-r042-20221111
arc                  randconfig-r043-20221111
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                             allyesconfig
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm                       imx_v6_v7_defconfig
mips                 decstation_r4k_defconfig
arm                        oxnas_v6_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
ia64                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-c001
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arm                         axm55xx_defconfig
parisc                           alldefconfig
parisc64                            defconfig
openrisc                            defconfig
openrisc                  or1klitex_defconfig
m68k                       m5208evb_defconfig
mips                           jazz_defconfig
mips                      loongson3_defconfig
powerpc                      cm5200_defconfig
mips                 randconfig-c004-20221111
powerpc                      ppc40x_defconfig
arm                        mvebu_v7_defconfig
powerpc                     tqm8541_defconfig
sh                            hp6xx_defconfig
arc                          axs103_defconfig
powerpc                     asp8347_defconfig

clang tested configs:
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
riscv                            alldefconfig
powerpc                      ppc44x_defconfig
mips                           rs90_defconfig
arm                          sp7021_defconfig
powerpc                 mpc8560_ads_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-k001
powerpc                  mpc885_ads_defconfig
hexagon              randconfig-r041-20221111
hexagon              randconfig-r045-20221111
arm                           omap1_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc8272_ads_defconfig
mips                           ip27_defconfig
riscv                    nommu_virt_defconfig
arm                       cns3420vb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
