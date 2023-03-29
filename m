Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3A56CD4DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjC2Ijt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjC2Ijr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:39:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4A4172B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680079185; x=1711615185;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=poWiTKXXjB2irzdwXJepBH5Kl4nLIFcPvPCF/KFH/Xc=;
  b=QKFOX1fmA6zAnKQuOkOdWLscJ1V1RN6m8sf7bjbZIWSH5HKqpqtyGt/x
   VcxVNtE2ctef5MmMbQdNXYxjNw5hP5Wzehxkjf482Mhc/SyhnttT1uKjs
   1VMDY5tp8TR83rtyvQGSRoADm+bFzBtlsP+vUVH2W4cL5Pph3Q4u7A9Ii
   Bj7hWj54i4f9ntFvGvlI3gtxQTeG8ZD1OmlX/m3TiFrhWmgexV45QOLtV
   3ou7oacZDlfAVCtLcQstSi/VM8XGKndxnQiT9SuCDbilF4ofF2Yyq9ln2
   sOBjWm4UT9P5K84YukMRkJ/2oN8uQ/6l3Lc2Qw1G4OJd5ejPMcp33wt4n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="340838511"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="340838511"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 01:39:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="748713552"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="748713552"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 Mar 2023 01:39:43 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phRLK-000JN8-2z;
        Wed, 29 Mar 2023 08:39:42 +0000
Date:   Wed, 29 Mar 2023 16:39:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 4be50def57153151444ad4d4dc16c73c311b2123
Message-ID: <6423f947.3xY+w/KtCYX7FZ8y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 4be50def57153151444ad4d4dc16c73c311b2123  Revert "rcu/kvfree: Eliminate k[v]free_rcu() single argument macro"

elapsed time: 723m

configs tested: 131
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r003-20230326   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230327   gcc  
alpha                randconfig-r013-20230326   gcc  
alpha                randconfig-r015-20230327   gcc  
alpha                randconfig-r016-20230326   gcc  
alpha                randconfig-r025-20230326   gcc  
alpha                randconfig-r034-20230326   gcc  
alpha                randconfig-r036-20230326   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230327   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230326   gcc  
arc                  randconfig-r034-20230327   gcc  
arc                  randconfig-r043-20230326   gcc  
arc                  randconfig-r043-20230327   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230326   gcc  
arm                  randconfig-r011-20230326   clang
arm                  randconfig-r024-20230326   clang
arm                  randconfig-r031-20230327   clang
arm                  randconfig-r046-20230326   clang
arm                  randconfig-r046-20230327   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230326   clang
arm64                randconfig-r021-20230326   gcc  
csky         buildonly-randconfig-r004-20230327   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r015-20230326   clang
hexagon              randconfig-r041-20230326   clang
hexagon              randconfig-r041-20230327   clang
hexagon              randconfig-r045-20230326   clang
hexagon              randconfig-r045-20230327   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230327   gcc  
i386                 randconfig-a002-20230327   gcc  
i386                 randconfig-a003-20230327   gcc  
i386                 randconfig-a004-20230327   gcc  
i386                 randconfig-a005-20230327   gcc  
i386                 randconfig-a006-20230327   gcc  
i386                 randconfig-a011-20230327   clang
i386                 randconfig-a012-20230327   clang
i386                 randconfig-a013-20230327   clang
i386                 randconfig-a014-20230327   clang
i386                 randconfig-a015-20230327   clang
i386                 randconfig-a016-20230327   clang
i386                 randconfig-r032-20230327   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230326   gcc  
loongarch    buildonly-randconfig-r006-20230326   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230327   gcc  
loongarch            randconfig-r006-20230327   gcc  
loongarch            randconfig-r012-20230326   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230326   gcc  
m68k                 randconfig-r016-20230327   gcc  
microblaze   buildonly-randconfig-r004-20230326   gcc  
microblaze           randconfig-r002-20230327   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230326   gcc  
mips                 randconfig-r025-20230327   gcc  
mips                 randconfig-r033-20230327   clang
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230326   gcc  
nios2                randconfig-r022-20230326   gcc  
openrisc             randconfig-r033-20230326   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r036-20230327   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r023-20230326   gcc  
powerpc              randconfig-r031-20230326   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230327   gcc  
riscv                randconfig-r021-20230327   clang
riscv                randconfig-r042-20230326   gcc  
riscv                randconfig-r042-20230327   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r013-20230327   clang
s390                 randconfig-r044-20230326   gcc  
s390                 randconfig-r044-20230327   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230327   gcc  
sh                   randconfig-r035-20230326   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230327   gcc  
sparc                randconfig-r011-20230327   gcc  
sparc                randconfig-r014-20230326   gcc  
sparc64      buildonly-randconfig-r002-20230327   gcc  
sparc64      buildonly-randconfig-r005-20230327   gcc  
sparc64              randconfig-r002-20230326   gcc  
sparc64              randconfig-r024-20230327   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
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
xtensa               randconfig-r022-20230327   gcc  
xtensa               randconfig-r032-20230326   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
