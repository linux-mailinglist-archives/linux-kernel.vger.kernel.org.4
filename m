Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB7E6ADB44
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjCGKB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCGKBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:01:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7BD51C80
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678183283; x=1709719283;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mUR4QPHbQfrTILf46RP054a5pwNONEsnfgfAdtK1w+g=;
  b=SlwHiGsmR4ZNMuwyY6oMHwe3aca8vw/sZpJpE55P4XCkfH7BthMsBNG/
   y2an5YLc9PwnCsASbeZ3gMjeOckBjt1Wib8OfyE56g3g0AZud5vPPHafe
   KgczBhHqRw91ysP0T6SQHSdsHyUVNZrlOy18x73sXoVNXw3N+n3PRXmuE
   5pT34YRzzI0RqO65GxKtEGJKKvEdVP4o9TQYr8QGMghfrFw8YYFspDac4
   /yj5oQCZNiw/TT6A25T09gf2wHrE6CnPsXkTFhBikv3DhqRfgXlS/ZpHe
   n7ow1orgD+cD5CbZAAumoQQ+YPvaWHTItncFAMJf5iUViSis4MzEDRBGH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="334527946"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="334527946"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 02:01:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669811998"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="669811998"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 Mar 2023 02:01:00 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZU7v-0001CX-1T;
        Tue, 07 Mar 2023 10:00:59 +0000
Date:   Tue, 07 Mar 2023 18:00:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.02.27a] BUILD REGRESSION
 b171cbcbbd8e5f5f2e0638c5b5b5c77e3cc79007
