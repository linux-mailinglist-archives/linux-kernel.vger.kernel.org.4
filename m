Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C346694A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241283AbjAMKt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241087AbjAMKtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:49:24 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9651022
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673606963; x=1705142963;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=r+ILINdOIQZQgxPyOYzZyoqCk0veoQRazPAtz1Y5z6M=;
  b=I49e/WWS80NH96b0uaLtGJ0ApcLvj4a/Pwi5UPdfTntriLYG2V6n6xox
   6L/YSyv4lArAmq799KNyDiqaSkz+wMU5wsAdKruyFGKg79HgctQsRBJPv
   z/kt5uHiVgJ36YLuzJl6DR31w9kPKrYbqxGUE5pqUVARuqHQ4yXVRknwm
   5gOhN24HyfLQ/BCli5YVSFF4Q4O1rvLrmRxyshMy/9FQg5WNnKbFCYjk9
   OFQp5vRToAVfp9OHhw+gmcow7k5fDMxrrjEApM8DHTPOsJ4A6EXKN4lLP
   Y03C5o7K7MzRGPrwmPXzQ1Fob5bgI+RejD/6KQORcXPtGN8+WuxfhBUAX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="326023319"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="326023319"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 02:49:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="782113689"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="782113689"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Jan 2023 02:49:21 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGHcc-000B2C-0Q;
        Fri, 13 Jan 2023 10:49:19 +0000
Date:   Fri, 13 Jan 2023 18:48:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:peterz.2023.01.12a] BUILD SUCCESS
 65ccf783a9ebcd1e722eff90cdbfb4cbdc62ba19
Message-ID: <63c13701.XHmv6ladJA14DxZ/%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git peterz.2023.01.12a
branch HEAD: 65ccf783a9ebcd1e722eff90cdbfb4cbdc62ba19  context_tracking: Fix noinstr vs KASAN

elapsed time: 724m

configs tested: 87
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
ia64                             allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a005
arm                  randconfig-r046-20230113
arc                  randconfig-r043-20230113
i386                          randconfig-a016
arc                  randconfig-r043-20230112
s390                 randconfig-r044-20230112
riscv                randconfig-r042-20230112
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
um                           x86_64_defconfig
um                             i386_defconfig
arm                      integrator_defconfig
sh                           se7721_defconfig
m68k                          atari_defconfig
arc                          axs103_defconfig
m68k                       bvme6000_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
arc                                 defconfig
arm                                 defconfig
s390                             allmodconfig
i386                                defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                        realview_defconfig
mips                            ar7_defconfig
arm                            zeus_defconfig
arc                            hsdk_defconfig
alpha                               defconfig
sh                               allmodconfig
s390                                defconfig
x86_64                               rhel-8.3
s390                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a012
hexagon              randconfig-r041-20230113
i386                          randconfig-a002
i386                          randconfig-a013
x86_64                        randconfig-a003
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a016
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r045-20230113
i386                          randconfig-a015
riscv                randconfig-r042-20230113
s390                 randconfig-r044-20230113
i386                          randconfig-a011
arm                  randconfig-r046-20230112
hexagon              randconfig-r041-20230112
hexagon              randconfig-r045-20230112
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
