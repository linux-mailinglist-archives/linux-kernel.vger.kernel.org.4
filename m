Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145EC7256F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239051AbjFGIH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239091AbjFGIHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:07:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90B11989
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686125243; x=1717661243;
  h=date:from:to:cc:subject:message-id;
  bh=icmZgfCr8bAi5cG1UIf5IRJz0GMmanpm01Nuk5uWHw8=;
  b=URFRvBqgy2W2eemYfUCmRcJflhbBFIcRMvAi2VuDa/58B9r3a21ZZ1QM
   6Pte9U618hjBVc9BPSCXxw4T8iCiK0ABqoFDcs01cjMiOUdlpAWxkTl3a
   wpF7IVGGgd2qyxetncFrWVBBoc0UMKcBFpeib2U9ENIG5h4C7NDuIZTGJ
   g10WqJt/MVBsNoppBBpunqOyl+pj9Vuil4vvs+f3chTZuU9wcaeevpQYo
   iF7wW3aI3mR+ITtBCUbbPlsin7uTLMsfKUK6kO09qHRGFQ/01sntyy8ZK
   qGzDHN35o3KKfw8d6G1iRKheV2XIkEyzwG2vXal80WDQNoR/qeXwahHSj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="443286709"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="443286709"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 01:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="833566050"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="833566050"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Jun 2023 01:06:50 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6oBt-0006Mt-2C;
        Wed, 07 Jun 2023 08:06:49 +0000
Date:   Wed, 07 Jun 2023 16:06:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 409bf2895d71bb68bc5b8589036e5ed1ca30bada
Message-ID: <20230607080613.qyDJM%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 409bf2895d71bb68bc5b8589036e5ed1ca30bada  Merge x86/cc into tip/master

elapsed time: 725m

configs tested: 120
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r033-20230606   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230606   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230606   clang
arm                  randconfig-r046-20230606   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r005-20230606   gcc  
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r003-20230606   clang
hexagon              randconfig-r002-20230606   clang
hexagon              randconfig-r016-20230606   clang
hexagon              randconfig-r041-20230606   clang
hexagon              randconfig-r045-20230606   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230606   gcc  
i386                 randconfig-i002-20230606   gcc  
i386                 randconfig-i003-20230606   gcc  
i386                 randconfig-i004-20230606   gcc  
i386                 randconfig-i005-20230606   gcc  
i386                 randconfig-i006-20230606   gcc  
i386                 randconfig-i011-20230606   clang
i386                 randconfig-i012-20230606   clang
i386                 randconfig-i013-20230606   clang
i386                 randconfig-i014-20230606   clang
i386                 randconfig-i015-20230606   clang
i386                 randconfig-i016-20230606   clang
i386                 randconfig-i051-20230606   gcc  
i386                 randconfig-i052-20230606   gcc  
i386                 randconfig-i053-20230606   gcc  
i386                 randconfig-i054-20230606   gcc  
i386                 randconfig-i055-20230606   gcc  
i386                 randconfig-i056-20230606   gcc  
i386                 randconfig-i061-20230606   gcc  
i386                 randconfig-i062-20230606   gcc  
i386                 randconfig-i063-20230606   gcc  
i386                 randconfig-i064-20230606   gcc  
i386                 randconfig-i065-20230606   gcc  
i386                 randconfig-i066-20230606   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r034-20230606   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r004-20230606   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230606   gcc  
m68k                 randconfig-r003-20230606   gcc  
m68k                 randconfig-r032-20230606   gcc  
microblaze           randconfig-r015-20230606   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230606   clang
mips                 randconfig-r021-20230606   gcc  
mips                 randconfig-r024-20230606   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230606   gcc  
nios2                randconfig-r025-20230606   gcc  
openrisc             randconfig-r013-20230606   gcc  
openrisc             randconfig-r022-20230606   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230606   clang
riscv                               defconfig   gcc  
riscv                randconfig-r035-20230606   gcc  
riscv                randconfig-r042-20230606   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r023-20230606   clang
s390                 randconfig-r044-20230606   clang
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r006-20230606   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230606   gcc  
x86_64               randconfig-a002-20230606   gcc  
x86_64               randconfig-a003-20230606   gcc  
x86_64               randconfig-a004-20230606   gcc  
x86_64               randconfig-a005-20230606   gcc  
x86_64               randconfig-a006-20230606   gcc  
x86_64               randconfig-a011-20230606   clang
x86_64               randconfig-a012-20230606   clang
x86_64               randconfig-a013-20230606   clang
x86_64               randconfig-a014-20230606   clang
x86_64               randconfig-a015-20230606   clang
x86_64               randconfig-a016-20230606   clang
x86_64               randconfig-r031-20230606   gcc  
x86_64               randconfig-x051-20230606   clang
x86_64               randconfig-x052-20230606   clang
x86_64               randconfig-x053-20230606   clang
x86_64               randconfig-x054-20230606   clang
x86_64               randconfig-x055-20230606   clang
x86_64               randconfig-x056-20230606   clang
x86_64               randconfig-x061-20230606   clang
x86_64               randconfig-x062-20230606   clang
x86_64               randconfig-x063-20230606   clang
x86_64               randconfig-x064-20230606   clang
x86_64               randconfig-x065-20230606   clang
x86_64               randconfig-x066-20230606   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r005-20230606   gcc  
xtensa               randconfig-r026-20230606   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
