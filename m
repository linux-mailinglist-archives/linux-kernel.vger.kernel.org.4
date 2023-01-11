Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3862665AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjAKL7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239110AbjAKL6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:58:51 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86812AD6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673438190; x=1704974190;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=loE9AzJydvNNySIae8hCNuip2QKFQeq3Qh6BoErX/h4=;
  b=ZMM7Tg1lvyg1hdqlHeib/hGEctsc8HNyflbeU6ThqthZKKMPLHWTJDAe
   OjPOdZ8SNOOdupzJ9/8MsbPGjMk7yL17N3nhDQ4VoeK+zMmCs+ucYjoMv
   5b3ZZHWp7VHpbrZNFZbpGxPmn53/DlBUrStkfJF4O8q5ZtA4FIzUHCqWj
   th9DoEgh77USKMUHlWTA3FPjTXu32uy6VEs0pQN7sezG1v80mYQp96Rqv
   fKxnmJ5qCDJjRdYRwZIlGOXMmE1mhSTKKr6GCcelMiMuaQ9UCTO+d5sD0
   /u2JPba4Mzdk7W/iiDlwh3SeACB78v7V/mB1YbyWm0bUsiUNYronNnlnE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="325402122"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="325402122"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 03:56:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="986135538"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="986135538"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jan 2023 03:56:28 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFZiV-00096u-33;
        Wed, 11 Jan 2023 11:56:27 +0000
Date:   Wed, 11 Jan 2023 19:56:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 19213bf117ac998698d80a777f76b947dbeb42bd
Message-ID: <63bea3de.lxY9TtneJE1gJdfM%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 19213bf117ac998698d80a777f76b947dbeb42bd  tools: rcu: Add usage function and check for argument

elapsed time: 798m

configs tested: 101
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
x86_64                            allnoconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
arc                  randconfig-r043-20230110
s390                 randconfig-r044-20230110
riscv                randconfig-r042-20230110
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
arc                              allyesconfig
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                                defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
m68k                          amiga_defconfig
riscv                            allmodconfig
sh                   rts7751r2dplus_defconfig
m68k                                defconfig
sh                          rsk7201_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
powerpc                     taishan_defconfig
arm                         assabet_defconfig
parisc                generic-64bit_defconfig
mips                        vocore2_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                  iss476-smp_defconfig
sh                          r7780mp_defconfig
mips                           gcw0_defconfig
mips                         bigsur_defconfig
sh                          sdk7786_defconfig
sh                             espt_defconfig
openrisc                         alldefconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arc                           tb10x_defconfig
csky                             alldefconfig
arm                        keystone_defconfig
sh                          rsk7264_defconfig
sh                           se7722_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
i386                             alldefconfig
sh                         microdev_defconfig
sh                          urquell_defconfig

clang tested configs:
hexagon              randconfig-r041-20230110
arm                  randconfig-r046-20230110
hexagon              randconfig-r045-20230110
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-k001
riscv                randconfig-r042-20230111
s390                 randconfig-r044-20230111
hexagon              randconfig-r041-20230111
hexagon              randconfig-r045-20230111

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