Message-ID: <64070b4b.PYts85aeBoT4aARn%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.02.27a
branch HEAD: b171cbcbbd8e5f5f2e0638c5b5b5c77e3cc79007  rcutorture: Test NMI diagnostics

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303070906.VxnzlSyY-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303071057.1r9aTmDM-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303071217.ajqvt2rz-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303071235.NvgrGJl5-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303071331.kR21mwSK-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/arm64/kernel/process.c:75:1: warning: 'noreturn' function does return
arch/csky/kernel/smp.c:320:1: warning: 'noreturn' function does return
arch/mips/kernel/process.c:46:1: warning: 'noreturn' function does return
arch/x86/kernel/nmi.c:441:6: warning: no previous prototype for 'set_nmi_torture' [-Wmissing-prototypes]
arch/x86/kernel/nmi.c:441:6: warning: no previous prototype for function 'set_nmi_torture' [-Wmissing-prototypes]
arm-linux-gnueabi-ld: kernel/rcu/rcutorture.c:3301: undefined reference to `set_nmi_torture'
csky-linux-ld: kernel/rcu/rcutorture.c:3301: undefined reference to `set_nmi_torture'
hppa-linux-ld: (.text+0x2b80): undefined reference to `set_nmi_torture'
hppa-linux-ld: kernel/rcu/rcutorture.c:3301: undefined reference to `set_nmi_torture'
kernel/rcu/rcutorture.c:(.text+0x5c44): undefined reference to `set_nmi_torture'
kernel/rcu/rcutorture.c:3289: undefined reference to `set_nmi_torture'
ld.lld: error: undefined symbol: set_nmi_torture
mips64-linux-ld: kernel/rcu/rcutorture.c:(.text+0x5c64): undefined reference to `set_nmi_torture'
nios2-linux-ld: kernel/rcu/rcutorture.c:3301: undefined reference to `set_nmi_torture'
rcutorture.c:(.text+0x49ac): undefined reference to `set_nmi_torture'
vmlinux.o: warning: objtool: exc_nmi+0x13b: call to __const_udelay() leaves .noinstr.text section

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-randconfig-r006-20230305
|   |-- arm-linux-gnueabi-ld:kernel-rcu-rcutorture.c:undefined-reference-to-set_nmi_torture
|   `-- kernel-rcu-rcutorture.c:undefined-reference-to-set_nmi_torture
|-- arm64-randconfig-r021-20230305
|   `-- arch-arm64-kernel-process.c:warning:noreturn-function-does-return
|-- csky-randconfig-r035-20230306
|   |-- arch-csky-kernel-smp.c:warning:noreturn-function-does-return
|   `-- csky-linux-ld:kernel-rcu-rcutorture.c:undefined-reference-to-set_nmi_torture
|-- i386-randconfig-a004-20230306
|   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
|-- loongarch-randconfig-r032-20230306
|   `-- rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|-- mips-randconfig-r023-20230306
|   |-- kernel-rcu-rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|   `-- mips64-linux-ld:kernel-rcu-rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|-- mips-randconfig-r025-20230306
|   `-- arch-mips-kernel-process.c:warning:noreturn-function-does-return
|-- nios2-randconfig-r021-20230306
|   |-- kernel-rcu-rcutorture.c:undefined-reference-to-set_nmi_torture
|   `-- nios2-linux-ld:kernel-rcu-rcutorture.c:undefined-reference-to-set_nmi_torture
|-- parisc-randconfig-r014-20230305
|   `-- hppa-linux-ld:(.text):undefined-reference-to-set_nmi_torture
|-- parisc-randconfig-r033-20230305
|   `-- hppa-linux-ld:kernel-rcu-rcutorture.c:undefined-reference-to-set_nmi_torture
|-- x86_64-allmodconfig
|   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
|-- x86_64-allyesconfig
|   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
|-- x86_64-defconfig
|   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
|-- x86_64-kexec
|   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
|-- x86_64-randconfig-a001-20230306
|   `-- vmlinux.o:warning:objtool:exc_nmi:call-to-__const_udelay()-leaves-.noinstr.text-section
`-- x86_64-rhel-8.3
    `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
clang_recent_errors
|-- riscv-randconfig-r003-20230305
|   `-- ld.lld:error:undefined-symbol:set_nmi_torture
|-- riscv-randconfig-r026-20230306
|   `-- ld.lld:error:undefined-symbol:set_nmi_torture
|-- x86_64-randconfig-a014-20230306
|   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-function-set_nmi_torture
`-- x86_64-randconfig-a015-20230306
    `-- vmlinux.o:warning:objtool:exc_nmi:call-to-__const_udelay()-leaves-.noinstr.text-section

elapsed time: 742m

configs tested: 127
configs skipped: 9

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230306   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230305   gcc  
alpha                randconfig-r022-20230305   gcc  
alpha                randconfig-r023-20230305   gcc  
alpha                randconfig-r031-20230306   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230306   gcc  
arc                  randconfig-r043-20230305   gcc  
arc                  randconfig-r043-20230306   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r003-20230306   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r006-20230305   gcc  
arm                  randconfig-r016-20230306   gcc  
arm                  randconfig-r046-20230305   clang
arm                  randconfig-r046-20230306   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230306   gcc  
arm64                randconfig-r004-20230305   clang
arm64                randconfig-r013-20230306   clang
arm64                randconfig-r021-20230305   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r035-20230306   gcc  
hexagon              randconfig-r012-20230306   clang
hexagon              randconfig-r034-20230305   clang
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
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230305   gcc  
ia64                 randconfig-r005-20230306   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r015-20230306   gcc  
loongarch            randconfig-r032-20230306   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r004-20230306   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r036-20230306   gcc  
microblaze   buildonly-randconfig-r001-20230306   gcc  
microblaze           randconfig-r024-20230305   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r011-20230306   gcc  
mips                 randconfig-r023-20230306   gcc  
mips                 randconfig-r025-20230305   clang
mips                 randconfig-r025-20230306   gcc  
mips                 randconfig-r026-20230305   clang
mips                 randconfig-r033-20230306   clang
nios2                               defconfig   gcc  
nios2                randconfig-r021-20230306   gcc  
openrisc             randconfig-r013-20230305   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230305   gcc  
parisc               randconfig-r014-20230306   gcc  
parisc               randconfig-r033-20230305   gcc  
parisc               randconfig-r034-20230306   gcc  
parisc               randconfig-r035-20230305   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r022-20230306   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230305   clang
riscv                randconfig-r026-20230306   clang
riscv                randconfig-r042-20230305   gcc  
riscv                randconfig-r042-20230306   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230306   gcc  
s390                 randconfig-r044-20230305   gcc  
s390                 randconfig-r044-20230306   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230306   gcc  
sh                   randconfig-r006-20230306   gcc  
sh                   randconfig-r036-20230305   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230306   gcc  
sparc                randconfig-r011-20230305   gcc  
sparc64              randconfig-r016-20230305   gcc  
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
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r002-20230305   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
