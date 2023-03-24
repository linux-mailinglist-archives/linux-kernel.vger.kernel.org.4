Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8906C7DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjCXMRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCXMRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:17:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784F02412A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679660236; x=1711196236;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vBcIiKPB5unOzsDJZ1WcKLPuEU3EiwDN6LE4vIlqe5M=;
  b=ZhSn3dsfBbBZ6Mrwcucr9hQ9Z9qCOfe7r+0E/DNb8hr1pL4P963lkUY9
   1jxjMVQoLWy0K5v1s+Mh2GTg6KBl2OA7HNYDBKZSxTB8Q52dqu6Mv5ybp
   NCNph5MbHM9nknO+O+weEiczG0DD+BV57bRquLt+dtCijvl6gwOMvHHvR
   MaXxArpp3dxnPDosqKOOdQP7UjEEtRy98ablV4gmdkSuBGLXLghvYbfQy
   LHLWdUqfteKWA+zXC9cB5HSEpYYWHL5NXFdUa1STiFGb+HkyjgxEONseP
   /AuILZEHwFlvOcBM/A7wrPqwGkeR6tqDwoagUYjFUJUvGw+KvEYcLY3uL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="338484328"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="338484328"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 05:17:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="682680959"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="682680959"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2023 05:17:14 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfgM6-000FHc-07;
        Fri, 24 Mar 2023 12:17:14 +0000
Date:   Fri, 24 Mar 2023 20:16:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.03.22b] BUILD REGRESSION
 6c104ef06e7fcd7a66237e2ffbac435e00503eed
Message-ID: <641d94a6.hrZlNT/but/l7xoZ%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.03.22b
branch HEAD: 6c104ef06e7fcd7a66237e2ffbac435e00503eed  rcu-tasks: Clarify the cblist_init_generic() function's pr_info() output

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/powerpc/kernel/smp.c:1768:1: error: function declared 'noreturn' should not return [-Werror,-Winvalid-noreturn]

Error/Warning ids grouped by kconfigs:

clang_recent_errors
`-- powerpc-randconfig-r011-20230323
    `-- arch-powerpc-kernel-smp.c:error:function-declared-noreturn-should-not-return-Werror-Winvalid-noreturn

elapsed time: 725m

configs tested: 101
configs skipped: 5

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230322   gcc  
arc                  randconfig-r023-20230322   gcc  
arc                  randconfig-r043-20230322   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r003-20230324   clang
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230322   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r014-20230322   clang
hexagon              randconfig-r041-20230322   clang
hexagon              randconfig-r045-20230322   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r011-20230322   gcc  
ia64                 randconfig-r013-20230322   gcc  
ia64                 randconfig-r016-20230322   gcc  
ia64                 randconfig-r025-20230322   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r026-20230322   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r021-20230322   clang
mips                 randconfig-r035-20230322   gcc  
mips                 randconfig-r036-20230322   gcc  
nios2        buildonly-randconfig-r002-20230324   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r031-20230322   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r034-20230322   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r001-20230322   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230324   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230324   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230322   clang
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230324   gcc  
sparc        buildonly-randconfig-r005-20230324   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230322   gcc  
sparc64              randconfig-r002-20230322   gcc  
sparc64              randconfig-r022-20230322   gcc  
sparc64              randconfig-r032-20230322   gcc  
sparc64              randconfig-r033-20230322   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r005-20230322   gcc  
xtensa               randconfig-r024-20230322   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
