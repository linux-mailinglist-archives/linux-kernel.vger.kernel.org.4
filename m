Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD836C4062
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCVC2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjCVC23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:28:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D8325BA6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 19:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679452092; x=1710988092;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FNpbWwhtysMhKkKFb2pjNygnC0ksXUoa7d2hhmUK5v4=;
  b=Eb0G8bihRuqbyDegOa9+zA6aQrsqhRQXAArPTDhInEhAFqqpHT5X2FGX
   P2k/2FT5g4dVts1LypYyjJeddKcGERwZ4zL3RzXmHdR6oOr5QC048ULL4
   UgyQ+T3rh2q+CtQpED8OTsoRXZDnZ8LmCTN7Y74co6c3CFz3NHAzxKtrm
   jwawMB7dDk06QUfBxveYYWl5WpMsEt+xNfoX0b9tnoJqP2CEvDo3XHAVd
   JFXOS3G1tejGRHv3gImblsYlnbmkPq06zPYHdLiOraMqZVZNqsEgPOe8S
   3xfGxJjcO5ipgfOzOZikatXR758gTCTQ4GWmhpqjwjxGQHO73Zz2XFXB8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="322952161"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="322952161"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 19:28:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="927666178"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="927666178"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Mar 2023 19:28:10 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peoCv-000CjB-1G;
        Wed, 22 Mar 2023 02:28:09 +0000
Date:   Wed, 22 Mar 2023 10:27:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/urgent] BUILD SUCCESS
 b416514054810cf2d2cc348ae477cea619b64da7
Message-ID: <641a677f.kHBhHN5MjjfBGpIM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent
branch HEAD: b416514054810cf2d2cc348ae477cea619b64da7  entry/rcu: Check TIF_RESCHED _after_ delayed RCU wake-up

elapsed time: 729m

