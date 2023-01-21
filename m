Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5406769BD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 23:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjAUWDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 17:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAUWDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 17:03:49 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C570718B3B
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 14:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674338628; x=1705874628;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=NxYjfDxBfKqXdjyHriqsu8dGVF210TRMFy1dcMCSIAk=;
  b=LXwS5WIpIGBT/PpGkQCrAZtj+Pbccf1iHu9FfYvyg9AZg5eYQTnMWggV
   CH8izyzuWjkhA4XMjT30ETBL+mgKqX1wbD8ZoOkskPymNJci5SpDAJ+HU
   UnzHMR7YCYRWtnwEqmGEHRqQiMhqqXbFdYfGnxVHKWnOFohnTWMqJjUAX
   BbYzjTgDvKNtYGmZJ3Jqut8uxFrhu/IsWwrQovor+/F7Ei/VFatEpS9OA
   CemSKWxmBehCP2ff35N1pXLKGs0Em0EOc6VrEuJ6woj/8zLG37amTRZBU
   rYI1P1SN9IuByMANRaYC4/1031cFwXachEwiyDZ+jEljPDCBXtprctYAI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="313728583"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="313728583"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 14:03:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="906353714"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="906353714"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jan 2023 14:03:47 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJLxi-0004Vi-15;
        Sat, 21 Jan 2023 22:03:46 +0000
Date:   Sun, 22 Jan 2023 06:02:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 001c28e57187570e4b5aa4492c7a957fb6d65d7b
Message-ID: <63cc610a.eJnW2XXs01UsvO1B%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 001c28e57187570e4b5aa4492c7a957fb6d65d7b  exit: Detect and fix irq disabled state in oops

elapsed time: 723m

configs tested: 92
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                          randconfig-a001
i386                          randconfig-a003
arc                                 defconfig
alpha                               defconfig
x86_64                            allnoconfig
i386                          randconfig-a005
s390                             allmodconfig
s390                                defconfig
i386                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
m68k                             allyesconfig
sh                               allmodconfig
m68k                             allmodconfig
arm                                 defconfig
arc                              allyesconfig
x86_64                        randconfig-a004
arm                  randconfig-r046-20230119
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
mips                             allyesconfig
x86_64                        randconfig-a002
s390                             allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
arc                  randconfig-r043-20230119
i386                          randconfig-a014
x86_64                        randconfig-a013
x86_64                        randconfig-a006
x86_64                        randconfig-a011
i386                          randconfig-a012
powerpc                          allmodconfig
i386                          randconfig-a016
arm64                            allyesconfig
x86_64                        randconfig-a015
arm                              allyesconfig
sparc                       sparc32_defconfig
arm                           stm32_defconfig
arm64                            alldefconfig
arm                          exynos_defconfig
sh                        sh7757lcr_defconfig
i386                          randconfig-c001
arc                        vdk_hs38_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                    xip_kc705_defconfig
powerpc                    klondike_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                  sh7785lcr_32bit_defconfig
sh                         ecovec24_defconfig
sh                          urquell_defconfig
m68k                       bvme6000_defconfig
sh                         ap325rxa_defconfig
alpha                            alldefconfig
sh                        sh7763rdp_defconfig
ia64                         bigsur_defconfig
xtensa                  cadence_csp_defconfig
powerpc                      arches_defconfig
sh                        dreamcast_defconfig
mips                             allmodconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a014
i386                          randconfig-a013
x86_64                        randconfig-a001
i386                          randconfig-a015
s390                 randconfig-r044-20230119
hexagon              randconfig-r045-20230119
i386                          randconfig-a011
riscv                randconfig-r042-20230119
x86_64                        randconfig-a003
x86_64                        randconfig-a016
hexagon              randconfig-r041-20230119
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-k001
mips                     cu1000-neo_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
