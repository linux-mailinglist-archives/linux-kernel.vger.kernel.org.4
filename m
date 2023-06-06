Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0624D723519
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 04:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjFFCNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 22:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjFFCNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 22:13:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BF612A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 19:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686017622; x=1717553622;
  h=date:from:to:cc:subject:message-id;
  bh=2mk0vSFpdMSXpM/xsoqQdP5eNci2t+J93taVmZZtpfs=;
  b=kcDGSTc2WTvlP6LrhnTkPZMUsN8MS9HmYlxNvsrt+RirqgzgeCeeWFSr
   7Y2+xBtNJc+UUoHPsqENGjHhJzQHTeXlBb9xd2d3OMwmDebk4p4HLt7S3
   XrvUQ8wg+2v9ARzmW8xLKxK/Ioe68kC2eGULnSitNBElQ0a2J7iW8l87f
   Utn4kCEAGihFY6+/qg9jH3TSQPSmPUkMgoQ3W6849SRlVw6r8AYGyp1FK
   P08is07nEYbpcPjrLwoUyz+dEohRjsxUsraFOLbh042FkIxCDGq205RFl
   qhk0FwEUukPZr9dXJvZ9o/exnDT/h01Xle8dJxJSAL3xQsG+E5bvMsL5j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422364638"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422364638"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 19:13:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="778797434"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="778797434"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jun 2023 19:13:40 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6MCZ-0004hR-0K;
        Tue, 06 Jun 2023 02:13:39 +0000
Date:   Tue, 06 Jun 2023 10:13:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 1b474896156b1b30e37dcd1f98e79875cf505090
Message-ID: <20230606021326.AvZZC%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 1b474896156b1b30e37dcd1f98e79875cf505090  EDAC/amd64: Cache and use GPU node map

elapsed time: 722m

