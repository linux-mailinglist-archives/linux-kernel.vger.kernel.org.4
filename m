Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631226FBE76
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjEIE6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEIE6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:58:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EC3468B
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 21:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683608280; x=1715144280;
  h=date:from:to:cc:subject:message-id;
  bh=FoLgchsHuUVvX/U3NY65QuQXWcyU3AvBaOGgO5lmdhg=;
  b=IFh/GfIEDjqKgsUeQn0seEvfCYAVN9ZxMd9SL1DSejCQff3mcgTq4Fwv
   5dqzS2T0upj/PyFuHJwP7ZnDWFw6KXnt6GrS79K3jp7H4JxNiITBLD08J
   LsTE6gCY40XFgOmZVTANpJqfI+RHljvhbz/DkFHQsogzB2NUBzOCTMnqt
   /TaGl2PViSEhP905hh6/W2nBaxYtCiX3OVwmqjMxufghO4X0D/t92tIm4
   YGdtG38Rk3xzUpOh8vuSasf4T75cQJrb1qegGpwPk3LEhsztLYdQXsqcB
   O4aMam8FvMEpb3kXFZtqIMjGQPuCOO7m8Re3BFoW6I+2DrI34YnNOcL6L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="339035328"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="339035328"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 21:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="873030679"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="873030679"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 May 2023 21:57:57 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwFQD-0001im-2r;
        Tue, 09 May 2023 04:57:57 +0000
Date:   Tue, 09 May 2023 12:57:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 b2ad431f6469b58914ee7254302c6dc97f688e54
Message-ID: <20230509045724.WV-se%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: b2ad431f6469b58914ee7254302c6dc97f688e54  tools/x86/kcpuid: Add .gitignore

elapsed time: 730m

configs tested: 129
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230508   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230507   gcc  
alpha                randconfig-r016-20230508   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230507   gcc  
arc                  randconfig-r023-20230507   gcc  
arc                  randconfig-r043-20230507   gcc  
arc                  randconfig-r043-20230508   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230507   gcc  
arm          buildonly-randconfig-r002-20230508   clang
arm          buildonly-randconfig-r003-20230507   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r036-20230508   gcc  
arm                  randconfig-r046-20230507   gcc  
arm                  randconfig-r046-20230508   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r006-20230507   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230507   gcc  
hexagon              randconfig-r041-20230507   clang
hexagon              randconfig-r041-20230508   clang
hexagon              randconfig-r045-20230507   clang
hexagon              randconfig-r045-20230508   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230508   gcc  
i386                 randconfig-a012-20230508   gcc  
i386                 randconfig-a013-20230508   gcc  
i386                 randconfig-a014-20230508   gcc  
i386                 randconfig-a015-20230508   gcc  
i386                 randconfig-a016-20230508   gcc  
i386                 randconfig-r022-20230508   gcc  
i386                 randconfig-r026-20230508   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r014-20230508   gcc  
ia64                 randconfig-r026-20230507   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230508   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230507   gcc  
loongarch            randconfig-r021-20230507   gcc  
loongarch            randconfig-r031-20230508   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r004-20230508   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230508   gcc  
m68k                 randconfig-r016-20230507   gcc  
microblaze   buildonly-randconfig-r002-20230507   gcc  
microblaze   buildonly-randconfig-r005-20230507   gcc  
microblaze           randconfig-r013-20230507   gcc  
microblaze           randconfig-r032-20230508   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r024-20230508   clang
mips                 randconfig-r033-20230508   gcc  
mips                 randconfig-r035-20230507   clang
nios2                               defconfig   gcc  
nios2                randconfig-r015-20230507   gcc  
nios2                randconfig-r015-20230508   gcc  
nios2                randconfig-r021-20230508   gcc  
nios2                randconfig-r022-20230507   gcc  
nios2                randconfig-r031-20230507   gcc  
nios2                randconfig-r034-20230508   gcc  
openrisc             randconfig-r023-20230508   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r002-20230507   gcc  
powerpc              randconfig-r033-20230507   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230507   clang
riscv        buildonly-randconfig-r005-20230508   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r025-20230507   clang
riscv                randconfig-r042-20230507   clang
riscv                randconfig-r042-20230508   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230508   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230507   clang
s390                 randconfig-r044-20230508   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r014-20230507   gcc  
sh                   randconfig-r032-20230507   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230507   gcc  
sparc64              randconfig-r011-20230508   gcc  
sparc64              randconfig-r024-20230507   gcc  
sparc64              randconfig-r035-20230508   gcc  
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
x86_64               randconfig-a011-20230508   gcc  
x86_64               randconfig-a012-20230508   gcc  
x86_64               randconfig-a013-20230508   gcc  
x86_64               randconfig-a014-20230508   gcc  
x86_64               randconfig-a015-20230508   gcc  
x86_64               randconfig-a016-20230508   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r012-20230507   gcc  
xtensa               randconfig-r025-20230508   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
