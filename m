Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E556D70ACFD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 10:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjEUIbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 04:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjEUIYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 04:24:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB5A1A6
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 01:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684657335; x=1716193335;
  h=date:from:to:cc:subject:message-id;
  bh=xkAFYghe+sJHVHpTcXYCu1qjQ2ifG+WbceFU9vlNe6o=;
  b=DF/0uBdeq2F5w8VPoA/32sXjBHeydaI/meMUD4KRBMcyxF6OumoC28+b
   5FF0s9Rq/rOtyXewF4/8uT4Nl4rrB/+JOP+hgSgI7WjfqkU9sDY41fbwf
   wRg3DLzZZNBwrW9rFyAFOhKtFdLu8Q+KoImiin0u4FUqSPBxxjta1iMqA
   dbCMOrsB2pBTxeagBnJpKw0okIa7H5EL6rVuIZI+wKz9wsd9euwCNLIL/
   95F+0huW7AMdb4ZN9N0EzG4IOT8w3RY8lBnpALX5BzvdZ+e6wCcS3F+Dn
   VLUFeiWc7OM3aGGrdCLnGmA0oaLoIEP33cSDuZTucQuLLiSxwjx2GgNe8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="350189484"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="350189484"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 01:22:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="706145255"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="706145255"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 May 2023 01:22:14 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q0eKT-000C3Q-2s;
        Sun, 21 May 2023 08:22:13 +0000
Date:   Sun, 21 May 2023 16:22:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 812195e4f70ef0e9fc68127355c553c537749546
Message-ID: <20230521082203.gkHt6%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230519164737/lkp-src/repo/*/paulmck-rcu
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 812195e4f70ef0e9fc68127355c553c537749546  rcuscale: Measure grace-period kthread CPU time

elapsed time: 721m

configs tested: 132
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r034-20230521   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                  randconfig-r043-20230521   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm          buildonly-randconfig-r005-20230521   clang
arm                                 defconfig   gcc  
arm                           omap1_defconfig   clang
arm                  randconfig-r046-20230521   clang
arm                        vexpress_defconfig   clang
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r006-20230521   clang
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230521   gcc  
csky                 randconfig-r026-20230521   gcc  
hexagon      buildonly-randconfig-r001-20230521   clang
hexagon              randconfig-r031-20230521   clang
hexagon              randconfig-r032-20230521   clang
hexagon              randconfig-r041-20230521   clang
hexagon              randconfig-r045-20230521   clang
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
ia64                 randconfig-r023-20230521   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r022-20230521   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze           randconfig-r006-20230521   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      malta_kvm_defconfig   clang
mips                 randconfig-r004-20230521   gcc  
mips                         rt305x_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r025-20230521   gcc  
nios2                randconfig-r033-20230521   gcc  
nios2                randconfig-r036-20230521   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                              defconfig   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                    mvme5100_defconfig   clang
powerpc                     ppa8548_defconfig   clang
powerpc                      tqm8xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230521   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230521   clang
s390                 randconfig-r002-20230521   clang
s390                 randconfig-r044-20230521   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230521   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230521   gcc  
sparc                randconfig-r013-20230521   gcc  
sparc                randconfig-r015-20230521   gcc  
sparc64              randconfig-r003-20230521   gcc  
sparc64              randconfig-r035-20230521   gcc  
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
x86_64                        randconfig-k001   clang
x86_64                        randconfig-x051   gcc  
x86_64                        randconfig-x052   clang
x86_64                        randconfig-x053   gcc  
x86_64                        randconfig-x054   clang
x86_64                        randconfig-x055   gcc  
x86_64                        randconfig-x056   clang
x86_64                        randconfig-x061   gcc  
x86_64                        randconfig-x062   clang
x86_64                        randconfig-x063   gcc  
x86_64                        randconfig-x064   clang
x86_64                        randconfig-x065   gcc  
x86_64                        randconfig-x066   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa               randconfig-r016-20230521   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
