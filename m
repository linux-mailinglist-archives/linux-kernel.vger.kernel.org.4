Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36B46C8BDB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjCYGpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCYGo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:44:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E125614EA0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679726697; x=1711262697;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=853iA6IXA2UNkvrdjUGW3EV63l2t4qGwxs6QL6BdF8c=;
  b=oJAZqBqMavKi/KPnH46mSx0xnYtmbq8OX4Bblbj98al8GIABdB2OkJD6
   uMYDMHMZR0kLPq01n0soGnc9oDPCjvXXoLO33TKDaJxl5suERFImz/DHd
   Lh7z8W/ciTmBEQ5qu8ZLrV+ujaIous4YNimHje/Q0bf24WWLJFwt2Eoo1
   MIlUrwaLEeinuzZ4SrivLCNnRVYBkUI0MpzPkqZqwXSubCzW8i0kC2otH
   Szt9GbierQQxGgmBUDmJ0s+X/jK0gGvxgW1Xl4wXN9A/mHb/a+6/sU9la
   7iP+ZtO64nPfOWwQx75qvn1uyrGyrkjfG3qv3ccUUVptIhpybF5OOgYLG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="338667193"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="338667193"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 23:44:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="1012523802"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="1012523802"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Mar 2023 23:44:56 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfxdy-000G1x-2v;
        Sat, 25 Mar 2023 06:44:50 +0000
Date:   Sat, 25 Mar 2023 14:44:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.03.23a] BUILD SUCCESS
 cf6765834b843c1a8efac7797dd43b7271b6a614
Message-ID: <641e9844.zF6YDiFPougKyB9/%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.03.23a
branch HEAD: cf6765834b843c1a8efac7797dd43b7271b6a614  srcu: Check for readers at module-exit time

Unverified Warning (likely false positive, please contact us if interested):

arch/mips/kernel/process.c:46:1: warning: 'noreturn' function does return

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- mips-randconfig-r005-20230322
    `-- arch-mips-kernel-process.c:warning:noreturn-function-does-return

elapsed time: 729m

configs tested: 116
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230322   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r005-20230324   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r023-20230323   gcc  
arc                  randconfig-r043-20230322   gcc  
arc                  randconfig-r043-20230324   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230322   gcc  
arm                  randconfig-r023-20230322   clang
arm                  randconfig-r025-20230322   clang
arm                  randconfig-r036-20230324   gcc  
arm                  randconfig-r046-20230322   clang
arm                  randconfig-r046-20230324   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r025-20230323   clang
csky                                defconfig   gcc  
csky                 randconfig-r012-20230322   gcc  
hexagon              randconfig-r033-20230322   clang
hexagon              randconfig-r033-20230324   clang
hexagon              randconfig-r041-20230322   clang
hexagon              randconfig-r041-20230324   clang
hexagon              randconfig-r045-20230322   clang
hexagon              randconfig-r045-20230324   clang
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
ia64         buildonly-randconfig-r004-20230324   gcc  
ia64         buildonly-randconfig-r006-20230324   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r004-20230322   gcc  
ia64                 randconfig-r005-20230322   gcc  
ia64                 randconfig-r013-20230322   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230322   gcc  
nios2                randconfig-r015-20230322   gcc  
nios2                randconfig-r024-20230323   gcc  
nios2                randconfig-r026-20230322   gcc  
openrisc             randconfig-r016-20230322   gcc  
openrisc             randconfig-r026-20230323   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r021-20230323   gcc  
parisc               randconfig-r036-20230322   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230324   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230322   clang
riscv                randconfig-r034-20230324   clang
riscv                randconfig-r042-20230322   gcc  
riscv                randconfig-r042-20230324   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230324   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230322   gcc  
s390                 randconfig-r044-20230324   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r022-20230323   gcc  
sh                   randconfig-r024-20230322   gcc  
sh                   randconfig-r034-20230322   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r001-20230322   gcc  
sparc64              randconfig-r002-20230322   gcc  
sparc64              randconfig-r035-20230324   gcc  
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
xtensa       buildonly-randconfig-r002-20230324   gcc  
xtensa               randconfig-r032-20230324   gcc  
xtensa               randconfig-r035-20230322   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
