Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6DC6C3F61
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 01:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCVA4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 20:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCVA4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 20:56:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813FB4B80D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 17:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679446566; x=1710982566;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Wj3BSW7PgcbgM3mk7krA1a4JWFumu31eV/rRxS66CTs=;
  b=QQeJ2gPpmCyNaCkCR1fx+FTwjMJLQv9z/uCR+Y/OP1MhWU1Msu7ht7EL
   z8KnjuZArI3zJ5uQUwCGdNPP9rmx43jM2Tk2qm/AbpthmtM5msGIAfEVB
   EP8gbVfdT/fr2C4PKqzN33qhklvmzJ7cA/+bV5eNsMbmv6VPGI3Y5Rr7i
   gsxK3lq/TJ0K/Z30E/3Ujo9skp8TEpTo9xvlFzDo7wiWJ49CtBAEazLBs
   4ZOq+sURLxR/WTiS1F9gfEWVFu2Me2dcOKJ97hgpGbSGvxBxiDYLIF5G4
   DuzhJ1s9578i/CLY16LYgpVAK6vMjp7ML4TPQ7Hi97WumaOQLn5WCVNjb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="337820236"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="337820236"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="805644202"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="805644202"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Mar 2023 17:56:04 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pemln-000Ccv-37;
        Wed, 22 Mar 2023 00:56:03 +0000
Date:   Wed, 22 Mar 2023 08:55:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 8a071b9c1325c6bfaf22508603b947ab75c1e9db
Message-ID: <641a51e8.++VgAMBCfEbHyqqG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 8a071b9c1325c6bfaf22508603b947ab75c1e9db  Merge branch into tip/master: 'x86/shstk'

elapsed time: 727m

