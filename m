Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CF45EFE1B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiI2Ti4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiI2Tit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:38:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7EF18B4B4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664480325; x=1696016325;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vj6G7koUtOVjXsIyBymFvU447+Z663HkP9QOxDVnr7o=;
  b=kUDRamLYzmDcleWuHiCT2GgF7/WeH68nrogOdTJKpdTGRvWhZdNFOk1A
   wO5dFtiSLvDwiUpEdj7p3r8vaO3G2SoJ9nubsR0yNmBjEg/qLBhUj+Wp4
   2UcvkEeVPbwkrX/lLCzmLONFmTDYl0ijnzpFBf9UZoTypV9TwVOigRnCc
   HCe3OwPg80DKvYaBPjkpXSJG/rjnQozWj3u0OX+A/pzrF012xzEnpL7+i
   Qc6B0t/snYs/lZn9hN0nR89cvyxQCVMwIbe6bzWHDzDyHRcX7ZuLX+UzD
   eKcnHSv5up9kFSkqYtidCoPE0tmjdqJJ/I/X0/LMD2SC65hI+2aUL4kSw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="300722759"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="300722759"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 12:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="747969302"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="747969302"
Received: from lkp-server01.sh.intel.com (HELO 6126f2790925) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Sep 2022 12:38:16 -0700
Received: from kbuild by 6126f2790925 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1odzMN-0001a3-12;
        Thu, 29 Sep 2022 19:38:15 +0000
Date:   Fri, 30 Sep 2022 03:37:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.09.27a] BUILD SUCCESS
 bfdd9c41583bbc67550d15aaee13c733e41eaa11
Message-ID: <6335f3ec.jrUJqGhOkvdKgx14%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.09.27a
branch HEAD: bfdd9c41583bbc67550d15aaee13c733e41eaa11  arch/s390: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option

elapsed time: 1478m

configs tested: 63
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
arc                              allyesconfig
alpha                            allyesconfig
i386                                defconfig
x86_64                           allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
i386                             allyesconfig
i386                 randconfig-a001-20220926
i386                 randconfig-a002-20220926
arm                                 defconfig
i386                 randconfig-a003-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a005-20220926
i386                 randconfig-a006-20220926
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220925
riscv                randconfig-r042-20220925
arm64                            allyesconfig
arc                  randconfig-r043-20220926
arm                              allyesconfig
s390                 randconfig-r044-20220925
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r045-20220925
i386                 randconfig-a011-20220926
hexagon              randconfig-r041-20220926
i386                 randconfig-a013-20220926
hexagon              randconfig-r045-20220926
i386                 randconfig-a016-20220926
hexagon              randconfig-r041-20220925
i386                 randconfig-a012-20220926
riscv                randconfig-r042-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a014-20220926
s390                 randconfig-r044-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a016-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a014-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
