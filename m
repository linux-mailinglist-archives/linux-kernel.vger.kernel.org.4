Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D8662CC90
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbiKPVT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbiKPVTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:19:24 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF45B6172
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668633562; x=1700169562;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FfD7Y55epwVOfmMOz5s1pJaOjdTWeygbIKYNrbY/NZ0=;
  b=HuCPjOfYuHtBMYu1c/66ctPsDuvnB5aksNj+M7yiCB0YFYvGFXEc6czP
   YkvCxcVvylSfaRKOPk7a8USmeNNe8fUGfZJkdD8Jscy1SshMgdrDSBfz6
   VP8mwHbul1W2Xv9152MQoDwfJqejGu+wrpSXZWYRHzCT0h254bz/+mQWc
   CJ7b8XJ7iBEPGS6oLR8WPm8979TTrQf77L6HoED7RbUKEKDEoZ77h1+77
   KKDOcUmB5nV8ShLcag4ZpdK3EiGx9krx15u8rlF/umBBP/LXI9cOYhRPC
   gkaCO/ICmlTKTZyvMWk/5r4d2AcFbyBX1YKsNqiDVBGDfKuCAhTYBLt6/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="313821441"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="313821441"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 13:19:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="781928609"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="781928609"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2022 13:19:19 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovPoU-0002kU-30;
        Wed, 16 Nov 2022 21:19:18 +0000
Date:   Thu, 17 Nov 2022 05:18:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS WITH WARNING
 e8d7a90c08ce963c592fb49845f2ccc606a2ac21
Message-ID: <637553b5.ebdZY+lvkXPfAk1E%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: e8d7a90c08ce963c592fb49845f2ccc606a2ac21  perf: Fix possible memleak in pmu_dev_alloc()

Warning: (recently discovered and may have been fixed)

kernel/events/core.c:11274:4: warning: cast from 'int (*)(struct perf_cpu_pmu_context *)' to 'remote_function_f' (aka 'int (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- hexagon-randconfig-r001-20221116
|   `-- kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type
|-- hexagon-randconfig-r005-20221116
|   `-- kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type
`-- s390-randconfig-r012-20221116
    `-- kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type

elapsed time: 722m

configs tested: 53
configs skipped: 2

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
arm                                 defconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                    rhel-8.3-kselftests
arc                              allyesconfig
x86_64                          rhel-8.3-func
ia64                             allmodconfig
alpha                            allyesconfig
i386                                defconfig
arm64                            allyesconfig
powerpc                           allnoconfig
i386                          randconfig-a012
arm                              allyesconfig
x86_64                              defconfig
x86_64                           rhel-8.3-syz
powerpc                          allmodconfig
i386                          randconfig-a014
x86_64                         rhel-8.3-kunit
mips                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
i386                          randconfig-a016
sh                               allmodconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                           allyesconfig
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a001
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a003
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
