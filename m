Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E146FE813
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbjEJXWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbjEJXWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:22:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05F6E45
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 16:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683760970; x=1715296970;
  h=date:from:to:cc:subject:message-id;
  bh=TAMJSgyRJmULSqag0odlaz38ayTRNkNVi5i825oIy4w=;
  b=PbFO25naOp1+hAjkF6hEa/PGHVsCrp73lcExgYGzpWwdESkAjtrB6/F+
   zhi911UfwQ1uxxCf46FRofBg+SJC8/dJiCab/CFXHSQoYketGdYzfYhzc
   U77fo8f7BH6R83tPz6pvjKBFMnIfckqC/90lgNuGWUoCT1bsLQfK4Y/7x
   D6IuOadrRBIyYrFeEhJ01urmvBmW1A2ffQ9IAFchJpPS85YY/rzF2n0NN
   Pc56oWvoddL75ABx3DrKs6GxV9XGZ2INRqMOv0MNI4r4l77FXEbqPzYj3
   VH1junqwhwy+lzjvwb7PPGU5aTwSFTxMfnGoJ/oGFm8xUEcESjJMXxPyO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="436670260"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="436670260"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 16:22:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="649917921"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="649917921"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 May 2023 16:22:49 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwt8y-0003eS-2I;
        Wed, 10 May 2023 23:22:48 +0000
Date:   Thu, 11 May 2023 07:22:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.05.09a] BUILD SUCCESS
 73a6c983aee85f37fbd92a42f73727ff6f4d8a39
Message-ID: <20230510232218.uHNc8%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.05.09a
branch HEAD: 73a6c983aee85f37fbd92a42f73727ff6f4d8a39  docs: Add atomic operations to the driver basic API documentation

elapsed time: 1307m

configs tested: 117
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230509   gcc  
alpha        buildonly-randconfig-r005-20230509   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230509   gcc  
arc                  randconfig-r043-20230509   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230509   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230509   gcc  
arm64                randconfig-r034-20230509   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230509   gcc  
csky                 randconfig-r014-20230509   gcc  
hexagon              randconfig-r031-20230509   clang
hexagon              randconfig-r041-20230509   clang
hexagon              randconfig-r045-20230509   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230509   gcc  
ia64                 randconfig-r014-20230509   gcc  
ia64                 randconfig-r015-20230509   gcc  
ia64                 randconfig-r033-20230509   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r002-20230509   gcc  
microblaze   buildonly-randconfig-r004-20230509   gcc  
microblaze           randconfig-r024-20230509   gcc  
microblaze           randconfig-r035-20230509   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r015-20230509   gcc  
mips                 randconfig-r031-20230510   clang
nios2                               defconfig   gcc  
nios2                randconfig-r031-20230509   gcc  
nios2                randconfig-r032-20230509   gcc  
nios2                randconfig-r036-20230509   gcc  
openrisc             randconfig-r006-20230509   gcc  
openrisc             randconfig-r011-20230509   gcc  
openrisc             randconfig-r023-20230509   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230509   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   clang
powerpc              randconfig-r022-20230509   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230509   clang
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                randconfig-r034-20230509   gcc  
riscv                randconfig-r042-20230509   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230509   clang
s390                                defconfig   gcc  
s390                 randconfig-r016-20230509   clang
s390                 randconfig-r033-20230509   gcc  
s390                 randconfig-r044-20230509   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230509   gcc  
sh                   randconfig-r012-20230509   gcc  
sh                   randconfig-r016-20230509   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r036-20230509   gcc  
sparc64              randconfig-r032-20230509   gcc  
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
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230509   gcc  
xtensa       buildonly-randconfig-r006-20230509   gcc  
xtensa               randconfig-r001-20230509   gcc  
xtensa               randconfig-r013-20230509   gcc  
xtensa               randconfig-r025-20230509   gcc  
xtensa               randconfig-r035-20230509   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
