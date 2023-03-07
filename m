Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140CC6AEAF2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjCGRit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjCGRiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:38:25 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5681517C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678210458; x=1709746458;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=N2iDi8TxZlVV7Ym+Dgej1t3agdElwUgAkbAt+oaz2Rw=;
  b=SIfL1I/x0g/Rwxjo6rkJaSC6u04u9uirjBgmphaIZvkXQErOujbhe6hG
   QWco1/4WKfZhnTq0lTCymQKaPoRJTfv45NrHKLSQEQrqBH6zR2pG4Jqiq
   9lnTE9MDMNashj1gf5WZuAs8Fx8WJYkR0vowhTHY+2V6riAT7ZzstzsSX
   Hz2h/+DmOA4JM4+gJ6soGas79W1uMUOgblksWPM0LGytLczaRmbLSnH0v
   PmOw9taRloqzdTQGOyB240AHwPLMp52JZVOFh8X0ZDbHnOQV9h/v5DQCl
   ZoxR7BbLdu1vYVict0rG+irnlb7XxkwsuvhnOi11LUI0lU5dZlKPGF2T8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="333388385"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="333388385"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 09:34:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="626617877"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="626617877"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Mar 2023 09:34:15 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZbCY-0001VX-2x;
        Tue, 07 Mar 2023 17:34:14 +0000
Date:   Wed, 08 Mar 2023 01:33:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.03.06a] BUILD REGRESSION
 b5f34f7f546f7746ed4ca21da873aea5f408f295
Message-ID: <64077585.f+7ODNdBgYVt0Mbj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.03.06a
branch HEAD: b5f34f7f546f7746ed4ca21da873aea5f408f295  locktorture: Add long_hold to adjust lock-hold delays

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303071604.o6pvgZPl-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303071727.8CfkaGXj-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

aarch64-linux-ld: rcutorture.c:(.text+0x5f00): undefined reference to `set_nmi_torture'
arc-elf-ld: rcutorture.c:(.text+0x2080): undefined reference to `set_nmi_torture'
arch/x86/kernel/nmi.c:441:6: warning: no previous prototype for 'set_nmi_torture' [-Wmissing-prototypes]
arch/x86/kernel/nmi.c:441:6: warning: no previous prototype for function 'set_nmi_torture' [-Wmissing-prototypes]
hppa-linux-ld: rcutorture.c:(.text+0x2adc): undefined reference to `set_nmi_torture'
microblaze-linux-ld: kernel/rcu/rcutorture.c:3301: undefined reference to `set_nmi_torture'
rcutorture.c:(.text+0x5ee0): undefined reference to `set_nmi_torture'
s390x-linux-ld: rcutorture.c:(.text+0x1a0): undefined reference to `set_nmi_torture'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-r006-20230305
|   `-- arc-elf-ld:rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|-- arm64-randconfig-r034-20230306
|   |-- aarch64-linux-ld:rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|   `-- rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|-- microblaze-randconfig-r013-20230306
|   `-- microblaze-linux-ld:kernel-rcu-rcutorture.c:undefined-reference-to-set_nmi_torture
|-- parisc-randconfig-r006-20230306
|   `-- hppa-linux-ld:rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
`-- x86_64-randconfig-r002-20230306
    `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
clang_recent_errors
|-- s390-randconfig-r033-20230305
|   `-- s39-linux-ld:rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
`-- x86_64-randconfig-r023-20230306
    `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-function-set_nmi_torture

elapsed time: 735m

configs tested: 127
configs skipped: 9

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r003-20230307   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r016-20230305   gcc  
alpha                randconfig-r034-20230305   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230306   gcc  
arc                  randconfig-r006-20230305   gcc  
arc                  randconfig-r021-20230305   gcc  
arc                  randconfig-r043-20230305   gcc  
arc                  randconfig-r043-20230306   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r025-20230305   clang
arm                  randconfig-r046-20230305   clang
arm                  randconfig-r046-20230306   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r006-20230307   clang
arm64                               defconfig   gcc  
arm64                randconfig-r033-20230306   gcc  
arm64                randconfig-r034-20230306   gcc  
csky         buildonly-randconfig-r005-20230307   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r026-20230305   gcc  
hexagon              randconfig-r011-20230306   clang
hexagon              randconfig-r041-20230305   clang
hexagon              randconfig-r041-20230306   clang
hexagon              randconfig-r045-20230305   clang
hexagon              randconfig-r045-20230306   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230306   gcc  
i386                 randconfig-a002-20230306   gcc  
i386                 randconfig-a003-20230306   gcc  
i386                 randconfig-a004-20230306   gcc  
i386                 randconfig-a005-20230306   gcc  
i386                 randconfig-a006-20230306   gcc  
i386                 randconfig-a011-20230306   clang
i386                 randconfig-a012-20230306   clang
i386                 randconfig-a013-20230306   clang
i386                 randconfig-a014-20230306   clang
i386                 randconfig-a015-20230306   clang
i386                 randconfig-a016-20230306   clang
i386                 randconfig-r036-20230306   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230307   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230305   gcc  
ia64                 randconfig-r022-20230305   gcc  
ia64                 randconfig-r023-20230305   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230305   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230307   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r021-20230306   gcc  
m68k                 randconfig-r022-20230306   gcc  
m68k                 randconfig-r024-20230305   gcc  
microblaze           randconfig-r005-20230306   gcc  
microblaze           randconfig-r013-20230305   gcc  
microblaze           randconfig-r013-20230306   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r015-20230305   clang
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230306   gcc  
nios2                randconfig-r004-20230306   gcc  
nios2                randconfig-r024-20230306   gcc  
nios2                randconfig-r035-20230305   gcc  
openrisc             randconfig-r002-20230305   gcc  
openrisc             randconfig-r004-20230305   gcc  
openrisc             randconfig-r014-20230306   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230306   gcc  
parisc               randconfig-r014-20230305   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r035-20230306   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230305   clang
riscv                randconfig-r042-20230305   gcc  
riscv                randconfig-r042-20230306   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230305   clang
s390                 randconfig-r016-20230306   clang
s390                 randconfig-r033-20230305   clang
s390                 randconfig-r044-20230305   gcc  
s390                 randconfig-r044-20230306   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r012-20230306   gcc  
sh                   randconfig-r015-20230306   gcc  
sparc        buildonly-randconfig-r004-20230307   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230306   gcc  
x86_64               randconfig-a002-20230306   gcc  
x86_64               randconfig-a003-20230306   gcc  
x86_64               randconfig-a004-20230306   gcc  
x86_64               randconfig-a005-20230306   gcc  
x86_64               randconfig-a006-20230306   gcc  
x86_64               randconfig-a011-20230306   clang
x86_64               randconfig-a012-20230306   clang
x86_64               randconfig-a013-20230306   clang
x86_64               randconfig-a014-20230306   clang
x86_64               randconfig-a015-20230306   clang
x86_64               randconfig-a016-20230306   clang
x86_64               randconfig-r002-20230306   gcc  
x86_64               randconfig-r023-20230306   clang
x86_64               randconfig-r031-20230306   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r026-20230306   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
