Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE31B6F4EE0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 04:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjECCd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 22:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjECCdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 22:33:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBDA3C30
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 19:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683081228; x=1714617228;
  h=date:from:to:cc:subject:message-id;
  bh=Vj4fI+/k6PTRZEyaVveJrE+Dr2i7N8cTI3JXhlVwj48=;
  b=Ajf+ltQVtsp8aUMvYX0TUjhbTAdYT4JB8hGkw5Vvi/gShgPqUM+uzJLF
   BQLlm7ks21eBI+aTXeLTmly8iHvHD1tT81/laANymFSD4GZi6jWKwAEMv
   ZP7ulu1KT+KI2cuZDfuySuT8pUWu4FjVtb9/Yt7+5jN6cD+k0tbp/PNBR
   axiV2xRH6zBSOszpOXXd/f6igQiHghOPM2W7ytxqy8kJ8TerqUWSNOfKI
   f5BGYO+VfyEXdkA3eS5Uy6L+fb3Qz6QcLx6F8Sh+4lWwaxMpfv8ux24Cm
   7uETrfaNRJ3TaMQc5B5LRqHTqj09vVD8Aq0aByD7b5DfZYtk3dfM8JdZo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="414005378"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="414005378"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 19:33:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="726982529"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="726982529"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 May 2023 19:33:47 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pu2JO-0001Qe-1s;
        Wed, 03 May 2023 02:33:46 +0000
Date:   Wed, 03 May 2023 10:33:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/debugobjects] BUILD SUCCESS
 0cce06ba859a515bd06224085d3addb870608b6d
Message-ID: <20230503023325.Y1wDF%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/debugobjects
branch HEAD: 0cce06ba859a515bd06224085d3addb870608b6d  debugobjects,locking: Annotate debug_object_fill_pool() wait type violation

elapsed time: 813m

configs tested: 151
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230502   gcc  
alpha        buildonly-randconfig-r006-20230502   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230430   gcc  
alpha                randconfig-r013-20230430   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230430   gcc  
arc          buildonly-randconfig-r006-20230430   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230501   gcc  
arc                  randconfig-r022-20230501   gcc  
arc                  randconfig-r043-20230430   gcc  
arc                  randconfig-r043-20230501   gcc  
arc                  randconfig-r043-20230502   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r012-20230430   gcc  
arm                  randconfig-r033-20230430   clang
arm                  randconfig-r046-20230430   gcc  
arm                  randconfig-r046-20230501   gcc  
arm                  randconfig-r046-20230502   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230501   gcc  
csky                 randconfig-r031-20230501   gcc  
hexagon              randconfig-r041-20230430   clang
hexagon              randconfig-r041-20230501   clang
hexagon              randconfig-r041-20230502   clang
hexagon              randconfig-r045-20230430   clang
hexagon              randconfig-r045-20230501   clang
hexagon              randconfig-r045-20230502   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230501   gcc  
i386                 randconfig-a002-20230501   gcc  
i386                 randconfig-a003-20230501   gcc  
i386                 randconfig-a004-20230501   gcc  
i386                 randconfig-a005-20230501   gcc  
i386                 randconfig-a006-20230501   gcc  
i386                 randconfig-a011-20230501   clang
i386                 randconfig-a012-20230501   clang
i386                 randconfig-a013-20230501   clang
i386                 randconfig-a014-20230501   clang
i386                 randconfig-a015-20230501   clang
i386                 randconfig-a016-20230501   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r004-20230501   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r003-20230501   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230501   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r024-20230501   gcc  
loongarch            randconfig-r031-20230430   gcc  
loongarch            randconfig-r033-20230501   gcc  
loongarch            randconfig-r035-20230430   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230430   gcc  
m68k         buildonly-randconfig-r002-20230501   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230502   gcc  
m68k                 randconfig-r035-20230501   gcc  
microblaze           randconfig-r006-20230430   gcc  
microblaze           randconfig-r034-20230430   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r005-20230501   clang
mips                 randconfig-r035-20230502   gcc  
nios2        buildonly-randconfig-r003-20230430   gcc  
nios2        buildonly-randconfig-r003-20230502   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230430   gcc  
nios2                randconfig-r004-20230501   gcc  
nios2                randconfig-r024-20230430   gcc  
nios2                randconfig-r036-20230502   gcc  
openrisc     buildonly-randconfig-r005-20230430   gcc  
parisc       buildonly-randconfig-r006-20230501   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230501   gcc  
parisc               randconfig-r016-20230430   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230502   gcc  
powerpc              randconfig-r002-20230502   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230502   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230502   clang
riscv                randconfig-r004-20230430   gcc  
riscv                randconfig-r042-20230430   clang
riscv                randconfig-r042-20230501   clang
riscv                randconfig-r042-20230502   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230501   clang
s390                                defconfig   gcc  
s390                 randconfig-r021-20230430   clang
s390                 randconfig-r033-20230502   clang
s390                 randconfig-r036-20230501   gcc  
s390                 randconfig-r044-20230430   clang
s390                 randconfig-r044-20230501   clang
s390                 randconfig-r044-20230502   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r015-20230430   gcc  
sh                   randconfig-r022-20230430   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230430   gcc  
sparc                randconfig-r004-20230502   gcc  
sparc                randconfig-r011-20230501   gcc  
sparc                randconfig-r015-20230501   gcc  
sparc                randconfig-r031-20230502   gcc  
sparc                randconfig-r034-20230502   gcc  
sparc64              randconfig-r001-20230502   gcc  
sparc64              randconfig-r005-20230430   gcc  
sparc64              randconfig-r005-20230502   gcc  
sparc64              randconfig-r011-20230430   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230501   gcc  
x86_64               randconfig-a002-20230501   gcc  
x86_64               randconfig-a003-20230501   gcc  
x86_64               randconfig-a004-20230501   gcc  
x86_64               randconfig-a005-20230501   gcc  
x86_64               randconfig-a006-20230501   gcc  
x86_64               randconfig-a011-20230501   clang
x86_64               randconfig-a012-20230501   clang
x86_64               randconfig-a013-20230501   clang
x86_64               randconfig-a014-20230501   clang
x86_64               randconfig-a015-20230501   clang
x86_64               randconfig-a016-20230501   clang
x86_64               randconfig-r013-20230501   clang
x86_64               randconfig-r025-20230501   clang
x86_64               randconfig-r026-20230501   clang
x86_64               randconfig-r034-20230501   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230501   gcc  
xtensa               randconfig-r002-20230501   gcc  
xtensa               randconfig-r014-20230430   gcc  
xtensa               randconfig-r032-20230501   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
