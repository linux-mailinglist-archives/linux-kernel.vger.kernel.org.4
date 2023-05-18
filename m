Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F00C707DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjERKTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjERKSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:18:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C721FC3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684405107; x=1715941107;
  h=date:from:to:cc:subject:message-id;
  bh=80twg7MGXGzPRzjsNH9oqNLMvPYlRlr5sq/bVdEUbOk=;
  b=ao0EKcRcy7O78UVTAFiDiirlFGajLIEpq/Tp3vKgZJlluCaUlnX59fsz
   R+wEFu+b6KejYsB/9LlrUkpuSwH5tzqhJAJ1XFXSF7Tk8TxkgrsDBEBJs
   qbT/MADkzLqeEmm3EX57kyjc9xC8hLeGyKRNec3fR72s9Cn0lCP1YpB3G
   x8GAlzYvfCWPGzgu6bWlS6Czt69nRFBqjcNSkIH/zFyOatZsbaDJ+sLhI
   geIbG4Ph+fFBJ4LhnXkmUyiJLTCVHyTfiDZilSinUMukqC61mP2iQFcsz
   69mrrQvsjkB2jK93x6pjAecQIjonA950ESNcbuMR1MTvfSQ+XATBA+KU1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="415454403"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="415454403"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 03:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="735030787"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="735030787"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 May 2023 03:18:22 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pzaiD-0009si-2Q;
        Thu, 18 May 2023 10:18:21 +0000
Date:   Thu, 18 May 2023 18:17:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 ce0b15d11ad837fbacc5356941712218e38a0a83
Message-ID: <20230518101738.I1uoI%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230517200055/lkp-src/repo/*/tip
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: ce0b15d11ad837fbacc5356941712218e38a0a83  x86/mm: Avoid incomplete Global INVLPG flushes

elapsed time: 732m

configs tested: 214
configs skipped: 115

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230517   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230517   gcc  
alpha                randconfig-r015-20230517   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230517   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230517   gcc  
arc                  randconfig-r022-20230517   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                        mvebu_v5_defconfig   clang
arm                            qcom_defconfig   gcc  
arm                  randconfig-r034-20230517   gcc  
arm                  randconfig-r036-20230517   gcc  
arm                  randconfig-r046-20230517   clang
arm                           sama5_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230517   clang
arm64                randconfig-r012-20230517   gcc  
arm64                randconfig-r014-20230517   gcc  
arm64                randconfig-r022-20230518   clang
arm64                randconfig-r023-20230517   gcc  
arm64                randconfig-r025-20230517   gcc  
csky         buildonly-randconfig-r005-20230517   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230517   gcc  
csky                 randconfig-r013-20230517   gcc  
hexagon              randconfig-r022-20230517   clang
hexagon              randconfig-r035-20230517   clang
hexagon              randconfig-r041-20230517   clang
hexagon              randconfig-r045-20230517   clang
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
ia64         buildonly-randconfig-r003-20230517   gcc  
ia64         buildonly-randconfig-r004-20230517   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230517   gcc  
ia64                 randconfig-r012-20230517   gcc  
ia64                 randconfig-r013-20230517   gcc  
ia64                 randconfig-r014-20230517   gcc  
ia64                 randconfig-r016-20230517   gcc  
ia64                 randconfig-r036-20230517   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230517   gcc  
loongarch            randconfig-r003-20230517   gcc  
loongarch            randconfig-r004-20230517   gcc  
loongarch            randconfig-r005-20230517   gcc  
loongarch            randconfig-r033-20230517   gcc  
loongarch            randconfig-r035-20230517   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r005-20230517   gcc  
m68k                 randconfig-r011-20230517   gcc  
m68k                 randconfig-r023-20230517   gcc  
m68k                 randconfig-r024-20230517   gcc  
m68k                 randconfig-r034-20230517   gcc  
microblaze   buildonly-randconfig-r002-20230517   gcc  
microblaze           randconfig-r003-20230517   gcc  
microblaze           randconfig-r006-20230517   gcc  
microblaze           randconfig-r031-20230517   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips         buildonly-randconfig-r005-20230517   gcc  
mips                     decstation_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                        maltaup_defconfig   clang
mips                 randconfig-r006-20230517   gcc  
mips                 randconfig-r025-20230517   clang
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230517   gcc  
nios2                randconfig-r011-20230517   gcc  
nios2                randconfig-r025-20230517   gcc  
openrisc             randconfig-r001-20230517   gcc  
openrisc             randconfig-r002-20230517   gcc  
openrisc             randconfig-r003-20230517   gcc  
openrisc             randconfig-r013-20230517   gcc  
openrisc             randconfig-r035-20230517   gcc  
parisc                           alldefconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230517   gcc  
parisc               randconfig-r023-20230517   gcc  
parisc               randconfig-r032-20230517   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                        fsp2_defconfig   clang
powerpc              randconfig-r011-20230517   gcc  
powerpc              randconfig-r014-20230517   gcc  
powerpc              randconfig-r016-20230517   gcc  
powerpc              randconfig-r025-20230518   clang
powerpc              randconfig-r026-20230517   gcc  
powerpc                     tqm5200_defconfig   clang
powerpc                      tqm8xx_defconfig   gcc  
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230517   gcc  
riscv                randconfig-r015-20230517   gcc  
riscv                randconfig-r024-20230517   gcc  
riscv                randconfig-r026-20230517   gcc  
riscv                randconfig-r032-20230517   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230517   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230517   clang
s390                 randconfig-r016-20230517   gcc  
s390                 randconfig-r021-20230517   gcc  
s390                 randconfig-r022-20230517   gcc  
s390                 randconfig-r026-20230517   gcc  
s390                 randconfig-r031-20230517   clang
s390                 randconfig-r032-20230517   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230517   gcc  
sh           buildonly-randconfig-r006-20230517   gcc  
sh                        dreamcast_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r002-20230517   gcc  
sh                   randconfig-r013-20230517   gcc  
sh                   randconfig-r022-20230517   gcc  
sh                   randconfig-r024-20230517   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc        buildonly-randconfig-r002-20230517   gcc  
sparc        buildonly-randconfig-r004-20230517   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230517   gcc  
sparc                randconfig-r006-20230517   gcc  
sparc                randconfig-r033-20230517   gcc  
sparc64      buildonly-randconfig-r001-20230517   gcc  
sparc64      buildonly-randconfig-r004-20230517   gcc  
sparc64              randconfig-r005-20230517   gcc  
sparc64              randconfig-r015-20230517   gcc  
sparc64              randconfig-r033-20230517   gcc  
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
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230517   gcc  
xtensa       buildonly-randconfig-r003-20230517   gcc  
xtensa               randconfig-r002-20230517   gcc  
xtensa               randconfig-r004-20230517   gcc  
xtensa               randconfig-r006-20230517   gcc  
xtensa               randconfig-r021-20230517   gcc  
xtensa               randconfig-r034-20230517   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
