Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE208733DBB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 05:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjFQDNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 23:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjFQDNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 23:13:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815461A4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 20:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686971590; x=1718507590;
  h=date:from:to:cc:subject:message-id;
  bh=Xuevrl4UD5tRJA0iGWf5yDyNuai5xuNrGonHxJqyJ4Q=;
  b=BV0NN2Z90Djhe7iMvjiyBWa694NmO3HsCpzPtl96bGM7mLfs1Zy+GhLH
   0jZnXOSuvJgM+HFwxCsLcGilonb06lF1JoXbZ+wY6Ky/mR0UuTiiLs/bt
   BS0YwFqCE9f5+Yf5xppaB1JH24nVhvvgLOYZ/AgQFAtcRbnU4X+YJkGl4
   rAn/fuct4jH8PI2/eK34NNQ1IcWT7WEDB2eX95pWTRPmAnBjZnj+qFOSI
   bHQYnAmQoNU/3XK5oRu30iCPSrlaJQFrLZYZIkM7ahyOlv618Oa/4wMxx
   k6lBcfdoP/oW/UqLCdUbLB991BvYTKAYwOiasdamaivfZJEuVXfATJdRY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="361890412"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="361890412"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 20:13:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="783146028"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="783146028"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jun 2023 20:13:08 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qAMN9-00028w-37;
        Sat, 17 Jun 2023 03:13:07 +0000
Date:   Sat, 17 Jun 2023 11:12:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 a6742cb90b567f952a95efa27dee345748d09fc7
Message-ID: <202306171155.yWTrkacL-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/urgent
branch HEAD: a6742cb90b567f952a95efa27dee345748d09fc7  perf/x86/intel: Fix the FRONTEND encoding on GNR and MTL

elapsed time: 722m

configs tested: 120
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230616   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r022-20230616   gcc  
arc                  randconfig-r025-20230616   gcc  
arc                  randconfig-r043-20230616   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r021-20230616   clang
arm                  randconfig-r025-20230616   clang
arm                  randconfig-r034-20230616   gcc  
arm                  randconfig-r046-20230616   clang
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r033-20230616   clang
csky                                defconfig   gcc  
csky                 randconfig-r002-20230616   gcc  
csky                 randconfig-r005-20230616   gcc  
csky                 randconfig-r026-20230616   gcc  
csky                 randconfig-r035-20230616   gcc  
hexagon              randconfig-r036-20230616   clang
hexagon              randconfig-r041-20230616   clang
hexagon              randconfig-r045-20230616   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230616   clang
i386                 randconfig-i002-20230616   clang
i386                 randconfig-i003-20230616   clang
i386                 randconfig-i004-20230616   clang
i386                 randconfig-i005-20230616   clang
i386                 randconfig-i006-20230616   clang
i386                 randconfig-i011-20230616   gcc  
i386                 randconfig-i012-20230616   gcc  
i386                 randconfig-i013-20230616   gcc  
i386                 randconfig-i014-20230616   gcc  
i386                 randconfig-i015-20230616   gcc  
i386                 randconfig-i016-20230616   gcc  
i386                 randconfig-r024-20230616   gcc  
i386                 randconfig-r033-20230616   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230616   gcc  
loongarch            randconfig-r012-20230616   gcc  
loongarch            randconfig-r013-20230616   gcc  
loongarch            randconfig-r014-20230616   gcc  
loongarch            randconfig-r015-20230616   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230616   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze           randconfig-r012-20230616   gcc  
microblaze           randconfig-r026-20230616   gcc  
microblaze           randconfig-r032-20230616   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                 randconfig-r024-20230616   clang
mips                 randconfig-r034-20230616   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r001-20230616   gcc  
openrisc             randconfig-r003-20230616   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230616   gcc  
parisc               randconfig-r016-20230616   gcc  
parisc               randconfig-r023-20230616   gcc  
parisc               randconfig-r025-20230616   gcc  
parisc               randconfig-r031-20230616   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r014-20230616   gcc  
powerpc              randconfig-r033-20230616   clang
powerpc              randconfig-r036-20230616   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230616   gcc  
riscv                randconfig-r021-20230616   gcc  
riscv                randconfig-r042-20230616   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230616   clang
s390                 randconfig-r013-20230616   gcc  
s390                 randconfig-r021-20230616   gcc  
s390                 randconfig-r044-20230616   gcc  
sh                               allmodconfig   gcc  
sh                            migor_defconfig   gcc  
sh                   randconfig-r002-20230616   gcc  
sh                   randconfig-r035-20230616   gcc  
sh                           se7722_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230616   gcc  
sparc64              randconfig-r016-20230616   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r031-20230616   gcc  
um                   randconfig-r032-20230616   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r003-20230616   clang
x86_64               randconfig-r024-20230616   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r005-20230616   gcc  
xtensa               randconfig-r022-20230616   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
