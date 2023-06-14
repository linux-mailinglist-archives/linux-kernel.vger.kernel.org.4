Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D0972F30B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 05:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242221AbjFNDZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 23:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242693AbjFNDZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 23:25:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4400D1BE8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686713093; x=1718249093;
  h=date:from:to:cc:subject:message-id;
  bh=hVZLNR6+5DpgDnvcasm3E9jsgZlHN/9jwN/kLJDvwWA=;
  b=Be/DSXJqLaeO7VtwzP4DlAARbuyVDnHAAu78xNw9c/G63sWKtW2LoyAb
   7mFUSgtzIbidcoBj4HUa0i0mnY6e1qsueIMKa4C9vEWijinFDWTUS9taM
   3+C/WhHHn5/UckJp0vKdb0lJSnXryriJHufYoqpX7x59ftAU0PXtosvHT
   HYXEqIF4TTn8CwUlLbR9X8KRkgzIpflMB7OEJDWfS8XSFQ2GVdn7LObpi
   B9PNYxvtlSLEcwXeG3FaQbBlCgf6eogYJp3Q1Bk3KmKcqo20rOdUtvmx1
   ydHGf/EDQZZQ91LANK1yNzTEHEIrwkHdbBAbYtprFu2ssRUO0I4Pn01Tk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="424391761"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="424391761"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 20:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="781927955"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="781927955"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jun 2023 20:24:51 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9H7W-00004x-2L;
        Wed, 14 Jun 2023 03:24:30 +0000
Date:   Wed, 14 Jun 2023 11:22:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230613] BUILD SUCCESS WITH
 WARNING aa6560431480d8a66646dee2f0a2185073a11282
Message-ID: <202306141124.HhfLTQK8-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230613
branch HEAD: aa6560431480d8a66646dee2f0a2185073a11282  ARM: OMAP2+: Fix -Warray-bounds warning _pwrdm_state_switch()

Warning: (recently discovered and may have been fixed)

arch/alpha/include/asm/rwonce.h:25:35: warning: array subscript 0 is outside array bounds of 'struct inode[11885788707287082]' [-Warray-bounds]
include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'struct inode[14781044930857012]' [-Warray-bounds]
include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'struct inode[2684354]' [-Warray-bounds]
include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'struct inode[3314017]' [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified bound 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
include/linux/fortify-string.h:59:33: warning: '__builtin_memset' specified bound 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- arch-alpha-include-asm-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-struct-inode
|-- arc-randconfig-r043-20230612
|   `-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-struct-inode
|-- arm-randconfig-r005-20230612
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-exceeds-maximum-object-size
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-specified-bound-exceeds-maximum-object-size
|-- mips-allmodconfig
|   `-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-struct-inode
`-- x86_64-rhel-8.3
    `-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-struct-inode

elapsed time: 729m

configs tested: 105
configs skipped: 7

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r022-20230612   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230612   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230612   gcc  
arm                  randconfig-r046-20230612   clang
arm64                            alldefconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230612   clang
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230612   clang
arm64                randconfig-r011-20230612   gcc  
arm64                randconfig-r036-20230613   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230612   gcc  
hexagon              randconfig-r014-20230612   clang
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r045-20230612   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230612   clang
i386                 randconfig-i002-20230612   clang
i386                 randconfig-i003-20230612   clang
i386                 randconfig-i004-20230612   clang
i386                 randconfig-i005-20230612   clang
i386                 randconfig-i006-20230612   clang
i386                 randconfig-i011-20230613   clang
i386                 randconfig-i012-20230613   clang
i386                 randconfig-i013-20230613   clang
i386                 randconfig-i014-20230613   clang
i386                 randconfig-i015-20230613   clang
i386                 randconfig-i016-20230613   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230612   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r021-20230612   clang
mips                          rm200_defconfig   clang
nios2        buildonly-randconfig-r006-20230612   gcc  
nios2                               defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc             randconfig-r001-20230612   gcc  
openrisc             randconfig-r006-20230612   gcc  
openrisc             randconfig-r024-20230612   gcc  
openrisc             randconfig-r035-20230613   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r001-20230612   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r015-20230612   gcc  
powerpc              randconfig-r034-20230613   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r025-20230612   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r033-20230613   gcc  
sh                           se7724_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r002-20230612   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r004-20230612   gcc  
sparc64              randconfig-r032-20230613   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230613   gcc  
x86_64               randconfig-a002-20230613   gcc  
x86_64               randconfig-a003-20230613   gcc  
x86_64               randconfig-a004-20230613   gcc  
x86_64               randconfig-a005-20230613   gcc  
x86_64               randconfig-a006-20230613   gcc  
x86_64               randconfig-a011-20230612   gcc  
x86_64               randconfig-a012-20230612   gcc  
x86_64               randconfig-a013-20230612   gcc  
x86_64               randconfig-a014-20230612   gcc  
x86_64               randconfig-a015-20230612   gcc  
x86_64               randconfig-a016-20230612   gcc  
x86_64               randconfig-r012-20230612   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
