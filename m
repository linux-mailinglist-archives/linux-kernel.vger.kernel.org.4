Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3016C8AD5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 05:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjCYEax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 00:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjCYEav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 00:30:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE73C155
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 21:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679718650; x=1711254650;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ssbOC2FzDIfMVgwuhnjN394iA7TgATOIVGTfm7GS7Rg=;
  b=LlkAkMkAdkiLG0aIKq886PYMRImjayRy2R3IJTGYTYr5MMk9tuXKp3h9
   BfyVzY16m0wVu8H2WrpVwWcdK3earUBpDO3QwPJphjpez6e+u9BJChcYf
   mNI8Zz+nxuW3xKaKMIXoJNSFZq1gCooLwTkGtw21uuwXCgYu3R6nSsYcg
   E9hT0bD0g7OxAWPkdL89a2xCxsaZFBSE2lu9UHI3APJYn7UoqFTalgmE4
   yCC8nXGNo2Ork968tB34eiEbkJMivdAWjFZi2f00PJccupW/wNmbX3Fh6
   0SmMWg60Eh2tmYy+WtagYngoeYH34sxLvETQ1WIB7vkUcq2n78vpFW9Uk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="323817551"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="323817551"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 21:30:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="676394701"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="676394701"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Mar 2023 21:30:47 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfvYE-000Fww-1M;
        Sat, 25 Mar 2023 04:30:46 +0000
Date:   Sat, 25 Mar 2023 12:30:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:srcu-cf.2023.03.23a] BUILD SUCCESS WITH WARNING
 2702cd85a0c4744f1d272ff574294e7e1e4102e0
Message-ID: <641e78c9.uDWlBzL+saTCCqcz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git srcu-cf.2023.03.23a
branch HEAD: 2702cd85a0c4744f1d272ff574294e7e1e4102e0  srcu: Check for readers at module-exit time

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303241725.0RIyOS2U-lkp@intel.com

Warning: (recently discovered and may have been fixed)

kernel/rcu/tasks.h:140:20: warning: 'tasks_rcu_exit_srcu' defined but not used [-Wunused-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-debian-10.3
|   `-- kernel-rcu-tasks.h:warning:tasks_rcu_exit_srcu-defined-but-not-used
|-- x86_64-kexec
|   `-- kernel-rcu-tasks.h:warning:tasks_rcu_exit_srcu-defined-but-not-used
`-- x86_64-rhel-8.3
    `-- kernel-rcu-tasks.h:warning:tasks_rcu_exit_srcu-defined-but-not-used

elapsed time: 731m

configs tested: 114
configs skipped: 11

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230322   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230322   gcc  
arc                  randconfig-r035-20230322   gcc  
arc                  randconfig-r043-20230322   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230322   gcc  
arm                  randconfig-r046-20230322   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r025-20230322   gcc  
arm64                randconfig-r031-20230322   clang
csky                                defconfig   gcc  
csky                 randconfig-r011-20230322   gcc  
csky                 randconfig-r012-20230322   gcc  
csky                 randconfig-r016-20230322   gcc  
hexagon              randconfig-r026-20230322   clang
hexagon              randconfig-r031-20230322   clang
hexagon              randconfig-r041-20230322   clang
hexagon              randconfig-r045-20230322   clang
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
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230322   gcc  
loongarch            randconfig-r006-20230322   gcc  
loongarch            randconfig-r011-20230322   gcc  
loongarch            randconfig-r032-20230322   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r002-20230322   gcc  
microblaze           randconfig-r036-20230322   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230322   gcc  
nios2                randconfig-r034-20230322   gcc  
nios2                randconfig-r036-20230322   gcc  
openrisc             randconfig-r013-20230322   gcc  
openrisc             randconfig-r015-20230322   gcc  
parisc       buildonly-randconfig-r006-20230322   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230322   gcc  
parisc               randconfig-r034-20230322   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230322   gcc  
powerpc              randconfig-r012-20230322   gcc  
powerpc              randconfig-r013-20230322   gcc  
powerpc              randconfig-r035-20230322   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230322   clang
riscv                randconfig-r004-20230322   clang
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230322   gcc  
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sparc        buildonly-randconfig-r001-20230322   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230322   gcc  
sparc64              randconfig-r001-20230322   gcc  
sparc64              randconfig-r024-20230322   gcc  
sparc64              randconfig-r031-20230322   gcc  
sparc64              randconfig-r033-20230322   gcc  
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
xtensa               randconfig-r022-20230322   gcc  
xtensa               randconfig-r032-20230322   gcc  
xtensa               randconfig-r035-20230322   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
