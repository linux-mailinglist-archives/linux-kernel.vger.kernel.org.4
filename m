Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A61B6F64E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjEDGXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjEDGWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:22:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECC826BB
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683181374; x=1714717374;
  h=date:from:to:cc:subject:message-id;
  bh=5SN8+WB6ixFGCMLNQ7BEo8Y1G9JlcKVDOxByeJO88xU=;
  b=RLt66aykXAskbp2DALBQdj2v8NGiA3NJX3ktrr6HkLoW7KMnp+G2KXpH
   2FtIYL0LGKo7DeOMpOQbxLB1Wz4qgCfMU+o/kszI/5BW1p4/LOO4kNwXZ
   In6DsF7Cfzbhktj6wYLDnv3m3W9Fw5ioXLBxcT2OBVW4iVyZV/Y+Ll3Ji
   yNertWNYKa/sKuqVx4KQZOJKnx171tWWHMgySbzNjV/Sn7zIaOmm08Tr7
   enrAPu30igOW5NubdZYoq0WGKQmiyallzT2eBiimXmgAg4rSDJOnQYNr3
   C4BMyfb9MqSeBJMYNBmdAFAFx+u44rtSwafudFZ5gdNHm612wGdDzFz4l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="337989514"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="337989514"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 23:22:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="647196873"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="647196873"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2023 23:22:52 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1puSMd-0002dq-2Q;
        Thu, 04 May 2023 06:22:51 +0000
Date:   Thu, 04 May 2023 14:22:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.05.02a] BUILD SUCCESS
 613036a0713bff87790b0e8deb3238ce1709936d
Message-ID: <20230504062225.Kj9yQ%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.05.02a
branch HEAD: 613036a0713bff87790b0e8deb3238ce1709936d  locking/atomic: Add docbook header for arch_${atomic}_${pfx}${name}${sfx}_release

elapsed time: 720m

configs tested: 153
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230501   gcc  
alpha                randconfig-r032-20230430   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230501   gcc  
arc                  randconfig-r014-20230501   gcc  
arc                  randconfig-r022-20230502   gcc  
arc                  randconfig-r032-20230502   gcc  
arc                  randconfig-r043-20230430   gcc  
arc                  randconfig-r043-20230501   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230501   gcc  
arm          buildonly-randconfig-r005-20230501   gcc  
arm          buildonly-randconfig-r006-20230430   gcc  
arm          buildonly-randconfig-r006-20230501   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230430   clang
arm                  randconfig-r014-20230502   clang
arm                  randconfig-r046-20230430   gcc  
arm                  randconfig-r046-20230501   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230502   clang
arm64                randconfig-r006-20230430   gcc  
arm64                randconfig-r013-20230501   clang
arm64                randconfig-r015-20230430   clang
arm64                randconfig-r016-20230502   gcc  
csky         buildonly-randconfig-r006-20230502   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230430   gcc  
csky                 randconfig-r011-20230502   gcc  
csky                 randconfig-r015-20230502   gcc  
csky                 randconfig-r032-20230501   gcc  
hexagon              randconfig-r023-20230502   clang
hexagon              randconfig-r041-20230430   clang
hexagon              randconfig-r041-20230501   clang
hexagon              randconfig-r045-20230430   clang
hexagon              randconfig-r045-20230501   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230501   gcc  
i386                 randconfig-a002-20230501   gcc  
i386                 randconfig-a003-20230501   gcc  
i386                 randconfig-a004-20230501   gcc  
i386                 randconfig-a005-20230501   gcc  
i386                 randconfig-a006-20230501   gcc  
i386                 randconfig-a011-20230501   clang
i386                 randconfig-a012-20230501   clang
i386                 randconfig-a013-20230501   clang
i386                 randconfig-a014-20230501   clang
i386                 randconfig-a015-20230501   clang
i386                 randconfig-a016-20230501   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r023-20230430   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230430   gcc  
loongarch    buildonly-randconfig-r004-20230430   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230502   gcc  
loongarch            randconfig-r005-20230430   gcc  
loongarch            randconfig-r024-20230430   gcc  
loongarch            randconfig-r025-20230430   gcc  
loongarch            randconfig-r035-20230502   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230502   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230430   gcc  
m68k                 randconfig-r034-20230501   gcc  
m68k                 randconfig-r035-20230501   gcc  
microblaze           randconfig-r001-20230501   gcc  
microblaze           randconfig-r002-20230430   gcc  
microblaze           randconfig-r012-20230501   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r016-20230501   gcc  
nios2        buildonly-randconfig-r003-20230502   gcc  
nios2        buildonly-randconfig-r004-20230502   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230502   gcc  
nios2                randconfig-r022-20230501   gcc  
nios2                randconfig-r031-20230502   gcc  
nios2                randconfig-r033-20230502   gcc  
openrisc             randconfig-r004-20230501   gcc  
openrisc             randconfig-r024-20230502   gcc  
openrisc             randconfig-r031-20230501   gcc  
parisc       buildonly-randconfig-r002-20230501   gcc  
parisc       buildonly-randconfig-r002-20230502   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230501   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230501   clang
powerpc              randconfig-r026-20230501   clang
powerpc              randconfig-r033-20230501   gcc  
powerpc              randconfig-r034-20230430   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230430   clang
riscv                randconfig-r025-20230501   clang
riscv                randconfig-r034-20230502   clang
riscv                randconfig-r042-20230430   clang
riscv                randconfig-r042-20230501   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230501   clang
s390         buildonly-randconfig-r005-20230430   clang
s390                                defconfig   gcc  
s390                 randconfig-r044-20230430   clang
s390                 randconfig-r044-20230501   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r004-20230502   gcc  
sh                   randconfig-r012-20230502   gcc  
sh                   randconfig-r022-20230430   gcc  
sparc        buildonly-randconfig-r005-20230502   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230501   gcc  
sparc                randconfig-r013-20230430   gcc  
sparc64              randconfig-r011-20230501   gcc  
sparc64              randconfig-r021-20230430   gcc  
sparc64              randconfig-r021-20230501   gcc  
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
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r005-20230502   gcc  
xtensa               randconfig-r011-20230430   gcc  
xtensa               randconfig-r015-20230501   gcc  
xtensa               randconfig-r021-20230502   gcc  
xtensa               randconfig-r036-20230501   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
