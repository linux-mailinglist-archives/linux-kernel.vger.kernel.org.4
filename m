Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DB06D1441
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjCaAn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCaAnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:43:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CAAB465
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680223400; x=1711759400;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bjn7ll07kRwryQ3NUDA/uissp2h7i+dMWzBICn9f4uU=;
  b=hu/zm+obqULuFLwF2eBeFAF7DJFANlteE14gwTtvJInr4T8735phyg/8
   IB3rkBS72hO0qTHOODvhGNOYeL5gnTZdJJxwxDfwAdvspKFRIyVU3YA/R
   f4wGtL8rxs5SWcw2YOqipzolyvOVhVa0N+WGWR03GCftbkz8T/akITuqu
   R05wudi2mDsbhTSY0t/vCVvuAzplfbm6KZhpyNmim7EwLQW1oWcu3FOfd
   ufdu6M15WLEFvXiEwhiYKl6+AAJzg2dDvMBK9gg6+LCnUhEMJ7ZDXrk/G
   LThHiT/61VCKQWS3NSEOUGcHOtfjBo212+waMmmW86rKqFf55bhZmmLnt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="342966935"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="342966935"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 17:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="859099990"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="859099990"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 30 Mar 2023 17:43:18 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pi2rN-000LMM-21;
        Fri, 31 Mar 2023 00:43:17 +0000
Date:   Fri, 31 Mar 2023 08:42:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 5b422b9bb7318b5ab8d0c124d623db4d3f6b2771
Message-ID: <64262c92.ERMkVlKgCf/6vsqU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: 5b422b9bb7318b5ab8d0c124d623db4d3f6b2771  Merge branch 'x86/cc' into x86/apic

elapsed time: 723m

configs tested: 200
configs skipped: 155

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230329   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230329   gcc  
alpha                randconfig-r016-20230329   gcc  
alpha                randconfig-r025-20230329   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r005-20230329   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230329   gcc  
arc                  randconfig-r032-20230329   gcc  
arc                  randconfig-r033-20230329   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                  randconfig-c002-20230330   gcc  
arm                  randconfig-r026-20230329   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230329   gcc  
arm64        buildonly-randconfig-r002-20230329   gcc  
arm64        buildonly-randconfig-r005-20230329   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230329   gcc  
arm64                randconfig-r025-20230329   clang
arm64                randconfig-r026-20230329   clang
arm64                randconfig-r032-20230329   gcc  
arm64                randconfig-r036-20230329   gcc  
csky         buildonly-randconfig-r006-20230329   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230329   gcc  
csky                 randconfig-r004-20230329   gcc  
csky                 randconfig-r022-20230329   gcc  
csky                 randconfig-r034-20230329   gcc  
hexagon      buildonly-randconfig-r005-20230329   clang
hexagon              randconfig-r015-20230329   clang
hexagon              randconfig-r032-20230329   clang
hexagon              randconfig-r041-20230329   clang
hexagon              randconfig-r045-20230329   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a004   clang
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230329   gcc  
ia64                                defconfig   gcc  
ia64                      gensparse_defconfig   gcc  
ia64                 randconfig-r002-20230329   gcc  
ia64                 randconfig-r003-20230329   gcc  
ia64                 randconfig-r004-20230329   gcc  
ia64                 randconfig-r005-20230329   gcc  
ia64                 randconfig-r006-20230329   gcc  
ia64                 randconfig-r011-20230329   gcc  
ia64                 randconfig-r023-20230329   gcc  
ia64                 randconfig-r024-20230329   gcc  
ia64                 randconfig-r025-20230329   gcc  
ia64                 randconfig-r035-20230329   gcc  
ia64                 randconfig-r036-20230329   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230329   gcc  
loongarch            randconfig-r006-20230329   gcc  
loongarch            randconfig-r013-20230329   gcc  
loongarch            randconfig-r021-20230329   gcc  
loongarch            randconfig-r034-20230329   gcc  
m68k                             allmodconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k         buildonly-randconfig-r002-20230329   gcc  
m68k         buildonly-randconfig-r004-20230329   gcc  
m68k         buildonly-randconfig-r006-20230329   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                 randconfig-r002-20230329   gcc  
m68k                 randconfig-r004-20230329   gcc  
m68k                 randconfig-r012-20230329   gcc  
m68k                 randconfig-r014-20230329   gcc  
m68k                 randconfig-r016-20230329   gcc  
m68k                 randconfig-r031-20230329   gcc  
m68k                 randconfig-r035-20230329   gcc  
microblaze           randconfig-r015-20230329   gcc  
microblaze           randconfig-r023-20230329   gcc  
microblaze           randconfig-r024-20230329   gcc  
microblaze           randconfig-r031-20230329   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230329   clang
mips                 randconfig-r001-20230329   clang
mips                 randconfig-r012-20230329   gcc  
mips                 randconfig-r013-20230329   gcc  
nios2        buildonly-randconfig-r001-20230329   gcc  
nios2        buildonly-randconfig-r003-20230329   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230329   gcc  
nios2                randconfig-r006-20230329   gcc  
nios2                randconfig-r011-20230329   gcc  
nios2                randconfig-r026-20230329   gcc  
nios2                randconfig-r031-20230329   gcc  
nios2                randconfig-r033-20230329   gcc  
nios2                randconfig-r035-20230329   gcc  
openrisc     buildonly-randconfig-r002-20230329   gcc  
openrisc     buildonly-randconfig-r004-20230329   gcc  
openrisc             randconfig-r011-20230329   gcc  
openrisc             randconfig-r022-20230329   gcc  
openrisc             randconfig-r034-20230329   gcc  
parisc       buildonly-randconfig-r005-20230329   gcc  
parisc       buildonly-randconfig-r006-20230329   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230329   gcc  
parisc               randconfig-r014-20230329   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                 mpc8540_ads_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc              randconfig-r003-20230329   gcc  
powerpc              randconfig-r011-20230329   clang
powerpc              randconfig-r024-20230329   clang
powerpc              randconfig-r032-20230329   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     tqm8555_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230329   gcc  
riscv                randconfig-r005-20230329   gcc  
riscv                randconfig-r006-20230329   gcc  
riscv                randconfig-r013-20230329   clang
riscv                randconfig-r016-20230329   clang
riscv                randconfig-r022-20230329   clang
riscv                randconfig-r042-20230329   clang
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230329   clang
s390                                defconfig   gcc  
s390                 randconfig-r014-20230329   clang
s390                 randconfig-r016-20230329   clang
s390                 randconfig-r022-20230329   clang
s390                 randconfig-r023-20230329   clang
s390                 randconfig-r044-20230329   clang
sh                               allmodconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                   randconfig-r005-20230329   gcc  
sh                           sh2007_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sparc        buildonly-randconfig-r003-20230329   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230329   gcc  
sparc                randconfig-r022-20230329   gcc  
sparc                randconfig-r036-20230329   gcc  
sparc64      buildonly-randconfig-r003-20230329   gcc  
sparc64      buildonly-randconfig-r005-20230329   gcc  
sparc64      buildonly-randconfig-r006-20230329   gcc  
sparc64              randconfig-r003-20230329   gcc  
sparc64              randconfig-r005-20230329   gcc  
sparc64              randconfig-r006-20230329   gcc  
sparc64              randconfig-r012-20230329   gcc  
sparc64              randconfig-r031-20230329   gcc  
sparc64              randconfig-r033-20230329   gcc  
sparc64              randconfig-r035-20230329   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-c001   gcc  
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r003-20230329   gcc  
xtensa               randconfig-r026-20230329   gcc  
xtensa               randconfig-r033-20230329   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
