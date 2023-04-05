Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF146D7C16
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbjDEL7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbjDEL7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:59:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29E29B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 04:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680695954; x=1712231954;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=58xyEvKPE5jfD1PUYUgDWuVGec1ueUIIJT/YpMA95K0=;
  b=HO9nqmb8Hv+vIPbM6cwmAPPm59BArQ06TIT+LopSZK85LjG4hTRk7MNN
   xSKGZak8u6wtl18avqPaWTQ1p7DfjB9AhXPgVU7ibz75zQzGWkRiKGG/m
   WXUyeOiqkQW0LyR1dCAm/tICR94XfJGEj/xglW5LPQqHpGhcPFvO92W9r
   Xgvhc6WhxnamdTGeTGHWgAerKnpp+pQ7bOGFtD2zJLj6KGyq8pBsmfExx
   VkI2LSLb1PCEnf43F5lGQUhcEDUEHYqcV8nZBqPUYYXyspeVfCM1N07Po
   Rbe2Sat2XqHM100y+p3dEMxUp9+nodPS5Zhni125cutbvJHpr0EjTK3Pl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="331033984"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="331033984"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 04:59:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="776030866"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="776030866"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Apr 2023 04:59:12 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pk1nD-000QW1-1C;
        Wed, 05 Apr 2023 11:59:11 +0000
Date:   Wed, 05 Apr 2023 19:58:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 ef971c85bdbd0b1c3d8cd5266ba30b3e8f551d49
Message-ID: <642d627b.QYaDJiuziN2uUPgV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: ef971c85bdbd0b1c3d8cd5266ba30b3e8f551d49  Revert "rcu/kvfree: Eliminate k[v]free_rcu() single argument macro"

elapsed time: 721m

configs tested: 101
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r036-20230403   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r033-20230403   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230403   gcc  
arm                  randconfig-r034-20230403   gcc  
arm                  randconfig-r046-20230403   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230403   gcc  
csky                 randconfig-r013-20230403   gcc  
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r045-20230403   clang
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
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                 randconfig-r022-20230403   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230403   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230403   gcc  
m68k                 randconfig-r014-20230403   gcc  
microblaze   buildonly-randconfig-r005-20230403   gcc  
microblaze           randconfig-r001-20230403   gcc  
microblaze           randconfig-r023-20230403   gcc  
microblaze           randconfig-r024-20230403   gcc  
microblaze           randconfig-r031-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230403   gcc  
nios2        buildonly-randconfig-r004-20230403   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r025-20230403   gcc  
parisc       buildonly-randconfig-r003-20230403   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230403   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230403   clang
riscv                randconfig-r012-20230403   gcc  
riscv                randconfig-r016-20230403   gcc  
riscv                randconfig-r021-20230403   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r035-20230403   clang
s390                 randconfig-r044-20230403   gcc  
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r032-20230403   gcc  
sparc64      buildonly-randconfig-r006-20230403   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64               randconfig-a006-20230403   clang
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-r026-20230403   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
