Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C546FBEE0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 07:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjEIFtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 01:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjEIFtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 01:49:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872178A73
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 22:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683611344; x=1715147344;
  h=date:from:to:cc:subject:message-id;
  bh=hMSXIrDSn9Bf2JbPECtjSVjhj2OL0vixUZt0I90RD5o=;
  b=AJ8yGm2iVN59l12Ba1f5H2GJ3tELay0ZJRcX0LJFA2YN/Ulr7mPKmFsH
   Mv9X25t3k78hQPI1dn1xnICkjqgZSULSi/qnaMfpHHjrbDwDmbsuLLXjX
   4U6Rv79FgKuZ4YSq3kfTod30MI0i7QAKWBoIdSMvdehAlxPAFu6RTYh0d
   rd15IeEGOaQJs4WNm/z14x7VH9JYPjZpzx2bxYznW85T3l+BDRBlD+WXe
   J6Xqaxi+IkBUynHHtWVAvoSEHFxET8XXK3zC3k+pGD4B0fljdqS/EcmyI
   4XOg/pjx8TBuJu/w6jnwaWlk2gF9Cxvxv7uiaw/Czpv1ygpE5fSA8ewxt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="347276521"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="347276521"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 22:49:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="729342917"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="729342917"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 May 2023 22:49:03 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwGDe-0001nM-1P;
        Tue, 09 May 2023 05:49:02 +0000
Date:   Tue, 09 May 2023 13:48:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.05.07a] BUILD SUCCESS
 ab2eb093f599054e4664a4b23730fa8b4239b052
Message-ID: <20230509054830.0K4-U%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.05.07a
branch HEAD: ab2eb093f599054e4664a4b23730fa8b4239b052  locking/atomic: Remove duplicate kernel-doc headers

elapsed time: 732m

configs tested: 124
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230508   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230508   gcc  
arc                  randconfig-r022-20230508   gcc  
arc                  randconfig-r043-20230507   gcc  
arc                  randconfig-r043-20230508   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230507   clang
arm                  randconfig-r003-20230507   clang
arm                  randconfig-r014-20230508   clang
arm                  randconfig-r026-20230508   clang
arm                  randconfig-r046-20230507   gcc  
arm                  randconfig-r046-20230508   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230508   clang
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230508   clang
arm64                randconfig-r011-20230507   clang
arm64                randconfig-r021-20230507   clang
csky                                defconfig   gcc  
hexagon              randconfig-r026-20230507   clang
hexagon              randconfig-r031-20230507   clang
hexagon              randconfig-r036-20230508   clang
hexagon              randconfig-r041-20230507   clang
hexagon              randconfig-r041-20230508   clang
hexagon              randconfig-r045-20230507   clang
hexagon              randconfig-r045-20230508   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r002-20230508   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230508   clang
i386                 randconfig-a002-20230508   clang
i386                 randconfig-a003-20230508   clang
i386                 randconfig-a004-20230508   clang
i386                 randconfig-a005-20230508   clang
i386                 randconfig-a006-20230508   clang
i386                 randconfig-a011-20230508   gcc  
i386                 randconfig-a012-20230508   gcc  
i386                 randconfig-a013-20230508   gcc  
i386                 randconfig-a014-20230508   gcc  
i386                 randconfig-a015-20230508   gcc  
i386                 randconfig-a016-20230508   gcc  
i386                 randconfig-r021-20230508   gcc  
i386                 randconfig-r035-20230508   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230508   gcc  
ia64         buildonly-randconfig-r004-20230508   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r024-20230508   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r034-20230508   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230507   gcc  
microblaze           randconfig-r011-20230508   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r022-20230507   gcc  
mips                 randconfig-r034-20230507   clang
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230507   gcc  
nios2                randconfig-r031-20230508   gcc  
openrisc             randconfig-r013-20230507   gcc  
openrisc             randconfig-r015-20230507   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230508   gcc  
parisc               randconfig-r024-20230507   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r006-20230507   gcc  
powerpc              randconfig-r023-20230508   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r035-20230507   gcc  
riscv                randconfig-r042-20230507   clang
riscv                randconfig-r042-20230508   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230508   clang
s390                 randconfig-r006-20230508   clang
s390                 randconfig-r025-20230508   gcc  
s390                 randconfig-r032-20230507   gcc  
s390                 randconfig-r044-20230507   clang
s390                 randconfig-r044-20230508   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230508   gcc  
sh                   randconfig-r013-20230508   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r032-20230508   gcc  
sparc                randconfig-r033-20230507   gcc  
sparc64              randconfig-r001-20230507   gcc  
sparc64              randconfig-r036-20230507   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230508   clang
x86_64               randconfig-a002-20230508   clang
x86_64               randconfig-a003-20230508   clang
x86_64               randconfig-a004-20230508   clang
x86_64               randconfig-a005-20230508   clang
x86_64               randconfig-a006-20230508   clang
x86_64               randconfig-a011-20230508   gcc  
x86_64               randconfig-a012-20230508   gcc  
x86_64               randconfig-a013-20230508   gcc  
x86_64               randconfig-a014-20230508   gcc  
x86_64               randconfig-a015-20230508   gcc  
x86_64               randconfig-a016-20230508   gcc  
x86_64               randconfig-r033-20230508   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
