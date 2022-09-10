Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647E55B442C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 06:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiIJEgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 00:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIJEgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 00:36:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8026B5155
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 21:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662784600; x=1694320600;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uaaBUvok3KlZDwFIZL0F7OWg5jfQ2bA/z88nxKDa4iw=;
  b=mDMta9callX95X/Kqayu+bDYZ9vEYRdkfgqq9gDeboRiSZlOKonfMzT+
   rgJeY4SzQ8wpbgQQK0R0JTQYakHd0eq7eIu8HAu04EZqkOrKSBS+2JPwm
   ILCK+IrFwop+Bbm0Lrt5qIJxC2dHrTeJd7PpAddPM1+8Hx8nOCxo2i8hj
   gimLsRgJ/xCZ2M2qYXoeZ8TubaoK+MDAuILI5Vt2O1JQopUA0q/MX0Qu+
   9uq/YKUtlrcy8Tq6iPW2h/VmVYw4vLP21YvjDuqPCmbeMK8mjTIZOw/wW
   K93vOMKXKW4m73smGbPn1Sshg73WhEIT5zWNJMaEcyTLbwBtTuT2esvcs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="383909524"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="383909524"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 21:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="860620258"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 09 Sep 2022 21:36:39 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWsEL-00027c-2G;
        Sat, 10 Sep 2022 04:36:33 +0000
Date:   Sat, 10 Sep 2022 12:35:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 81fa6fd13b5c43601fba8486f2385dbd7c1935e2
Message-ID: <631c1429.GdwSpw5e3YKmGc9m%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 81fa6fd13b5c43601fba8486f2385dbd7c1935e2  x86/sgx: Handle VA page allocation failure for EAUG on PF.

elapsed time: 725m

configs tested: 99
configs skipped: 67

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
arm64                            allyesconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a012
arm                                 defconfig
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
sh                             espt_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                            mps2_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                        keystone_defconfig
x86_64                           alldefconfig
xtensa                    xip_kc705_defconfig
mips                    maltaup_xpa_defconfig
mips                      maltasmvp_defconfig
i386                          randconfig-c001
m68k                        m5407c3_defconfig
nios2                         3c120_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
mips                      fuloong2e_defconfig
arc                              alldefconfig
sh                              ul2_defconfig
arm                           sunxi_defconfig
arm                          exynos_defconfig
riscv                               defconfig
nios2                         10m50_defconfig
arm                            zeus_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                   secureedge5410_defconfig
arm                         lubbock_defconfig
sh                          rsk7264_defconfig
arm                          badge4_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
mips                     decstation_defconfig
sh                         ecovec24_defconfig
sh                           se7712_defconfig
sh                           se7750_defconfig
sh                          sdk7786_defconfig
arm                           h3600_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a002
riscv                randconfig-r042-20220909
hexagon              randconfig-r041-20220909
hexagon              randconfig-r045-20220909
s390                 randconfig-r044-20220909
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-k001
riscv                randconfig-r042-20220907
hexagon              randconfig-r041-20220907
hexagon              randconfig-r045-20220907
s390                 randconfig-r044-20220907
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
hexagon              randconfig-r041-20220908
hexagon              randconfig-r045-20220908

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
