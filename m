Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC877272B1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjFGXFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjFGXFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:05:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C61C2113
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686179099; x=1717715099;
  h=date:from:to:cc:subject:message-id;
  bh=qMrI3WPLL7IhRLcgYFDUJPW+m1pL4ba3Lz4/hDBJDh8=;
  b=Lbt28+xuELYScSFe6NvKp6++YPpIA+irOrHMZ7GzHYAyhi1lBkDUiLqZ
   qUD2F3kGpuU9StbHGwTJgDC0jpbWDPRlnBxRHtmbUs0TVGG6HAin6Rpr7
   EIuF0+K5zj2SjY/Z5npWvPSPGekRfkJFXZnaZfbB+APyJ+zGpnieITojC
   z6ybV6aqi6csXC8htt9PM1ONsSli3SEbmxUl+Px4+F+8bTgjZLdOEOYEp
   i2VZ/UVr9fK1J+ccy+BWI0ItE0/XIVaHAqFHn58CuEFmxdnt8oyykyp6I
   YsISYKtlkTOIFzQckVCF5j4s0Abm7Pc1VWJFsVpx2VDxwWEpPKa/aaO6b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="422979946"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="422979946"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 16:04:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="742877388"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="742877388"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2023 16:04:56 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q72D2-0006za-0O;
        Wed, 07 Jun 2023 23:04:56 +0000
Date:   Thu, 08 Jun 2023 07:04:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 7e980867ced0037a65f588971b89769857b77aab
Message-ID: <20230607230440.ZeeAV%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 7e980867ced0037a65f588971b89769857b77aab  x86/mm: Remove repeated word in comments

elapsed time: 724m

