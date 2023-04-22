Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1826EB742
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 06:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDVEEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 00:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDVEEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 00:04:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FEF1FF1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 21:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682136276; x=1713672276;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aDrmnTa0EvwnJayM0+q4kQhYIcBp6K0QqmqQ1hpKqFg=;
  b=agZkg826RFK2Se0YrceOPbUBdKCS7Crc8TTqhAqzIZ6WKtiMO22ZVZnv
   frJhGIK/TC2KDuqou24ETe+Rl0Yh7y35DcUV1qDZkoUFsxMAL5xm0ehLZ
   lBjjLrroraUUF70dW9ij7rUARYmDGGYqQI3m6ulZJHN6gup3XIcPOQyG+
   9t1stFprICrDh4xIFYrG64QOAGEqSC2KAfnpJgCrzVWAB7TV81lNWKASR
   GIoaXEvZEX603LxoFND0gV0QR9ABxEcSra3efeg+By5SP595Aco1n8+C3
   h+931pTc3MQjp2Ii5dOfNfiIKBj3NITdIeivnHgh9G/q/y4ySWlQmlwDA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="330332079"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="330332079"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 21:04:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="722970073"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="722970073"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Apr 2023 21:04:34 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pq4UD-000h3S-2T;
        Sat, 22 Apr 2023 04:04:33 +0000
Date:   Sat, 22 Apr 2023 12:04:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 f7abf14f0001a5a47539d9f60bbdca649e43536b
Message-ID: <64435cbc.dIUfJhPPS/XYBQJU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: f7abf14f0001a5a47539d9f60bbdca649e43536b  posix-cpu-timers: Implement the missing timer_wait_running callback

elapsed time: 865m

