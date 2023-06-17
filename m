Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2EE733F63
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 10:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346237AbjFQIE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 04:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346243AbjFQIEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:04:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D956294C
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686989064; x=1718525064;
  h=date:from:to:cc:subject:message-id;
  bh=W5A0Fvivjps8SrN/h/CZ7oRlK8bOEE9kegloc6yg8yc=;
  b=IS3oWIPnjXz6V6agTOWd37y9pnSGTnvEFNUyUAa5LV2/oMTYCQw/d5WH
   nNaU5seSe3zrQc4+xcV4SUCbimQx+zlT5T5LMHWqnLhzMC5xYwcMQuhcT
   xuEfakCmLsD1aItIhA1y9u4Zyubl5pSatZEkXR4AowbRIng+pSNvaJvCC
   op73GMkw9EjXRhQPvY4+rT2Z++VlkC3Hzmrys4dYpCkWWQjX6HHiUUrpy
   TtnQm7vyahF2QEBTK5sPpyXiDw7c8R1TSlYMhYg5DAQR4dH5RtCY4u2zD
   C2WOc2clz99ea19Fwk+vLFdkb1NRKS7dmevUEOK4oPXQXEONi3wI/FPgO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="356861092"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="356861092"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2023 01:04:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="663447057"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="663447057"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Jun 2023 01:04:22 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qAQuz-0002TV-2J;
        Sat, 17 Jun 2023 08:04:21 +0000
Date:   Sat, 17 Jun 2023 16:04:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/shstk] BUILD SUCCESS
 727f2a6ea02467c331f86ec5fde8e70dab418baa
Message-ID: <202306171619.1C8TKKJI-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/shstk
branch HEAD: 727f2a6ea02467c331f86ec5fde8e70dab418baa  x86/shstk: Add ARCH_SHSTK_STATUS

elapsed time: 1928m

configs tested: 101
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230615   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r022-20230616   gcc  
arc                  randconfig-r032-20230616   gcc  
arc                  randconfig-r035-20230616   gcc  
arc                  randconfig-r043-20230616   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r021-20230616   clang
arm                  randconfig-r025-20230616   clang
arm                  randconfig-r046-20230616   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230615   gcc  
csky                 randconfig-r005-20230616   gcc  
hexagon              randconfig-r024-20230615   clang
hexagon              randconfig-r025-20230615   clang
hexagon              randconfig-r041-20230616   clang
hexagon              randconfig-r045-20230616   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230616   clang
i386                 randconfig-i002-20230616   clang
i386                 randconfig-i003-20230616   clang
i386                 randconfig-i004-20230616   clang
i386                 randconfig-i005-20230616   clang
i386                 randconfig-i006-20230616   clang
i386                 randconfig-i011-20230616   gcc  
i386                 randconfig-i012-20230616   gcc  
i386                 randconfig-i013-20230616   gcc  
i386                 randconfig-i014-20230616   gcc  
i386                 randconfig-i015-20230616   gcc  
i386                 randconfig-i016-20230616   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230616   gcc  
microblaze           randconfig-r005-20230615   gcc  
microblaze           randconfig-r026-20230616   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r023-20230615   gcc  
mips                 randconfig-r036-20230616   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r001-20230616   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r021-20230615   gcc  
parisc               randconfig-r034-20230616   gcc  
parisc               randconfig-r036-20230616   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r033-20230616   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230616   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230615   gcc  
s390                 randconfig-r006-20230616   clang
s390                 randconfig-r026-20230615   clang
s390                 randconfig-r044-20230616   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230616   gcc  
sh                   randconfig-r032-20230616   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r006-20230615   gcc  
sparc64              randconfig-r022-20230615   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r031-20230616   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a011-20230617   clang
x86_64               randconfig-a012-20230617   clang
x86_64               randconfig-a013-20230617   clang
x86_64               randconfig-a014-20230617   clang
x86_64               randconfig-a015-20230617   clang
x86_64               randconfig-a016-20230617   clang
x86_64               randconfig-r003-20230616   clang
x86_64               randconfig-r024-20230616   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r035-20230616   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