configs tested: 202
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230605   gcc  
alpha        buildonly-randconfig-r004-20230605   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r016-20230605   gcc  
alpha                randconfig-r026-20230605   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230605   gcc  
arc          buildonly-randconfig-r006-20230605   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230605   gcc  
arc                  randconfig-r015-20230605   gcc  
arc                  randconfig-r022-20230605   gcc  
arc                  randconfig-r026-20230605   gcc  
arc                  randconfig-r043-20230605   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r031-20230605   gcc  
arm                  randconfig-r032-20230605   gcc  
arm                  randconfig-r033-20230605   gcc  
arm                  randconfig-r036-20230605   gcc  
arm                  randconfig-r046-20230605   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230605   clang
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230605   clang
arm64                randconfig-r012-20230605   gcc  
arm64                randconfig-r013-20230605   gcc  
arm64                randconfig-r016-20230605   gcc  
csky         buildonly-randconfig-r005-20230605   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230605   gcc  
csky                 randconfig-r005-20230605   gcc  
csky                 randconfig-r025-20230605   gcc  
csky                 randconfig-r031-20230605   gcc  
csky                 randconfig-r032-20230605   gcc  
csky                 randconfig-r034-20230605   gcc  
hexagon      buildonly-randconfig-r001-20230605   clang
hexagon              randconfig-r004-20230605   clang
hexagon              randconfig-r025-20230605   clang
hexagon              randconfig-r036-20230605   clang
hexagon              randconfig-r041-20230605   clang
hexagon              randconfig-r045-20230605   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230605   clang
i386                 randconfig-i002-20230605   clang
i386                 randconfig-i003-20230605   clang
i386                 randconfig-i004-20230605   clang
i386                 randconfig-i005-20230605   clang
i386                 randconfig-i006-20230605   clang
i386                 randconfig-i011-20230605   gcc  
i386                 randconfig-i012-20230605   gcc  
i386                 randconfig-i013-20230605   gcc  
i386                 randconfig-i014-20230605   gcc  
i386                 randconfig-i015-20230605   gcc  
i386                 randconfig-i016-20230605   gcc  
i386                 randconfig-i051-20230605   clang
i386                 randconfig-i052-20230605   clang
i386                 randconfig-i053-20230605   clang
i386                 randconfig-i054-20230605   clang
i386                 randconfig-i055-20230605   clang
i386                 randconfig-i056-20230605   clang
i386                 randconfig-i061-20230605   clang
i386                 randconfig-i062-20230605   clang
i386                 randconfig-i063-20230605   clang
i386                 randconfig-i064-20230605   clang
i386                 randconfig-i065-20230605   clang
i386                 randconfig-i066-20230605   clang
i386                 randconfig-r011-20230605   gcc  
i386                 randconfig-r021-20230605   gcc  
i386                 randconfig-r022-20230605   gcc  
i386                 randconfig-r025-20230605   gcc  
i386                 randconfig-r026-20230605   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230606   gcc  
loongarch            randconfig-r012-20230605   gcc  
loongarch            randconfig-r016-20230605   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230605   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230606   gcc  
m68k                 randconfig-r021-20230605   gcc  
m68k                 randconfig-r023-20230605   gcc  
microblaze   buildonly-randconfig-r004-20230605   gcc  
microblaze           randconfig-r003-20230606   gcc  
microblaze           randconfig-r034-20230605   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230605   gcc  
mips         buildonly-randconfig-r003-20230605   gcc  
mips                 randconfig-r003-20230605   gcc  
mips                 randconfig-r021-20230605   clang
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230605   gcc  
nios2                randconfig-r016-20230605   gcc  
nios2                randconfig-r032-20230605   gcc  
nios2                randconfig-r035-20230605   gcc  
openrisc     buildonly-randconfig-r001-20230605   gcc  
openrisc     buildonly-randconfig-r003-20230605   gcc  
openrisc     buildonly-randconfig-r004-20230605   gcc  
openrisc     buildonly-randconfig-r005-20230605   gcc  
openrisc             randconfig-r002-20230605   gcc  
openrisc             randconfig-r006-20230605   gcc  
openrisc             randconfig-r023-20230605   gcc  
openrisc             randconfig-r024-20230605   gcc  
openrisc             randconfig-r035-20230605   gcc  
parisc       buildonly-randconfig-r004-20230605   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230605   gcc  
parisc               randconfig-r012-20230605   gcc  
parisc               randconfig-r014-20230605   gcc  
parisc               randconfig-r015-20230605   gcc  
parisc               randconfig-r031-20230605   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230605   gcc  
powerpc      buildonly-randconfig-r003-20230605   gcc  
powerpc              randconfig-r001-20230605   clang
powerpc              randconfig-r005-20230606   gcc  
powerpc              randconfig-r013-20230605   gcc  
powerpc              randconfig-r014-20230605   gcc  
powerpc              randconfig-r015-20230605   gcc  
powerpc              randconfig-r035-20230605   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230605   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230605   clang
riscv                randconfig-r006-20230605   clang
riscv                randconfig-r015-20230605   gcc  
riscv                randconfig-r023-20230605   gcc  
riscv                randconfig-r042-20230605   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230606   gcc  
s390                 randconfig-r016-20230605   gcc  
s390                 randconfig-r035-20230605   clang
s390                 randconfig-r044-20230605   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230605   gcc  
sh                   randconfig-r013-20230605   gcc  
sh                   randconfig-r025-20230605   gcc  
sh                   randconfig-r032-20230605   gcc  
sh                   randconfig-r034-20230605   gcc  
sparc        buildonly-randconfig-r002-20230605   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230605   gcc  
sparc                randconfig-r006-20230605   gcc  
sparc                randconfig-r022-20230605   gcc  
sparc                randconfig-r025-20230605   gcc  
sparc                randconfig-r033-20230605   gcc  
sparc                randconfig-r035-20230605   gcc  
sparc64      buildonly-randconfig-r003-20230605   gcc  
sparc64      buildonly-randconfig-r006-20230605   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230605   clang
x86_64               randconfig-a002-20230605   clang
x86_64               randconfig-a003-20230605   clang
x86_64               randconfig-a004-20230605   clang
x86_64               randconfig-a005-20230605   clang
x86_64               randconfig-a006-20230605   clang
x86_64               randconfig-a011-20230605   gcc  
x86_64               randconfig-a012-20230605   gcc  
x86_64               randconfig-a013-20230605   gcc  
x86_64               randconfig-a014-20230605   gcc  
x86_64               randconfig-a015-20230605   gcc  
x86_64               randconfig-a016-20230605   gcc  
x86_64               randconfig-r005-20230605   clang
x86_64               randconfig-r024-20230605   gcc  
x86_64               randconfig-r031-20230605   clang
x86_64               randconfig-x051-20230605   gcc  
x86_64               randconfig-x052-20230605   gcc  
x86_64               randconfig-x053-20230605   gcc  
x86_64               randconfig-x054-20230605   gcc  
x86_64               randconfig-x055-20230605   gcc  
x86_64               randconfig-x056-20230605   gcc  
x86_64               randconfig-x061-20230605   gcc  
x86_64               randconfig-x062-20230605   gcc  
x86_64               randconfig-x063-20230605   gcc  
x86_64               randconfig-x064-20230605   gcc  
x86_64               randconfig-x065-20230605   gcc  
x86_64               randconfig-x066-20230605   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230605   gcc  
xtensa       buildonly-randconfig-r006-20230605   gcc  
xtensa               randconfig-r011-20230605   gcc  
xtensa               randconfig-r012-20230605   gcc  
xtensa               randconfig-r013-20230605   gcc  
xtensa               randconfig-r015-20230605   gcc  
xtensa               randconfig-r023-20230605   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
