Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732616F125C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345487AbjD1H3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbjD1H32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:29:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD36268E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682666967; x=1714202967;
  h=date:from:to:cc:subject:message-id;
  bh=+CzY/b1G1PbkG37kh7x4AB0jphoHsq8xD59+BVgB5RE=;
  b=bZOu15yShPJq4FUJjDtNpZ2bcNL1+Fevoe1bHHvNrc5tlNSp3ptYldf4
   cP/yhIQOZi8st1BPuDudX9heRoUbWln0lRffC1vX2AARE0yoizDlX+oIt
   aEURPGfeVA/QvR72zxZQRkr30GG0zHfKPdgnPPgn+O+WbhxV2QiKjcdcY
   q0Otcyil1wltSvNLQa1wPywa+Ugl+++K1Pk+BuCFn9EYwVW8QkGix89wL
   fzGXu6iCJFlsx/ieT+UlSCUBukRvywK/SwX9LQS3qfrc/HIE9yIszlqSE
   O/A3m3tHGO8BKrUe8TWHp9SyPFnbXRhIHjhgdgkDmGBIRmQwPEe0gZIxY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="349697970"
X-IronPort-AV: E=Sophos;i="5.99,233,1677571200"; 
   d="scan'208";a="349697970"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 00:29:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="672056977"
X-IronPort-AV: E=Sophos;i="5.99,233,1677571200"; 
   d="scan'208";a="672056977"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Apr 2023 00:29:24 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psIXj-0000FL-2N;
        Fri, 28 Apr 2023 07:29:23 +0000
Date:   Fri, 28 Apr 2023 15:28:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.04.26b] BUILD SUCCESS WITH WARNING
 fcaa8c6ca41362484ff84124f7fd8929739eef45
Message-ID: <20230428072834.JxD6a%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.04.26b
branch HEAD: fcaa8c6ca41362484ff84124f7fd8929739eef45  squash! rcu-tasks: Stop rcu_tasks_invoke_cbs() from using never-onlined CPUs

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202304280553.ZsGndQkE-lkp@intel.com

Warning: (recently discovered and may have been fixed)

arch/arm64/kernel/process.c:75:1: warning: function declared 'noreturn' should not return [-Winvalid-noreturn]
arch/mips/kernel/process.c:46:1: warning: 'noreturn' function does return

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- mips-allmodconfig
|   `-- arch-mips-kernel-process.c:warning:noreturn-function-does-return
`-- mips-randconfig-r012-20230427
    `-- arch-mips-kernel-process.c:warning:noreturn-function-does-return
clang_recent_errors
`-- arm64-randconfig-r023-20230427
    `-- arch-arm64-kernel-process.c:warning:function-declared-noreturn-should-not-return

elapsed time: 724m

configs tested: 112
configs skipped: 13

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r025-20230427   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230427   gcc  
arc                  randconfig-r043-20230427   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                       netwinder_defconfig   clang
arm                  randconfig-r046-20230427   gcc  
arm                         vf610m4_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230427   clang
arm64                randconfig-r023-20230427   clang
csky                                defconfig   gcc  
csky                 randconfig-r004-20230427   gcc  
hexagon              randconfig-r041-20230427   clang
hexagon              randconfig-r045-20230427   clang
i386                             alldefconfig   gcc  
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
ia64                 randconfig-r006-20230427   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230427   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch            randconfig-r035-20230427   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230427   gcc  
m68k                 randconfig-r026-20230427   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230427   clang
mips                 randconfig-r003-20230427   clang
mips                 randconfig-r012-20230427   gcc  
mips                 randconfig-r016-20230427   gcc  
mips                 randconfig-r032-20230427   clang
nios2        buildonly-randconfig-r004-20230427   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230427   gcc  
openrisc             randconfig-r005-20230427   gcc  
openrisc             randconfig-r033-20230427   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   bluestone_defconfig   clang
powerpc                        fsp2_defconfig   clang
powerpc                    ge_imp3a_defconfig   clang
powerpc                 mpc8272_ads_defconfig   clang
powerpc                      ppc40x_defconfig   gcc  
powerpc              randconfig-r021-20230427   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230427   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230427   clang
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r036-20230427   gcc  
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
xtensa               randconfig-r031-20230427   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
