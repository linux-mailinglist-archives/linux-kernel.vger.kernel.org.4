Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228156B0480
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCHKd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjCHKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:33:16 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572617F02A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678271567; x=1709807567;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nIwX5DWTYAwMK+o4Aj5eeOm/V5uS3yU7n1vo8wSy1Nc=;
  b=j8wJ65WzJu6O4PafuUszj8frakDEUVG5p06iTE2I5SmIWqsME6ivKidy
   OtvIuicMsQ/Jm3yNh2xIphRRqQbqFowUJOHqL312SaT4a6I2MPMqNsXPu
   CVCdgytamiMmZrYnevcQ+RoJyXOBC30yrKu7jqGtRXETGca+pLd/NfUNj
   AziKwEo7Cc/CWJJMppqDeg6I1pcTEVJ6Imb4d7PWZd71cxtzDiefrtdBl
   oSERcKoXtyVu0xYOjZ1En07Ol43sAojQ2UOkTlZ2iJFenv9oaX34/KWoa
   naDhWkpetz100priMkLg+I9b6Lnv3/waF3gnE4ON3yOyBD0ByMcVo4Pri
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="324432646"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="324432646"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 02:32:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="709382188"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="709382188"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Mar 2023 02:32:43 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZr6A-00023h-1c;
        Wed, 08 Mar 2023 10:32:42 +0000
Date:   Wed, 08 Mar 2023 18:32:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.03.06b] BUILD REGRESSION
 30ccfed62f5c0ac683aaa6fa4f573c112094fcc3
Message-ID: <6408642e.DLSklzGvCwYH+3m6%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.03.06b
branch HEAD: 30ccfed62f5c0ac683aaa6fa4f573c112094fcc3  fixup! locktorture: Add long_hold to adjust lock-hold delays

Error/Warning: (recently discovered and may have been fixed)

aarch64-linux-ld: rcutorture.c:(.text+0x7df0): undefined reference to `set_nmi_torture'
ia64-linux-ld: kernel/rcu/rcutorture.c:3334: undefined reference to `set_nmi_torture'
loongarch64-linux-ld: kernel/rcu/rcutorture.c:3301: undefined reference to `set_nmi_torture'
or1k-linux-ld: kernel/rcu/rcutorture.c:3301: undefined reference to `set_nmi_torture'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-buildonly-randconfig-r004-20230306
|   `-- aarch64-linux-ld:rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|-- ia64-randconfig-r023-20230306
|   `-- ia64-linux-ld:kernel-rcu-rcutorture.c:undefined-reference-to-set_nmi_torture
|-- loongarch-randconfig-r012-20230306
|   `-- loongarch64-linux-ld:kernel-rcu-rcutorture.c:undefined-reference-to-set_nmi_torture
`-- openrisc-buildonly-randconfig-r002-20230306
    `-- or1k-linux-ld:kernel-rcu-rcutorture.c:undefined-reference-to-set_nmi_torture

elapsed time: 953m

configs tested: 124
configs skipped: 12

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230306   gcc  
alpha                randconfig-r034-20230305   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230305   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230305   clang
arm          buildonly-randconfig-r005-20230305   clang
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230305   gcc  
arm                  randconfig-r015-20230306   gcc  
arm                  randconfig-r025-20230305   clang
arm                  randconfig-r046-20230305   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230306   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230306   clang
arm64                randconfig-r022-20230306   clang
arm64                randconfig-r033-20230306   gcc  
arm64                randconfig-r034-20230306   gcc  
csky         buildonly-randconfig-r004-20230305   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230306   gcc  
csky                 randconfig-r013-20230305   gcc  
hexagon              randconfig-r003-20230306   clang
hexagon              randconfig-r005-20230306   clang
hexagon              randconfig-r011-20230306   clang
hexagon              randconfig-r022-20230305   clang
hexagon              randconfig-r024-20230306   clang
hexagon              randconfig-r041-20230305   clang
hexagon              randconfig-r045-20230305   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230306   gcc  
i386                 randconfig-a002-20230306   gcc  
i386                 randconfig-a003-20230306   gcc  
i386                 randconfig-a004-20230306   gcc  
i386                 randconfig-a005-20230306   gcc  
i386                 randconfig-a006-20230306   gcc  
i386                 randconfig-a011-20230306   clang
i386                 randconfig-a012-20230306   clang
i386                 randconfig-a013-20230306   clang
i386                 randconfig-a014-20230306   clang
i386                 randconfig-a015-20230306   clang
i386                 randconfig-a016-20230306   clang
i386                 randconfig-r025-20230306   clang
i386                 randconfig-r036-20230306   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r006-20230306   gcc  
ia64                 randconfig-r023-20230306   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230306   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230305   gcc  
m68k                 randconfig-r014-20230305   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230306   clang
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230305   gcc  
nios2                randconfig-r035-20230305   gcc  
openrisc     buildonly-randconfig-r001-20230305   gcc  
openrisc     buildonly-randconfig-r002-20230306   gcc  
openrisc             randconfig-r002-20230305   gcc  
openrisc             randconfig-r024-20230305   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230305   gcc  
powerpc              randconfig-r004-20230305   clang
powerpc              randconfig-r021-20230306   clang
powerpc              randconfig-r035-20230306   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230305   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230305   clang
riscv                randconfig-r021-20230305   gcc  
riscv                randconfig-r042-20230305   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r023-20230305   gcc  
s390                 randconfig-r026-20230305   gcc  
s390                 randconfig-r033-20230305   clang
s390                 randconfig-r044-20230305   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230306   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230305   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r005-20230306   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230306   gcc  
x86_64               randconfig-a002-20230306   gcc  
x86_64               randconfig-a003-20230306   gcc  
x86_64               randconfig-a004-20230306   gcc  
x86_64               randconfig-a005-20230306   gcc  
x86_64               randconfig-a006-20230306   gcc  
x86_64               randconfig-a011-20230306   clang
x86_64               randconfig-a012-20230306   clang
x86_64               randconfig-a013-20230306   clang
x86_64               randconfig-a014-20230306   clang
x86_64               randconfig-a015-20230306   clang
x86_64               randconfig-a016-20230306   clang
x86_64               randconfig-r026-20230306   clang
x86_64               randconfig-r031-20230306   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230306   gcc  
xtensa               randconfig-r016-20230306   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
