Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887986BCD0B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjCPKnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCPKnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:43:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF4D3C79B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678963410; x=1710499410;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3csk5FsH8ikkS43LBzzYoTc5beiYXeKq1hQdfqJC8rs=;
  b=X4iUb2whUC1i74kskkhCuDTMiJPYRuqzakOyWAq0G0HTV4GXLoXsDxGt
   8qSc6qPG/BhFGvJtknLl0CF+7U8Jf9L/9mhoJFM4uoIRK2JCSlRHLjQMo
   6WM6BMCRigtsakRZoOn4QL5K2uwDqcue0B6zYW8vfJptou+Bf5whrCxqD
   QJ2vBy/gWTidNPM//I6X5X1NX+SBd1auCkkYMUprZUG5QRI2NFLIw4WRH
   bP+Suy/osXaCW35P7kwyimOWOkg5ijRpm/Xoj79Ty5MigAAzVwDPqEcHQ
   50Wjk3q076zTl7hFXwoA/xjpNEY5BRJdGvL0VsER7zkEIcLItNbHUq6Wd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="326304821"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="326304821"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 03:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="712305723"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="712305723"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 16 Mar 2023 03:43:28 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcl4x-0008TS-2s;
        Thu, 16 Mar 2023 10:43:27 +0000
Date:   Thu, 16 Mar 2023 18:43:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 0424a7dfe9129b93f29b277511a60e87f052ac6b
Message-ID: <6412f2c9.ALvpvoCD0Py35EMD%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 0424a7dfe9129b93f29b277511a60e87f052ac6b  x86/resctrl: Clear staged_config[] before and after it is used

elapsed time: 721m

configs tested: 171
configs skipped: 142

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230313   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230313   gcc  
alpha                randconfig-r021-20230312   gcc  
alpha                randconfig-r031-20230313   gcc  
alpha                randconfig-r033-20230313   gcc  
alpha                randconfig-r034-20230313   gcc  
alpha                randconfig-r036-20230313   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230312   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230312   gcc  
arc                  randconfig-r014-20230312   gcc  
arc                  randconfig-r022-20230313   gcc  
arc                  randconfig-r026-20230312   gcc  
arc                  randconfig-r026-20230315   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                  randconfig-r006-20230313   clang
arm                  randconfig-r013-20230313   gcc  
arm                  randconfig-r016-20230313   gcc  
arm                  randconfig-r021-20230315   gcc  
arm                  randconfig-r025-20230313   gcc  
arm                  randconfig-r026-20230313   gcc  
arm                  randconfig-r046-20230312   clang
arm                         s3c6400_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230312   clang
arm64                randconfig-r005-20230313   gcc  
arm64                randconfig-r006-20230312   clang
arm64                randconfig-r011-20230312   gcc  
arm64                randconfig-r034-20230312   clang
arm64                randconfig-r035-20230313   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230313   gcc  
csky                 randconfig-r011-20230313   gcc  
csky                 randconfig-r012-20230313   gcc  
csky                 randconfig-r032-20230312   gcc  
hexagon      buildonly-randconfig-r004-20230312   clang
hexagon      buildonly-randconfig-r005-20230313   clang
hexagon              randconfig-r015-20230312   clang
hexagon              randconfig-r035-20230313   clang
hexagon              randconfig-r041-20230312   clang
hexagon              randconfig-r041-20230313   clang
hexagon              randconfig-r045-20230312   clang
hexagon              randconfig-r045-20230313   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230313   gcc  
i386                 randconfig-a002-20230313   gcc  
i386                 randconfig-a003-20230313   gcc  
i386                 randconfig-a004-20230313   gcc  
i386                 randconfig-a005-20230313   gcc  
i386                 randconfig-a006-20230313   gcc  
i386                 randconfig-a011-20230313   clang
i386                 randconfig-a012-20230313   clang
i386                 randconfig-a013-20230313   clang
i386                 randconfig-a014-20230313   clang
i386                 randconfig-a015-20230313   clang
i386                 randconfig-a016-20230313   clang
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230312   gcc  
ia64                                defconfig   gcc  
ia64                        generic_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r022-20230312   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230312   gcc  
m68k                 randconfig-r014-20230313   gcc  
m68k                 randconfig-r015-20230313   gcc  
m68k                 randconfig-r016-20230312   gcc  
m68k                 randconfig-r023-20230315   gcc  
m68k                           virt_defconfig   gcc  
microblaze   buildonly-randconfig-r002-20230313   gcc  
microblaze           randconfig-r011-20230312   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                 randconfig-r003-20230312   gcc  
mips                 randconfig-r013-20230312   clang
mips                 randconfig-r022-20230313   gcc  
mips                 randconfig-r034-20230313   clang
nios2        buildonly-randconfig-r003-20230312   gcc  
nios2        buildonly-randconfig-r005-20230313   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230312   gcc  
nios2                randconfig-r013-20230312   gcc  
nios2                randconfig-r015-20230312   gcc  
nios2                randconfig-r025-20230313   gcc  
nios2                randconfig-r026-20230312   gcc  
nios2                randconfig-r031-20230312   gcc  
openrisc             randconfig-r022-20230315   gcc  
openrisc             randconfig-r026-20230312   gcc  
openrisc             randconfig-r032-20230313   gcc  
parisc       buildonly-randconfig-r006-20230313   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230313   gcc  
parisc               randconfig-r026-20230313   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230313   clang
powerpc      buildonly-randconfig-r004-20230313   clang
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc              randconfig-r015-20230312   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230313   gcc  
riscv                randconfig-r022-20230312   gcc  
riscv                randconfig-r024-20230312   gcc  
riscv                randconfig-r042-20230313   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230312   gcc  
s390                 randconfig-r025-20230312   gcc  
s390                 randconfig-r044-20230313   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230312   gcc  
sh                   randconfig-r023-20230313   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230312   gcc  
sparc                randconfig-r024-20230312   gcc  
sparc                randconfig-r025-20230315   gcc  
sparc                randconfig-r034-20230312   gcc  
sparc64              randconfig-r006-20230313   gcc  
sparc64              randconfig-r024-20230312   gcc  
sparc64              randconfig-r025-20230313   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230313   gcc  
x86_64               randconfig-a002-20230313   gcc  
x86_64               randconfig-a003-20230313   gcc  
x86_64               randconfig-a004-20230313   gcc  
x86_64               randconfig-a005-20230313   gcc  
x86_64               randconfig-a006-20230313   gcc  
x86_64               randconfig-a011-20230313   clang
x86_64               randconfig-a012-20230313   clang
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230313   clang
x86_64               randconfig-a014-20230313   clang
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230313   clang
x86_64               randconfig-a016-20230313   clang
x86_64                        randconfig-a016   clang
x86_64               randconfig-k001-20230313   clang
x86_64               randconfig-r016-20230313   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230312   gcc  
xtensa               randconfig-r005-20230312   gcc  
xtensa               randconfig-r016-20230312   gcc  
xtensa               randconfig-r021-20230313   gcc  
xtensa               randconfig-r023-20230312   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
