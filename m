Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823B66D91B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbjDFIdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjDFIds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:33:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F60EE55
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680770027; x=1712306027;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tpVqMqy8EiWGfEUArzJ0E5S4Av3+LoYMfk/qrNdRRls=;
  b=lSUm6NNOHEICHxFDBVga0szlPrs3UhHkGc+jO3YFeEoRdCb5ogTNQoQ7
   f0r6UHyGgo0N7Gv5wBF1jSuqJ4NgcTXBEgxRVa3xpPpfkcLglz4gCNKIx
   OiTs3a9bBd4OySJUYWK39yOsAYnUeo3JYVRRgJt9He8uKCAIPRnG688uR
   ZTzycQWX9umgFyePAC4X5qlKG0wnYiO/P5h/U/MXKRzFQgSw9CVJcfiL8
   CMhNZFQ/UwFSZ3VkMe+iOOYsIXR5NeHYz7nrZnboQI7xd9A+i/9L+Tay+
   9CtiCusylSwfD0D5Tl9xWrrVfmSmX/537SwJlMGptmjhfZE2TjC3gyJWk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="370515100"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="370515100"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 01:33:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="1016790816"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="1016790816"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 06 Apr 2023 01:33:44 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkL3w-000RDa-0U;
        Thu, 06 Apr 2023 08:33:44 +0000
Date:   Thu, 06 Apr 2023 16:33:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 93a0a9e05a23688c3c67ec6fd68b8b3d3775c2b2
Message-ID: <642e83e7.a/QAGZ1Z/hqB95VS%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 93a0a9e05a23688c3c67ec6fd68b8b3d3775c2b2  Revert "rcu/kvfree: Eliminate k[v]free_rcu() single argument macro"

elapsed time: 727m

configs tested: 170
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230403   gcc  
alpha                randconfig-r033-20230406   gcc  
alpha                randconfig-r034-20230403   gcc  
alpha                randconfig-r036-20230403   gcc  
alpha                randconfig-r036-20230404   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r021-20230403   gcc  
arc                  randconfig-r033-20230403   gcc  
arc                  randconfig-r034-20230403   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                  randconfig-r021-20230403   clang
arm                  randconfig-r031-20230403   gcc  
arm                  randconfig-r034-20230403   gcc  
arm                  randconfig-r035-20230403   gcc  
arm                  randconfig-r046-20230403   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230403   clang
arm64                randconfig-r012-20230403   gcc  
arm64                randconfig-r026-20230403   gcc  
arm64                randconfig-r026-20230405   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230403   gcc  
csky                 randconfig-r011-20230403   gcc  
csky                 randconfig-r012-20230403   gcc  
csky                 randconfig-r033-20230403   gcc  
hexagon      buildonly-randconfig-r001-20230403   clang
hexagon      buildonly-randconfig-r006-20230404   clang
hexagon              randconfig-r035-20230403   clang
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r041-20230406   clang
hexagon              randconfig-r045-20230403   clang
hexagon              randconfig-r045-20230406   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                 randconfig-a012-20230403   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                 randconfig-r003-20230403   clang
i386                 randconfig-r015-20230403   gcc  
i386                 randconfig-r016-20230403   gcc  
i386                 randconfig-r036-20230403   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230403   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230403   gcc  
loongarch            randconfig-r023-20230405   gcc  
loongarch            randconfig-r032-20230406   gcc  
loongarch            randconfig-r034-20230406   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230403   gcc  
m68k         buildonly-randconfig-r002-20230403   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230403   gcc  
m68k                 randconfig-r021-20230405   gcc  
m68k                 randconfig-r034-20230404   gcc  
m68k                 randconfig-r036-20230406   gcc  
microblaze   buildonly-randconfig-r005-20230403   gcc  
microblaze           randconfig-r005-20230403   gcc  
microblaze           randconfig-r031-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230403   gcc  
mips                 randconfig-r024-20230403   clang
mips                 randconfig-r026-20230403   clang
nios2        buildonly-randconfig-r004-20230403   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230403   gcc  
nios2                randconfig-r022-20230403   gcc  
nios2                randconfig-r024-20230403   gcc  
nios2                randconfig-r033-20230404   gcc  
openrisc     buildonly-randconfig-r006-20230403   gcc  
openrisc             randconfig-r011-20230403   gcc  
openrisc             randconfig-r022-20230403   gcc  
parisc       buildonly-randconfig-r003-20230403   gcc  
parisc       buildonly-randconfig-r004-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230403   gcc  
parisc               randconfig-r011-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230404   clang
powerpc              randconfig-r014-20230403   gcc  
powerpc              randconfig-r015-20230403   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230403   gcc  
riscv        buildonly-randconfig-r003-20230403   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230403   gcc  
riscv                randconfig-r013-20230403   gcc  
riscv                randconfig-r031-20230406   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                randconfig-r042-20230406   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r031-20230404   gcc  
s390                 randconfig-r044-20230403   gcc  
s390                 randconfig-r044-20230406   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230403   gcc  
sh           buildonly-randconfig-r005-20230403   gcc  
sh                   randconfig-r025-20230405   gcc  
sh                   randconfig-r026-20230403   gcc  
sh                   randconfig-r031-20230403   gcc  
sh                   randconfig-r036-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230403   gcc  
sparc                randconfig-r021-20230403   gcc  
sparc                randconfig-r024-20230403   gcc  
sparc                randconfig-r025-20230403   gcc  
sparc                randconfig-r032-20230403   gcc  
sparc64      buildonly-randconfig-r006-20230403   gcc  
sparc64              randconfig-r005-20230403   gcc  
sparc64              randconfig-r014-20230403   gcc  
sparc64              randconfig-r035-20230406   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r005-20230403   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64               randconfig-a006-20230403   clang
x86_64               randconfig-a011-20230403   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64               randconfig-k001-20230403   gcc  
x86_64               randconfig-r001-20230403   clang
x86_64               randconfig-r032-20230403   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230403   gcc  
xtensa               randconfig-r001-20230403   gcc  
xtensa               randconfig-r033-20230403   gcc  
xtensa               randconfig-r035-20230404   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
