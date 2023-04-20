Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8BB6E9CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjDTUQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjDTUQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:16:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3779D1BF2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 13:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682021766; x=1713557766;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nUVtKfP9okcg9sxFbPiqjWfoDn2t1/4nubQjvnAI0fo=;
  b=XzA40mGuwhlfGV7/OQyNxOjpqEmIwrCRJ0KVcGa88OoPA2SdnRF2FhpS
   xFEP1kLI5Qbww2I14okTesan/SM21+kV5Nz2enXmtlQoRRlfE4wXtz4sq
   Y8EGwZiS02PakgMvZT42lFsFmB1NLiGw0ZQe+2Ov75MQRdBlLwPpKIoe/
   DEIDbxsPOQFja7vpFd2bH3OKwQODOzFAeh5114Hr7n78e4tOZtA1oYd3F
   pzZDI9VZlbK7Ku42KP7nvrQmGR0lCtVLyE88kVfSap5K7jZA4CF+oJTfz
   U3PO+CoHiIeh10s/P+6sxrI1b7Kr0uyNiElFUinKUtG+wXkdY006PGDeo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="343331542"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="343331542"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 13:16:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="938221653"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="938221653"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Apr 2023 13:15:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppah6-000g3g-2K;
        Thu, 20 Apr 2023 20:15:52 +0000
Date:   Fri, 21 Apr 2023 04:15:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD REGRESSION
 2aaae4bf41b101f7e58e8b06778b1cd9a1dddf94
Message-ID: <64419d5a.seNDxoLqS/4z1d+G%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 2aaae4bf41b101f7e58e8b06778b1cd9a1dddf94  posix-cpu-timers: Implement the missing timer_wait_running callback

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202304201736.fc1wH7zC-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304202022.rfhhidYd-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

