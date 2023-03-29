Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711E86CD413
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjC2IKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjC2IJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:09:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD36468D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680077384; x=1711613384;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=S3f9fzDNZflV0TRY5V8f5Fbs4mGwGyvypxNPmKhklCI=;
  b=WdRT+eugJ2SljPgsOWAcz9CQp4HxTqClOcQFPm3wOxvXQeBwAMHxPN9X
   Wz+wJKazdeKqtEef4AvpA7p3EfYfHoqMiBqu/w4xcgsAxfHvS0a0Q57YJ
   yCwDE25/oOdCbyulZpB0RHyCEbtSA+Reu7bJDuxTjFeiO5gLCiGVvDT8G
   iLMyJIjGNNM3M2I/niLz8meJgQMdU3O1v7fXM7lv9HxIVKEIIhbi1vUGY
   ldXO745/qd7fVfVpficSXy2I3qkQTCBYFWiqtrdwSgIwBxj4C5w9I52IV
   dY+8m1lIEkp0MU5qRKg+2iOMdsjTYA1cyt8r4jaOVjkFNyYO5sHxlVSQd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="324715981"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="324715981"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 01:09:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="714543464"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="714543464"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2023 01:09:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phQsI-000JMK-0o;
        Wed, 29 Mar 2023 08:09:42 +0000
Date:   Wed, 29 Mar 2023 16:09:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.03.27b] BUILD SUCCESS
 326232a254293c41a88dee2ad0592f413b593be4
Message-ID: <6423f221.TZ5ox4ghMDFmm8Ws%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.03.27b
branch HEAD: 326232a254293c41a88dee2ad0592f413b593be4  tools/nolibc: tests: use volatile to force stack smashing

elapsed time: 753m

configs tested: 137
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r012-20230327   gcc  
arc                  randconfig-r043-20230326   gcc  
arc                  randconfig-r043-20230327   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r022-20230326   clang
arm                  randconfig-r034-20230328   gcc  
arm                  randconfig-r046-20230326   clang
arm                  randconfig-r046-20230327   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230326   clang
arm64                               defconfig   gcc  
arm64                randconfig-r021-20230326   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r024-20230326   gcc  
csky                 randconfig-r026-20230326   gcc  
hexagon              randconfig-r022-20230327   clang
hexagon              randconfig-r034-20230326   clang
hexagon              randconfig-r035-20230328   clang
hexagon              randconfig-r036-20230327   clang
hexagon              randconfig-r041-20230326   clang
hexagon              randconfig-r041-20230327   clang
hexagon              randconfig-r045-20230326   clang
hexagon              randconfig-r045-20230327   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230327   gcc  
i386                          randconfig-a001   gcc  
i386                 randconfig-a002-20230327   gcc  
i386                          randconfig-a002   clang
i386                 randconfig-a003-20230327   gcc  
i386                          randconfig-a003   gcc  
i386                 randconfig-a004-20230327   gcc  
i386                          randconfig-a004   clang
i386                 randconfig-a005-20230327   gcc  
i386                          randconfig-a005   gcc  
i386                 randconfig-a006-20230327   gcc  
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230327   clang
i386                 randconfig-a012-20230327   clang
i386                 randconfig-a013-20230327   clang
i386                 randconfig-a014-20230327   clang
i386                 randconfig-a015-20230327   clang
i386                 randconfig-a016-20230327   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r006-20230327   gcc  
ia64                 randconfig-r011-20230327   gcc  
ia64                 randconfig-r015-20230327   gcc  
ia64                 randconfig-r032-20230326   gcc  
ia64                 randconfig-r032-20230328   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r006-20230329   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230327   gcc  
loongarch            randconfig-r025-20230326   gcc  
loongarch            randconfig-r035-20230326   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230326   gcc  
m68k                 randconfig-r012-20230326   gcc  
m68k                 randconfig-r023-20230326   gcc  
m68k                 randconfig-r031-20230328   gcc  
microblaze           randconfig-r031-20230327   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r034-20230327   clang
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230327   gcc  
openrisc             randconfig-r013-20230327   gcc  
openrisc             randconfig-r021-20230327   gcc  
openrisc             randconfig-r025-20230327   gcc  
parisc       buildonly-randconfig-r001-20230327   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230326   gcc  
parisc               randconfig-r003-20230327   gcc  
parisc               randconfig-r013-20230326   gcc  
parisc               randconfig-r036-20230328   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230326   gcc  
powerpc              randconfig-r003-20230326   clang
powerpc              randconfig-r033-20230326   clang
powerpc              randconfig-r035-20230327   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230327   gcc  
riscv                randconfig-r016-20230327   clang
riscv                randconfig-r026-20230327   clang
riscv                randconfig-r042-20230326   gcc  
riscv                randconfig-r042-20230327   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230326   clang
s390                 randconfig-r014-20230327   clang
s390                 randconfig-r016-20230326   gcc  
s390                 randconfig-r024-20230327   clang
s390                 randconfig-r044-20230326   gcc  
s390                 randconfig-r044-20230327   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r031-20230326   gcc  
sparc        buildonly-randconfig-r006-20230327   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r033-20230328   gcc  
sparc64              randconfig-r036-20230326   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r002-20230327   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230327   gcc  
x86_64               randconfig-a002-20230327   gcc  
x86_64               randconfig-a003-20230327   gcc  
x86_64               randconfig-a004-20230327   gcc  
x86_64               randconfig-a005-20230327   gcc  
x86_64               randconfig-a006-20230327   gcc  
x86_64               randconfig-a011-20230327   clang
x86_64               randconfig-a012-20230327   clang
x86_64               randconfig-a013-20230327   clang
x86_64               randconfig-a014-20230327   clang
x86_64               randconfig-a015-20230327   clang
x86_64               randconfig-a016-20230327   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r033-20230327   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
