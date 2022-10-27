Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C90260F071
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiJ0Gkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiJ0Gkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:40:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB54132242
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666852842; x=1698388842;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UiZ3m1p7meqyAc8uxGq+0V+i5vuQUpAzS5JeAdFd91s=;
  b=eXpv3+zrl4nABoVra2kIr6kcVawi8DaMg97GTvYdTC1/apQ6c2WzoHFi
   xGmm/G8nIFpay7UE+mCMPTzUdq+1inafMIrIvhllfrpCMfWz5jUysUYuX
   Hc8T3MdnSesWS8AKhzfRi/Lkz+DWDizdrzB8pwFroS7ifKGG8YgRI3YzV
   8rgLlUeSxN2QZYdKD2tXUQCdlRMK4mq4As4ogkQUJkOjTRBiuJAkvxJZp
   mwrqefpDVEPK9aqhVrGhoOqotAEi7/s5NIulhiJiu7zL9X6YknXLSTQfk
   nWiRR4kr8peRCFxUV7XlADYxRhV1IJ8773dkFAlMirfbfI67ds9GUIjFa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="291446223"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="291446223"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 23:40:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="610241663"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="610241663"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Oct 2022 23:40:40 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onwZE-0008Ox-01;
        Thu, 27 Oct 2022 06:40:40 +0000
Date:   Thu, 27 Oct 2022 14:39:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.10.24a] BUILD SUCCESS
 1cdf27b46dfdc445e1b90177e6eddf8f2b3bb917
Message-ID: <635a27b1.EOL9YfEMtw9WGOWL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.10.24a
branch HEAD: 1cdf27b46dfdc445e1b90177e6eddf8f2b3bb917  selftests/nolibc: Always rebuild the sysroot when running a test

elapsed time: 730m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                              defconfig
s390                             allmodconfig
s390                                defconfig
sh                               allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
s390                             allyesconfig
arc                  randconfig-r043-20221027
i386                                defconfig
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a013
x86_64                          rhel-8.3-func
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                           allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
x86_64                        randconfig-a006
i386                          randconfig-a003
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
m68k                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r041-20221027
hexagon              randconfig-r045-20221027
s390                 randconfig-r044-20221027
riscv                randconfig-r042-20221027
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a006
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
