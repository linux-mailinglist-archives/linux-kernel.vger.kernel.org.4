Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429026407E6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiLBNqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiLBNqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:46:17 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AD1D3DE5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 05:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669988777; x=1701524777;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RNVI3hqmIYQOnuT+7ObeBiNqmwX3ljUlYRZt7UFIc18=;
  b=WG7ZhmYEDB+8sVGCflGqvpFds84Crop2eSYfrzPG7CzoJsXFP3+8o2ZW
   ndLnPx8V6EOhWlVW0dM/5Fqy+R985Cgtg+cnH1ZfLWIxGQa7heRGpkwoV
   DpCKYETpLIN/vp7sp2yR3pPRQTt32FPAy3U3ZaEzL27dAs8Fw/w18dzuZ
   LCbERoB2iklQbztq7BPSMLCcEj7tQxtJJjO5Ycm3cQP8T2HH5WC8uKjZC
   xtvTvB01K6nWVqSKqM6NSTLMDRCjNeJcBUb+XLq53ZDfwb6MWw1q41D2T
   0K9JFxm1B04cZDJ/1f/BluaEJc7XNb5ZVrdHZk/GMTZktcePTGIUdOEJH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="378107963"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="378107963"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 05:46:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="890151090"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="890151090"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Dec 2022 05:46:15 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p16Mo-000Dhr-2H;
        Fri, 02 Dec 2022 13:46:14 +0000
Date:   Fri, 02 Dec 2022 21:46:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.11.30a] BUILD SUCCESS
 033ddc5d337984e20b9d49c8af4faa4689727626
Message-ID: <638a0199.7pbCpdbQuf9CARsX%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.11.30a
branch HEAD: 033ddc5d337984e20b9d49c8af4faa4689727626  rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug

elapsed time: 2187m

configs tested: 103
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
arm                                 defconfig
x86_64                            allnoconfig
arc                        nsim_700_defconfig
arm                           h3600_defconfig
sparc                       sparc64_defconfig
alpha                             allnoconfig
sh                 kfr2r09-romimage_defconfig
powerpc                       holly_defconfig
m68k                          hp300_defconfig
sh                          r7785rp_defconfig
powerpc                 mpc837x_rdb_defconfig
xtensa                       common_defconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
arm                  randconfig-c002-20221201
x86_64                        randconfig-c001
um                             i386_defconfig
um                           x86_64_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
ia64                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                              defconfig
i386                             allyesconfig
arc                  randconfig-r043-20221201
x86_64                               rhel-8.3
riscv                randconfig-r042-20221201
x86_64                           allyesconfig
s390                 randconfig-r044-20221201
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a005
xtensa                           alldefconfig
microblaze                          defconfig
powerpc                      arches_defconfig
powerpc                      tqm8xx_defconfig

clang tested configs:
s390                 randconfig-r044-20221128
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
hexagon              randconfig-r045-20221128
x86_64                        randconfig-k001
arm                  randconfig-c002-20221201
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20221201
riscv                randconfig-c006-20221201
mips                 randconfig-c004-20221201
s390                 randconfig-c005-20221201
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
hexagon              randconfig-r041-20221201
hexagon              randconfig-r045-20221201
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
