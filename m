Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E74725334
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjFGFHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjFGFHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:07:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C64A1726
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 22:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686114461; x=1717650461;
  h=date:from:to:cc:subject:message-id;
  bh=+Upeu7MNbK07ic6htbyq2UB7ziJhsMijwHYhiFVpdnM=;
  b=GadpWyGb3vcJsQ6fAp+6RRhFnnkrHjp2FWJNJ4chvXv3xpGI/7fUNvbI
   Ka+ex0cXBNcK26Klpd/vlsJPojNso+P5FK6evBCNAzl8NcmZILX/f4mrI
   rVYGwstherdotm8lSArosUQQKcZDafol9v8IHK3FiZZpYM2GWSuaTWNph
   NNateCV37mqUPPJd/mYIninnCEg5WtIfyR816N44dFt4uaHtt6MsN8Au5
   3hVKKp5eRLoePyHiQotAA1qc3Bt9ELNsde4S9hKeKmSi67Ovc2ETHD5K4
   hnIDLReMbnH40Dyv4tWEwypxuOWTFcnmJKX5WdQe37uI66nApYs/LvyBf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="341537602"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="341537602"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 22:07:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="1039453764"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="1039453764"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jun 2023 22:07:38 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6lOT-0006B1-1h;
        Wed, 07 Jun 2023 05:07:37 +0000
Date:   Wed, 07 Jun 2023 13:06:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230606] BUILD SUCCESS WITH
 WARNING e2af9c6b35f6c39c338b785312947759d0dcdba8
Message-ID: <20230607050639.LzbPn%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230606
branch HEAD: e2af9c6b35f6c39c338b785312947759d0dcdba8  Makefile: Enable -Warray-bounds

Warning: (recently discovered and may have been fixed)

arch/arc/include/asm/atomic-spinlock.h:37:10: warning: array subscript 0 is outside array bounds of 'atomic_t[0]' [-Warray-bounds]
arch/arc/include/asm/io.h:130:9: warning: array subscript 0 is outside array bounds of 'volatile void[0]' [-Warray-bounds]
arch/arc/include/asm/io.h:151:9: warning: array subscript 0 is outside array bounds of 'void[0]' [-Warray-bounds]
arch/arc/include/asm/io.h:54:9: warning: array subscript 0 is outside array bounds of 'const volatile void[0]' [-Warray-bounds]
arch/arm/include/asm/io.h:113:9: warning: array subscript 0 is outside array bounds of 'void[0]' [-Warray-bounds]
arch/arm/mach-omap2/powerdomain.c:178:45: warning: array subscript -22 is below array bounds of 'unsigned int[4]' [-Warray-bounds]
drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1194:25: warning: array subscript 1 is outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
drivers/platform/chrome/cros_ec_vbc.c:36:15: warning: array subscript 'struct ec_params_vbnvcontext[1]' is partly outside array bounds of 'unsigned char[36]' [-Warray-bounds]
include/asm-generic/rwonce.h:55:37: warning: array subscript 0 is outside array bounds of 'atomic_t[0]' [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-r025-20230606
|   `-- arch-arc-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-void
|-- arc-randconfig-r043-20230606
|   |-- arch-arc-include-asm-atomic-spinlock.h:warning:array-subscript-is-outside-array-bounds-of-atomic_t
|   |-- arch-arc-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   |-- arch-arc-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|   |-- drivers-net-ethernet-qlogic-qed-qed_init_fw_funcs.c:warning:array-subscript-is-outside-array-bounds-of-u32-aka-unsigned-int
|   `-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-atomic_t
|-- arm-randconfig-r012-20230606
|   |-- arch-arm-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-void
|   `-- arch-arm-mach-omap2-powerdomain.c:warning:array-subscript-is-below-array-bounds-of-unsigned-int
|-- csky-randconfig-r013-20230606
|   `-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|-- m68k-allmodconfig
|   `-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
`-- riscv-allmodconfig
    `-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char

elapsed time: 721m

configs tested: 122
configs skipped: 4

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230606   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r022-20230606   gcc  
arc                  randconfig-r025-20230606   gcc  
arc                  randconfig-r043-20230606   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r012-20230606   gcc  
arm                  randconfig-r046-20230606   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230606   clang
csky                                defconfig   gcc  
csky                 randconfig-r013-20230606   gcc  
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
i386                 randconfig-r024-20230606   clang
i386                 randconfig-r034-20230606   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r032-20230606   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r026-20230606   gcc  
microblaze   buildonly-randconfig-r004-20230606   gcc  
microblaze           randconfig-r015-20230606   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230606   clang
mips                 randconfig-r001-20230606   clang
mips                 randconfig-r023-20230606   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r003-20230606   gcc  
openrisc             randconfig-r021-20230606   gcc  
parisc       buildonly-randconfig-r001-20230606   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r033-20230606   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230606   clang
riscv                               defconfig   gcc  
riscv                randconfig-r036-20230606   gcc  
riscv                randconfig-r042-20230606   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r014-20230606   clang
s390                 randconfig-r044-20230606   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r006-20230606   gcc  
sh                   randconfig-r035-20230606   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r031-20230606   gcc  
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
x86_64               randconfig-r005-20230606   gcc  
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
xtensa       buildonly-randconfig-r005-20230606   gcc  
xtensa               randconfig-r002-20230606   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
