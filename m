Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34BB688393
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjBBP7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjBBP7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:59:14 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782637AE6A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675353504; x=1706889504;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vbVDVAAUARNDAAzJjCEGUkkigILnGy4guEaov72UCxQ=;
  b=T3P5vyeUbJEk/yuRplxrzSsemHWTXlCU4cXyf9eR8nxNDWpCgSnIOa4E
   GeZb5hszBd12QaH18fwC09LR38do34nvNdIoOn+OYomirNUopk2pDhB7i
   4rX76BSkGu+ezF2r9X3b/GLSj8LAk7icgvBkaYGtCwESI7eV1NWgtt3qp
   b/wJSznQiZ3AUhIU/t7QiIJu6uCP+4tuB29ljgHqTrFzntV6EUGFcVYTB
   tIDZZGNba1xHfwH3U3KxrRjat0PpqfDudHKENt+90lZnC5DWF0/dGCSmy
   ZpQM0RNVgdCpn1O8uBta9Xp5e2ai+jsMPpVq/PTPORF8hXgSwSva1DEu3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="308129742"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="308129742"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 07:55:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="615333117"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="615333117"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2023 07:55:37 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNbw0-0006dQ-14;
        Thu, 02 Feb 2023 15:55:36 +0000
Date:   Thu, 02 Feb 2023 23:55:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 4f64a6c9f6f11e8b7314f8e27e2c4568706009e6
Message-ID: <63dbdced.SpQKUzVpaeZX0mLs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 4f64a6c9f6f11e8b7314f8e27e2c4568706009e6  perf: Fix perf_event_pmu_context serialization

elapsed time: 1412m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
x86_64               randconfig-a001-20230130
s390                                defconfig
x86_64               randconfig-a003-20230130
x86_64               randconfig-a002-20230130
ia64                             allmodconfig
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
x86_64               randconfig-a004-20230130
i386                 randconfig-a001-20230130
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
i386                 randconfig-a002-20230130
i386                 randconfig-a005-20230130
i386                 randconfig-a006-20230130
um                             i386_defconfig
um                           x86_64_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arc                  randconfig-r043-20230129
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arm                  randconfig-r046-20230129
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130
i386                                defconfig
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a014-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
hexagon              randconfig-r041-20230129
riscv                randconfig-r042-20230129
riscv                randconfig-r042-20230130
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
s390                 randconfig-r044-20230129
s390                 randconfig-r044-20230130

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
