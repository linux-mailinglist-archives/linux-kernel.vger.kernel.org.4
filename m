Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7C265218B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiLTN2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbiLTN2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:28:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE49619C1D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671542839; x=1703078839;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KJes0oHvNYSy19p0G561gqKkJDq52p2CnNzSaeD3EGw=;
  b=LXTBw0e32/styIyTPOBilijAlaPhqDOVAzCuqIO4Ec+v5fiN+buir6Tl
   DsdYrsjH9ZQDDHw+g2pH8BJwlT8Rgz/56QNLn5rtJnjNSzn/weADHTuDl
   tZ9zpIxO4UrXCKsTyEr9y4StpSVZ5Dm53UetM8+CHAWLfwcd0scteNUEr
   EfUbfKB2cGPtLZGaI+hyZBoDRXTNnWI1WUUjxvtt8/LCUnfFxL+KusXY/
   Wtr10h8cdvsjH9mDMRiPhlxxSMjKKgqc/SMbKQqv0ibm72tvEBW/RRc8v
   xrUso55DCVOqPKsdcrsVoB9sUInGs9rpgIIRSfZXwwN7uzH05MB7/4Ckx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="303033253"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="303033253"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 05:27:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="775302373"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="775302373"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Dec 2022 05:27:18 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p7ceL-0009Wu-13;
        Tue, 20 Dec 2022 13:27:17 +0000
Date:   Tue, 20 Dec 2022 21:27:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.12.17a] BUILD REGRESSION
 45206ffe7a2e08f2cb2591fc19d609690761000f
Message-ID: <63a1b82d.v1R/7YNrghCFK6V1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.12.17a
branch HEAD: 45206ffe7a2e08f2cb2591fc19d609690761000f  rcu: Test synchronous RCU grace periods at the end of rcu_init()

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202212201204.qBGK2SxT-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202212202014.WoSZId7N-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "dump_cpu_task" [kernel/rcu/rcutorture.ko] undefined!

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- s390-defconfig
    `-- ERROR:dump_cpu_task-kernel-rcu-rcutorture.ko-undefined
clang_recent_errors
`-- i386-randconfig-a014-20221219
    `-- ERROR:dump_cpu_task-kernel-rcu-rcutorture.ko-undefined

elapsed time: 735m

configs tested: 68
configs skipped: 2

gcc tested configs:
alpha                               defconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allmodconfig
x86_64                              defconfig
um                             i386_defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
um                           x86_64_defconfig
x86_64                           rhel-8.3-bpf
s390                             allyesconfig
x86_64               randconfig-a005-20221219
x86_64                               rhel-8.3
x86_64               randconfig-a003-20221219
sh                               allmodconfig
x86_64               randconfig-a001-20221219
m68k                             allmodconfig
alpha                            allyesconfig
m68k                             allyesconfig
arm                                 defconfig
x86_64               randconfig-a006-20221219
x86_64                           allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20221219
mips                             allyesconfig
arc                              allyesconfig
x86_64               randconfig-a004-20221219
i386                                defconfig
ia64                             allmodconfig
i386                 randconfig-a004-20221219
arm64                            allyesconfig
i386                 randconfig-a001-20221219
arm                              allyesconfig
i386                 randconfig-a003-20221219
i386                 randconfig-a002-20221219
i386                 randconfig-a006-20221219
i386                             allyesconfig
i386                 randconfig-a005-20221219
riscv                randconfig-r042-20221218
arc                  randconfig-r043-20221219
arm                  randconfig-r046-20221219
arc                  randconfig-r043-20221218
s390                 randconfig-r044-20221218
x86_64                            allnoconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a011-20221219
x86_64               randconfig-a012-20221219
x86_64               randconfig-a014-20221219
x86_64               randconfig-a013-20221219
x86_64               randconfig-a016-20221219
x86_64               randconfig-a015-20221219
i386                 randconfig-a014-20221219
i386                 randconfig-a012-20221219
i386                 randconfig-a013-20221219
i386                 randconfig-a011-20221219
i386                 randconfig-a015-20221219
i386                 randconfig-a016-20221219
arm                  randconfig-r046-20221218
hexagon              randconfig-r041-20221218
hexagon              randconfig-r045-20221219
s390                 randconfig-r044-20221219
hexagon              randconfig-r041-20221219
hexagon              randconfig-r045-20221218
riscv                randconfig-r042-20221219

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
