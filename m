Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1044870F13C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjEXImn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjEXIm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:42:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F820E64
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684917696; x=1716453696;
  h=date:from:to:cc:subject:message-id;
  bh=aiObfXHOVrTroJMhG5kd0Q+mH5EHu3CILl2EIKxgfYQ=;
  b=RyPu5XwHYG2dx+olxddyf4cZe2L9BmtdYyG5pzur+MljLKE17vz5qq3f
   un9aJE/tBh0arnvx5Hjfxbo65ey5tz4o4YeOMLzV9kYaOsH42ZPS6exs7
   dmBXxe6LQbGef5mM29PrJp/oa+tJskhVixdxdzFYVoB0uJQrl5eEaXCw8
   JOgdzHjrhhTzCroRhBvLx/GfaVO3NvwzgIDi1dl+vfGYoOVw4muWi3QID
   noZxrlQvj9zOrJnzNQW53g4I80Xg5yOncQXCwlcZIQd+l6f27ca0OadEr
   //Q+IRraEzYmEBw6fEyJCzXLT4OnXTWn+TPgB/XZXQWJWkBWFjsurwZie
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="416960734"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="416960734"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 01:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="681793880"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="681793880"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 May 2023 01:40:56 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1k3D-000Ec3-1k;
        Wed, 24 May 2023 08:40:55 +0000
Date:   Wed, 24 May 2023 16:40:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:smp/core] BUILD SUCCESS
 06c6796e0304234da65e70577f354cb194086521
Message-ID: <20230524084048.bfNgt%lkp@intel.com>
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

