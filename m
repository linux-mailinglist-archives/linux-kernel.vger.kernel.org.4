Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532736E05E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjDMEUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjDMETt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:19:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5FA12B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681359586; x=1712895586;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WEbpKGBUyRF/wlzyVFVPBnMni2cqIZPMdnUzvDvbL8c=;
  b=giVbtcaIFcHBYOtDxJ+EkzhblNZ423xB8HVsYhCR+mT9L3VjOcjEP6Mu
   rrM+lqpXlCWGno86mYSLlpx6tmxlRLQKJxENCFfjtqrEI1BuQ7dT+QVeZ
   0R9Vtp8ESOh11DCZOudHdQ2gAIlVF7geqoIwGqwYcalOnn3PJFP/VSlck
   Nd3QkI118heOEr1Fsb5bkLh7mWzW4c5/SMeD1Kj7lpjB5GqdoBeZVDh95
   eR4Bsjkpr6ijzmVZrCAkD84XtkZb1PnAmhXN1z+6VqT8i63ZNE3hDWDUI
   noygN7Acre8fCVamJkfCA32xbVfIaO7QiKNKcsMdCdSKr5qb0cc2gVaE4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="409232854"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="409232854"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:19:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="719650634"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="719650634"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 Apr 2023 21:19:34 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmoQo-000YL1-01;
        Thu, 13 Apr 2023 04:19:34 +0000
Date:   Thu, 13 Apr 2023 12:19:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 5af507bef93c09a94fb8f058213b489178f4cbe5
Message-ID: <643782b9.O/QfH4EpUe2FDaK1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: 5af507bef93c09a94fb8f058213b489178f4cbe5  x86/ioapic: Don't return 0 from arch_dynirq_lower_bound()

elapsed time: 724m

configs tested: 188
configs skipped: 122

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230409   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230410   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230409   gcc  
arc                  randconfig-r005-20230409   gcc  
arc                  randconfig-r005-20230412   gcc  
arc                  randconfig-r013-20230410   gcc  
arc                  randconfig-r043-20230409   gcc  
arc                  randconfig-r043-20230410   gcc  
arc                  randconfig-r043-20230412   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          moxart_defconfig   clang
arm                       netwinder_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                  randconfig-r046-20230412   clang
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230410   gcc  
arm64                randconfig-r023-20230410   gcc  
arm64                randconfig-r025-20230412   gcc  
arm64                randconfig-r026-20230409   gcc  
arm64                randconfig-r035-20230409   clang
csky                                defconfig   gcc  
csky                 randconfig-r014-20230410   gcc  
csky                 randconfig-r021-20230409   gcc  
csky                 randconfig-r024-20230410   gcc  
hexagon              randconfig-r015-20230409   clang
hexagon              randconfig-r033-20230409   clang
hexagon              randconfig-r041-20230412   clang
hexagon              randconfig-r045-20230412   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
i386                          randconfig-a016   gcc  
i386                 randconfig-r036-20230410   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230410   gcc  
ia64                 randconfig-r015-20230410   gcc  
ia64                 randconfig-r024-20230410   gcc  
ia64                 randconfig-r025-20230409   gcc  
ia64                 randconfig-r032-20230412   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230410   gcc  
loongarch    buildonly-randconfig-r004-20230409   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230409   gcc  
loongarch            randconfig-r013-20230410   gcc  
loongarch            randconfig-r014-20230409   gcc  
loongarch            randconfig-r016-20230410   gcc  
loongarch            randconfig-r021-20230410   gcc  
loongarch            randconfig-r031-20230412   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r002-20230409   gcc  
m68k                 randconfig-r021-20230410   gcc  
m68k                 randconfig-r024-20230409   gcc  
microblaze           randconfig-r004-20230409   gcc  
microblaze           randconfig-r004-20230412   gcc  
microblaze           randconfig-r005-20230410   gcc  
microblaze           randconfig-r016-20230409   gcc  
microblaze           randconfig-r023-20230410   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230409   gcc  
mips         buildonly-randconfig-r001-20230410   gcc  
mips         buildonly-randconfig-r002-20230409   gcc  
mips                     decstation_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                           mtx1_defconfig   clang
mips                 randconfig-r036-20230412   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230409   gcc  
nios2                randconfig-r011-20230409   gcc  
openrisc             randconfig-r003-20230409   gcc  
openrisc             randconfig-r006-20230410   gcc  
openrisc             randconfig-r024-20230410   gcc  
openrisc             randconfig-r024-20230412   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230410   gcc  
parisc               randconfig-r012-20230409   gcc  
parisc               randconfig-r022-20230409   gcc  
parisc               randconfig-r024-20230409   gcc  
parisc               randconfig-r026-20230412   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     ppa8548_defconfig   clang
powerpc              randconfig-r021-20230410   gcc  
powerpc              randconfig-r025-20230409   gcc  
powerpc              randconfig-r026-20230410   gcc  
powerpc              randconfig-r034-20230409   clang
powerpc              randconfig-r036-20230412   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230410   gcc  
riscv                randconfig-r021-20230412   gcc  
riscv                randconfig-r022-20230409   gcc  
riscv                randconfig-r026-20230410   gcc  
riscv                randconfig-r031-20230412   clang
riscv                randconfig-r035-20230412   clang
riscv                randconfig-r042-20230409   gcc  
riscv                randconfig-r042-20230410   gcc  
riscv                randconfig-r042-20230412   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r023-20230409   gcc  
s390                 randconfig-r025-20230410   gcc  
s390                 randconfig-r033-20230410   clang
s390                 randconfig-r044-20230409   gcc  
s390                 randconfig-r044-20230410   gcc  
s390                 randconfig-r044-20230412   gcc  
sh                               allmodconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                   randconfig-r001-20230412   gcc  
sh                   randconfig-r014-20230409   gcc  
sh                   randconfig-r015-20230409   gcc  
sh                   randconfig-r023-20230409   gcc  
sh                   randconfig-r023-20230410   gcc  
sh                   randconfig-r026-20230409   gcc  
sparc        buildonly-randconfig-r003-20230409   gcc  
sparc        buildonly-randconfig-r005-20230409   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230409   gcc  
sparc                randconfig-r023-20230412   gcc  
sparc64      buildonly-randconfig-r005-20230410   gcc  
sparc64              randconfig-r003-20230410   gcc  
sparc64              randconfig-r006-20230409   gcc  
sparc64              randconfig-r006-20230412   gcc  
sparc64              randconfig-r021-20230409   gcc  
sparc64              randconfig-r022-20230410   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230410   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230410   clang
x86_64               randconfig-a003-20230410   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230410   clang
x86_64               randconfig-a005-20230410   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230410   clang
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-r022-20230410   gcc  
x86_64               randconfig-r025-20230410   gcc  
x86_64               randconfig-r034-20230410   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230409   gcc  
xtensa               randconfig-r002-20230410   gcc  
xtensa               randconfig-r006-20230409   gcc  
xtensa               randconfig-r034-20230412   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
