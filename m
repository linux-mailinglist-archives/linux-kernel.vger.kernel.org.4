Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08383701642
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 13:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbjEMLDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 07:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbjEMLDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 07:03:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E993040EA
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 04:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683975790; x=1715511790;
  h=date:from:to:cc:subject:message-id;
  bh=SFQb/05gW9wsRL7NM1Xq12XW1HM41sR9mn7piXQd0yg=;
  b=lerf4VCFbhU4cRJCdlWJZ/7l8gWDIEDoDl5v7cPFmlvr+kKSlEJFIOdY
   xxn0LveZPOPV/U5nu8YgyyYOh/zoDx5JG2F6ZvTjhc2BhsjTS2OS5bHz8
   gzuJSmCaY8fpyWQfX9l9KOLWrCO1VaSxdtLxGfA6YHf3Yyv2qnBoWe/90
   gZ+6BK8TINW8Yb2Rbc9GuvvEEp9rm/tBYgCOKM8EYASRm+dAN7KgovXoG
   ddgFtJZN3Gg+ej/5v9CBT/jqQ9nyCAGSytEnnRmEuYCGqB3r4AcxdiVSt
   D3mK3jSKXWgBbbycKbS0MfRA2fpp+ZJ/PTOHVcMAJwvGK8z7hJ0C+FZyy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="379096715"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="379096715"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 04:03:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="946889789"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="946889789"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 May 2023 04:03:09 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxn1o-0005Sz-31;
        Sat, 13 May 2023 11:03:08 +0000
Date:   Sat, 13 May 2023 19:02:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:tglx.2023.05.12a] BUILD SUCCESS
 4279344f0e62e4dafc9906df283e6c432eba68f8
Message-ID: <20230513110250.hcIuI%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tglx.2023.05.12a
branch HEAD: 4279344f0e62e4dafc9906df283e6c432eba68f8  x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it

elapsed time: 804m

configs tested: 141
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230511   gcc  
alpha                randconfig-r016-20230509   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230511   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230509   gcc  
arc                  randconfig-r035-20230509   gcc  
arc                  randconfig-r043-20230509   gcc  
arc                  randconfig-r043-20230511   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                  randconfig-r015-20230512   gcc  
arm                  randconfig-r032-20230511   gcc  
arm                  randconfig-r046-20230509   gcc  
arm                  randconfig-r046-20230511   clang
arm                        spear6xx_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230511   gcc  
csky                 randconfig-r006-20230509   gcc  
csky                 randconfig-r025-20230509   gcc  
csky                 randconfig-r031-20230511   gcc  
hexagon              randconfig-r034-20230509   clang
hexagon              randconfig-r036-20230511   clang
hexagon              randconfig-r041-20230509   clang
hexagon              randconfig-r041-20230511   clang
hexagon              randconfig-r045-20230509   clang
hexagon              randconfig-r045-20230511   clang
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
ia64                         bigsur_defconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r006-20230511   gcc  
ia64                 randconfig-r035-20230511   gcc  
ia64                 randconfig-r036-20230509   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230511   gcc  
loongarch            randconfig-r024-20230509   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230509   gcc  
m68k                 randconfig-r016-20230512   gcc  
m68k                 randconfig-r022-20230511   gcc  
m68k                 randconfig-r032-20230509   gcc  
microblaze           randconfig-r003-20230511   gcc  
microblaze           randconfig-r021-20230511   gcc  
microblaze           randconfig-r024-20230511   gcc  
microblaze           randconfig-r033-20230509   gcc  
mips                             allmodconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                 randconfig-r015-20230509   gcc  
mips                 randconfig-r015-20230511   clang
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230511   gcc  
nios2                randconfig-r016-20230511   gcc  
nios2                randconfig-r026-20230511   gcc  
openrisc             randconfig-r012-20230509   gcc  
openrisc             randconfig-r014-20230509   gcc  
openrisc             randconfig-r025-20230511   gcc  
openrisc             randconfig-r034-20230511   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r023-20230509   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc              randconfig-r011-20230512   clang
powerpc              randconfig-r022-20230509   clang
powerpc              randconfig-r023-20230511   gcc  
powerpc                 xes_mpc85xx_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230511   gcc  
riscv        buildonly-randconfig-r006-20230511   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230511   clang
riscv                randconfig-r042-20230509   clang
riscv                randconfig-r042-20230511   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230509   clang
s390                 randconfig-r044-20230511   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230509   gcc  
sh                   randconfig-r031-20230509   gcc  
sh                           se7722_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230512   gcc  
sparc64              randconfig-r005-20230509   gcc  
sparc64              randconfig-r013-20230512   gcc  
sparc64              randconfig-r014-20230511   gcc  
sparc64              randconfig-r014-20230512   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
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
xtensa       buildonly-randconfig-r003-20230511   gcc  
xtensa               randconfig-r002-20230509   gcc  
xtensa               randconfig-r011-20230509   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
