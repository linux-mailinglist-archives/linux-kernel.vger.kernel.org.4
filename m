Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF155BFAC0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiIUJWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiIUJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:22:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CD780EAF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663752094; x=1695288094;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qsKMzCluRP2kHi9aODYj+J7wVo+5h8nDNgj2t0qCdFk=;
  b=eedklE79bfLczNDR31W4kHZISLhuEfQUz0RGkdKgErn2VlBDn5A5hAlo
   fkUrM2YcUTSobvNvGcbDrgjTIbExj4cjj/5GeYiR/Nj1AbmYOOM911Dap
   0uLJ/Ge/3SUxIHd0Fphx+DRceSjnhFrl7BWiiYmArgW+zWhcoxDDlICjs
   9zsPqeAjIvWJZBqOvDG8aMNgqzqrIJx6wGTjVpRPUsVKGHWWZ7BI0FWbs
   MIFxgWmLF+8pRnCDr4AzXe+cnBV7AZs9uWzRBxdxgGtR54hOuTSsJkHoH
   yRfUAjJH4mV9QfctAG4YsGW6ObIuDKI08LNsdirAl8MzAAXMldsrY6TCk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="297550206"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="297550206"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 02:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="649976924"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Sep 2022 02:21:14 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oavur-0003T5-27;
        Wed, 21 Sep 2022 09:21:13 +0000
Date:   Wed, 21 Sep 2022 17:20:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.09.03a] BUILD REGRESSION
 607762184099b5d0b6765f69673fafa1d7eb4d30
Message-ID: <632ad758.4SlheXgFz4bm2lB9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.09.03a
branch HEAD: 607762184099b5d0b6765f69673fafa1d7eb4d30  srcu: Check for consistent per-CPU per-srcu_struct NMI safety

Error/Warning reports:

https://lore.kernel.org/lkml/202209210942.YUFSaizJ-lkp@intel.com
https://lore.kernel.org/lkml/202209211114.7li0O31k-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "__srcu_read_lock_nmisafe" [kernel/rcu/rcutorture.ko] undefined!
ERROR: modpost: "__srcu_read_unlock_nmisafe" [kernel/rcu/rcutorture.ko] undefined!
kernel/rcu/srcutree.c:647:1: error: 'u' undeclared (first use in this function); did you mean 'u8'?
kernel/rcu/srcutree.c:647:1: error: 'u' undeclared (first use in this function); did you mean 'up'?
kernel/rcu/srcutree.c:647:2: error: expected ';' before ')' token
kernel/rcu/srcutree.c:647:2: error: expected statement before ')' token

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- parisc-randconfig-r005-20220921
|   |-- kernel-rcu-srcutree.c:error:expected-before-)-token
|   |-- kernel-rcu-srcutree.c:error:expected-statement-before-)-token
|   `-- kernel-rcu-srcutree.c:error:u-undeclared-(first-use-in-this-function)
|-- riscv-allmodconfig
|   |-- kernel-rcu-srcutree.c:error:expected-before-)-token
|   |-- kernel-rcu-srcutree.c:error:expected-statement-before-)-token
|   `-- kernel-rcu-srcutree.c:error:u-undeclared-(first-use-in-this-function)
|-- s390-allyesconfig
|   |-- kernel-rcu-srcutree.c:error:expected-before-)-token
|   |-- kernel-rcu-srcutree.c:error:expected-statement-before-)-token
|   `-- kernel-rcu-srcutree.c:error:u-undeclared-(first-use-in-this-function)
|-- x86_64-allmodconfig
|   |-- kernel-rcu-srcutree.c:error:expected-before-)-token
|   |-- kernel-rcu-srcutree.c:error:expected-statement-before-)-token
|   `-- kernel-rcu-srcutree.c:error:u-undeclared-(first-use-in-this-function)
|-- x86_64-allyesconfig
|   |-- kernel-rcu-srcutree.c:error:expected-before-)-token
|   |-- kernel-rcu-srcutree.c:error:expected-statement-before-)-token
|   `-- kernel-rcu-srcutree.c:error:u-undeclared-(first-use-in-this-function)
`-- x86_64-randconfig-a002
    |-- ERROR:__srcu_read_lock_nmisafe-kernel-rcu-rcutorture.ko-undefined
    `-- ERROR:__srcu_read_unlock_nmisafe-kernel-rcu-rcutorture.ko-undefined
clang_recent_errors
|-- arm-randconfig-r013-20220921
|   `-- kernel-rcu-srcutree.c:error:use-of-undeclared-identifier-u
`-- powerpc-randconfig-r004-20220921
    `-- kernel-rcu-srcutree.c:error:use-of-undeclared-identifier-u

elapsed time: 827m

configs tested: 54
configs skipped: 2

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20220921
riscv                randconfig-r042-20220921
s390                 randconfig-r044-20220921
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                              defconfig
x86_64                               rhel-8.3
arm                                 defconfig
x86_64                           allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a005
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
