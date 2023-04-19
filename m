Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1866E83FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjDSVyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjDSVyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:54:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7904ED0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681941246; x=1713477246;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=H93QXBCBKIVh0Qnv7AD5uKLYmNj2JxjW3eLh9IFk17w=;
  b=YIjShG1KRyB36zDq1fq/kx2LguBTIitfZHVB7YuhTxWnJ4RPMq5Bjh/H
   cHPeeVkr3pCg5Ycmw/ltS/v2u8f2f2m+sgWY+GN4cLYm6WHT0SBuHudWA
   ncJp+MBX0ZqAMeGRKdAovfKWA2O3UIvXmnscjeI8bZ+ackdv+gvZXgwvo
   m/XSkVKmKpMz+YCG7KKJzluHgOIvRsQ1p8pf3ucN8qtFPNF3WcbV3r4B6
   hUGpGaUlcRy84J1Zqby+D27TRvdWdUnhTM1kxMiN3F/18Ir31pKkOsO6R
   x3zaATFbJ65RKgaJWjnV/Gr9JCwOnWLEST9qZnvKPBWX1ZL8EM4fLGrus
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="325180113"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="325180113"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 14:54:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="835466810"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="835466810"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 19 Apr 2023 14:54:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppFka-000fDm-2b;
        Wed, 19 Apr 2023 21:54:04 +0000
Date:   Thu, 20 Apr 2023 05:53:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD REGRESSION
 1bb5b68fd3aabb6b9d6b9e9bb092bb8f3c2ade62
Message-ID: <644062c1.G7M9lFvZ3U0pK0Jv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 1bb5b68fd3aabb6b9d6b9e9bb092bb8f3c2ade62  posix-cpu-timers: Implement the missing timer_wait_running callback

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202304200309.F6HbUeCE-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

kernel/time/posix-cpu-timers.c:1310:19: error: use of undeclared identifier 'timer'

Error/Warning ids grouped by kconfigs:

clang_recent_errors
|-- arm-randconfig-r046-20230416
|   `-- kernel-time-posix-cpu-timers.c:error:use-of-undeclared-identifier-timer
|-- powerpc-randconfig-r002-20230418
|   `-- kernel-time-posix-cpu-timers.c:error:use-of-undeclared-identifier-timer
`-- s390-randconfig-r003-20230418
    `-- kernel-time-posix-cpu-timers.c:error:use-of-undeclared-identifier-timer

elapsed time: 727m

configs tested: 83
configs skipped: 5

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r022-20230417   gcc  
arc                  randconfig-r024-20230417   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230418   clang
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230417   gcc  
arm64        buildonly-randconfig-r005-20230417   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r041-20230417   clang
hexagon              randconfig-r041-20230418   clang
hexagon              randconfig-r045-20230416   clang
hexagon              randconfig-r045-20230417   clang
hexagon              randconfig-r045-20230418   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r021-20230417   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
parisc       buildonly-randconfig-r002-20230416   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r026-20230417   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230417   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230417   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230417   gcc  
sh           buildonly-randconfig-r005-20230416   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sparc        buildonly-randconfig-r003-20230417   gcc  
sparc                               defconfig   gcc  
sparc64      buildonly-randconfig-r006-20230416   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230417   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r003-20230416   gcc  
xtensa               randconfig-r025-20230417   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
