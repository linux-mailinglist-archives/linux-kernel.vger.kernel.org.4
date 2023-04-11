Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7F66DE58D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDKUQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDKUQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:16:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFE3A1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681244189; x=1712780189;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1qpeho+TLRHbL6reUHmvBMUdMvEFJMVG2POWE/NLLGE=;
  b=DXkko1soegI+ShvnjMbywwDIjyGUlBNeHrHRz0XZA3JfapzGxkHyp17W
   gdlya3rkmzJtok1dX65DzwYudyY8Dt7ubqSPC2uMG045TY7WukXAaJHrV
   pcp/8+wLF/jDLFrfA44To7tzK4RqGk975ubhRZS8KCyFIEr2zqkciN682
   OvL+VYV4iIduFnQLZNu5MbjtpfrVBFLu2qL4DFCFFeEqxmt0W3We2dehD
   GxVIKNuxZa1kv9NYgQr/iXyEraFfCm2+ChD1lJYO85mjax4Sn51kdHG9U
   WETR+Mo6eOKaRGyjSHfxRv1lfBeUpGfRA0K22HjtGt+bmciyocggUnAbU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="345516719"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="345516719"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 13:16:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="863037495"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="863037495"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 11 Apr 2023 13:16:27 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmKPi-000Wfk-14;
        Tue, 11 Apr 2023 20:16:26 +0000
Date:   Wed, 12 Apr 2023 04:15:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f91f9332d78265ccf24c2b773adbb5ff83b95db2
Message-ID: <6435bff4.NGf6X14qimsQA3cS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f91f9332d78265ccf24c2b773adbb5ff83b95db2  Merge branch into tip/master: 'x86/tdx'

elapsed time: 725m

configs tested: 174
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230410   gcc  
alpha                randconfig-r004-20230409   gcc  
alpha                randconfig-r034-20230409   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230410   gcc  
arc                  randconfig-r005-20230410   gcc  
arc                  randconfig-r031-20230409   gcc  
arc                  randconfig-r034-20230409   gcc  
arc                  randconfig-r035-20230410   gcc  
arc                  randconfig-r043-20230409   gcc  
arc                  randconfig-r043-20230410   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r005-20230410   clang
arm                                 defconfig   gcc  
arm                        multi_v5_defconfig   clang
arm                  randconfig-r012-20230409   clang
arm                  randconfig-r033-20230410   gcc  
arm                  randconfig-r046-20230409   clang
arm                  randconfig-r046-20230410   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230409   clang
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230409   clang
arm64                randconfig-r021-20230410   gcc  
csky         buildonly-randconfig-r002-20230409   gcc  
csky         buildonly-randconfig-r006-20230409   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r021-20230410   gcc  
csky                 randconfig-r022-20230410   gcc  
csky                 randconfig-r034-20230410   gcc  
csky                 randconfig-r036-20230410   gcc  
hexagon              randconfig-r011-20230409   clang
hexagon              randconfig-r012-20230411   clang
hexagon              randconfig-r026-20230410   clang
hexagon              randconfig-r041-20230409   clang
hexagon              randconfig-r041-20230410   clang
hexagon              randconfig-r045-20230409   clang
hexagon              randconfig-r045-20230410   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r003-20230410   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
i386                 randconfig-r006-20230410   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230409   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r004-20230410   gcc  
ia64                 randconfig-r006-20230410   gcc  
ia64                 randconfig-r016-20230411   gcc  
ia64                 randconfig-r024-20230410   gcc  
ia64                 randconfig-r025-20230409   gcc  
ia64                 randconfig-r031-20230410   gcc  
ia64                 randconfig-r036-20230410   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230409   gcc  
loongarch            randconfig-r015-20230411   gcc  
loongarch            randconfig-r021-20230409   gcc  
loongarch            randconfig-r034-20230410   gcc  
loongarch            randconfig-r036-20230409   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230409   gcc  
m68k                 randconfig-r025-20230410   gcc  
microblaze           randconfig-r025-20230409   gcc  
microblaze           randconfig-r035-20230409   gcc  
microblaze           randconfig-r035-20230410   gcc  
microblaze           randconfig-r036-20230410   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r001-20230409   gcc  
mips                 randconfig-r001-20230410   gcc  
mips                 randconfig-r011-20230410   clang
mips                 randconfig-r031-20230410   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230409   gcc  
nios2                randconfig-r002-20230409   gcc  
nios2                randconfig-r023-20230410   gcc  
nios2                randconfig-r024-20230409   gcc  
nios2                randconfig-r032-20230409   gcc  
nios2                randconfig-r035-20230409   gcc  
openrisc     buildonly-randconfig-r002-20230410   gcc  
openrisc     buildonly-randconfig-r004-20230409   gcc  
openrisc     buildonly-randconfig-r004-20230410   gcc  
openrisc             randconfig-r002-20230409   gcc  
openrisc             randconfig-r031-20230410   gcc  
openrisc             randconfig-r032-20230410   gcc  
openrisc             randconfig-r033-20230410   gcc  
openrisc             randconfig-r036-20230409   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230411   gcc  
parisc               randconfig-r024-20230409   gcc  
parisc               randconfig-r032-20230409   gcc  
parisc               randconfig-r034-20230409   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230410   gcc  
powerpc      buildonly-randconfig-r006-20230409   gcc  
powerpc                       ebony_defconfig   clang
powerpc              randconfig-r002-20230410   clang
powerpc              randconfig-r006-20230409   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230409   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r025-20230410   gcc  
riscv                randconfig-r035-20230409   clang
riscv                randconfig-r042-20230409   gcc  
riscv                randconfig-r042-20230410   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230409   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230409   gcc  
s390                 randconfig-r044-20230410   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230410   gcc  
sh                   randconfig-r021-20230409   gcc  
sh                   randconfig-r022-20230409   gcc  
sh                   randconfig-r033-20230409   gcc  
sh                   randconfig-r033-20230410   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230410   gcc  
sparc                randconfig-r031-20230409   gcc  
sparc                randconfig-r032-20230409   gcc  
sparc                randconfig-r033-20230409   gcc  
sparc64      buildonly-randconfig-r001-20230409   gcc  
sparc64              randconfig-r026-20230409   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230410   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230410   clang
x86_64               randconfig-a003-20230410   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230410   clang
x86_64               randconfig-a005-20230410   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230410   clang
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230410   gcc  
xtensa               randconfig-r005-20230409   gcc  
xtensa               randconfig-r005-20230410   gcc  
xtensa               randconfig-r023-20230410   gcc  
xtensa               randconfig-r034-20230410   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
