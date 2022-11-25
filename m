Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663B2638289
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 03:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiKYCvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 21:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKYCvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 21:51:54 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4350D275DC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 18:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669344713; x=1700880713;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VpFMlJQstYspm1vm0Pso+Kcxo0Fs2u35qFIg5uEmCKA=;
  b=EXlSGo/278L8Gs9q65Rz32C67KyTKJogQMTVJv3hjxJtdB6ZEoojjdQf
   5F0CjXEJrqaF1bnfn9DJFcQ7JdTHadSitWHn+uuGRfb4JiOdMey15s5ZS
   7IWXdG30P2hUgXR0vB6NP609eMESVwMU1LpppFgdOWV8kn7M2mOK6pdYn
   rKneZM8vIiQbPqNsOc+6neGylv2PwSFUdijqoC8ZR1P8SlDc/yZFn+ms0
   AI15HymB+V3wX/XJw/eClk/3srKHCYJZMUZm2wDCrv/TpLntV4hxsOjPz
   5BSuS2UJPYwSa1Ni+CjVMGk5Ce66lIdH0nxD/W1ojeHlyLAvkwBPH9bFR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="313096984"
X-IronPort-AV: E=Sophos;i="5.96,192,1665471600"; 
   d="scan'208";a="313096984"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 18:51:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="642563732"
X-IronPort-AV: E=Sophos;i="5.96,192,1665471600"; 
   d="scan'208";a="642563732"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Nov 2022 18:51:51 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oyOog-0004Zw-1J;
        Fri, 25 Nov 2022 02:51:50 +0000
Date:   Fri, 25 Nov 2022 10:51:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.11.18a] BUILD REGRESSION
 7831c47ed19bac29a16088dc2511c9df012ff128
Message-ID: <63802d9c.dtl/XsBNlPPUnTZU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.11.18a
branch HEAD: 7831c47ed19bac29a16088dc2511c9df012ff128  rcu: Make SRCU mandatory

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202211231037.tYD7Fs4z-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202211241842.t0GeLmJk-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202211242205.zuqd06xy-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202211242235.YuBuC1y7-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

kernel/rcu/tasks.h:1511:17: warning: 'flags' is used uninitialized [-Wuninitialized]
kernel/rcu/tasks.h:256:17: error: implicit declaration of function 'raw_spin_lock_rcu_node'; did you mean 'raw_spin_lock_init'? [-Werror=implicit-function-declaration]
kernel/rcu/tasks.h:256:3: error: implicit declaration of function 'raw_spin_lock_rcu_node' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
kernel/rcu/tasks.h:264:17: error: implicit declaration of function 'raw_spin_unlock_rcu_node'; did you mean 'raw_spin_unlock_irqrestore'? [-Werror=implicit-function-declaration]
kernel/rcu/tasks.h:264:3: error: implicit declaration of function 'raw_spin_unlock_rcu_node' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
kernel/rcu/tasks.h:299:14: error: implicit declaration of function 'raw_spin_trylock_rcu_node'; did you mean 'raw_spin_trylock_irqsave'? [-Werror=implicit-function-declaration]
kernel/rcu/tasks.h:299:7: error: implicit declaration of function 'raw_spin_trylock_rcu_node' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
kernel/rcu/tasks.h:317:2: error: implicit declaration of function 'raw_spin_unlock_irqrestore_rcu_node' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
kernel/rcu/tasks.h:317:9: error: implicit declaration of function 'raw_spin_unlock_irqrestore_rcu_node'; did you mean 'raw_spin_unlock_irqrestore'? [-Werror=implicit-function-declaration]
kernel/rcu/tasks.h:369:17: error: implicit declaration of function 'raw_spin_lock_irqsave_rcu_node'; did you mean 'raw_spin_lock_irqsave_nested'? [-Werror=implicit-function-declaration]
kernel/rcu/tasks.h:369:3: error: implicit declaration of function 'raw_spin_lock_irqsave_rcu_node' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
kernel/rcu/tasks.h:369:41: warning: variable 'flags' is uninitialized when used here [-Wuninitialized]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- m68k-allmodconfig
|   `-- kernel-rcu-tasks.h:warning:flags-is-used-uninitialized
|-- m68k-allyesconfig
|   `-- kernel-rcu-tasks.h:warning:flags-is-used-uninitialized
`-- x86_64-randconfig-a013
    |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-raw_spin_lock_irqsave_rcu_node
    |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-raw_spin_lock_rcu_node
    |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-raw_spin_trylock_rcu_node
    |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-raw_spin_unlock_irqrestore_rcu_node
    |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-raw_spin_unlock_rcu_node
    `-- kernel-rcu-tasks.h:warning:flags-is-used-uninitialized
clang_recent_errors
|-- i386-randconfig-a015
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-raw_spin_lock_irqsave_rcu_node-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-raw_spin_lock_rcu_node-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-raw_spin_trylock_rcu_node-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-raw_spin_unlock_irqrestore_rcu_node-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-raw_spin_unlock_rcu_node-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|   `-- kernel-rcu-tasks.h:warning:variable-flags-is-uninitialized-when-used-here
`-- x86_64-randconfig-a012
    |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-raw_spin_lock_irqsave_rcu_node-is-invalid-in-C99-Werror-Wimplicit-function-declaration
    |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-raw_spin_lock_rcu_node-is-invalid-in-C99-Werror-Wimplicit-function-declaration
    |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-raw_spin_trylock_rcu_node-is-invalid-in-C99-Werror-Wimplicit-function-declaration
    |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-raw_spin_unlock_irqrestore_rcu_node-is-invalid-in-C99-Werror-Wimplicit-function-declaration
    |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-raw_spin_unlock_rcu_node-is-invalid-in-C99-Werror-Wimplicit-function-declaration
    `-- kernel-rcu-tasks.h:warning:variable-flags-is-uninitialized-when-used-here

elapsed time: 3107m

configs tested: 56
configs skipped: 2

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
s390                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
s390                             allyesconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
m68k                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20221124
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                              defconfig
x86_64                               rhel-8.3
i386                                defconfig
i386                             allyesconfig
x86_64                           allyesconfig
arm                                 defconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
riscv                randconfig-r042-20221124
hexagon              randconfig-r041-20221124
hexagon              randconfig-r045-20221124
s390                 randconfig-r044-20221124
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
