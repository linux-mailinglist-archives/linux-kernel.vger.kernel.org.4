Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CE363FC48
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiLAXsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLAXsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:48:53 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C9BC5104
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669938531; x=1701474531;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Nyg4hsbkli7lbMbs7eHltsrooNKF8KJdlLwAc+dZy5A=;
  b=kqfzEbvM220vPyz8J+NG7Cut4P6C121Hkd6Y+nn5IYMfFpLfdc78FxGX
   OAKqFuSdDIVL9PuQ9q3Y/B8AZzIUNYtZ6iyxcCY4a05b0HtbOuMRnUjFF
   8ylgQFeu7Miiq/e1WhMPDpcc/n+RjWVamJTyY8CnjqCFWPsdPlEiRVzpC
   AKrY65MTJGLDwn3yxFpUYtglVscIPkE2jDvTuh5gMs9iev9xILScYBd7P
   gDKTQuIUPQJqb4fhJ360KWKvzTbIiMpKZc3p+kiKn6Ib9wUhDYDygY19n
   Hm4NztV7O0YbnC6eAmWBSR08MAKh3KUV1RVO+qGVF8E7Aqu09fj1jkulP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="402106629"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="402106629"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 15:48:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="889933631"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="889933631"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Dec 2022 15:48:47 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0tIM-000D1v-1p;
        Thu, 01 Dec 2022 23:48:46 +0000
Date:   Fri, 02 Dec 2022 07:48:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:smp/core] BUILD SUCCESS
 f4576ee2315f1ad5f147a356c6e5c223462fd599
Message-ID: <63893d36.C2EaX64vpF4idDFH%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
branch HEAD: f4576ee2315f1ad5f147a356c6e5c223462fd599  cpuhp: Set cpuhp target for boot cpu

elapsed time: 728m

configs tested: 44
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
s390                             allmodconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
s390                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
sh                               allmodconfig
s390                             allyesconfig
ia64                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                            allnoconfig
riscv                randconfig-r042-20221201
arc                  randconfig-r043-20221201
s390                 randconfig-r044-20221201
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016

clang tested configs:
hexagon              randconfig-r041-20221201
hexagon              randconfig-r045-20221201
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
