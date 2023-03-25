Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931F66C8CEF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 10:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjCYJZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 05:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjCYJZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 05:25:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A2714996
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 02:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679736303; x=1711272303;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Pd9FEKw/aGh6o8/jcSmsAE5fvN7L1A8mBnRM7L0qOSo=;
  b=b7cl+3hVld/Prk8WoafZsze9HP577/YodHoSUAWHtI6GS+6mmwhfJkRW
   DiKWLXCfrEnTK4Mrj1T11eilHBNRyY1sgKeElcaENX0t/z7jDkWIpeari
   wCuOw4ISFVGkxqnNjY8gvyT/GM+DqieOfFbDiGdvr0Wrgx5xoe8s8O0lf
   ngCqIiXPJQpHYB80vVtvN37XIU1Vvx0bfQyYmkGxsJmOPKeKLkOy5Z7Sg
   LHp4TYeSMZiJ6kJj+iBq36QZr5jC8OSE/CNZQTQuNkdHgRz2j3W5q9Ad0
   8IJIF+hdk6rB5evVDj4jjSjJuGhBB+MZ+ROG3OkcWDepAMmYS4VBU+B+Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="338676644"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="338676644"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 02:25:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="826514328"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="826514328"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2023 02:25:01 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pg08t-000G9R-30;
        Sat, 25 Mar 2023 09:24:55 +0000
Date:   Sat, 25 Mar 2023 17:24:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 e25da1d1376652996425e3596330554434a8d650
Message-ID: <641ebdce.g3CA4k9/jIKCsvgS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: e25da1d1376652996425e3596330554434a8d650  Revert "rcu/kvfree: Eliminate k[v]free_rcu() single argument macro"

elapsed time: 726m

configs tested: 188
configs skipped: 17

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230322   gcc  
alpha                randconfig-r021-20230322   gcc  
alpha                randconfig-r026-20230322   gcc  
alpha                randconfig-r036-20230324   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230322   gcc  
arc                  randconfig-r001-20230323   gcc  
arc                  randconfig-r013-20230323   gcc  
arc                  randconfig-r023-20230322   gcc  
arc                  randconfig-r023-20230323   gcc  
arc                  randconfig-r025-20230324   gcc  
arc                  randconfig-r034-20230322   gcc  
arc                  randconfig-r043-20230322   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230322   clang
arm          buildonly-randconfig-r003-20230324   clang
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230322   gcc  
arm                  randconfig-r021-20230322   clang
arm                  randconfig-r046-20230322   clang
arm                  randconfig-r046-20230324   clang
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230322   clang
arm64        buildonly-randconfig-r006-20230322   clang
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230322   gcc  
arm64                randconfig-r023-20230322   gcc  
arm64                randconfig-r035-20230324   clang
csky                                defconfig   gcc  
csky                 randconfig-r011-20230322   gcc  
csky                 randconfig-r012-20230322   gcc  
csky                 randconfig-r016-20230322   gcc  
hexagon      buildonly-randconfig-r004-20230322   clang
hexagon      buildonly-randconfig-r006-20230323   clang
hexagon              randconfig-r002-20230322   clang
hexagon              randconfig-r004-20230322   clang
hexagon              randconfig-r014-20230322   clang
hexagon              randconfig-r031-20230322   clang
hexagon              randconfig-r035-20230322   clang
hexagon              randconfig-r041-20230322   clang
hexagon              randconfig-r041-20230324   clang
hexagon              randconfig-r045-20230322   clang
hexagon              randconfig-r045-20230324   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r003-20230323   gcc  
ia64                 randconfig-r011-20230322   gcc  
ia64                 randconfig-r013-20230322   gcc  
ia64                 randconfig-r014-20230323   gcc  
ia64                 randconfig-r016-20230322   gcc  
ia64                 randconfig-r022-20230324   gcc  
ia64                 randconfig-r031-20230322   gcc  
ia64                 randconfig-r031-20230324   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230322   gcc  
loongarch            randconfig-r006-20230322   gcc  
loongarch            randconfig-r014-20230322   gcc  
loongarch            randconfig-r016-20230322   gcc  
loongarch            randconfig-r021-20230322   gcc  
loongarch            randconfig-r032-20230322   gcc  
loongarch            randconfig-r033-20230324   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230322   gcc  
m68k                 randconfig-r023-20230322   gcc  
m68k                 randconfig-r026-20230322   gcc  
microblaze   buildonly-randconfig-r002-20230322   gcc  
microblaze           randconfig-r015-20230322   gcc  
microblaze           randconfig-r021-20230322   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r023-20230322   clang
mips                 randconfig-r036-20230322   gcc  
nios2        buildonly-randconfig-r002-20230324   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230322   gcc  
nios2                randconfig-r024-20230323   gcc  
nios2                randconfig-r026-20230322   gcc  
nios2                randconfig-r036-20230322   gcc  
openrisc             randconfig-r011-20230323   gcc  
openrisc             randconfig-r015-20230322   gcc  
openrisc             randconfig-r022-20230322   gcc  
openrisc             randconfig-r026-20230323   gcc  
parisc       buildonly-randconfig-r006-20230322   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230323   gcc  
parisc               randconfig-r011-20230322   gcc  
parisc               randconfig-r012-20230323   gcc  
parisc               randconfig-r016-20230322   gcc  
parisc               randconfig-r021-20230323   gcc  
parisc               randconfig-r024-20230322   gcc  
parisc               randconfig-r025-20230322   gcc  
parisc               randconfig-r032-20230324   gcc  
parisc               randconfig-r034-20230322   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230322   gcc  
powerpc              randconfig-r004-20230323   gcc  
powerpc              randconfig-r013-20230322   gcc  
powerpc              randconfig-r025-20230322   gcc  
powerpc              randconfig-r034-20230324   clang
powerpc              randconfig-r035-20230322   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230324   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230322   clang
riscv                randconfig-r024-20230322   gcc  
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230323   clang
s390         buildonly-randconfig-r006-20230324   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230322   gcc  
s390                 randconfig-r016-20230322   gcc  
s390                 randconfig-r031-20230322   clang
s390                 randconfig-r035-20230322   clang
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230324   gcc  
sh                   randconfig-r012-20230322   gcc  
sh                   randconfig-r013-20230322   gcc  
sh                   randconfig-r022-20230323   gcc  
sh                   randconfig-r024-20230322   gcc  
sparc        buildonly-randconfig-r001-20230322   gcc  
sparc        buildonly-randconfig-r005-20230324   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230322   gcc  
sparc                randconfig-r006-20230323   gcc  
sparc                randconfig-r015-20230322   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r001-20230322   gcc  
sparc64              randconfig-r016-20230323   gcc  
sparc64              randconfig-r022-20230322   gcc  
sparc64              randconfig-r024-20230324   gcc  
sparc64              randconfig-r026-20230322   gcc  
sparc64              randconfig-r031-20230322   gcc  
sparc64              randconfig-r035-20230322   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r011-20230322   gcc  
xtensa               randconfig-r014-20230322   gcc  
xtensa               randconfig-r015-20230322   gcc  
xtensa               randconfig-r035-20230322   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
