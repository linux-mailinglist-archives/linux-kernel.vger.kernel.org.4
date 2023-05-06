Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2836F9102
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjEFJqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 05:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjEFJqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 05:46:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F3361BC
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 02:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683366374; x=1714902374;
  h=date:from:to:cc:subject:message-id;
  bh=oq7ONrSV1it95ufd2306WvSce4kRSrBQM6SELWA6ck0=;
  b=UOtwYU+eQxwWTkz89wzAw2uckxbmI0Ol1Fw256RiE7uKtAo6VRLuhrmv
   Q+VqleO1yN2UkDd7lsp3T/mTHRYK8cQAQF5ptYPCIbyiinqN3vdewxwLH
   NrjjeJrAGEaebI8AMC/occ5cMbR7w8uDVy9Xzunx7I2bAnNYupaZmYzfK
   m7+kV32MbMlANgMQiHwTrenDL4GdMI0Y1TkDndoTOFesjsgQpzvvN07To
   V5u4rE8EAjLRxWnY4SiKOisWCPNnkOba+hbeXEmJ+oySJOdieVkNxvHkx
   +f0R4iqaZU/m/cblvy+o7kxiQvcSpw9yVRbhcBW2ldARiATiXbjf1TGLm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="377449703"
X-IronPort-AV: E=Sophos;i="5.99,254,1677571200"; 
   d="scan'208";a="377449703"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 02:46:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="691989668"
X-IronPort-AV: E=Sophos;i="5.99,254,1677571200"; 
   d="scan'208";a="691989668"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 May 2023 02:46:12 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvEUR-00006N-0c;
        Sat, 06 May 2023 09:46:07 +0000
Date:   Sat, 06 May 2023 17:45:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.05.03a] BUILD SUCCESS
 d3d734216c88fb7c13205dc62178ff5011da415b
Message-ID: <20230506094543.OUsXC%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.05.03a
branch HEAD: d3d734216c88fb7c13205dc62178ff5011da415b  rcu: Add missing parentheses around rcu_dereference() "p" parameter

elapsed time: 722m

configs tested: 148
configs skipped: 18

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230502   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230430   gcc  
alpha                randconfig-r021-20230502   gcc  
alpha                randconfig-r022-20230501   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230502   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230501   gcc  
arc                  randconfig-r012-20230502   gcc  
arc                  randconfig-r025-20230430   gcc  
arc                  randconfig-r043-20230430   gcc  
arc                  randconfig-r043-20230501   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r013-20230502   clang
arm                  randconfig-r016-20230430   gcc  
arm                  randconfig-r022-20230430   gcc  
arm                  randconfig-r025-20230502   clang
arm                  randconfig-r046-20230430   gcc  
arm                  randconfig-r046-20230501   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230430   gcc  
arm64                randconfig-r026-20230502   gcc  
csky         buildonly-randconfig-r001-20230505   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230505   gcc  
csky                 randconfig-r003-20230501   gcc  
csky                 randconfig-r006-20230502   gcc  
csky                 randconfig-r021-20230430   gcc  
csky                 randconfig-r022-20230502   gcc  
hexagon              randconfig-r036-20230502   clang
hexagon              randconfig-r041-20230430   clang
hexagon              randconfig-r041-20230501   clang
hexagon              randconfig-r045-20230430   clang
hexagon              randconfig-r045-20230501   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230501   clang
i386                 randconfig-a012-20230501   clang
i386                 randconfig-a013-20230501   clang
i386                 randconfig-a014-20230501   clang
i386                 randconfig-a015-20230501   clang
i386                 randconfig-a016-20230501   clang
i386                 randconfig-r025-20230501   clang
i386                 randconfig-r026-20230501   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r014-20230430   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r023-20230501   gcc  
loongarch            randconfig-r026-20230430   gcc  
loongarch            randconfig-r033-20230502   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230501   gcc  
m68k                 randconfig-r001-20230502   gcc  
m68k                 randconfig-r013-20230430   gcc  
microblaze   buildonly-randconfig-r003-20230505   gcc  
microblaze           randconfig-r013-20230501   gcc  
microblaze           randconfig-r016-20230502   gcc  
microblaze           randconfig-r016-20230504   gcc  
microblaze           randconfig-r024-20230502   gcc  
microblaze           randconfig-r031-20230502   gcc  
microblaze           randconfig-r032-20230502   gcc  
microblaze           randconfig-r035-20230502   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r006-20230501   clang
mips                 randconfig-r015-20230504   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230505   gcc  
nios2                randconfig-r015-20230430   gcc  
nios2                randconfig-r016-20230501   gcc  
openrisc             randconfig-r004-20230502   gcc  
openrisc             randconfig-r034-20230502   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230430   gcc  
parisc               randconfig-r003-20230502   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r006-20230505   gcc  
powerpc              randconfig-r012-20230501   clang
powerpc              randconfig-r014-20230504   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r005-20230505   clang
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230430   gcc  
riscv                randconfig-r002-20230502   clang
riscv                randconfig-r003-20230505   gcc  
riscv                randconfig-r004-20230430   gcc  
riscv                randconfig-r013-20230504   gcc  
riscv                randconfig-r042-20230430   clang
riscv                randconfig-r042-20230501   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230502   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230502   gcc  
s390                 randconfig-r044-20230430   clang
s390                 randconfig-r044-20230501   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230502   gcc  
sh                   randconfig-r011-20230502   gcc  
sh                   randconfig-r021-20230501   gcc  
sh                   randconfig-r024-20230430   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r001-20230430   gcc  
sparc64              randconfig-r002-20230501   gcc  
sparc64              randconfig-r023-20230430   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230501   gcc  
x86_64               randconfig-a002-20230501   gcc  
x86_64               randconfig-a003-20230501   gcc  
x86_64               randconfig-a004-20230501   gcc  
x86_64               randconfig-a005-20230501   gcc  
x86_64               randconfig-a006-20230501   gcc  
x86_64               randconfig-a011-20230501   clang
x86_64               randconfig-a012-20230501   clang
x86_64               randconfig-a013-20230501   clang
x86_64               randconfig-a014-20230501   clang
x86_64               randconfig-a015-20230501   clang
x86_64               randconfig-a016-20230501   clang
x86_64               randconfig-r005-20230501   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r004-20230505   gcc  
xtensa               randconfig-r012-20230504   gcc  
xtensa               randconfig-r023-20230502   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
