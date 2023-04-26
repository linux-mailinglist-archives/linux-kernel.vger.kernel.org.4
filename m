Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A266EFC56
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjDZVUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDZVUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:20:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3AE138
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682544006; x=1714080006;
  h=date:from:to:cc:subject:message-id;
  bh=lI2UPAu/8dlt6iitwZkyZxgBjZe6+uussJfmxJa7Z7k=;
  b=V4B518GmoDLalmk7yvBExhyzqeqxQqkfC2LU4IIIhPPcUyFxqFizH8ak
   nD+XYd9lABEYIj0DIrg7c9ng3LOKVIQE56quY+X6l2ltOdE5IsfWNRF3K
   VpWiKCR355H72ZUwKrgEmC6tU5wC7DX/h+1vWFzNH+4Wai8pY3/cyDTk9
   wMUq/DHEqsLfOnhtj2EN9ma2rrMbikJoyPWRlT1qfJDGqkulEF64SHzrj
   OOyIV3uR9IBJd3liZLW7gkmaSeHgiHflMuU9FjnaUMxgQHVJlvDawxsyu
   4sd/0m6yHg7WISEJ59F8WYVULdr/IUPJAC5njGimTqrtVqCiWKmkFInfQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="347260212"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="347260212"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 14:19:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="783466648"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="783466648"
Received: from lkp-server01.sh.intel.com (HELO 041f065c1b1b) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Apr 2023 14:19:53 -0700
Received: from kbuild by 041f065c1b1b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prmYL-0000Wu-0A;
        Wed, 26 Apr 2023 21:19:53 +0000
Date:   Thu, 27 Apr 2023 05:18:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 7e0664b660bc8f977d2948d8c8fbfc4809b3e6b4
Message-ID: <20230426211853.TRmud%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 7e0664b660bc8f977d2948d8c8fbfc4809b3e6b4  Merge tag 'timers-v6.4-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

elapsed time: 725m

configs tested: 124
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230426   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230426   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230426   gcc  
arc          buildonly-randconfig-r006-20230426   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230426   gcc  
arc                  randconfig-r011-20230426   gcc  
arc                  randconfig-r043-20230426   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r001-20230426   gcc  
arm                  randconfig-r006-20230426   gcc  
arm                  randconfig-r046-20230426   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230426   clang
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230426   clang
csky                                defconfig   gcc  
csky                 randconfig-r022-20230426   gcc  
hexagon      buildonly-randconfig-r003-20230426   clang
hexagon              randconfig-r041-20230426   clang
hexagon              randconfig-r045-20230426   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230424   gcc  
i386                 randconfig-a012-20230424   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230424   gcc  
i386                 randconfig-a014-20230424   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230424   gcc  
i386                 randconfig-a016-20230424   gcc  
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r022-20230426   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230426   gcc  
loongarch            randconfig-r025-20230426   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230426   gcc  
m68k                 randconfig-r023-20230426   gcc  
microblaze           randconfig-r013-20230426   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r016-20230426   clang
mips                 randconfig-r034-20230426   gcc  
nios2        buildonly-randconfig-r002-20230426   gcc  
nios2        buildonly-randconfig-r004-20230426   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230426   gcc  
nios2                randconfig-r014-20230426   gcc  
openrisc             randconfig-r003-20230426   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230426   gcc  
parisc               randconfig-r033-20230426   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230426   gcc  
powerpc              randconfig-r024-20230426   gcc  
powerpc              randconfig-r031-20230426   clang
powerpc              randconfig-r034-20230426   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r035-20230426   clang
riscv                randconfig-r042-20230426   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230426   gcc  
s390                 randconfig-r026-20230426   gcc  
s390                 randconfig-r035-20230426   clang
s390                 randconfig-r044-20230426   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r031-20230426   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r032-20230426   gcc  
sparc                randconfig-r036-20230426   gcc  
sparc64      buildonly-randconfig-r001-20230426   gcc  
sparc64      buildonly-randconfig-r003-20230426   gcc  
sparc64              randconfig-r006-20230426   gcc  
sparc64              randconfig-r013-20230426   gcc  
sparc64              randconfig-r014-20230426   gcc  
sparc64              randconfig-r015-20230426   gcc  
sparc64              randconfig-r024-20230426   gcc  
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
xtensa               randconfig-r004-20230426   gcc  
xtensa               randconfig-r023-20230426   gcc  
xtensa               randconfig-r026-20230426   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