configs tested: 187
configs skipped: 86

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230607   gcc  
alpha        buildonly-randconfig-r005-20230607   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230607   gcc  
alpha                randconfig-r033-20230607   gcc  
alpha                randconfig-r036-20230607   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc          buildonly-randconfig-r001-20230607   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                  randconfig-r006-20230607   gcc  
arc                  randconfig-r012-20230607   gcc  
arc                  randconfig-r023-20230607   gcc  
arc                  randconfig-r024-20230607   gcc  
arc                  randconfig-r025-20230607   gcc  
arc                  randconfig-r043-20230607   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230607   gcc  
arm                  randconfig-r004-20230607   gcc  
arm                  randconfig-r013-20230607   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230607   clang
csky         buildonly-randconfig-r001-20230607   gcc  
csky         buildonly-randconfig-r006-20230607   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230607   gcc  
hexagon              randconfig-r003-20230607   clang
hexagon              randconfig-r004-20230607   clang
hexagon              randconfig-r015-20230607   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230607   clang
i386                 randconfig-i002-20230607   clang
i386                 randconfig-i003-20230607   clang
i386                 randconfig-i004-20230607   clang
i386                 randconfig-i005-20230607   clang
i386                 randconfig-i006-20230607   clang
i386                 randconfig-i011-20230607   gcc  
i386                 randconfig-i012-20230607   gcc  
i386                 randconfig-i013-20230607   gcc  
i386                 randconfig-i014-20230607   gcc  
i386                 randconfig-i015-20230607   gcc  
i386                 randconfig-i016-20230607   gcc  
i386                 randconfig-i051-20230607   clang
i386                 randconfig-i052-20230607   clang
i386                 randconfig-i053-20230607   clang
i386                 randconfig-i054-20230607   clang
i386                 randconfig-i055-20230607   clang
i386                 randconfig-i056-20230607   clang
i386                 randconfig-i061-20230607   clang
i386                 randconfig-i062-20230607   clang
i386                 randconfig-i063-20230607   clang
i386                 randconfig-i064-20230607   clang
i386                 randconfig-i065-20230607   clang
i386                 randconfig-i066-20230607   clang
i386                 randconfig-r033-20230607   clang
i386                 randconfig-r034-20230607   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r004-20230607   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230607   gcc  
loongarch            randconfig-r013-20230607   gcc  
m68k                             allmodconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k         buildonly-randconfig-r003-20230607   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r001-20230607   gcc  
m68k                 randconfig-r036-20230607   gcc  
m68k                           virt_defconfig   gcc  
microblaze   buildonly-randconfig-r002-20230607   gcc  
microblaze           randconfig-r002-20230607   gcc  
microblaze           randconfig-r016-20230607   gcc  
microblaze           randconfig-r021-20230607   gcc  
microblaze           randconfig-r023-20230607   gcc  
microblaze           randconfig-r034-20230607   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips         buildonly-randconfig-r001-20230607   gcc  
mips         buildonly-randconfig-r006-20230607   gcc  
nios2        buildonly-randconfig-r004-20230607   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r022-20230607   gcc  
nios2                randconfig-r024-20230607   gcc  
openrisc     buildonly-randconfig-r003-20230607   gcc  
openrisc             randconfig-r006-20230607   gcc  
openrisc             randconfig-r025-20230607   gcc  
openrisc             randconfig-r031-20230607   gcc  
openrisc             randconfig-r035-20230607   gcc  
parisc       buildonly-randconfig-r005-20230607   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r025-20230607   gcc  
parisc               randconfig-r031-20230607   gcc  
parisc               randconfig-r035-20230607   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230607   gcc  
powerpc                 mpc8540_ads_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc              randconfig-r005-20230607   clang
powerpc              randconfig-r006-20230607   clang
powerpc              randconfig-r015-20230607   gcc  
powerpc              randconfig-r026-20230607   gcc  
powerpc              randconfig-r031-20230607   clang
powerpc                     tqm8555_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230607   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230607   clang
riscv                randconfig-r015-20230607   gcc  
riscv                randconfig-r022-20230607   gcc  
riscv                randconfig-r042-20230607   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230607   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230607   clang
s390                 randconfig-r032-20230607   clang
s390                 randconfig-r044-20230607   gcc  
sh                               allmodconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                   randconfig-r024-20230607   gcc  
sh                   randconfig-r032-20230607   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc        buildonly-randconfig-r005-20230607   gcc  
sparc        buildonly-randconfig-r006-20230607   gcc  
sparc                               defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64      buildonly-randconfig-r003-20230607   gcc  
sparc64      buildonly-randconfig-r004-20230607   gcc  
sparc64              randconfig-r004-20230607   gcc  
sparc64              randconfig-r011-20230607   gcc  
sparc64              randconfig-r014-20230607   gcc  
sparc64              randconfig-r033-20230607   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230607   clang
x86_64               randconfig-a002-20230607   clang
x86_64               randconfig-a003-20230607   clang
x86_64               randconfig-a004-20230607   clang
x86_64               randconfig-a005-20230607   clang
x86_64               randconfig-a006-20230607   clang
x86_64               randconfig-a011-20230607   gcc  
x86_64               randconfig-a012-20230607   gcc  
x86_64               randconfig-a013-20230607   gcc  
x86_64               randconfig-a014-20230607   gcc  
x86_64               randconfig-a015-20230607   gcc  
x86_64               randconfig-a016-20230607   gcc  
x86_64               randconfig-r005-20230607   clang
x86_64               randconfig-r036-20230607   clang
x86_64               randconfig-x051-20230607   gcc  
x86_64               randconfig-x052-20230607   gcc  
x86_64               randconfig-x053-20230607   gcc  
x86_64               randconfig-x054-20230607   gcc  
x86_64               randconfig-x055-20230607   gcc  
x86_64               randconfig-x056-20230607   gcc  
x86_64               randconfig-x061-20230607   gcc  
x86_64               randconfig-x062-20230607   gcc  
x86_64               randconfig-x063-20230607   gcc  
x86_64               randconfig-x064-20230607   gcc  
x86_64               randconfig-x065-20230607   gcc  
x86_64               randconfig-x066-20230607   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230607   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r001-20230607   gcc  
xtensa               randconfig-r021-20230607   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
