Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FDC6FC021
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbjEIHHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjEIHHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:07:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95686D06A
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683616061; x=1715152061;
  h=date:from:to:cc:subject:message-id;
  bh=2mf9b07l8pIbK9jAvJOt5U67B+T2jSAq8CkRyc5jJL8=;
  b=YZv5hx/sjaVMMS8rl9JFJuLmwcDl/10klfVmGgxBxnnMhsJNWJzJBois
   yE5yhVax7GIUNl1dBd/zfNpd5C/uMPyPku4Qy+7XJ15XsbbNcfvyqwBD7
   dCawEifYxwqYq5V3p7gsTothPdyWyl5DdV9dZK+AqTZSZUoIwulBPau2b
   ZDig+1+ATGAVFKO9CVZ2ffCHp6hBi0rphvH4Rp5zY78E80jgXLHjzn8Qn
   eMGwUIV1O+xXXuk/4U0IhRw+ArAfjOzDKtAk3e5y/55XhNun86932beT6
   3DoCPkngSKtRBXrFvoAlOVs1N1tiwjHEVkMZa8fOfMg7FBz33n9c4Onb/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="377922075"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="377922075"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 00:07:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="822955436"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="822955436"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 May 2023 00:07:34 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwHRd-0001tI-1j;
        Tue, 09 May 2023 07:07:33 +0000
Date:   Tue, 09 May 2023 15:06:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.05.08a] BUILD SUCCESS
 35d7ef1042dcad011497cfed0b7af11d7e5d38cd
Message-ID: <20230509070621.jfnBC%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.05.08a
branch HEAD: 35d7ef1042dcad011497cfed0b7af11d7e5d38cd  docs: Add atomic operations to the driver basic API documentation

elapsed time: 732m

configs tested: 127
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230508   gcc  
alpha                randconfig-r014-20230507   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230507   gcc  
arc          buildonly-randconfig-r003-20230508   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230508   gcc  
arc                  randconfig-r043-20230507   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230507   clang
arm                  randconfig-r003-20230507   clang
arm                  randconfig-r011-20230507   gcc  
arm                  randconfig-r023-20230508   clang
arm                  randconfig-r036-20230508   gcc  
arm                  randconfig-r046-20230507   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230507   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230508   clang
arm64                randconfig-r015-20230507   clang
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r002-20230508   clang
hexagon      buildonly-randconfig-r006-20230508   clang
hexagon              randconfig-r041-20230507   clang
hexagon              randconfig-r045-20230507   clang
i386                             allyesconfig   gcc  
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
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230507   gcc  
loongarch            randconfig-r031-20230508   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230508   gcc  
microblaze           randconfig-r032-20230508   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r021-20230508   clang
mips                 randconfig-r022-20230507   gcc  
mips                 randconfig-r022-20230508   clang
mips                 randconfig-r024-20230508   clang
mips                 randconfig-r025-20230508   clang
mips                 randconfig-r033-20230508   gcc  
mips                 randconfig-r035-20230507   clang
nios2                               defconfig   gcc  
nios2                randconfig-r031-20230507   gcc  
nios2                randconfig-r034-20230508   gcc  
openrisc     buildonly-randconfig-r006-20230507   gcc  
openrisc             randconfig-r011-20230508   gcc  
parisc       buildonly-randconfig-r004-20230507   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r023-20230507   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r006-20230507   gcc  
powerpc              randconfig-r026-20230508   gcc  
powerpc              randconfig-r033-20230507   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r005-20230507   clang
riscv                               defconfig   gcc  
riscv                randconfig-r013-20230507   clang
riscv                randconfig-r042-20230507   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230508   clang
s390                 randconfig-r006-20230508   clang
s390                 randconfig-r044-20230507   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230507   gcc  
sh           buildonly-randconfig-r005-20230508   gcc  
sh                   randconfig-r005-20230508   gcc  
sh                   randconfig-r016-20230508   gcc  
sh                   randconfig-r032-20230507   gcc  
sparc        buildonly-randconfig-r001-20230508   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r024-20230507   gcc  
sparc64      buildonly-randconfig-r004-20230508   gcc  
sparc64              randconfig-r001-20230507   gcc  
sparc64              randconfig-r012-20230507   gcc  
sparc64              randconfig-r021-20230507   gcc  
sparc64              randconfig-r026-20230507   gcc  
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
x86_64               randconfig-r012-20230508   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r013-20230508   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
