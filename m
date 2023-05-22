Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9DD70CE2F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjEVWpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjEVWpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:45:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFF3FA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684795529; x=1716331529;
  h=date:from:to:cc:subject:message-id;
  bh=zkRyv6ZpsH5Vb/mssvp/9wjmAU7dl7yLsKxTrEmyfVI=;
  b=YZI3//MeBCmfbcm/qQmOH8yzq5Jxgj2YAGqW7gZXdRcSZk64UqthpbsI
   F1YP5nsIcmgJObFie0MoDKyfy57MjIhImKeopAvx8aifhzRJEC8S8uixF
   JF3FYfKX9e5Pt41Wmvg1i4FGPSUIRXrBIa71Txj2cZ6ygkwMbqfaWTrXa
   kHkfE7CoJj4ysQYHL74Xd19vW0/jvNyuwkhPCzpXBStcO9CdEX375fSi2
   gNhR7PumHyCuHsZH01fCcMgnGQ4iJKO0+6/k6MOZpxta+06sMkWHJUZBw
   RnP/GM5/VG4wRzK67Aa2Yr+vpSBBNVkULgJEvYkNJnEVkXrAkfwK60vuR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="333426624"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="333426624"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 15:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="734472429"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="734472429"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 May 2023 15:45:26 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1EHN-000DHV-1q;
        Mon, 22 May 2023 22:45:25 +0000
Date:   Tue, 23 May 2023 06:45:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 3cf363a4daf359e8392b5048c619b7e9e429f122
Message-ID: <20230522224512.I7PwX%lkp@intel.com>
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

tree/branch: INFO setup_repo_specs: /db/releases/20230522162832/lkp-src/repo/*/tip
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 3cf363a4daf359e8392b5048c619b7e9e429f122  s390/cpum_sf: Convert to cmpxchg128()

elapsed time: 724m

configs tested: 155
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230522   gcc  
alpha        buildonly-randconfig-r004-20230521   gcc  
alpha        buildonly-randconfig-r006-20230521   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230522   gcc  
alpha                randconfig-r036-20230522   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230522   gcc  
arc                  randconfig-r012-20230521   gcc  
arc                  randconfig-r012-20230522   gcc  
arc                  randconfig-r043-20230521   gcc  
arc                  randconfig-r043-20230522   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r034-20230521   gcc  
arm                  randconfig-r046-20230521   clang
arm                  randconfig-r046-20230522   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230522   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230521   gcc  
arm64                randconfig-r021-20230521   gcc  
arm64                randconfig-r024-20230522   clang
arm64                randconfig-r033-20230521   clang
csky                                defconfig   gcc  
csky                 randconfig-r036-20230521   gcc  
hexagon      buildonly-randconfig-r002-20230521   clang
hexagon              randconfig-r014-20230522   clang
hexagon              randconfig-r015-20230522   clang
hexagon              randconfig-r024-20230521   clang
hexagon              randconfig-r031-20230522   clang
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
i386                 randconfig-a011-20230522   clang
i386                 randconfig-a012-20230522   clang
i386                 randconfig-a013-20230522   clang
i386                 randconfig-a014-20230522   clang
i386                 randconfig-a015-20230522   clang
i386                 randconfig-a016-20230522   clang
i386                 randconfig-r011-20230522   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r004-20230521   gcc  
ia64                 randconfig-r016-20230522   gcc  
ia64                 randconfig-r026-20230522   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230521   gcc  
m68k                 randconfig-r021-20230522   gcc  
m68k                 randconfig-r022-20230521   gcc  
m68k                 randconfig-r032-20230522   gcc  
microblaze   buildonly-randconfig-r001-20230522   gcc  
microblaze           randconfig-r016-20230521   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r004-20230522   clang
nios2        buildonly-randconfig-r003-20230522   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r013-20230521   gcc  
nios2                randconfig-r015-20230521   gcc  
nios2                randconfig-r023-20230522   gcc  
openrisc             randconfig-r003-20230522   gcc  
parisc       buildonly-randconfig-r001-20230521   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r033-20230522   gcc  
parisc               randconfig-r034-20230522   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r026-20230521   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230521   gcc  
riscv                randconfig-r025-20230522   clang
riscv                randconfig-r042-20230521   gcc  
riscv                randconfig-r042-20230522   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230522   gcc  
s390                 randconfig-r044-20230521   gcc  
s390                 randconfig-r044-20230522   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230521   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r035-20230522   gcc  
sparc64      buildonly-randconfig-r006-20230522   gcc  
sparc64              randconfig-r002-20230521   gcc  
sparc64              randconfig-r002-20230522   gcc  
sparc64              randconfig-r006-20230521   gcc  
sparc64              randconfig-r032-20230521   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
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
x86_64               randconfig-r022-20230522   clang
x86_64               randconfig-x051-20230522   clang
x86_64               randconfig-x052-20230522   clang
x86_64               randconfig-x053-20230522   clang
x86_64               randconfig-x054-20230522   clang
x86_64               randconfig-x055-20230522   clang
x86_64               randconfig-x056-20230522   clang
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
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r003-20230521   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
