Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F754624927
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiKJSPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiKJSPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:15:35 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4461A3A0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668104134; x=1699640134;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wt3jBZaD8x8kFwckqsfqBH+n5Ikb7tL2YnEbSgoUm4M=;
  b=PPj6ASVgQ92YK17bsXMtn32p0QDWNIe1mmHxLxKC4YrpwuZUr9l4ZzY3
   nDrG3aaFMEoNun0dbCcU7dIN/4HNaSwvWPQa+pBzn8aui8Vl7LYqxBXmh
   yXrLcE5Sr33FrvBsFmdiQD4Xwdo1nE0O+YEOQLNwwH4zNBYooP31k51Hj
   Qj0mlWVPLE6qVVVfg5EPMTBIh5qnV4886m6CaPmQ1MvbiZ0oj/hNz6dSy
   XQfyoVTpufAL4GNeRU8HCVs+q8Iodcw7D/PGviKGfO0JEdyhjR1iCD+5b
   iTZl/fJ8/nPwhY0TdflZSjSCHb4cuxYOU8DDayPfZbKw/3JM5y1EQ/qoa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="375643266"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="375643266"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:15:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="668511344"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="668511344"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 10 Nov 2022 10:15:33 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otC5M-00032z-1d;
        Thu, 10 Nov 2022 18:15:32 +0000
Date:   Fri, 11 Nov 2022 02:14:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:srcunmisafe.2022.11.09a] BUILD SUCCESS
 f733615e39aa2d6ddeef33b7b2c9aa6a5a2c2785
Message-ID: <636d3fa2.wd3cmu0hrTZucF2t%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git srcunmisafe.2022.11.09a
branch HEAD: f733615e39aa2d6ddeef33b7b2c9aa6a5a2c2785  rcu: Implement lockdep_rcu_enabled for !CONFIG_DEBUG_LOCK_ALLOC

elapsed time: 1423m

configs tested: 71
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                            allnoconfig
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                              defconfig
powerpc                           allnoconfig
i386                          randconfig-a014
i386                          randconfig-a005
i386                          randconfig-a012
x86_64                               rhel-8.3
ia64                             allmodconfig
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a004
x86_64                        randconfig-a011
x86_64                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
arm                        cerfcube_defconfig
sh                               alldefconfig
sh                        sh7757lcr_defconfig
arm                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                       zfcpdump_defconfig
powerpc                      arches_defconfig
powerpc                     sequoia_defconfig
mips                         cobalt_defconfig
arm                      footbridge_defconfig
xtensa                  cadence_csp_defconfig
mips                         db1xxx_defconfig
arm                        spear6xx_defconfig
powerpc                      pasemi_defconfig
s390                                defconfig
s390                             allyesconfig
arm64                            allyesconfig
sh                           se7722_defconfig
arm                         cm_x300_defconfig
m68k                             allyesconfig
arm                              allyesconfig
powerpc              randconfig-c003-20221110
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a015
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a013
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a006
riscv                randconfig-r042-20221110
s390                 randconfig-r044-20221110
hexagon              randconfig-r041-20221110
hexagon              randconfig-r045-20221110
x86_64                        randconfig-a003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