tree/branch: INFO setup_repo_specs: /db/releases/20230524154417/lkp-src/repo/*/tip
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
branch HEAD: 06c6796e0304234da65e70577f354cb194086521  cpu/hotplug: Fix off by one in cpuhp_bringup_mask()

elapsed time: 982m

configs tested: 219
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230522   gcc  
alpha        buildonly-randconfig-r003-20230521   gcc  
alpha        buildonly-randconfig-r003-20230522   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230524   gcc  
alpha                randconfig-r006-20230522   gcc  
alpha                randconfig-r006-20230523   gcc  
alpha                randconfig-r013-20230521   gcc  
alpha                randconfig-r013-20230523   gcc  
alpha                randconfig-r014-20230523   gcc  
alpha                randconfig-r035-20230521   gcc  
alpha                randconfig-r036-20230522   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc          buildonly-randconfig-r004-20230521   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r012-20230522   gcc  
arc                  randconfig-r015-20230521   gcc  
arc                  randconfig-r034-20230522   gcc  
arc                  randconfig-r036-20230521   gcc  
arc                  randconfig-r043-20230521   gcc  
arc                  randconfig-r043-20230522   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                  randconfig-r014-20230522   gcc  
arm                  randconfig-r046-20230521   clang
arm                  randconfig-r046-20230522   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230523   clang
arm64                randconfig-r011-20230523   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230521   gcc  
csky                 randconfig-r022-20230522   gcc  
csky                 randconfig-r026-20230521   gcc  
csky                 randconfig-r026-20230524   gcc  
csky                 randconfig-r035-20230521   gcc  
hexagon      buildonly-randconfig-r001-20230521   clang
hexagon      buildonly-randconfig-r001-20230522   clang
hexagon              randconfig-r002-20230522   clang
hexagon              randconfig-r006-20230521   clang
hexagon              randconfig-r032-20230521   clang
hexagon              randconfig-r035-20230522   clang
hexagon              randconfig-r041-20230521   clang
hexagon              randconfig-r041-20230522   clang
hexagon              randconfig-r045-20230521   clang
hexagon              randconfig-r045-20230522   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230522   gcc  
i386                 randconfig-a002-20230522   gcc  
i386                 randconfig-a003-20230522   gcc  
i386                 randconfig-a004-20230522   gcc  
i386                 randconfig-a005-20230522   gcc  
i386                 randconfig-a006-20230522   gcc  
i386                 randconfig-i051-20230524   gcc  
i386                 randconfig-i052-20230524   gcc  
i386                 randconfig-i053-20230524   gcc  
i386                 randconfig-i054-20230524   gcc  
i386                 randconfig-i055-20230524   gcc  
i386                 randconfig-i056-20230524   gcc  
i386                 randconfig-i061-20230523   clang
i386                 randconfig-i062-20230523   clang
i386                 randconfig-i063-20230523   clang
i386                 randconfig-i064-20230523   clang
i386                 randconfig-i065-20230523   clang
i386                 randconfig-i066-20230523   clang
i386                 randconfig-r003-20230522   gcc  
i386                 randconfig-r016-20230522   clang
i386                 randconfig-r036-20230522   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230522   gcc  
ia64                 randconfig-r015-20230523   gcc  
ia64                 randconfig-r016-20230521   gcc  
ia64                 randconfig-r023-20230521   gcc  
ia64                 randconfig-r024-20230524   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230521   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230521   gcc  
loongarch            randconfig-r012-20230522   gcc  
loongarch            randconfig-r012-20230523   gcc  
loongarch            randconfig-r014-20230521   gcc  
loongarch            randconfig-r022-20230521   gcc  
loongarch            randconfig-r034-20230521   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230522   gcc  
m68k         buildonly-randconfig-r005-20230522   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230523   gcc  
m68k                 randconfig-r006-20230524   gcc  
m68k                 randconfig-r024-20230522   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230522   clang
mips         buildonly-randconfig-r005-20230521   gcc  
mips         buildonly-randconfig-r006-20230521   gcc  
mips                malta_qemu_32r6_defconfig   clang
mips                 randconfig-r036-20230521   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230523   gcc  
nios2                randconfig-r003-20230523   gcc  
nios2                randconfig-r004-20230522   gcc  
nios2                randconfig-r021-20230524   gcc  
nios2                randconfig-r025-20230521   gcc  
nios2                randconfig-r031-20230521   gcc  
openrisc     buildonly-randconfig-r001-20230522   gcc  
openrisc     buildonly-randconfig-r004-20230521   gcc  
openrisc             randconfig-r002-20230521   gcc  
openrisc             randconfig-r002-20230524   gcc  
openrisc             randconfig-r003-20230524   gcc  
openrisc             randconfig-r015-20230522   gcc  
openrisc             randconfig-r032-20230521   gcc  
parisc       buildonly-randconfig-r002-20230521   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230522   clang
powerpc                      chrp32_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230522   clang
riscv        buildonly-randconfig-r005-20230522   clang
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230524   gcc  
riscv                randconfig-r005-20230521   clang
riscv                randconfig-r023-20230524   clang
riscv                randconfig-r035-20230521   clang
riscv                randconfig-r042-20230521   gcc  
riscv                randconfig-r042-20230522   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r004-20230522   clang
s390                                defconfig   gcc  
s390                 randconfig-r001-20230523   clang
s390                 randconfig-r003-20230521   clang
s390                 randconfig-r004-20230521   clang
s390                 randconfig-r011-20230521   gcc  
s390                 randconfig-r013-20230521   gcc  
s390                 randconfig-r022-20230524   clang
s390                 randconfig-r033-20230521   clang
s390                 randconfig-r044-20230521   gcc  
s390                 randconfig-r044-20230522   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r015-20230521   gcc  
sh                   randconfig-r034-20230522   gcc  
sh                           se7705_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc        buildonly-randconfig-r005-20230522   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230524   gcc  
sparc                randconfig-r023-20230522   gcc  
sparc                randconfig-r025-20230524   gcc  
sparc                randconfig-r033-20230521   gcc  
sparc                randconfig-r035-20230522   gcc  
sparc64              randconfig-r001-20230521   gcc  
sparc64              randconfig-r013-20230522   gcc  
sparc64              randconfig-r034-20230521   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r002-20230522   gcc  
x86_64       buildonly-randconfig-r006-20230522   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230522   gcc  
x86_64               randconfig-a002-20230522   gcc  
x86_64               randconfig-a003-20230522   gcc  
x86_64               randconfig-a004-20230522   gcc  
x86_64               randconfig-a005-20230522   gcc  
x86_64               randconfig-a006-20230522   gcc  
x86_64               randconfig-a011-20230522   clang
x86_64               randconfig-a012-20230522   clang
x86_64               randconfig-a013-20230522   clang
x86_64               randconfig-a014-20230522   clang
x86_64               randconfig-a015-20230522   clang
x86_64               randconfig-a016-20230522   clang
x86_64               randconfig-r011-20230522   clang
x86_64                        randconfig-x052   clang
x86_64                        randconfig-x054   clang
x86_64                        randconfig-x056   clang
x86_64               randconfig-x061-20230522   clang
x86_64               randconfig-x062-20230522   clang
x86_64               randconfig-x063-20230522   clang
x86_64               randconfig-x064-20230522   clang
x86_64               randconfig-x065-20230522   clang
x86_64               randconfig-x066-20230522   clang
x86_64               randconfig-x071-20230522   gcc  
x86_64               randconfig-x072-20230522   gcc  
x86_64               randconfig-x073-20230522   gcc  
x86_64               randconfig-x074-20230522   gcc  
x86_64               randconfig-x075-20230522   gcc  
x86_64               randconfig-x076-20230522   gcc  
x86_64               randconfig-x081-20230522   gcc  
x86_64               randconfig-x082-20230522   gcc  
x86_64               randconfig-x083-20230522   gcc  
x86_64               randconfig-x084-20230522   gcc  
x86_64               randconfig-x085-20230522   gcc  
x86_64               randconfig-x086-20230522   gcc  
x86_64               randconfig-x091-20230524   clang
x86_64               randconfig-x092-20230524   clang
x86_64               randconfig-x093-20230524   clang
x86_64               randconfig-x094-20230524   clang
x86_64               randconfig-x095-20230524   clang
x86_64               randconfig-x096-20230524   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r031-20230522   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
