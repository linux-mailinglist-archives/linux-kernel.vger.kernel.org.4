Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433096FD308
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 01:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjEIX3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 19:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEIX26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 19:28:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B04B4239
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 16:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683674937; x=1715210937;
  h=date:from:to:cc:subject:message-id;
  bh=9HdVZyYUoZ3CwJD6rQPjc4LnKSSplS4iPSW+zDwh2gI=;
  b=XK/LUjPR8lfsKixNAXODxghlFiNO36B+oqdke4sAmlBqdNLiBxagPw43
   tK3nd/hYLp+hiNSVXzr3WNaubIsvvWGJvoy4rmhlLL78RQ1cuP5YQBZ4G
   SvJt1Nh1uguelvCvmkgt7GtHhZPZ5aI2CYVPuyAu1GttYjXxTNexMEGnC
   40CoA5PuNXQJ2tN1UMNauZ55P0N1hlh2uyY5ObDyEJFXU0ycCZWs/h3kQ
   921EfvxCNbSUx5cGTKhhvitOoB2nO7s/BezJm2i/7gyM8J5xabMEqV7sz
   SA2jNgvu+x4Spj0CSMENgNKbN11fWi0r74iF5VKBTVMoRQYBr65YZWbUK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="436404519"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="436404519"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 16:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="873371390"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="873371390"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 May 2023 16:28:55 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwWlL-0002ci-0T;
        Tue, 09 May 2023 23:28:55 +0000
Date:   Wed, 10 May 2023 07:27:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 da86eb9611840772a459693832e54c63cbcc040a
Message-ID: <20230509232756.sAnKm%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: da86eb9611840772a459693832e54c63cbcc040a  x86/coco: Get rid of accessor functions

elapsed time: 729m

configs tested: 116
configs skipped: 115

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230509   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230509   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r023-20230509   gcc  
arc                  randconfig-r031-20230509   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                          moxart_defconfig   clang
arm                        neponset_defconfig   clang
arm                          sp7021_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230509   gcc  
arm64                randconfig-r004-20230509   gcc  
arm64                randconfig-r015-20230509   clang
csky                                defconfig   gcc  
csky                 randconfig-r032-20230509   gcc  
hexagon              randconfig-r024-20230509   clang
hexagon              randconfig-r041-20230509   clang
hexagon              randconfig-r045-20230509   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                 randconfig-a004-20230508   clang
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a014   gcc  
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                      gensparse_defconfig   gcc  
ia64                 randconfig-r013-20230509   gcc  
ia64                 randconfig-r023-20230509   gcc  
ia64                 randconfig-r025-20230509   gcc  
ia64                 randconfig-r035-20230509   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r021-20230509   gcc  
m68k                             allmodconfig   gcc  
m68k                 randconfig-r025-20230509   gcc  
m68k                           virt_defconfig   gcc  
microblaze   buildonly-randconfig-r002-20230509   gcc  
microblaze           randconfig-r001-20230509   gcc  
microblaze           randconfig-r003-20230509   gcc  
microblaze           randconfig-r036-20230509   gcc  
mips         buildonly-randconfig-r001-20230509   clang
mips                           gcw0_defconfig   gcc  
mips                 randconfig-r031-20230509   clang
mips                 randconfig-r031-20230510   clang
mips                 randconfig-r035-20230509   clang
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230509   gcc  
nios2                randconfig-r006-20230509   gcc  
openrisc             randconfig-r004-20230509   gcc  
openrisc             randconfig-r022-20230509   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r015-20230509   gcc  
parisc               randconfig-r024-20230509   gcc  
parisc64                            defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc              randconfig-r005-20230509   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230509   clang
riscv        buildonly-randconfig-r004-20230509   clang
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230509   clang
riscv                randconfig-r042-20230509   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230509   gcc  
s390                 randconfig-r011-20230509   clang
s390                 randconfig-r034-20230509   gcc  
s390                 randconfig-r044-20230509   clang
sh                               allmodconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r014-20230509   gcc  
sh                   secureedge5410_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230509   gcc  
sparc64              randconfig-r006-20230509   gcc  
sparc64              randconfig-r016-20230509   gcc  
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
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230509   gcc  
xtensa               randconfig-r004-20230509   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