kernel/time/posix-cpu-timers.c:1308:66: warning: parameter 'timr' set but not used [-Wunused-but-set-parameter]
kernel/time/posix-cpu-timers.c:1310:23: error: member reference type 'struct k_itimer *' is a pointer; did you mean to use '->'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- alpha-randconfig-r014-20230416
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- alpha-randconfig-r015-20230416
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- arc-allyesconfig
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- arc-randconfig-r002-20230417
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- arc-randconfig-r031-20230417
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- arc-randconfig-r035-20230420
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- arc-randconfig-r043-20230416
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- arm-allmodconfig
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- arm-allyesconfig
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- arm-defconfig
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- arm-randconfig-r005-20230418
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- arm-randconfig-r046-20230417
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- arm-randconfig-r046-20230419
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- loongarch-allmodconfig
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- loongarch-allnoconfig
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- loongarch-defconfig
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- loongarch-randconfig-r005-20230417
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- loongarch-randconfig-r034-20230420
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- m68k-allmodconfig
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- m68k-allyesconfig
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- m68k-randconfig-r016-20230416
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- m68k-randconfig-r036-20230420
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- microblaze-randconfig-r024-20230416
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- microblaze-randconfig-r035-20230418
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- mips-allmodconfig
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- mips-allyesconfig
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- nios2-randconfig-r004-20230416
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- nios2-randconfig-r022-20230417
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- nios2-randconfig-r033-20230418
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- openrisc-randconfig-r034-20230416
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- parisc-buildonly-randconfig-r002-20230416
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- s390-allmodconfig
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- s390-allyesconfig
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- s390-defconfig
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- s390-randconfig-r044-20230416
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- s390-randconfig-r044-20230420
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- sh-allmodconfig
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- sh-randconfig-r006-20230416
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- sparc-randconfig-r011-20230417
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- sparc-randconfig-r024-20230420
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- sparc-randconfig-r032-20230416
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- sparc64-buildonly-randconfig-r006-20230416
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- sparc64-randconfig-r032-20230418
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- xtensa-allyesconfig
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
|-- xtensa-randconfig-r005-20230416
|   `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
`-- xtensa-randconfig-r014-20230417
    `-- kernel-time-posix-cpu-timers.c:warning:parameter-timr-set-but-not-used
clang_recent_errors
|-- arm-randconfig-r021-20230416
|   `-- kernel-time-posix-cpu-timers.c:error:member-reference-type-struct-k_itimer-is-a-pointer
|-- arm-randconfig-r046-20230416
|   `-- kernel-time-posix-cpu-timers.c:error:member-reference-type-struct-k_itimer-is-a-pointer
|-- arm-randconfig-r046-20230420
|   `-- kernel-time-posix-cpu-timers.c:error:member-reference-type-struct-k_itimer-is-a-pointer
|-- hexagon-randconfig-r041-20230417
|   `-- kernel-time-posix-cpu-timers.c:error:member-reference-type-struct-k_itimer-is-a-pointer
|-- hexagon-randconfig-r041-20230418
|   `-- kernel-time-posix-cpu-timers.c:error:member-reference-type-struct-k_itimer-is-a-pointer
|-- hexagon-randconfig-r041-20230420
|   `-- kernel-time-posix-cpu-timers.c:error:member-reference-type-struct-k_itimer-is-a-pointer
|-- hexagon-randconfig-r045-20230416
|   `-- kernel-time-posix-cpu-timers.c:error:member-reference-type-struct-k_itimer-is-a-pointer
|-- hexagon-randconfig-r045-20230418
|   `-- kernel-time-posix-cpu-timers.c:error:member-reference-type-struct-k_itimer-is-a-pointer
|-- hexagon-randconfig-r045-20230419
|   `-- kernel-time-posix-cpu-timers.c:error:member-reference-type-struct-k_itimer-is-a-pointer
|-- s390-randconfig-r002-20230418
|   `-- kernel-time-posix-cpu-timers.c:error:member-reference-type-struct-k_itimer-is-a-pointer
|-- s390-randconfig-r031-20230416
|   `-- kernel-time-posix-cpu-timers.c:error:member-reference-type-struct-k_itimer-is-a-pointer
|-- s390-randconfig-r036-20230418
|   `-- kernel-time-posix-cpu-timers.c:error:member-reference-type-struct-k_itimer-is-a-pointer
|-- s390-randconfig-r044-20230417
|   `-- kernel-time-posix-cpu-timers.c:error:member-reference-type-struct-k_itimer-is-a-pointer
`-- s390-randconfig-r044-20230419
    `-- kernel-time-posix-cpu-timers.c:error:member-reference-type-struct-k_itimer-is-a-pointer

elapsed time: 720m

