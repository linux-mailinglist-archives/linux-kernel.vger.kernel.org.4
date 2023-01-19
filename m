Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFF9672FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjASECo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjASDrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:47:08 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B24F6DB35
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674099979; x=1705635979;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VZauz1X7OmJSQjYHUbVNiSlTVinyVP2eQDDnuMWokqA=;
  b=TebSTR6LlwegUX1GiuHeuos+PRAnRHyqO0emnHkGMrj/1JotLA21u1My
   NX1fpiyKRgbvkgoJux2fCvSY461JT84jD4tlhl6gzn0o4TwfpyL/ZbBx3
   zn25aV33e+7E2nF19bGKhG0UOaSLgfF9BbI2aBdmftuNdUoMrfLmgwXh8
   A7/79GBHiPKkhnpKWAfj3qk6NeA03kzi7iIoT6gPcp0LUA8AKUE66yPbe
   t4SAjRwDp5u015AYqWTJJVesK7pamj+eHpRDRUNkZtJjKSCN2ZBdcWdQo
   Z8mvjBgG1W0eq6a/yLxIYKFZJVG/AfLxObXXlsV1uENdjWOVOd5/+zxmn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="313058891"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="313058891"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 19:42:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="653221544"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="653221544"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Jan 2023 19:42:30 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pILor-00012k-34;
        Thu, 19 Jan 2023 03:42:29 +0000
Date:   Thu, 19 Jan 2023 11:42:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 c3aceb71874a28cf19cc23f77920d91fd8f8a5c0
Message-ID: <63c8bc20.OeGG6P6mSxIy+wso%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: c3aceb71874a28cf19cc23f77920d91fd8f8a5c0  rcutorture: Add srcu_lockdep.sh

elapsed time: 727m

configs tested: 82
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                             allyesconfig
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
i386                                defconfig
x86_64                           allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
ia64                             allmodconfig
mips                             allyesconfig
sh                               allmodconfig
arm                       omap2plus_defconfig
sparc                             allnoconfig
arm                           tegra_defconfig
arm                         assabet_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                randconfig-r042-20230118
s390                 randconfig-r044-20230118
arc                  randconfig-r043-20230118
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                      mgcoge_defconfig
sh                        dreamcast_defconfig
sh                           se7722_defconfig
m68k                            q40_defconfig
mips                     loongson1b_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                          randconfig-c001
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
sh                                  defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
parisc                           allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
microblaze                          defconfig
nios2                         10m50_defconfig
arm                               allnoconfig
sh                           se7705_defconfig
arc                      axs103_smp_defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
powerpc                 xes_mpc85xx_defconfig
mips                     cu1830-neo_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                       lemote2f_defconfig
arm                         socfpga_defconfig
arm                         orion5x_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
