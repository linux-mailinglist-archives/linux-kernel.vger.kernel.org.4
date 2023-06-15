Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA5D7323C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbjFOXnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjFOXm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:42:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F32944
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686872578; x=1718408578;
  h=date:from:to:cc:subject:message-id;
  bh=BJ/ssBNFgWM7KZS10OeD86abJ6flUdX01zEfyZEWLrA=;
  b=IgaRbTpCb9zW1Jz21kqRAVVFbzriAB6nkFUIF5e4uqcw1SjZXi6Wyd/C
   SyY0i6GGtA5BpxGBP9TzWejKVejdiY+Ueoe+1Fx1phFYpe15oTWAUlhE+
   Fh5kONrpQ4glfZg0N8kqwRUeJi/DCppPCc67XqY9j31QfCWPXPilmkM8z
   SOcDRYgoZVzLv+68NXZ2WG/2sgdu97bJFvQjHEQ8OFp1hEevIv3/wuAmB
   IzOSFbmZ/rnntVv8cCX0+Y2h+eRQV95Zyw0SZAG7jsiS0cT8Kb6yxGYoD
   bn0rfGUxPMtk/nKlP7BMvGA+GrHdEMiMIuxblVgSGRvTktW0m4q4e/Vrs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="348775886"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="348775886"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 16:42:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="742430926"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="742430926"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 15 Jun 2023 16:42:56 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9wcC-0000WP-0e;
        Thu, 15 Jun 2023 23:42:56 +0000
Date:   Fri, 16 Jun 2023 07:42:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 4b85308dac750b16bd273b0f4e9c9b478fbb886b
Message-ID: <202306160716.H8tNgV4k-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 4b85308dac750b16bd273b0f4e9c9b478fbb886b  sched/wait: Fix a kthread_park race with wait_woken()

elapsed time: 728m

configs tested: 151
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230615   gcc  
arc                  randconfig-r043-20230615   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                          gemini_defconfig   gcc  
arm                  randconfig-r021-20230615   gcc  
arm                  randconfig-r046-20230615   gcc  
arm                         s5pv210_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230615   gcc  
csky                 randconfig-r005-20230615   gcc  
csky                 randconfig-r006-20230615   gcc  
csky                 randconfig-r012-20230614   gcc  
csky                 randconfig-r034-20230615   gcc  
hexagon      buildonly-randconfig-r002-20230615   clang
hexagon              randconfig-r024-20230615   clang
hexagon              randconfig-r041-20230615   clang
hexagon              randconfig-r045-20230615   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r005-20230614   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230614   clang
i386                 randconfig-i001-20230615   gcc  
i386                 randconfig-i002-20230614   clang
i386                 randconfig-i002-20230615   gcc  
i386                 randconfig-i003-20230614   clang
i386                 randconfig-i003-20230615   gcc  
i386                 randconfig-i004-20230614   clang
i386                 randconfig-i004-20230615   gcc  
i386                 randconfig-i005-20230614   clang
i386                 randconfig-i005-20230615   gcc  
i386                 randconfig-i006-20230614   clang
i386                 randconfig-i006-20230615   gcc  
i386                 randconfig-i011-20230615   clang
i386                 randconfig-i012-20230615   clang
i386                 randconfig-i013-20230615   clang
i386                 randconfig-i014-20230615   clang
i386                 randconfig-i015-20230615   clang
i386                 randconfig-i016-20230615   clang
i386                 randconfig-r004-20230615   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r014-20230614   gcc  
loongarch            randconfig-r015-20230614   gcc  
loongarch            randconfig-r022-20230615   gcc  
loongarch            randconfig-r034-20230615   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230615   gcc  
m68k                           virt_defconfig   gcc  
microblaze   buildonly-randconfig-r002-20230614   gcc  
microblaze           randconfig-r023-20230615   gcc  
microblaze           randconfig-r025-20230615   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                        omega2p_defconfig   clang
nios2        buildonly-randconfig-r003-20230614   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r032-20230615   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r001-20230614   gcc  
parisc       buildonly-randconfig-r004-20230614   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r023-20230615   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                     kilauea_defconfig   clang
powerpc                      makalu_defconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc              randconfig-r011-20230614   gcc  
powerpc              randconfig-r033-20230615   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r001-20230615   clang
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230615   gcc  
riscv                randconfig-r014-20230614   gcc  
riscv                randconfig-r015-20230614   gcc  
riscv                randconfig-r042-20230615   clang
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230615   gcc  
s390                 randconfig-r011-20230614   gcc  
s390                 randconfig-r012-20230614   gcc  
s390                 randconfig-r026-20230615   clang
s390                 randconfig-r033-20230615   gcc  
s390                 randconfig-r044-20230615   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230614   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                   randconfig-r024-20230615   gcc  
sh                   randconfig-r025-20230615   gcc  
sh                   randconfig-r031-20230615   gcc  
sh                   randconfig-r035-20230615   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r036-20230615   gcc  
sparc64              randconfig-r001-20230615   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230614   clang
x86_64               randconfig-a001-20230615   gcc  
x86_64               randconfig-a002-20230614   clang
x86_64               randconfig-a002-20230615   gcc  
x86_64               randconfig-a003-20230614   clang
x86_64               randconfig-a003-20230615   gcc  
x86_64               randconfig-a004-20230614   clang
x86_64               randconfig-a004-20230615   gcc  
x86_64               randconfig-a005-20230614   clang
x86_64               randconfig-a005-20230615   gcc  
x86_64               randconfig-a006-20230614   clang
x86_64               randconfig-a006-20230615   gcc  
x86_64               randconfig-a011-20230615   clang
x86_64               randconfig-a012-20230615   clang
x86_64               randconfig-a013-20230615   clang
x86_64               randconfig-a014-20230615   clang
x86_64               randconfig-a015-20230615   clang
x86_64               randconfig-a016-20230615   clang
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                       common_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa               randconfig-r006-20230615   gcc  
xtensa               randconfig-r016-20230614   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
