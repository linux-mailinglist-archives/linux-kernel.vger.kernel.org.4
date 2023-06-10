Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5176372A83A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjFJCQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjFJCQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:16:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C76535A9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 19:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686363363; x=1717899363;
  h=date:from:to:cc:subject:message-id;
  bh=eOFwcUpV0trVEMjunIDYr4XEwHU//uhi2URg20E/m4E=;
  b=YQFy3EAnZoKXDzmqaGs3HyU5cltIeJ2L6p8hEfrllPtH/AI7vnHhnzXj
   EnIWIAW2A+CDekjhO92+1j9Uw1HFDPWYy+wYN5C29KAlqEVBbKIg4xI2Q
   O6+MCHDu4Q5F4aYxDYqUzngwCqfRJcrRhrm9Tw8fNVXYDgjOEOG3FfbeA
   uhw/PQX0icNWJ/rlpmqZuz7969fMI3JK718hC2FECv9XO+oQ6ZuxxKDnP
   lwuCmfjF6MJwXhY/6X7JK3txe3a+Do9yjRIianWsP6+ACvovC1IHjsAdD
   pIsYfkY33kddVGrIg/GD6tLE1lKGQaxn2rZgURDv5yPyG0Tajhr2duFjn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="355211083"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="355211083"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 19:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="800406089"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="800406089"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2023 19:16:02 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7o93-0009bQ-2V;
        Sat, 10 Jun 2023 02:16:01 +0000
Date:   Sat, 10 Jun 2023 10:15:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 5416bf1cf5602ab3a38b4c0d15ccec1ca4199633
Message-ID: <202306101020.nurlegNU-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 5416bf1cf5602ab3a38b4c0d15ccec1ca4199633  arm64/arch_timer: Fix MMIO byteswap

elapsed time: 1090m

configs tested: 151
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230608   gcc  
alpha                randconfig-r023-20230608   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                  randconfig-r005-20230608   gcc  
arc                  randconfig-r016-20230608   gcc  
arc                  randconfig-r025-20230608   gcc  
arc                  randconfig-r043-20230608   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                          moxart_defconfig   clang
arm                  randconfig-r021-20230608   gcc  
arm                  randconfig-r046-20230608   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230608   clang
csky         buildonly-randconfig-r006-20230608   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r015-20230608   gcc  
csky                 randconfig-r026-20230608   gcc  
csky                 randconfig-r035-20230608   gcc  
hexagon      buildonly-randconfig-r001-20230608   clang
hexagon              randconfig-r006-20230608   clang
hexagon              randconfig-r014-20230608   clang
hexagon              randconfig-r041-20230608   clang
hexagon              randconfig-r045-20230608   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230608   gcc  
i386                 randconfig-i002-20230608   gcc  
i386                 randconfig-i003-20230608   gcc  
i386                 randconfig-i004-20230608   gcc  
i386                 randconfig-i005-20230608   gcc  
i386                 randconfig-i006-20230608   gcc  
i386                 randconfig-i011-20230608   clang
i386                 randconfig-i011-20230610   gcc  
i386                 randconfig-i012-20230608   clang
i386                 randconfig-i012-20230610   gcc  
i386                 randconfig-i013-20230608   clang
i386                 randconfig-i013-20230610   gcc  
i386                 randconfig-i014-20230608   clang
i386                 randconfig-i014-20230610   gcc  
i386                 randconfig-i015-20230608   clang
i386                 randconfig-i015-20230610   gcc  
i386                 randconfig-i016-20230608   clang
i386                 randconfig-i016-20230610   gcc  
i386                 randconfig-i051-20230608   gcc  
i386                 randconfig-i052-20230608   gcc  
i386                 randconfig-i053-20230608   gcc  
i386                 randconfig-i054-20230608   gcc  
i386                 randconfig-i055-20230608   gcc  
i386                 randconfig-i056-20230608   gcc  
i386                 randconfig-i061-20230608   gcc  
i386                 randconfig-i062-20230608   gcc  
i386                 randconfig-i063-20230608   gcc  
i386                 randconfig-i064-20230608   gcc  
i386                 randconfig-i065-20230608   gcc  
i386                 randconfig-i066-20230608   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230608   gcc  
loongarch    buildonly-randconfig-r005-20230608   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230608   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r024-20230608   gcc  
microblaze           randconfig-r025-20230608   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                 randconfig-r001-20230608   clang
mips                 randconfig-r002-20230608   clang
mips                 randconfig-r034-20230608   clang
mips                 randconfig-r036-20230608   clang
nios2                               defconfig   gcc  
openrisc     buildonly-randconfig-r002-20230608   gcc  
openrisc             randconfig-r013-20230608   gcc  
openrisc             randconfig-r014-20230608   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r006-20230608   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230608   gcc  
parisc               randconfig-r012-20230608   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                 mpc8560_ads_defconfig   clang
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230608   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230608   clang
sh                               allmodconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                   randconfig-r022-20230608   gcc  
sh                   randconfig-r026-20230608   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r003-20230608   gcc  
sparc                               defconfig   gcc  
sparc64      buildonly-randconfig-r005-20230608   gcc  
sparc64              randconfig-r006-20230608   gcc  
sparc64              randconfig-r011-20230608   gcc  
sparc64              randconfig-r013-20230608   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230608   gcc  
x86_64               randconfig-a002-20230608   gcc  
x86_64               randconfig-a003-20230608   gcc  
x86_64               randconfig-a004-20230608   gcc  
x86_64               randconfig-a005-20230608   gcc  
x86_64               randconfig-a006-20230608   gcc  
x86_64               randconfig-a011-20230608   clang
x86_64               randconfig-a012-20230608   clang
x86_64               randconfig-a013-20230608   clang
x86_64               randconfig-a014-20230608   clang
x86_64               randconfig-a015-20230608   clang
x86_64               randconfig-a016-20230608   clang
x86_64               randconfig-r001-20230608   gcc  
x86_64               randconfig-x051-20230609   gcc  
x86_64               randconfig-x052-20230609   gcc  
x86_64               randconfig-x053-20230609   gcc  
x86_64               randconfig-x054-20230609   gcc  
x86_64               randconfig-x055-20230609   gcc  
x86_64               randconfig-x056-20230609   gcc  
x86_64               randconfig-x061-20230608   clang
x86_64               randconfig-x062-20230608   clang
x86_64               randconfig-x063-20230608   clang
x86_64               randconfig-x064-20230608   clang
x86_64               randconfig-x065-20230608   clang
x86_64               randconfig-x066-20230608   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
