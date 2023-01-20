Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C3C6756F3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjATOVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjATOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:21:52 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F5A743A0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674224477; x=1705760477;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cJmwkBK/IAenE4xi6HRcOaqLv0O/kICJ8jLx2Y/cceA=;
  b=ciTijDzwvAfJrPOpnX9Qy+8MyMQ8Vnm56nwhjpZn7gamPp5E4RPd6TBl
   sN469HRRIP+DWAy7uWiHXaWToexzpUumF0L4deVBThT/MY9Pvxb0B+Nkj
   Y7Oq78TZKcTG4xJ57aiwsPeP+p2LR2aPnrJTBqjNAJZ+a691a3cjDVvvj
   4xqtRpsyDoAXvjFX7JkJ9RuUBULCLZ+ROUQCjEQo05kw8eC85fGuvAqoo
   cV0v3L2Wczz2YPIA+zRwPrBB4PzEpKoaQvqyIJgp7NwdS5glIwloLQebf
   YudYBa4OCWv8CnWePWtDFvWocxbmCvt4BLvM1oTdAIxbusPmiX75zUC80
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="326864398"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="326864398"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 06:21:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="749349283"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="749349283"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jan 2023 06:21:11 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIsGP-0002cG-0q;
        Fri, 20 Jan 2023 14:21:05 +0000
Date:   Fri, 20 Jan 2023 22:20:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:haltnmi3.2023.01.19a] BUILD SUCCESS
 437a60eca96fc6698b969f21bea74116a0225220
Message-ID: <63caa32e.v0fGA9KDYYuTJqqL%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git haltnmi3.2023.01.19a
branch HEAD: 437a60eca96fc6698b969f21bea74116a0225220  x86/nmi: Test commit for exc_nmi handler deep-losing NMIs

elapsed time: 794m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                              defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
powerpc                           allnoconfig
sh                               allmodconfig
arc                                 defconfig
s390                             allmodconfig
powerpc                          allmodconfig
alpha                               defconfig
i386                          randconfig-a001
mips                             allyesconfig
arm                  randconfig-r046-20230119
i386                          randconfig-a003
arm                                 defconfig
x86_64                        randconfig-a013
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20230119
s390                                defconfig
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a011
m68k                             allmodconfig
i386                          randconfig-a005
s390                             allyesconfig
arm64                            allyesconfig
alpha                            allyesconfig
arm                              allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a015
arc                              allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                                defconfig
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
mips                         bigsur_defconfig
arm                        keystone_defconfig
sh                   secureedge5410_defconfig
powerpc                 mpc85xx_cds_defconfig
parisc                           alldefconfig
openrisc                  or1klitex_defconfig
powerpc                       maple_defconfig
ia64                                defconfig
sh                          rsk7269_defconfig
sh                        sh7757lcr_defconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
s390                 randconfig-r044-20230119
hexagon              randconfig-r045-20230119
x86_64                        randconfig-a016
i386                          randconfig-a006
x86_64                        randconfig-a012
riscv                randconfig-r042-20230119
hexagon              randconfig-r041-20230119
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
arm                      tct_hammer_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
