Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7376770ABAB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 01:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjETXkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 19:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjETXkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 19:40:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1CE13E
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 16:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684626006; x=1716162006;
  h=date:from:to:cc:subject:message-id;
  bh=BzAIiTuZJ23jRg6YT2qByheZbNdtmLrUj207idi0vVc=;
  b=g855mVlAJty2RHsv1jRy+ISg/KI1zNf7C5UzJA2aeDS+/ChkpF5zM5pn
   cOIW70QF3ykmD0DTkSFjsAR4l8lNxpkOH4wIo7btGuimnhcweszD7zCaH
   rxXczf9sZ3kynIMAG2AcMMUDJ60N26UkNuG0T2XVMeib0r0xq4b2jjYDG
   icFOfL49YXsb/6jP2vMgQCALl9pciiIwmqozyMjGPvycp9LBOHuI0IoWk
   WRoD3eQLRij/4EiRPvpySfXNbsgGhcDhHglWl3CZT4SJDfUtWQPZwHJjU
   RQEuz5AiOJvprfYCsrx9oLkXzWJO+ePaSJA/AgWvfiCWuwLDKisRke6Cz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="416108202"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="416108202"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2023 16:40:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="792815978"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="792815978"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 May 2023 16:40:04 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q0WBA-000BrM-1A;
        Sat, 20 May 2023 23:40:04 +0000
Date:   Sun, 21 May 2023 07:39:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.05.18b] BUILD SUCCESS
 8f5742447f1d25636519741c955f927945daf571
Message-ID: <20230520233921.DqFbu%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230519164737/lkp-src/repo/*/paulmck-rcu
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.05.18b
branch HEAD: 8f5742447f1d25636519741c955f927945daf571  squash! rcuscale: Measure grace-period kthread CPU time

elapsed time: 721m

configs tested: 162
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230520   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r005-20230517   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230517   gcc  
arc                  randconfig-r033-20230520   gcc  
arc                  randconfig-r034-20230520   gcc  
arc                  randconfig-r043-20230517   gcc  
arc                  randconfig-r043-20230520   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm          buildonly-randconfig-r004-20230517   clang
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                        multi_v5_defconfig   clang
arm                         mv78xx0_defconfig   clang
arm                  randconfig-r013-20230520   gcc  
arm                  randconfig-r022-20230517   clang
arm                  randconfig-r046-20230517   clang
arm                  randconfig-r046-20230520   gcc  
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230520   gcc  
arm64                randconfig-r002-20230517   clang
arm64                randconfig-r006-20230517   clang
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r003-20230520   clang
hexagon              randconfig-r021-20230519   clang
hexagon              randconfig-r041-20230517   clang
hexagon              randconfig-r041-20230520   clang
hexagon              randconfig-r045-20230517   clang
hexagon              randconfig-r045-20230520   clang
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
ia64                 randconfig-r004-20230520   gcc  
ia64                 randconfig-r014-20230520   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230520   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                 randconfig-r022-20230519   gcc  
m68k                 randconfig-r023-20230517   gcc  
microblaze           randconfig-r005-20230520   gcc  
microblaze           randconfig-r021-20230517   gcc  
microblaze           randconfig-r025-20230517   gcc  
microblaze           randconfig-r033-20230517   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                        maltaup_defconfig   clang
mips                 randconfig-r012-20230520   gcc  
mips                 randconfig-r024-20230519   clang
mips                 randconfig-r031-20230520   clang
nios2        buildonly-randconfig-r006-20230517   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230517   gcc  
nios2                randconfig-r015-20230520   gcc  
nios2                randconfig-r026-20230519   gcc  
nios2                randconfig-r032-20230520   gcc  
openrisc             randconfig-r002-20230520   gcc  
openrisc             randconfig-r023-20230520   gcc  
openrisc             randconfig-r024-20230520   gcc  
openrisc             randconfig-r026-20230520   gcc  
openrisc             randconfig-r036-20230520   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r025-20230519   gcc  
parisc               randconfig-r026-20230517   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                      katmai_defconfig   clang
powerpc                     kmeter1_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc              randconfig-r003-20230520   gcc  
powerpc                     stx_gp3_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230517   gcc  
riscv        buildonly-randconfig-r004-20230520   clang
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230517   gcc  
riscv                randconfig-r042-20230520   clang
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230520   clang
s390                                defconfig   gcc  
s390                 randconfig-r025-20230520   clang
s390                 randconfig-r035-20230520   gcc  
s390                 randconfig-r044-20230517   gcc  
s390                 randconfig-r044-20230520   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230517   gcc  
sh                   randconfig-r022-20230520   gcc  
sh                   randconfig-r034-20230517   gcc  
sh                           se7705_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r023-20230519   gcc  
sparc                randconfig-r024-20230517   gcc  
sparc                randconfig-r031-20230517   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64      buildonly-randconfig-r005-20230520   gcc  
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
x86_64                        randconfig-x051   gcc  
x86_64                        randconfig-x052   clang
x86_64                        randconfig-x053   gcc  
x86_64                        randconfig-x054   clang
x86_64                        randconfig-x055   gcc  
x86_64                        randconfig-x056   clang
x86_64                        randconfig-x061   gcc  
x86_64                        randconfig-x062   clang
x86_64                        randconfig-x063   gcc  
x86_64                        randconfig-x064   clang
x86_64                        randconfig-x065   gcc  
x86_64                        randconfig-x066   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r003-20230517   gcc  
xtensa       buildonly-randconfig-r006-20230520   gcc  
xtensa               randconfig-r004-20230517   gcc  
xtensa               randconfig-r035-20230517   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
