Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA8C6B0B3D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjCHObh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjCHObS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:31:18 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC49C3E27
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678285870; x=1709821870;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fwyCSzUw4zpzexRXo2Tcn9FyeUfcxlYD1ARJ3Rs0Q0U=;
  b=hmZWgtV3kG3E4AuM/7MMGZBUBwtz8wk03Ys/GyEdlxUmEWGYtPNKyST5
   PeG6Sh3fUBeDGi2Fb+hd5busmyyRZ7Q/HOmGY119hMjA2sLY61i8dfo5Z
   6fl9iOGKaUadxFcuvEJ7YlHtyGMXX+MrbJM0UbExp9Nxkkz+7aEvm0eXx
   iodJqiDWH1uFBygSrqAnQq9UJKN/22MGw1+doI04KA/b26LZRuXLdT1WP
   GfqA89CBAJc7ayT/Lv4noOo4wvxA/fKilGcosnToVyA0Yd77+X3AGzWCZ
   6XigLUspfTBbkEcv7HlVFz8LNmkQTTNQXOBgOyG2ZLDloDZ6f2DDo8ZBo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="338491959"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="338491959"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 06:28:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="766005103"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="766005103"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Mar 2023 06:28:47 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZumc-0002B1-1n;
        Wed, 08 Mar 2023 14:28:46 +0000
Date:   Wed, 08 Mar 2023 22:28:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 cd3ad6619517cda3a055d864a85cebbd434dba9a
Message-ID: <64089b99./daZpZBXtKjKRfMU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: cd3ad6619517cda3a055d864a85cebbd434dba9a  tools/x86/kcpuid: Dump the CPUID function in detailed view

elapsed time: 931m

configs tested: 132
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230305   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r005-20230306   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230306   gcc  
arc                  randconfig-r025-20230306   gcc  
arc                  randconfig-r031-20230305   gcc  
arc                  randconfig-r035-20230306   gcc  
arc                  randconfig-r043-20230305   gcc  
arc                  randconfig-r043-20230306   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r031-20230306   clang
arm                  randconfig-r033-20230306   clang
arm                  randconfig-r046-20230305   clang
arm                  randconfig-r046-20230306   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230305   clang
arm64        buildonly-randconfig-r006-20230305   clang
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230306   clang
csky                                defconfig   gcc  
csky                 randconfig-r001-20230305   gcc  
csky                 randconfig-r014-20230305   gcc  
csky                 randconfig-r033-20230305   gcc  
hexagon      buildonly-randconfig-r003-20230305   clang
hexagon              randconfig-r002-20230306   clang
hexagon              randconfig-r024-20230305   clang
hexagon              randconfig-r041-20230305   clang
hexagon              randconfig-r041-20230306   clang
hexagon              randconfig-r045-20230305   clang
hexagon              randconfig-r045-20230306   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230306   gcc  
i386                 randconfig-a002-20230306   gcc  
i386                 randconfig-a003-20230306   gcc  
i386                 randconfig-a004-20230306   gcc  
i386                 randconfig-a005-20230306   gcc  
i386                 randconfig-a006-20230306   gcc  
i386                 randconfig-a011-20230306   clang
i386                 randconfig-a012-20230306   clang
i386                 randconfig-a013-20230306   clang
i386                 randconfig-a014-20230306   clang
i386                 randconfig-a015-20230306   clang
i386                 randconfig-a016-20230306   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r021-20230305   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230305   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230305   gcc  
loongarch            randconfig-r016-20230305   gcc  
loongarch            randconfig-r036-20230305   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r011-20230305   gcc  
m68k                 randconfig-r013-20230305   gcc  
m68k                 randconfig-r023-20230306   gcc  
m68k                 randconfig-r035-20230305   gcc  
microblaze   buildonly-randconfig-r004-20230305   gcc  
microblaze           randconfig-r005-20230305   gcc  
microblaze           randconfig-r015-20230305   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r011-20230306   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230305   gcc  
nios2                randconfig-r026-20230305   gcc  
nios2                randconfig-r036-20230306   gcc  
openrisc     buildonly-randconfig-r002-20230306   gcc  
openrisc             randconfig-r021-20230306   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230305   gcc  
parisc               randconfig-r016-20230306   gcc  
parisc               randconfig-r022-20230306   gcc  
parisc               randconfig-r032-20230306   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r006-20230306   gcc  
powerpc              randconfig-r025-20230305   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r032-20230305   clang
riscv                randconfig-r042-20230305   gcc  
riscv                randconfig-r042-20230306   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230305   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230305   gcc  
s390                 randconfig-r044-20230306   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r012-20230306   gcc  
sh                   randconfig-r013-20230306   gcc  
sh                   randconfig-r034-20230306   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230306   gcc  
sparc64              randconfig-r026-20230306   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r003-20230306   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230306   gcc  
x86_64               randconfig-a002-20230306   gcc  
x86_64               randconfig-a003-20230306   gcc  
x86_64               randconfig-a004-20230306   gcc  
x86_64               randconfig-a005-20230306   gcc  
x86_64               randconfig-a006-20230306   gcc  
x86_64               randconfig-a011-20230306   clang
x86_64               randconfig-a012-20230306   clang
x86_64               randconfig-a013-20230306   clang
x86_64               randconfig-a014-20230306   clang
x86_64               randconfig-a015-20230306   clang
x86_64               randconfig-a016-20230306   clang
x86_64               randconfig-r001-20230306   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230306   gcc  
xtensa               randconfig-r003-20230306   gcc  
xtensa               randconfig-r034-20230305   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
