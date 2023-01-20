Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50946756F6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjATOWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjATOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:22:24 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD9DF760
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674224510; x=1705760510;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OhJfIru0MmyWEtVNduAU3PpI57XkYsov/LPxtLroJcU=;
  b=WOUZmzVmp7S/tcbaAuVcafTy3lTl4dIRXHwozKPVb4p78lUrc0Y+pzne
   mKkvooxAedgn2Ou/73rpA8bQhRhw8T1DOd1o19dJhQDb70o47P+pt7se+
   GwZBuqrVQSYy0VCxb0+HE/74gnI18nNuM+O846Wks0mkv8pg1UL0luv5J
   SewEgVzLtsEw1fA59mlZfm13GZ4WW2PmkkrEngPd7nBJdVSM8U3xoE1sU
   Re5CM/ZYaNPH5qHSUkHF5/CsCgWJEhe4is+TYpNLo5/zYA4YSHh0/N253
   lws64+q6lavK5FTVLlQ3GdEVV1RaiaNDH+zpoy1KBCNavzvk7zAMKlEkn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="326864414"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="326864414"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 06:21:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="749349292"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="749349292"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jan 2023 06:21:16 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIsGP-0002cO-17;
        Fri, 20 Jan 2023 14:21:05 +0000
Date:   Fri, 20 Jan 2023 22:20:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:slownmi.2023.01.19a] BUILD REGRESSION
 06901681acde9854a9a9a337cebbf3ab537f4543
Message-ID: <63caa325.8m2/A3WoZ768xRxh%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git slownmi.2023.01.19a
branch HEAD: 06901681acde9854a9a9a337cebbf3ab537f4543  x86/nmi: Test commit for delayed NMI handlers

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202301201335.5rpVzsvW-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "dump_cpu_task" [kernel/rcu/rcutorture.ko] undefined!

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-a001
|   `-- ERROR:dump_cpu_task-kernel-rcu-rcutorture.ko-undefined
`-- s390-allmodconfig
    `-- ERROR:dump_cpu_task-kernel-rcu-rcutorture.ko-undefined

elapsed time: 793m

configs tested: 66
configs skipped: 2

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
ia64                             allmodconfig
arc                                 defconfig
i386                          randconfig-a001
s390                             allmodconfig
arm                                 defconfig
i386                          randconfig-a003
alpha                               defconfig
arm64                            allyesconfig
i386                          randconfig-a005
i386                                defconfig
x86_64                        randconfig-a004
arm                  randconfig-r046-20230119
x86_64                        randconfig-a002
s390                                defconfig
arc                  randconfig-r043-20230119
x86_64                        randconfig-a006
m68k                             allmodconfig
arm                              allyesconfig
m68k                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
s390                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
powerpc                  storcenter_defconfig
sh                           se7722_defconfig
riscv                               defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r041-20230119
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r045-20230119
x86_64                        randconfig-a005
riscv                randconfig-r042-20230119
s390                 randconfig-r044-20230119
i386                          randconfig-a013
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a015
mips                      pic32mzda_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