configs tested: 170
configs skipped: 14

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230416   gcc  
alpha                randconfig-r015-20230416   gcc  
alpha                randconfig-r033-20230416   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230417   gcc  
arc                  randconfig-r013-20230417   gcc  
arc                  randconfig-r025-20230417   gcc  
arc                  randconfig-r031-20230417   gcc  
arc                  randconfig-r035-20230420   gcc  
arc                  randconfig-r043-20230416   gcc  
arc                  randconfig-r043-20230417   gcc  
arc                  randconfig-r043-20230418   gcc  
arc                  randconfig-r043-20230419   gcc  
arc                  randconfig-r043-20230420   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230418   gcc  
arm                  randconfig-r011-20230416   clang
arm                  randconfig-r021-20230416   clang
arm                  randconfig-r025-20230416   clang
arm                  randconfig-r032-20230417   clang
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230417   gcc  
arm                  randconfig-r046-20230418   clang
arm                  randconfig-r046-20230419   gcc  
arm                  randconfig-r046-20230420   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230417   gcc  
arm64        buildonly-randconfig-r005-20230417   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r026-20230416   gcc  
arm64                randconfig-r036-20230416   clang
csky                                defconfig   gcc  
csky                 randconfig-r003-20230417   gcc  
csky                 randconfig-r012-20230416   gcc  
csky                 randconfig-r023-20230416   gcc  
csky                 randconfig-r035-20230416   gcc  
hexagon      buildonly-randconfig-r004-20230416   clang
hexagon              randconfig-r003-20230416   clang
hexagon              randconfig-r033-20230417   clang
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r041-20230417   clang
hexagon              randconfig-r041-20230418   clang
hexagon              randconfig-r041-20230419   clang
hexagon              randconfig-r041-20230420   clang
hexagon              randconfig-r045-20230416   clang
hexagon              randconfig-r045-20230417   clang
hexagon              randconfig-r045-20230418   clang
hexagon              randconfig-r045-20230419   clang
hexagon              randconfig-r045-20230420   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
i386                 randconfig-r023-20230417   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r025-20230420   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230417   gcc  
loongarch            randconfig-r034-20230420   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230416   gcc  
m68k                 randconfig-r021-20230420   gcc  
m68k                 randconfig-r036-20230420   gcc  
microblaze           randconfig-r021-20230417   gcc  
microblaze           randconfig-r024-20230416   gcc  
microblaze           randconfig-r035-20230418   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r004-20230417   clang
mips                 randconfig-r013-20230416   clang
mips                 randconfig-r035-20230417   clang
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230416   gcc  
nios2                randconfig-r022-20230417   gcc  
nios2                randconfig-r033-20230418   gcc  
openrisc             randconfig-r015-20230417   gcc  
openrisc             randconfig-r034-20230416   gcc  
openrisc             randconfig-r036-20230417   gcc  
parisc       buildonly-randconfig-r002-20230416   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230418   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r001-20230418   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230417   clang
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230416   clang
riscv                randconfig-r016-20230417   clang
riscv                randconfig-r032-20230420   clang
riscv                randconfig-r042-20230416   gcc  
riscv                randconfig-r042-20230417   clang
riscv                randconfig-r042-20230418   gcc  
riscv                randconfig-r042-20230419   clang
riscv                randconfig-r042-20230420   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230418   clang
s390                 randconfig-r003-20230418   clang
s390                 randconfig-r023-20230420   gcc  
s390                 randconfig-r031-20230416   clang
s390                 randconfig-r036-20230418   clang
s390                 randconfig-r044-20230416   gcc  
s390                 randconfig-r044-20230417   clang
s390                 randconfig-r044-20230418   gcc  
s390                 randconfig-r044-20230419   clang
s390                 randconfig-r044-20230420   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230417   gcc  
sh           buildonly-randconfig-r005-20230416   gcc  
sh                   randconfig-r002-20230416   gcc  
sh                   randconfig-r006-20230416   gcc  
sh                   randconfig-r034-20230417   gcc  
sparc        buildonly-randconfig-r003-20230417   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230417   gcc  
sparc                randconfig-r024-20230420   gcc  
sparc                randconfig-r032-20230416   gcc  
sparc64      buildonly-randconfig-r006-20230416   gcc  
sparc64              randconfig-r031-20230420   gcc  
sparc64              randconfig-r032-20230418   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230417   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230417   gcc  
x86_64               randconfig-a002-20230417   gcc  
x86_64               randconfig-a003-20230417   gcc  
x86_64               randconfig-a004-20230417   gcc  
x86_64               randconfig-a005-20230417   gcc  
x86_64               randconfig-a006-20230417   gcc  
x86_64               randconfig-a011-20230417   clang
x86_64               randconfig-a012-20230417   clang
x86_64               randconfig-a013-20230417   clang
x86_64               randconfig-a014-20230417   clang
x86_64               randconfig-a015-20230417   clang
x86_64               randconfig-a016-20230417   clang
x86_64               randconfig-r001-20230417   gcc  
x86_64               randconfig-r012-20230417   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r003-20230416   gcc  
xtensa               randconfig-r005-20230416   gcc  
xtensa               randconfig-r014-20230417   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
