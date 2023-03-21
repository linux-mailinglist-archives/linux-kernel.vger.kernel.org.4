Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA4D6C2A18
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCUF4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCUF4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:56:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2250399EF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 22:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679378177; x=1710914177;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lF7KE/G6juZgb1twq42PZFWg2ojJe/LZVkHQna+m3eQ=;
  b=n7EzFWKEA+SPo+FC4KbNEqLNOv7RaSFKJInsgspJGCVyKMDbiO8Vsbq1
   CbLnodqB3dqdjIK4zUVk9FkSQEgglzMVEjqS8tt+5H8YNO3P719+07Zav
   XpVKrXIR09ArDyIXC7MZUHKxaweEhjV4HQ2P4BJLiGTegLAsfgR6BckGW
   Nu9CfILByelpy7aawABaXJdzr8VAZD5YGHpKH6EDsi3U5+SUlGGAdjx5l
   qBwQj5lwD+ZchrFJ//cdfRtT0c6cVclnu2d4+puFNAjvfNOJKslKgrWvk
   WrHy2MwPXixY/i64mY0ZBytvbTvYu0zx4gh6KiFTidbnr5mV0f97CBf9/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="327230526"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="327230526"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:56:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="855559720"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="855559720"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Mar 2023 22:56:16 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peUyl-000BeQ-15;
        Tue, 21 Mar 2023 05:56:15 +0000
Date:   Tue, 21 Mar 2023 13:55:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/shstk] BUILD SUCCESS
 b642e9e5f0dc797f543b431d4ba910a3da72a074
Message-ID: <641946e3.limZxbP77jq7awPD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/shstk
branch HEAD: b642e9e5f0dc797f543b431d4ba910a3da72a074  x86/shstk: Add ARCH_SHSTK_STATUS

elapsed time: 722m

configs tested: 143
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230319   gcc  
alpha                randconfig-r031-20230319   gcc  
alpha                randconfig-r033-20230319   gcc  
alpha                randconfig-r036-20230319   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230320   gcc  
arc                  randconfig-r025-20230319   gcc  
arc                  randconfig-r043-20230319   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r024-20230319   gcc  
arm                  randconfig-r046-20230319   gcc  
arm                  randconfig-r046-20230320   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230319   clang
arm64                randconfig-r014-20230319   clang
csky                                defconfig   gcc  
csky                 randconfig-r014-20230319   gcc  
csky                 randconfig-r035-20230319   gcc  
hexagon              randconfig-r012-20230320   clang
hexagon              randconfig-r022-20230319   clang
hexagon              randconfig-r041-20230319   clang
hexagon              randconfig-r041-20230320   clang
hexagon              randconfig-r045-20230319   clang
hexagon              randconfig-r045-20230320   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230320   clang
i386                 randconfig-a002-20230320   clang
i386                          randconfig-a002   clang
i386                 randconfig-a003-20230320   clang
i386                 randconfig-a004-20230320   clang
i386                          randconfig-a004   clang
i386                 randconfig-a005-20230320   clang
i386                 randconfig-a006-20230320   clang
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230320   gcc  
i386                 randconfig-a012-20230320   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230320   gcc  
i386                 randconfig-a014-20230320   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230320   gcc  
i386                 randconfig-a016-20230320   gcc  
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r036-20230319   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230319   gcc  
loongarch            randconfig-r022-20230319   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r031-20230319   gcc  
microblaze           randconfig-r034-20230319   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r026-20230319   gcc  
mips                           xway_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230320   gcc  
nios2                randconfig-r034-20230319   gcc  
openrisc             randconfig-r011-20230319   gcc  
openrisc             randconfig-r021-20230319   gcc  
openrisc             randconfig-r024-20230319   gcc  
openrisc             randconfig-r025-20230319   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230320   gcc  
parisc               randconfig-r022-20230319   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        fsp2_defconfig   clang
powerpc              randconfig-r021-20230319   clang
powerpc              randconfig-r033-20230319   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230319   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r023-20230319   clang
s390                 randconfig-r044-20230319   clang
sh                               allmodconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                   randconfig-r011-20230320   gcc  
sh                   randconfig-r016-20230319   gcc  
sh                   randconfig-r032-20230319   gcc  
sh                             sh03_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230319   gcc  
sparc                randconfig-r015-20230319   gcc  
sparc                randconfig-r032-20230319   gcc  
sparc                randconfig-r035-20230319   gcc  
sparc64              randconfig-r011-20230319   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230320   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230320   clang
x86_64                        randconfig-a002   gcc  
x86_64               randconfig-a003-20230320   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230320   clang
x86_64                        randconfig-a004   gcc  
x86_64               randconfig-a005-20230320   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230320   clang
x86_64                        randconfig-a006   gcc  
x86_64               randconfig-a011-20230320   gcc  
x86_64                        randconfig-a011   gcc  
x86_64               randconfig-a012-20230320   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230320   gcc  
x86_64                        randconfig-a013   gcc  
x86_64               randconfig-a014-20230320   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230320   gcc  
x86_64                        randconfig-a015   gcc  
x86_64               randconfig-a016-20230320   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r013-20230319   gcc  
xtensa               randconfig-r015-20230319   gcc  
xtensa               randconfig-r023-20230319   gcc  
xtensa               randconfig-r026-20230319   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