configs tested: 209
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230319   gcc  
alpha                randconfig-r016-20230320   gcc  
alpha                randconfig-r023-20230319   gcc  
alpha                randconfig-r031-20230319   gcc  
alpha                randconfig-r033-20230319   gcc  
alpha                randconfig-r035-20230319   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r005-20230319   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230320   gcc  
arc                  randconfig-r005-20230319   gcc  
arc                  randconfig-r015-20230319   gcc  
arc                  randconfig-r043-20230321   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230319   clang
arm                  randconfig-r011-20230319   gcc  
arm                  randconfig-r046-20230321   gcc  
arm                        vexpress_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230319   clang
arm64                randconfig-r013-20230320   gcc  
arm64                randconfig-r014-20230319   clang
csky         buildonly-randconfig-r003-20230319   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230319   gcc  
csky                 randconfig-r003-20230319   gcc  
csky                 randconfig-r004-20230319   gcc  
csky                 randconfig-r005-20230319   gcc  
csky                 randconfig-r006-20230319   gcc  
csky                 randconfig-r014-20230319   gcc  
csky                 randconfig-r022-20230319   gcc  
csky                 randconfig-r033-20230319   gcc  
csky                 randconfig-r035-20230319   gcc  
csky                 randconfig-r035-20230320   gcc  
hexagon      buildonly-randconfig-r004-20230319   clang
hexagon      buildonly-randconfig-r006-20230319   clang
hexagon                             defconfig   clang
hexagon              randconfig-r004-20230320   clang
hexagon              randconfig-r032-20230319   clang
hexagon              randconfig-r041-20230319   clang
hexagon              randconfig-r041-20230321   clang
hexagon              randconfig-r045-20230319   clang
hexagon              randconfig-r045-20230321   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230320   clang
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
i386                          randconfig-a011   clang
i386                 randconfig-a012-20230320   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230320   gcc  
i386                          randconfig-a013   clang
i386                 randconfig-a014-20230320   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230320   gcc  
i386                          randconfig-a015   clang
i386                 randconfig-a016-20230320   gcc  
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r003-20230319   gcc  
ia64                 randconfig-r021-20230319   gcc  
ia64                 randconfig-r033-20230319   gcc  
ia64                 randconfig-r036-20230319   gcc  
ia64                 randconfig-r036-20230320   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230319   gcc  
loongarch            randconfig-r011-20230320   gcc  
loongarch            randconfig-r013-20230319   gcc  
loongarch            randconfig-r025-20230320   gcc  
loongarch            randconfig-r026-20230320   gcc  
loongarch            randconfig-r031-20230319   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230320   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230319   gcc  
m68k                 randconfig-r026-20230319   gcc  
microblaze           randconfig-r003-20230319   gcc  
microblaze           randconfig-r012-20230320   gcc  
microblaze           randconfig-r013-20230319   gcc  
microblaze           randconfig-r014-20230319   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips         buildonly-randconfig-r001-20230319   clang
mips                        omega2p_defconfig   clang
mips                 randconfig-r026-20230319   gcc  
mips                 randconfig-r034-20230320   gcc  
mips                          rm200_defconfig   clang
mips                        vocore2_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230319   gcc  
nios2                randconfig-r003-20230319   gcc  
nios2                randconfig-r004-20230319   gcc  
nios2                randconfig-r023-20230320   gcc  
nios2                randconfig-r034-20230319   gcc  
nios2                randconfig-r036-20230319   gcc  
openrisc     buildonly-randconfig-r004-20230319   gcc  
openrisc             randconfig-r001-20230319   gcc  
openrisc             randconfig-r021-20230319   gcc  
openrisc             randconfig-r022-20230319   gcc  
openrisc             randconfig-r023-20230319   gcc  
openrisc             randconfig-r024-20230319   gcc  
openrisc             randconfig-r025-20230319   gcc  
openrisc             randconfig-r035-20230319   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230319   gcc  
parisc               randconfig-r022-20230319   gcc  
parisc               randconfig-r025-20230319   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230319   clang
powerpc      buildonly-randconfig-r006-20230320   gcc  
powerpc                   microwatt_defconfig   clang
powerpc                     mpc5200_defconfig   clang
powerpc              randconfig-r002-20230319   gcc  
powerpc              randconfig-r006-20230319   gcc  
powerpc              randconfig-r016-20230319   clang
powerpc              randconfig-r021-20230320   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230319   clang
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230319   gcc  
riscv                randconfig-r006-20230319   gcc  
riscv                randconfig-r016-20230319   clang
riscv                randconfig-r042-20230319   clang
riscv                randconfig-r042-20230321   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230319   clang
s390         buildonly-randconfig-r002-20230319   clang
s390         buildonly-randconfig-r004-20230320   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230319   clang
s390                 randconfig-r044-20230321   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230320   gcc  
sh                   randconfig-r011-20230319   gcc  
sh                   randconfig-r012-20230319   gcc  
sh                   randconfig-r032-20230319   gcc  
sh                   randconfig-r034-20230319   gcc  
sh                           se7619_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230319   gcc  
sparc                randconfig-r002-20230320   gcc  
sparc                randconfig-r004-20230319   gcc  
sparc                randconfig-r012-20230319   gcc  
sparc                randconfig-r015-20230319   gcc  
sparc                randconfig-r015-20230320   gcc  
sparc                randconfig-r021-20230319   gcc  
sparc                randconfig-r024-20230320   gcc  
sparc                randconfig-r031-20230319   gcc  
sparc                randconfig-r032-20230319   gcc  
sparc64              randconfig-r001-20230320   gcc  
sparc64              randconfig-r011-20230319   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230320   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230320   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230320   clang
x86_64               randconfig-a003-20230320   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230320   clang
x86_64               randconfig-a005-20230320   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230320   clang
x86_64               randconfig-a011-20230320   gcc  
x86_64               randconfig-a012-20230320   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230320   gcc  
x86_64               randconfig-a014-20230320   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230320   gcc  
x86_64               randconfig-a016-20230320   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64               randconfig-r006-20230320   clang
x86_64               randconfig-r022-20230320   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230319   gcc  
xtensa               randconfig-r004-20230319   gcc  
xtensa               randconfig-r033-20230320   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
