Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DFD677B19
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjAWMiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjAWMiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:38:10 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAFDE383
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674477488; x=1706013488;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Y1lTTyBwpNLHE2YVwXnrSlevtP10+6bGMM0v91VDNMU=;
  b=iLuedu+7/jyey/py3uFOTOyTYpV64w9PUm6Qe9MLOC4sCdxQ1/LK3j/u
   HGeq5QOgNoRM6PIuYz7zo8DJ78MwPVlC4ViWHb3UzCJBp2seA5+srDviG
   kUQFxgKN6ji0v/D8yLQ5VDdEDAWMgmZF6tCyZa+ZFqpLbyXXwQFvkP7Jv
   PxbyxYx466lM9Yhg+460Dsifp1zN1Ej0Tcn7YhVTUzmtztnWfvNT6ewdv
   J/xaH8yM/V0mO83b4RCxZ0jdKcDIAoCr4psxxy6Di/vh1yfYO1Q+B5EH+
   itM0PIn9uGG/7N9JvF4QDpex4tb2JfGwQvoIX5fIqLqmZAPPqi0+w2jh6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="306383600"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="306383600"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 04:38:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="611534854"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="611534854"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Jan 2023 04:38:07 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJw5O-0005di-0u;
        Mon, 23 Jan 2023 12:38:06 +0000
Date:   Mon, 23 Jan 2023 20:37:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 e5c645984a3884c92e124717c8c85635ba7a1057
Message-ID: <63ce7f84.uXqhG93SPgK+Troh%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: e5c645984a3884c92e124717c8c85635ba7a1057  Merge branch into tip/master: 'x86/platform'

elapsed time: 724m

configs tested: 82
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
arm                                 defconfig
s390                                defconfig
s390                             allmodconfig
ia64                             allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
s390                 randconfig-r044-20230122
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a002-20230123
x86_64                           rhel-8.3-bpf
x86_64               randconfig-a004-20230123
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a003-20230123
x86_64               randconfig-a001-20230123
i386                 randconfig-a004-20230123
x86_64                               rhel-8.3
i386                 randconfig-a003-20230123
arc                  randconfig-r043-20230123
x86_64               randconfig-a005-20230123
i386                          randconfig-a014
riscv                randconfig-r042-20230122
x86_64               randconfig-a006-20230123
i386                 randconfig-a002-20230123
arc                  randconfig-r043-20230122
arm                  randconfig-r046-20230123
i386                          randconfig-a012
mips                             allyesconfig
i386                 randconfig-a001-20230123
i386                          randconfig-a016
powerpc                          allmodconfig
i386                                defconfig
i386                 randconfig-a005-20230123
i386                 randconfig-a006-20230123
x86_64                           allyesconfig
i386                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                           imxrt_defconfig
powerpc                     rainier_defconfig
mips                         rt305x_defconfig
sparc                               defconfig
arm                       aspeed_g5_defconfig
powerpc                  iss476-smp_defconfig
powerpc                       ppc64_defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230122
hexagon              randconfig-r045-20230123
arm                  randconfig-r046-20230122
i386                          randconfig-a013
s390                 randconfig-r044-20230123
hexagon              randconfig-r041-20230122
i386                          randconfig-a011
riscv                randconfig-r042-20230123
i386                          randconfig-a015
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a015-20230123
x86_64               randconfig-a014-20230123
arm                  colibri_pxa300_defconfig
arm                       aspeed_g4_defconfig
arm                         socfpga_defconfig
mips                          ath25_defconfig
powerpc                     ksi8560_defconfig
mips                   sb1250_swarm_defconfig
arm                       netwinder_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
