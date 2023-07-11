Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DC574F279
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjGKOlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGKOlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:41:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252559C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689086467; x=1720622467;
  h=date:from:to:cc:subject:message-id;
  bh=vcOkD6qoIYozpR6tcUbkjEBwhN5bx6PoI6MD7T9ntGE=;
  b=KZvWfishh9AkVUO6W8VAnR4i1wo7oTMHnz+xHoUJJfHhxcMeqqA4acgv
   dCnZvgH5thQuHoSDe6eHKDILAa07wQf0IIq9IGQNgNlAzAtvmQPf/JcQy
   w/su96c7ueO+DR19ujMmAlLKevNNytGczXub6ht39a4Lz5bcuhVF8/sHZ
   aNRHHxAxifRYUqJ3JvK3PARXMkPeuiQXWt9EuGWaSOLmDSl9CnE3J4Wun
   XLBfAQuEEhWkhOZBeIieMxftToDUoW5xdY2OVBf9Cj0dgaBJyNAcZq0QG
   xqHpFD95pjmgT7DZQHPlGFWFHdXff/AAeh9BVCEHF78wviyb0zqCg8ala
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="428332046"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="428332046"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:41:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="811222461"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="811222461"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jul 2023 07:41:04 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJEY4-0004rf-0A;
        Tue, 11 Jul 2023 14:41:04 +0000
Date:   Tue, 11 Jul 2023 22:41:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/flex_struct_size-next20230710] BUILD
 SUCCESS a08d3354e6087f8911a6f831da7694f0a847cd64
Message-ID: <202307112200.0Tc4sEg3-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/flex_struct_size-next20230710
branch HEAD: a08d3354e6087f8911a6f831da7694f0a847cd64  treewide: Rename struct_size() with flex_struct_size()

elapsed time: 724m

configs tested: 125
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r022-20230710   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230711   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                       netwinder_defconfig   clang
arm                  randconfig-r035-20230710   clang
arm                  randconfig-r046-20230711   clang
arm                           sama5_defconfig   gcc  
arm                        spear3xx_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230710   clang
arm64                randconfig-r033-20230710   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r016-20230710   gcc  
hexagon                             defconfig   clang
hexagon              randconfig-r006-20230710   clang
hexagon              randconfig-r023-20230710   clang
hexagon              randconfig-r041-20230711   clang
hexagon              randconfig-r045-20230711   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230710   gcc  
i386         buildonly-randconfig-r005-20230710   gcc  
i386         buildonly-randconfig-r006-20230710   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230710   gcc  
i386                 randconfig-i002-20230710   gcc  
i386                 randconfig-i003-20230710   gcc  
i386                 randconfig-i004-20230710   gcc  
i386                 randconfig-i005-20230710   gcc  
i386                 randconfig-i006-20230710   gcc  
i386                 randconfig-i011-20230710   clang
i386                 randconfig-i012-20230710   clang
i386                 randconfig-i013-20230710   clang
i386                 randconfig-i014-20230710   clang
i386                 randconfig-i015-20230710   clang
i386                 randconfig-i016-20230710   clang
i386                 randconfig-r011-20230710   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                 randconfig-r001-20230710   gcc  
m68k                 randconfig-r004-20230710   gcc  
m68k                 randconfig-r036-20230710   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                         cobalt_defconfig   gcc  
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r015-20230710   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc              randconfig-r032-20230710   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230710   gcc  
riscv                randconfig-r042-20230711   gcc  
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r026-20230710   clang
s390                 randconfig-r044-20230711   gcc  
sh                               allmodconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r002-20230710   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r005-20230710   clang
um                   randconfig-r024-20230710   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230710   gcc  
x86_64       buildonly-randconfig-r002-20230710   gcc  
x86_64       buildonly-randconfig-r003-20230710   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r021-20230710   clang
x86_64               randconfig-x001-20230710   clang
x86_64               randconfig-x002-20230710   clang
x86_64               randconfig-x003-20230710   clang
x86_64               randconfig-x004-20230710   clang
x86_64               randconfig-x005-20230710   clang
x86_64               randconfig-x006-20230710   clang
x86_64               randconfig-x011-20230710   gcc  
x86_64               randconfig-x012-20230710   gcc  
x86_64               randconfig-x013-20230710   gcc  
x86_64               randconfig-x014-20230710   gcc  
x86_64               randconfig-x015-20230710   gcc  
x86_64               randconfig-x016-20230710   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa               randconfig-r012-20230710   gcc  
xtensa               randconfig-r034-20230710   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
