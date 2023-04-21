Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346616EB32C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 22:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjDUU53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 16:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDUU50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 16:57:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB231BD5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682110645; x=1713646645;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sKDFAlFl6KxMe+4tdUDmzY5lXxHW0Q2KIfi5Jt7rS18=;
  b=cqqM+gCcrDwdPOczTS9uyZMUwV/zM+29ineTrWOCUjpvrzHZaZeW9fdm
   2MW3qTc1mh+JpXpzi5/eTXj7idHZVcUQhyQYqAwcKezeZMvUFrYKQmzuh
   nGNe5AEX1BgLP7wmf1EG1FSp5STr3RksdkfSatUivqhocmadZvcwWfx+o
   tGzWLz1or0XQm5cVsH7V3/euinUSnvh//h6regWxVyF6SkPyiIP9BkXbW
   KUyTX/Zz+ytk/tH7VN+hUFawjW+4AAU1/9f4OPByiHHPvHid06eOejp2z
   sNdWdpFqoDNnQpjrPXh9Jjw2ViOS5bTIjq0w3FN6Oz1ar5r7aqPpupY2L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="347989506"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="347989506"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 13:57:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="761700670"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="761700670"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Apr 2023 13:57:23 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppxoo-000gnq-25;
        Fri, 21 Apr 2023 20:57:22 +0000
Date:   Sat, 22 Apr 2023 04:56:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 dd806e2f030e57dd5bac973372aa252b6c175b73
Message-ID: <6442f884.2BIe0IbSVL06lG04%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: dd806e2f030e57dd5bac973372aa252b6c175b73  Merge branch into tip/master: 'timers/core'

elapsed time: 727m

configs tested: 172
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230417   gcc  
alpha        buildonly-randconfig-r004-20230419   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r036-20230417   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230417   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230416   gcc  
arc                  randconfig-r003-20230418   gcc  
arc                  randconfig-r004-20230416   gcc  
arc                  randconfig-r005-20230417   gcc  
arc                  randconfig-r011-20230420   gcc  
arc                  randconfig-r012-20230418   gcc  
arc                  randconfig-r021-20230416   gcc  
arc                  randconfig-r034-20230417   gcc  
arc                  randconfig-r036-20230416   gcc  
arc                  randconfig-r043-20230416   gcc  
arc                  randconfig-r043-20230417   gcc  
arc                  randconfig-r043-20230420   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r003-20230416   clang
arm          buildonly-randconfig-r005-20230416   clang
arm                                 defconfig   gcc  
arm                      footbridge_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                  randconfig-r001-20230417   clang
arm                  randconfig-r013-20230417   gcc  
arm                  randconfig-r022-20230416   clang
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230417   gcc  
arm                  randconfig-r046-20230420   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230416   clang
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230418   gcc  
arm64                randconfig-r031-20230417   gcc  
csky         buildonly-randconfig-r002-20230419   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r005-20230416   gcc  
csky                 randconfig-r011-20230418   gcc  
csky                 randconfig-r012-20230416   gcc  
hexagon      buildonly-randconfig-r006-20230416   clang
hexagon              randconfig-r001-20230419   clang
hexagon              randconfig-r005-20230419   clang
hexagon              randconfig-r022-20230417   clang
hexagon              randconfig-r024-20230417   clang
hexagon              randconfig-r032-20230417   clang
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r041-20230417   clang
hexagon              randconfig-r041-20230420   clang
hexagon              randconfig-r045-20230416   clang
hexagon              randconfig-r045-20230417   clang
hexagon              randconfig-r045-20230420   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230419   gcc  
ia64         buildonly-randconfig-r006-20230419   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230416   gcc  
ia64                 randconfig-r002-20230418   gcc  
ia64                 randconfig-r033-20230417   gcc  
ia64                 randconfig-r035-20230416   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r015-20230420   gcc  
loongarch            randconfig-r016-20230416   gcc  
loongarch            randconfig-r023-20230417   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230418   gcc  
microblaze           randconfig-r003-20230419   gcc  
microblaze           randconfig-r005-20230418   gcc  
microblaze           randconfig-r006-20230418   gcc  
microblaze           randconfig-r011-20230417   gcc  
microblaze           randconfig-r014-20230418   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r004-20230419   clang
mips                 randconfig-r025-20230417   gcc  
mips                 randconfig-r026-20230416   clang
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230417   gcc  
openrisc             randconfig-r012-20230417   gcc  
openrisc             randconfig-r013-20230420   gcc  
openrisc             randconfig-r015-20230417   gcc  
openrisc             randconfig-r016-20230420   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230417   gcc  
parisc               randconfig-r011-20230416   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r031-20230416   clang
powerpc              randconfig-r032-20230416   clang
powerpc              randconfig-r033-20230416   clang
powerpc              randconfig-r034-20230416   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230416   gcc  
riscv        buildonly-randconfig-r003-20230419   clang
riscv        buildonly-randconfig-r004-20230417   clang
riscv        buildonly-randconfig-r005-20230417   clang
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230416   clang
riscv                randconfig-r006-20230419   gcc  
riscv                randconfig-r012-20230420   gcc  
riscv                randconfig-r035-20230417   gcc  
riscv                randconfig-r042-20230416   gcc  
riscv                randconfig-r042-20230417   clang
riscv                randconfig-r042-20230420   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230419   gcc  
s390                 randconfig-r004-20230417   gcc  
s390                 randconfig-r015-20230416   gcc  
s390                 randconfig-r044-20230416   gcc  
s390                 randconfig-r044-20230417   clang
s390                 randconfig-r044-20230420   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r014-20230416   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc        buildonly-randconfig-r004-20230416   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230417   gcc  
sparc64              randconfig-r002-20230417   gcc  
sparc64              randconfig-r016-20230418   gcc  
sparc64              randconfig-r025-20230416   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230417   gcc  
x86_64               randconfig-a002-20230417   gcc  
x86_64               randconfig-a003-20230417   gcc  
x86_64               randconfig-a004-20230417   gcc  
x86_64               randconfig-a005-20230417   gcc  
x86_64               randconfig-a006-20230417   gcc  
x86_64               randconfig-a011-20230417   clang
x86_64               randconfig-a012-20230417   clang
x86_64               randconfig-a013-20230417   clang
x86_64               randconfig-a014-20230417   clang
x86_64               randconfig-a015-20230417   clang
x86_64               randconfig-a016-20230417   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230419   gcc  
xtensa       buildonly-randconfig-r003-20230417   gcc  
xtensa               randconfig-r015-20230418   gcc  
xtensa               randconfig-r023-20230416   gcc  
xtensa               randconfig-r024-20230416   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
