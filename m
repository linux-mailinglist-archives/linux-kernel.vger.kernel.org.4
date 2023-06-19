Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B32735DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjFSTdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFSTdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:33:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCE6106
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687203185; x=1718739185;
  h=date:from:to:cc:subject:message-id;
  bh=j/NYJ1wKg2zsKL6qKtyvyWzBoS7R6m2hokVnr200Yuw=;
  b=d4lpwbfW3ry0lF/ShgujZDEdLoPs6jekrBfTBZVPYERlJc9bzwcV1/Am
   yyPsFjV41r0e0GntCC4wcjPi1cBVV0eQ++rmFBvA8agrv0QHuuJn9i+qy
   uupSC6YCuvxTRH4QSHaffw2hFccyk0WwEPSk8ikO0kdhnmkoAL6fCA9A3
   jHeb4NbhQtfqlxE42zgxWTwSyjD4HPA8FoJmJ/uelhw2OlNoLBc7KsnhI
   Bexp4wflKKOzGe1VRwbxmjgrod01m664Rr0NOq2UybeeFOEtifoFWzb69
   M3TDKEpNTwy3jGQhB6KMB1SwvGZwLkQMmBuj+pldQ1OlYVZfmEaaDvtsN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="423367150"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="423367150"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 12:33:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="960510243"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="960510243"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jun 2023 12:33:00 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBKcV-00053V-2Z;
        Mon, 19 Jun 2023 19:32:59 +0000
Date:   Tue, 20 Jun 2023 03:32:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 2951580ba6adb082bb6b7154a5ecb24e7c1f7569
Message-ID: <202306200314.suKGPVRf-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 2951580ba6adb082bb6b7154a5ecb24e7c1f7569  tracing/timer: Add missing hrtimer modes to decode_hrtimer_mode().

Unverified Warning (likely false positive, please contact us if interested):

kernel/time/posix-timers.c:1085 itimer_delete() warn: inconsistent returns '&timer->it_lock'.
kernel/time/posix-timers.c:1085 itimer_delete() warn: inconsistent returns 'flags'.

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-m041-20230619
    |-- kernel-time-posix-timers.c-itimer_delete()-warn:inconsistent-returns-flags-.
    `-- kernel-time-posix-timers.c-itimer_delete()-warn:inconsistent-returns-timer-it_lock-.

elapsed time: 731m

configs tested: 133
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230619   gcc  
alpha                randconfig-r034-20230619   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                  randconfig-r005-20230619   gcc  
arc                  randconfig-r043-20230619   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                  randconfig-r046-20230619   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230619   clang
arm64                randconfig-r031-20230619   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230619   gcc  
csky                 randconfig-r004-20230619   gcc  
csky                 randconfig-r025-20230619   gcc  
csky                 randconfig-r032-20230619   gcc  
hexagon              randconfig-r041-20230619   clang
hexagon              randconfig-r045-20230619   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230619   gcc  
i386         buildonly-randconfig-r005-20230619   gcc  
i386         buildonly-randconfig-r006-20230619   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230619   gcc  
i386                 randconfig-i002-20230619   gcc  
i386                 randconfig-i003-20230619   gcc  
i386                 randconfig-i004-20230619   gcc  
i386                 randconfig-i005-20230619   gcc  
i386                 randconfig-i006-20230619   gcc  
i386                 randconfig-i011-20230619   clang
i386                 randconfig-i012-20230619   clang
i386                 randconfig-i013-20230619   clang
i386                 randconfig-i014-20230619   clang
i386                 randconfig-i015-20230619   clang
i386                 randconfig-i016-20230619   clang
i386                 randconfig-r012-20230619   clang
i386                 randconfig-r032-20230619   gcc  
i386                 randconfig-r033-20230619   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230619   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230619   gcc  
m68k                 randconfig-r021-20230619   gcc  
m68k                 randconfig-r026-20230619   gcc  
m68k                 randconfig-r034-20230619   gcc  
m68k                 randconfig-r036-20230619   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                 randconfig-r015-20230619   gcc  
mips                 randconfig-r016-20230619   gcc  
mips                 randconfig-r022-20230619   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230619   gcc  
nios2                randconfig-r032-20230619   gcc  
openrisc             randconfig-r005-20230619   gcc  
openrisc             randconfig-r013-20230619   gcc  
openrisc             randconfig-r033-20230619   gcc  
openrisc             randconfig-r036-20230619   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r036-20230619   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                      pmac32_defconfig   clang
powerpc              randconfig-r013-20230619   clang
powerpc              randconfig-r031-20230619   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                randconfig-r042-20230619   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230619   clang
sh                               allmodconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r025-20230619   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r035-20230619   gcc  
sparc64              randconfig-r006-20230619   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r004-20230619   clang
um                   randconfig-r011-20230619   gcc  
um                   randconfig-r035-20230619   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230619   gcc  
x86_64       buildonly-randconfig-r002-20230619   gcc  
x86_64       buildonly-randconfig-r003-20230619   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230619   gcc  
x86_64               randconfig-a002-20230619   gcc  
x86_64               randconfig-a003-20230619   gcc  
x86_64               randconfig-a004-20230619   gcc  
x86_64               randconfig-a005-20230619   gcc  
x86_64               randconfig-a006-20230619   gcc  
x86_64               randconfig-a011-20230619   clang
x86_64               randconfig-a012-20230619   clang
x86_64               randconfig-a013-20230619   clang
x86_64               randconfig-a014-20230619   clang
x86_64               randconfig-a015-20230619   clang
x86_64               randconfig-a016-20230619   clang
x86_64               randconfig-r003-20230619   gcc  
x86_64               randconfig-r014-20230619   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa               randconfig-r021-20230619   gcc  
xtensa               randconfig-r024-20230619   gcc  
xtensa               randconfig-r025-20230619   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
