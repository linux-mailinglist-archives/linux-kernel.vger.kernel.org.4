Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BDF6DB7FC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 03:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjDHBak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 21:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDHBag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 21:30:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EDD113C4
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 18:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680917435; x=1712453435;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=u31UN2hNxYqDiJebUWlmxi6LVTrZFz217+ZinPUhhfw=;
  b=XXBruOvysE9LpeZ42tpE7julP7sBTtaVT39hhwdem+/Z65oNxcXT/97j
   xehxCTvgEXGyomqdpBYZK1y0goSb5dQYgBbQwdAMdjMWlgIsEL0dvTZPb
   M1vVqWSP7tRhADxPKUr9FMI9Yv90DjfxnHFriMB9ZCfqMW2doPTOZi1Fj
   Hpmo2EYXFXtjE/jzyUXZvaPuCf2SmvqUc7RXsKdWnaX3NQ+cMypcjUgnn
   bh5JxSKjBiXnsjm0XnmXytI3w3U8OqDcf7bkgGPeAX+e4KgvHF2aUPgEH
   IgA0hSVz0JGmnwaGn0rgSPMlkr6N0obBPXI51t7MgKUNCLn6LAbMp+45b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="340584313"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="340584313"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 18:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="752189478"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="752189478"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Apr 2023 18:30:19 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkxPG-000T80-1J;
        Sat, 08 Apr 2023 01:30:18 +0000
Date:   Sat, 08 Apr 2023 09:29:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b2e7ae549d84c654744bf70d30a881bfa140a6e3
Message-ID: <6430c38d.cR3O7thYb1Ychp8H%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: b2e7ae549d84c654744bf70d30a881bfa140a6e3  Merge x86/apic into tip/master

elapsed time: 723m

configs tested: 180
configs skipped: 94

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230403   gcc  
alpha                randconfig-r026-20230403   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230407   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230405   gcc  
arc                  randconfig-r002-20230403   gcc  
arc                  randconfig-r016-20230403   gcc  
arc                  randconfig-r023-20230405   gcc  
arc                  randconfig-r032-20230404   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                  randconfig-r005-20230405   gcc  
arm                  randconfig-r033-20230403   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230404   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230403   clang
arm64                randconfig-r014-20230407   gcc  
arm64                randconfig-r015-20230403   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r024-20230407   gcc  
csky                 randconfig-r032-20230405   gcc  
csky                 randconfig-r035-20230405   gcc  
hexagon              randconfig-r004-20230403   clang
hexagon              randconfig-r024-20230408   clang
hexagon              randconfig-r041-20230404   clang
hexagon              randconfig-r045-20230404   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                 randconfig-a012-20230403   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                          randconfig-a016   gcc  
ia64                             alldefconfig   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230403   gcc  
ia64         buildonly-randconfig-r004-20230404   gcc  
ia64         buildonly-randconfig-r005-20230407   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r015-20230407   gcc  
ia64                 randconfig-r022-20230405   gcc  
ia64                 randconfig-r023-20230403   gcc  
ia64                 randconfig-r026-20230405   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230403   gcc  
loongarch            randconfig-r011-20230407   gcc  
loongarch            randconfig-r013-20230403   gcc  
loongarch            randconfig-r022-20230407   gcc  
loongarch            randconfig-r035-20230403   gcc  
m68k                             allmodconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230403   gcc  
m68k                 randconfig-r012-20230403   gcc  
m68k                 randconfig-r012-20230407   gcc  
m68k                 randconfig-r031-20230405   gcc  
microblaze   buildonly-randconfig-r002-20230404   gcc  
microblaze   buildonly-randconfig-r005-20230403   gcc  
microblaze           randconfig-r024-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230403   gcc  
mips         buildonly-randconfig-r005-20230403   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                 randconfig-r002-20230405   gcc  
mips                 randconfig-r033-20230405   gcc  
mips                 randconfig-r034-20230403   gcc  
mips                        vocore2_defconfig   gcc  
nios2        buildonly-randconfig-r004-20230403   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230403   gcc  
openrisc     buildonly-randconfig-r005-20230404   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc             randconfig-r011-20230403   gcc  
openrisc             randconfig-r025-20230407   gcc  
openrisc             randconfig-r034-20230405   gcc  
parisc       buildonly-randconfig-r003-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230405   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc                 mpc837x_mds_defconfig   gcc  
powerpc              randconfig-r001-20230403   clang
powerpc              randconfig-r005-20230403   clang
powerpc              randconfig-r013-20230403   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230403   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                randconfig-r002-20230403   clang
riscv                randconfig-r042-20230403   gcc  
riscv                randconfig-r042-20230404   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230403   clang
s390                 randconfig-r031-20230404   gcc  
s390                 randconfig-r044-20230403   gcc  
s390                 randconfig-r044-20230404   clang
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r023-20230407   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc        buildonly-randconfig-r001-20230404   gcc  
sparc        buildonly-randconfig-r006-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r021-20230403   gcc  
sparc                randconfig-r035-20230404   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64      buildonly-randconfig-r002-20230407   gcc  
sparc64      buildonly-randconfig-r006-20230403   gcc  
sparc64              randconfig-r014-20230403   gcc  
sparc64              randconfig-r034-20230404   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r003-20230403   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230403   clang
x86_64               randconfig-a011-20230403   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-k001-20230403   gcc  
x86_64               randconfig-r022-20230403   gcc  
x86_64               randconfig-r025-20230403   gcc  
x86_64               randconfig-r032-20230403   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230407   gcc  
xtensa       buildonly-randconfig-r002-20230403   gcc  
xtensa       buildonly-randconfig-r003-20230403   gcc  
xtensa       buildonly-randconfig-r004-20230407   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