configs tested: 219
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230319   gcc  
alpha        buildonly-randconfig-r002-20230319   gcc  
alpha        buildonly-randconfig-r004-20230319   gcc  
alpha        buildonly-randconfig-r005-20230320   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230319   gcc  
alpha                randconfig-r004-20230319   gcc  
alpha                randconfig-r016-20230320   gcc  
alpha                randconfig-r036-20230319   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230320   gcc  
arc                  randconfig-r005-20230319   gcc  
arc                  randconfig-r015-20230319   gcc  
arc                  randconfig-r025-20230319   gcc  
arc                  randconfig-r043-20230319   gcc  
arc                  randconfig-r043-20230320   gcc  
arc                  randconfig-r043-20230321   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-c002-20230319   gcc  
arm                  randconfig-r006-20230319   clang
arm                  randconfig-r011-20230319   gcc  
arm                  randconfig-r046-20230319   gcc  
arm                  randconfig-r046-20230320   clang
arm                  randconfig-r046-20230321   gcc  
arm                           u8500_defconfig   gcc  
arm                        vexpress_defconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230319   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230320   gcc  
arm64                randconfig-r013-20230319   clang
arm64                randconfig-r013-20230320   gcc  
arm64                randconfig-r014-20230319   clang
arm64                randconfig-r016-20230320   gcc  
arm64                randconfig-r024-20230319   clang
csky                                defconfig   gcc  
csky                 randconfig-r001-20230319   gcc  
csky                 randconfig-r004-20230319   gcc  
csky                 randconfig-r014-20230319   gcc  
csky                 randconfig-r035-20230320   gcc  
hexagon      buildonly-randconfig-r004-20230319   clang
hexagon      buildonly-randconfig-r006-20230319   clang
hexagon                             defconfig   clang
hexagon              randconfig-r003-20230320   clang
hexagon              randconfig-r004-20230320   clang
hexagon              randconfig-r006-20230320   clang
hexagon              randconfig-r025-20230320   clang
hexagon              randconfig-r041-20230319   clang
hexagon              randconfig-r041-20230320   clang
hexagon              randconfig-r045-20230319   clang
hexagon              randconfig-r045-20230320   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r003-20230320   clang
i386         buildonly-randconfig-r006-20230320   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230320   clang
i386                          randconfig-a001   gcc  
i386                 randconfig-a002-20230320   clang
i386                          randconfig-a002   clang
i386                 randconfig-a003-20230320   clang
i386                          randconfig-a003   gcc  
i386                 randconfig-a004-20230320   clang
i386                          randconfig-a004   clang
i386                 randconfig-a005-20230320   clang
i386                          randconfig-a005   gcc  
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
ia64                 randconfig-r021-20230319   gcc  
ia64                 randconfig-r033-20230319   gcc  
ia64                 randconfig-r036-20230320   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230320   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230319   gcc  
loongarch            randconfig-r011-20230320   gcc  
loongarch            randconfig-r025-20230320   gcc  
loongarch            randconfig-r026-20230320   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230319   gcc  
m68k                 randconfig-r014-20230320   gcc  
m68k                 randconfig-r026-20230319   gcc  
m68k                 randconfig-r031-20230319   gcc  
microblaze   buildonly-randconfig-r003-20230319   gcc  
microblaze           randconfig-r003-20230319   gcc  
microblaze           randconfig-r005-20230319   gcc  
microblaze           randconfig-r012-20230320   gcc  
microblaze           randconfig-r013-20230319   gcc  
microblaze           randconfig-r014-20230319   gcc  
microblaze           randconfig-r034-20230319   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips         buildonly-randconfig-r001-20230320   gcc  
mips         buildonly-randconfig-r004-20230320   gcc  
mips                            gpr_defconfig   gcc  
mips                        omega2p_defconfig   clang
mips                 randconfig-r005-20230320   gcc  
mips                 randconfig-r026-20230319   gcc  
mips                 randconfig-r034-20230320   gcc  
mips                          rm200_defconfig   clang
mips                        vocore2_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r023-20230320   gcc  
nios2                randconfig-r036-20230319   gcc  
openrisc             randconfig-r021-20230319   gcc  
openrisc             randconfig-r022-20230319   gcc  
openrisc             randconfig-r023-20230319   gcc  
openrisc             randconfig-r024-20230319   gcc  
openrisc             randconfig-r025-20230319   gcc  
openrisc             randconfig-r035-20230319   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230319   gcc  
parisc               randconfig-r022-20230319   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                     kmeter1_defconfig   clang
powerpc                mpc7448_hpc2_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                 mpc8540_ads_defconfig   gcc  
powerpc              randconfig-r006-20230319   gcc  
powerpc              randconfig-r021-20230320   gcc  
powerpc              randconfig-r033-20230319   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230319   clang
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230319   gcc  
riscv                randconfig-r042-20230319   clang
riscv                randconfig-r042-20230320   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230319   clang
s390                                defconfig   gcc  
s390                 randconfig-r021-20230320   gcc  
s390                 randconfig-r044-20230319   clang
s390                 randconfig-r044-20230320   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230319   gcc  
sh                   randconfig-r005-20230320   gcc  
sh                   randconfig-r011-20230319   gcc  
sh                   randconfig-r012-20230319   gcc  
sh                   randconfig-r032-20230319   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230320   gcc  
sparc                randconfig-r012-20230319   gcc  
sparc                randconfig-r015-20230320   gcc  
sparc                randconfig-r024-20230320   gcc  
sparc                randconfig-r031-20230319   gcc  
sparc                randconfig-r035-20230319   gcc  
sparc64              randconfig-r001-20230320   gcc  
sparc64              randconfig-r024-20230320   gcc  
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
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-c001   gcc  
x86_64                        randconfig-k001   clang
x86_64               randconfig-r006-20230320   clang
x86_64               randconfig-r022-20230320   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa       buildonly-randconfig-r006-20230320   gcc  
xtensa               randconfig-r001-20230319   gcc  
xtensa               randconfig-r002-20230320   gcc  
xtensa               randconfig-r003-20230319   gcc  
xtensa               randconfig-r012-20230320   gcc  
xtensa               randconfig-r033-20230320   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