configs tested: 254
configs skipped: 28

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230421   gcc  
alpha        buildonly-randconfig-r002-20230421   gcc  
alpha        buildonly-randconfig-r006-20230421   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230421   gcc  
alpha                randconfig-r004-20230421   gcc  
alpha                randconfig-r023-20230421   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230421   gcc  
arc                  randconfig-r003-20230421   gcc  
arc                  randconfig-r004-20230421   gcc  
arc                  randconfig-r006-20230421   gcc  
arc                  randconfig-r011-20230421   gcc  
arc                  randconfig-r014-20230421   gcc  
arc                  randconfig-r015-20230421   gcc  
arc                  randconfig-r022-20230421   gcc  
arc                  randconfig-r031-20230421   gcc  
arc                  randconfig-r033-20230421   gcc  
arc                  randconfig-r043-20230421   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230421   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230421   clang
arm                  randconfig-r026-20230421   gcc  
arm                  randconfig-r031-20230421   clang
arm                  randconfig-r046-20230421   gcc  
arm                        shmobile_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230421   gcc  
arm64        buildonly-randconfig-r004-20230421   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r015-20230421   clang
arm64                randconfig-r031-20230421   gcc  
arm64                randconfig-r033-20230421   gcc  
csky         buildonly-randconfig-r004-20230421   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r005-20230421   gcc  
csky                 randconfig-r012-20230421   gcc  
csky                 randconfig-r015-20230421   gcc  
csky                 randconfig-r023-20230421   gcc  
csky                 randconfig-r024-20230421   gcc  
csky                 randconfig-r025-20230421   gcc  
csky                 randconfig-r032-20230421   gcc  
csky                 randconfig-r036-20230421   gcc  
hexagon      buildonly-randconfig-r001-20230421   clang
hexagon      buildonly-randconfig-r002-20230421   clang
hexagon              randconfig-r001-20230421   clang
hexagon              randconfig-r004-20230421   clang
hexagon              randconfig-r011-20230421   clang
hexagon              randconfig-r022-20230421   clang
hexagon              randconfig-r035-20230421   clang
hexagon              randconfig-r041-20230421   clang
hexagon              randconfig-r045-20230421   clang
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
ia64         buildonly-randconfig-r002-20230421   gcc  
ia64         buildonly-randconfig-r003-20230421   gcc  
ia64         buildonly-randconfig-r005-20230421   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230421   gcc  
ia64                 randconfig-r005-20230421   gcc  
ia64                 randconfig-r011-20230421   gcc  
ia64                 randconfig-r014-20230421   gcc  
ia64                 randconfig-r022-20230421   gcc  
ia64                 randconfig-r023-20230421   gcc  
ia64                 randconfig-r024-20230421   gcc  
ia64                 randconfig-r034-20230421   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230421   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230421   gcc  
loongarch            randconfig-r003-20230421   gcc  
loongarch            randconfig-r011-20230421   gcc  
loongarch            randconfig-r015-20230421   gcc  
loongarch            randconfig-r032-20230421   gcc  
loongarch            randconfig-r035-20230421   gcc  
loongarch            randconfig-r036-20230421   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230421   gcc  
m68k         buildonly-randconfig-r002-20230421   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230421   gcc  
m68k                 randconfig-r003-20230421   gcc  
m68k                 randconfig-r004-20230421   gcc  
m68k                 randconfig-r014-20230421   gcc  
m68k                 randconfig-r016-20230421   gcc  
m68k                 randconfig-r023-20230421   gcc  
m68k                 randconfig-r024-20230421   gcc  
m68k                 randconfig-r034-20230421   gcc  
microblaze   buildonly-randconfig-r005-20230421   gcc  
microblaze           randconfig-r001-20230421   gcc  
microblaze           randconfig-r006-20230421   gcc  
microblaze           randconfig-r012-20230421   gcc  
microblaze           randconfig-r013-20230421   gcc  
microblaze           randconfig-r015-20230421   gcc  
microblaze           randconfig-r021-20230421   gcc  
microblaze           randconfig-r022-20230421   gcc  
microblaze           randconfig-r023-20230421   gcc  
microblaze           randconfig-r024-20230421   gcc  
microblaze           randconfig-r034-20230421   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230421   clang
mips                 randconfig-r012-20230421   gcc  
mips                 randconfig-r013-20230421   gcc  
mips                 randconfig-r014-20230421   gcc  
mips                 randconfig-r015-20230421   gcc  
mips                 randconfig-r022-20230421   gcc  
mips                 randconfig-r032-20230421   clang
nios2                            alldefconfig   gcc  
nios2        buildonly-randconfig-r002-20230421   gcc  
nios2        buildonly-randconfig-r005-20230421   gcc  
nios2        buildonly-randconfig-r006-20230421   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230421   gcc  
nios2                randconfig-r006-20230421   gcc  
nios2                randconfig-r014-20230421   gcc  
nios2                randconfig-r026-20230421   gcc  
nios2                randconfig-r035-20230421   gcc  
openrisc     buildonly-randconfig-r002-20230421   gcc  
openrisc     buildonly-randconfig-r003-20230421   gcc  
openrisc     buildonly-randconfig-r006-20230421   gcc  
openrisc             randconfig-r006-20230421   gcc  
openrisc             randconfig-r031-20230421   gcc  
openrisc             randconfig-r032-20230421   gcc  
parisc       buildonly-randconfig-r001-20230421   gcc  
parisc       buildonly-randconfig-r002-20230421   gcc  
parisc       buildonly-randconfig-r003-20230421   gcc  
parisc       buildonly-randconfig-r004-20230421   gcc  
parisc       buildonly-randconfig-r005-20230421   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230421   gcc  
parisc               randconfig-r004-20230421   gcc  
parisc               randconfig-r006-20230421   gcc  
parisc               randconfig-r011-20230421   gcc  
parisc               randconfig-r014-20230421   gcc  
parisc               randconfig-r024-20230421   gcc  
parisc               randconfig-r031-20230421   gcc  
parisc               randconfig-r036-20230421   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230421   clang
powerpc      buildonly-randconfig-r006-20230421   clang
powerpc                 mpc832x_rdb_defconfig   clang
powerpc              randconfig-r001-20230421   gcc  
powerpc              randconfig-r002-20230421   gcc  
powerpc              randconfig-r014-20230421   clang
powerpc              randconfig-r022-20230421   clang
powerpc              randconfig-r025-20230421   clang
powerpc              randconfig-r032-20230421   gcc  
powerpc              randconfig-r033-20230421   gcc  
powerpc              randconfig-r034-20230421   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230421   clang
riscv        buildonly-randconfig-r004-20230421   clang
riscv        buildonly-randconfig-r005-20230421   clang
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230421   gcc  
riscv                randconfig-r004-20230421   gcc  
riscv                randconfig-r006-20230421   gcc  
riscv                randconfig-r015-20230421   clang
riscv                randconfig-r035-20230421   gcc  
riscv                randconfig-r042-20230421   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230421   clang
s390         buildonly-randconfig-r003-20230421   clang
s390         buildonly-randconfig-r004-20230421   clang
s390         buildonly-randconfig-r005-20230421   clang
s390                                defconfig   gcc  
s390                 randconfig-r005-20230421   gcc  
s390                 randconfig-r006-20230421   gcc  
s390                 randconfig-r011-20230421   clang
s390                 randconfig-r012-20230421   clang
s390                 randconfig-r016-20230421   clang
s390                 randconfig-r023-20230421   clang
s390                 randconfig-r044-20230421   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230421   gcc  
sh                        edosk7760_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                   randconfig-r005-20230421   gcc  
sh                   randconfig-r011-20230421   gcc  
sh                   randconfig-r012-20230421   gcc  
sh                   randconfig-r016-20230421   gcc  
sh                   randconfig-r032-20230421   gcc  
sh                              ul2_defconfig   gcc  
sparc        buildonly-randconfig-r004-20230421   gcc  
sparc        buildonly-randconfig-r005-20230421   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230421   gcc  
sparc                randconfig-r004-20230421   gcc  
sparc                randconfig-r005-20230421   gcc  
sparc                randconfig-r021-20230421   gcc  
sparc                randconfig-r034-20230421   gcc  
sparc64      buildonly-randconfig-r001-20230421   gcc  
sparc64      buildonly-randconfig-r006-20230421   gcc  
sparc64              randconfig-r002-20230421   gcc  
sparc64              randconfig-r013-20230421   gcc  
sparc64              randconfig-r016-20230421   gcc  
sparc64              randconfig-r025-20230421   gcc  
sparc64              randconfig-r031-20230421   gcc  
sparc64              randconfig-r034-20230421   gcc  
sparc64              randconfig-r035-20230421   gcc  
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
xtensa                  audio_kc705_defconfig   gcc  
xtensa       buildonly-randconfig-r002-20230421   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa               randconfig-r005-20230421   gcc  
xtensa               randconfig-r011-20230421   gcc  
xtensa               randconfig-r013-20230421   gcc  
xtensa               randconfig-r021-20230421   gcc  
xtensa               randconfig-r034-20230421   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
