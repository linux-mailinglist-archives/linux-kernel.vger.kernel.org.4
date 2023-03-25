Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3376D6C8C80
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjCYIRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjCYIQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:16:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620B2166E9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679732178; x=1711268178;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Ad7qylK7Qbyp20xOgBKBjg5toHpi65MgkiUuGcEy0yI=;
  b=hClbE3R3ccRgTCcP2MLefYrerVPuKQFnC7a0QlPLIU3ikXpFtjf38pX2
   2WJgVLkupHUAoSazyvOAP2OFc4YHtlQ2vZSNh6MN44B/NUXURvOROlp86
   zbPTzMTkYTdVm9MHG0YRgekx8XS/EnBS+9NwfUOdHogumUo9/2M7nzI7E
   3zskr2UvSOhPEYnYnTkxNPQv0olOi5rkWNH4ouv+X/hyQW104Eoj2Y7CR
   T7InKJo1WTUiOpp04VO5wW9AeLB4Gz6ol1zxDcUb71UiQVYtwGQz0Qlnh
   f+DAor3rhB9UrU+QseBKGBSoFSzSd588V/wBTpR6mfeDus9SfKEf/7Fk2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="323835681"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="323835681"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 01:15:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="713312163"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="713312163"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Mar 2023 01:15:54 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfz46-000G6F-0I;
        Sat, 25 Mar 2023 08:15:54 +0000
Date:   Sat, 25 Mar 2023 16:14:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp] BUILD SUCCESS
 7109385144a3e2dc831211d27ce48b6ccc614777
Message-ID: <641ead80.KA4wBR1J5YNi7/hl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp
branch HEAD: 7109385144a3e2dc831211d27ce48b6ccc614777  uapi: target: Replace fake flex-array with flexible-array member

elapsed time: 731m

configs tested: 153
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230322   gcc  
alpha                randconfig-r026-20230322   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                  randconfig-r001-20230322   gcc  
arc                  randconfig-r001-20230323   gcc  
arc                  randconfig-r002-20230322   gcc  
arc                  randconfig-r034-20230322   gcc  
arc                  randconfig-r035-20230322   gcc  
arc                  randconfig-r043-20230322   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm          buildonly-randconfig-r003-20230324   clang
arm                                 defconfig   gcc  
arm                          moxart_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                  randconfig-r014-20230322   clang
arm                  randconfig-r021-20230322   clang
arm                  randconfig-r025-20230322   clang
arm                  randconfig-r046-20230322   clang
arm                  randconfig-r046-20230324   clang
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230322   gcc  
arm64                randconfig-r025-20230322   gcc  
arm64                randconfig-r031-20230322   clang
csky                                defconfig   gcc  
csky                 randconfig-r011-20230322   gcc  
csky                 randconfig-r012-20230322   gcc  
csky                 randconfig-r016-20230322   gcc  
hexagon                          alldefconfig   clang
hexagon      buildonly-randconfig-r006-20230323   clang
hexagon              randconfig-r031-20230322   clang
hexagon              randconfig-r035-20230322   clang
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
i386                          randconfig-a012   gcc  
i386                          randconfig-a014   gcc  
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230322   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r003-20230323   gcc  
ia64                 randconfig-r011-20230322   gcc  
ia64                 randconfig-r015-20230322   gcc  
ia64                 randconfig-r031-20230322   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230322   gcc  
loongarch            randconfig-r006-20230322   gcc  
loongarch            randconfig-r021-20230322   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230322   gcc  
m68k                 randconfig-r023-20230322   gcc  
microblaze           randconfig-r015-20230322   gcc  
microblaze           randconfig-r036-20230322   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r004-20230322   gcc  
mips                 randconfig-r004-20230322   gcc  
mips                 randconfig-r005-20230322   gcc  
mips                 randconfig-r023-20230322   clang
mips                 randconfig-r036-20230322   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230322   gcc  
nios2                randconfig-r034-20230322   gcc  
openrisc             randconfig-r015-20230322   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230323   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                 mpc832x_mds_defconfig   clang
powerpc                 mpc837x_mds_defconfig   gcc  
powerpc              randconfig-c003-20230322   gcc  
powerpc              randconfig-r004-20230323   gcc  
powerpc              randconfig-r013-20230322   gcc  
powerpc              randconfig-r025-20230322   gcc  
powerpc              randconfig-r035-20230322   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                randconfig-r004-20230322   clang
riscv                randconfig-r024-20230322   gcc  
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230323   clang
s390                                defconfig   gcc  
s390                 randconfig-r014-20230322   gcc  
s390                 randconfig-r016-20230322   gcc  
s390                 randconfig-r031-20230322   clang
s390                 randconfig-r035-20230322   clang
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230322   gcc  
sh                   randconfig-r013-20230322   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230322   gcc  
sparc                randconfig-r006-20230323   gcc  
sparc                randconfig-r011-20230322   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r024-20230322   gcc  
sparc64              randconfig-r033-20230322   gcc  
sparc64              randconfig-r035-20230322   gcc  
um                               alldefconfig   gcc  
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
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r013-20230322   gcc  
xtensa               randconfig-r014-20230322   gcc  
xtensa               randconfig-r022-20230322   gcc  
xtensa               randconfig-r032-20230322   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
