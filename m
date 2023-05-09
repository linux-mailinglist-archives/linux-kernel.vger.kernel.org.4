Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B206FBC02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 02:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjEIAau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 20:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEIAat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 20:30:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360464EEE
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 17:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683592248; x=1715128248;
  h=date:from:to:cc:subject:message-id;
  bh=3SCKbHTowXD3up7R2zIC50B7HTZaJZ0U0EvTcwVZdLU=;
  b=Fpguy0Ipy1fSnkhWSiHFngBK+WGAsn62Y7/b5y0ivmlTxwIm/XVqA/x+
   hpQ7dPA+c//EeNgs3fIGssqpXfVCDHVTCZUnvr4QAaQaOJd5Y9ptSYNpb
   1o9novjB6wV+OduSWM0YuB5yGQ25oxNHaLgmL+PUndvJ/moKiAHgMyYY2
   b8tuWm0e09Lm72Caf5TW0v3fL12kT77UqCUAbXoaEcP1iRAPwzuOpWQkR
   jJgEI2OqWqFn+bSSd7mT66rpVdgsySE8llHUWnMv9tdvQ06YSYnsFZJgD
   RPW5gx6HVqDUPDi5jHwQg31gZRmn+d2E1cOzNvHZYS4+718wRZcZ0Pb4H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="339006102"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="339006102"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 17:30:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="788309871"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="788309871"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 May 2023 17:30:46 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwBFd-0001U1-2m;
        Tue, 09 May 2023 00:30:45 +0000
Date:   Tue, 09 May 2023 08:30:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 7d8accfaa0ab65e4282c8e58950f7d688342cd86
Message-ID: <20230509003030.ZAB6L%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 7d8accfaa0ab65e4282c8e58950f7d688342cd86  hwmon: (k10temp) Add PCI ID for family 19, model 78h

elapsed time: 733m

configs tested: 137
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230507   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r016-20230507   gcc  
alpha                randconfig-r016-20230508   gcc  
alpha                randconfig-r034-20230507   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r031-20230507   gcc  
arc                  randconfig-r032-20230507   gcc  
arc                  randconfig-r033-20230507   gcc  
arc                  randconfig-r043-20230507   gcc  
arc                  randconfig-r043-20230508   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230508   gcc  
arm                  randconfig-r032-20230508   gcc  
arm                  randconfig-r046-20230507   gcc  
arm                  randconfig-r046-20230508   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230507   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r024-20230508   gcc  
csky                 randconfig-r035-20230507   gcc  
hexagon      buildonly-randconfig-r006-20230508   clang
hexagon              randconfig-r005-20230508   clang
hexagon              randconfig-r013-20230507   clang
hexagon              randconfig-r015-20230508   clang
hexagon              randconfig-r035-20230508   clang
hexagon              randconfig-r036-20230508   clang
hexagon              randconfig-r041-20230507   clang
hexagon              randconfig-r041-20230508   clang
hexagon              randconfig-r045-20230507   clang
hexagon              randconfig-r045-20230508   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230508   clang
i386                 randconfig-a002-20230508   clang
i386                 randconfig-a003-20230508   clang
i386                 randconfig-a004-20230508   clang
i386                 randconfig-a005-20230508   clang
i386                 randconfig-a006-20230508   clang
i386                 randconfig-a011-20230508   gcc  
i386                 randconfig-a012-20230508   gcc  
i386                 randconfig-a013-20230508   gcc  
i386                 randconfig-a014-20230508   gcc  
i386                 randconfig-a015-20230508   gcc  
i386                 randconfig-a016-20230508   gcc  
i386                 randconfig-r011-20230508   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230508   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230507   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230507   gcc  
loongarch            randconfig-r013-20230508   gcc  
loongarch            randconfig-r014-20230508   gcc  
loongarch            randconfig-r026-20230508   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230507   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r004-20230507   gcc  
microblaze   buildonly-randconfig-r004-20230508   gcc  
microblaze   buildonly-randconfig-r006-20230507   gcc  
microblaze           randconfig-r001-20230507   gcc  
microblaze           randconfig-r022-20230508   gcc  
microblaze           randconfig-r034-20230508   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230507   gcc  
nios2                randconfig-r012-20230507   gcc  
nios2                randconfig-r022-20230507   gcc  
nios2                randconfig-r025-20230507   gcc  
openrisc             randconfig-r036-20230507   gcc  
parisc       buildonly-randconfig-r001-20230507   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r033-20230508   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r002-20230508   clang
powerpc              randconfig-r025-20230508   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r023-20230507   clang
riscv                randconfig-r042-20230507   clang
riscv                randconfig-r042-20230508   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230508   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230508   clang
s390                 randconfig-r006-20230508   clang
s390                 randconfig-r021-20230507   clang
s390                 randconfig-r044-20230507   clang
s390                 randconfig-r044-20230508   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r004-20230507   gcc  
sh                   randconfig-r012-20230508   gcc  
sh                   randconfig-r014-20230507   gcc  
sh                   randconfig-r023-20230508   gcc  
sparc        buildonly-randconfig-r002-20230508   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230507   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230508   clang
x86_64               randconfig-a002-20230508   clang
x86_64               randconfig-a003-20230508   clang
x86_64               randconfig-a004-20230508   clang
x86_64               randconfig-a005-20230508   clang
x86_64               randconfig-a006-20230508   clang
x86_64               randconfig-a011-20230508   gcc  
x86_64               randconfig-a012-20230508   gcc  
x86_64               randconfig-a013-20230508   gcc  
x86_64               randconfig-a014-20230508   gcc  
x86_64               randconfig-a015-20230508   gcc  
x86_64               randconfig-a016-20230508   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230508   gcc  
xtensa               randconfig-r005-20230507   gcc  
xtensa               randconfig-r006-20230507   gcc  
xtensa               randconfig-r021-20230508   gcc  
xtensa               randconfig-r024-20230507   gcc  
xtensa               randconfig-r026-20230507   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
