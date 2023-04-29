Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4866F260B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 21:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjD2TpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 15:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjD2TpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 15:45:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230AB1997
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 12:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682797513; x=1714333513;
  h=date:from:to:cc:subject:message-id;
  bh=utpyv73n2kyprvW8OxzBNEvCS608GHT7G+YFgphHMq8=;
  b=W2GjO0L8GVa1f7CnCoKGcKLej9HlWQ3eiSOCogc8lrzsFGTEPbWtPJ2t
   N4TPXljuHoJGcbTtCPnDcg15CSSsxZ1XJYQb7hyMrwGsTyrfGKHcSRr1u
   6NFdFeRi4q7imKKgUshVhgTUNW/8Cevp3vYn83nixVfU/6GHNyIKAQU0v
   Psw6LcX8aapdjFf3FVQKW/4cE9I/qxUBt3iAxBOKoBFM+qcniJ0kDapX3
   Rt7+NAIm+OZrBj3envjl/qKpUITkL7VBCag/kISjikp+TQLagUlC7EtjM
   sqiwOnINVEJjVY2fYf9J5fQZYQh8YqTpF/y3gG5wWuAMCrkWZx18NAGrL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="345424950"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="scan'208";a="345424950"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2023 12:45:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="819483607"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="scan'208";a="819483607"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2023 12:45:11 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psqVK-0001Jt-2I;
        Sat, 29 Apr 2023 19:45:10 +0000
Date:   Sun, 30 Apr 2023 03:44:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f6065e5060b9abe331675c996b72b5428b9400c2
Message-ID: <20230429194444.j6BB4%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f6065e5060b9abe331675c996b72b5428b9400c2  Merge branch into tip/master: 'x86/tdx'

elapsed time: 723m

configs tested: 110
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r003-20230428   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r026-20230428   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230429   gcc  
arc                  randconfig-r023-20230429   gcc  
arc                  randconfig-r043-20230428   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r022-20230428   clang
arm                  randconfig-r046-20230428   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230428   clang
arm64                               defconfig   gcc  
arm64                randconfig-r024-20230428   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r015-20230428   gcc  
csky                 randconfig-r024-20230429   gcc  
csky                 randconfig-r031-20230428   gcc  
hexagon              randconfig-r032-20230428   clang
hexagon              randconfig-r041-20230428   clang
hexagon              randconfig-r045-20230428   clang
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
ia64                 randconfig-r013-20230429   gcc  
ia64                 randconfig-r014-20230429   gcc  
ia64                 randconfig-r022-20230429   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230428   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r021-20230429   gcc  
microblaze   buildonly-randconfig-r005-20230428   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2        buildonly-randconfig-r001-20230428   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r026-20230429   gcc  
openrisc             randconfig-r025-20230428   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230428   gcc  
parisc               randconfig-r023-20230428   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r012-20230429   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230428   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230428   gcc  
riscv                randconfig-r014-20230428   gcc  
riscv                randconfig-r033-20230428   clang
riscv                randconfig-r034-20230428   clang
riscv                randconfig-r042-20230428   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r013-20230428   gcc  
s390                 randconfig-r044-20230428   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230428   gcc  
sh                   randconfig-r015-20230429   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r025-20230429   gcc  
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
xtensa               randconfig-r003-20230428   gcc  
xtensa               randconfig-r006-20230428   gcc  
xtensa               randconfig-r016-20230428   gcc  
xtensa               randconfig-r035-20230428   gcc  
xtensa               randconfig-r036-20230428   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
