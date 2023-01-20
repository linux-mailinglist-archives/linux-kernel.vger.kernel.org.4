Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D416675544
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjATNMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjATNMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:12:05 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBAB10AB2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674220324; x=1705756324;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FRfJeS/L7JMLj33P/Tz6ZCFtI4UJXoGanUpmQ1HgYPI=;
  b=ZHrONZi4J4uqwiphKghlWxQ7b7nWIgyn6PlkM4Q2bAQERWDRiDkbq7fN
   4qvThtA84MNg5XWNZVWT/ALKiL7HSQsahM43jodQQ+Wv2PCPuXFjXJOdG
   poD0xLzIqgh6ejvxUKR7uKouPtYvtPGODnezy2LujhrSbAxgMkmmqwvwO
   cmXnSWx4HsPOkb09Xm0dswmMRXJKvI+6WX82Rr63uEqWh7q1Xfb3KmNYo
   30s+lxWXzSZsBhaDtfqfQq5lBtKw2Tjk4VkqzFbNK7UkXD35Mq0h6ppDo
   6k+n+dUvuwFFDjyA5F+mVEf74CHTRC0WoINZWkzfQFgXji+qzgq7G/HxL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="309149707"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="309149707"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 05:12:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="784502767"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="784502767"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Jan 2023 05:12:02 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIrBY-0002Zm-2n;
        Fri, 20 Jan 2023 13:12:00 +0000
Date:   Fri, 20 Jan 2023 21:11:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:haltnmi1.2023.01.19a] BUILD SUCCESS
 eaab5a99276c644eb1dac3553ef98696941249cb
Message-ID: <63ca92ef.pBoXYpopVf1OUkXB%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git haltnmi1.2023.01.19a
branch HEAD: eaab5a99276c644eb1dac3553ef98696941249cb  x86/nmi: Test commit for exc_nmi handler losing NMIs

elapsed time: 725m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                              defconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                               rhel-8.3
alpha                               defconfig
x86_64                           allyesconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
s390                             allyesconfig
powerpc                           allnoconfig
i386                                defconfig
arm                                 defconfig
arm                  randconfig-r046-20230119
sh                         ecovec24_defconfig
x86_64                        randconfig-a013
x86_64                    rhel-8.3-kselftests
xtensa                          iss_defconfig
ia64                             allmodconfig
x86_64                          rhel-8.3-func
i386                          randconfig-a001
x86_64                        randconfig-a011
parisc                              defconfig
arc                  randconfig-r043-20230119
i386                          randconfig-a003
sh                          sdk7786_defconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a004
i386                          randconfig-a005
x86_64                        randconfig-a002
m68k                             allmodconfig
x86_64                        randconfig-a006
alpha                            allyesconfig
i386                          randconfig-a014
arm64                            allyesconfig
i386                             allyesconfig
sh                               allmodconfig
arm                              allyesconfig
i386                          randconfig-a012
arc                              allyesconfig
i386                          randconfig-a016
m68k                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
sparc64                          alldefconfig
sparc                       sparc32_defconfig
m68k                          hp300_defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
arm                         orion5x_defconfig
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
s390                 randconfig-r044-20230119
powerpc                      pmac32_defconfig
hexagon              randconfig-r045-20230119
riscv                randconfig-r042-20230119
i386                          randconfig-a002
hexagon              randconfig-r041-20230119
i386                          randconfig-a004
x86_64                        randconfig-a005
i386                          randconfig-a006
x86_64                        randconfig-a001
i386                          randconfig-a013
x86_64                        randconfig-a003
i386                          randconfig-a015
i386                          randconfig-a011
arm                           omap1_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
