Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BAB624B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKJUKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiKJUKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:10:39 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8E325EA6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668111039; x=1699647039;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sbPC+deMWuxM0Nd77xYhB54Nm/CFWT7fEo8f/FG5tWU=;
  b=kjXInYslXPvBTa0Z9fX1UKMw7B6ck9rk2rQvgzCBFv1rGqJCNOW54Uxe
   QmKvKiuiU5czwN/9841txIqVGBwl5eh88feniMcp1UyVWX5Mc0WOZ7nAm
   lZqCNiGrnCun4FEts0ZLBZyPmC1ZnTbVtThOFlqrgBlhzuQcWHrfX7ILF
   z3jK6vAJ8voxHIlPiobJ5ykpBGvWtlo7Ee/boBYn+yPnfjBXcpSPtBwjT
   LVGwfGtAu9V6/gB00hOz4y7VF+OP18SOQUgioCvvgiuKiGy1GR4UMC61o
   IF4OyB5bQYxnyHFs1HawwQ0HgptGnTOUrRfH/6b3wPypHtkJSgMyrugyR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="309056968"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="309056968"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 12:10:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="706286226"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="706286226"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 Nov 2022 12:10:37 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otDsj-0003CU-0S;
        Thu, 10 Nov 2022 20:10:37 +0000
Date:   Fri, 11 Nov 2022 04:09:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 cede97a6d18cd12367950b2ed4cbafea1b2e605b
Message-ID: <636d5a93.IHBCN/0vMyKS7st5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: cede97a6d18cd12367950b2ed4cbafea1b2e605b  refscale: Add tests using SLAB_TYPESAFE_BY_RCU

elapsed time: 1538m

configs tested: 93
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                     tqm8541_defconfig
sh                         microdev_defconfig
sh                   rts7751r2dplus_defconfig
arc                        nsimosci_defconfig
arm                             pxa_defconfig
alpha                             allnoconfig
m68k                           sun3_defconfig
arc                                 defconfig
arc                     nsimosci_hs_defconfig
mips                         rt305x_defconfig
sh                      rts7751r2d1_defconfig
mips                 decstation_r4k_defconfig
alpha                               defconfig
i386                          randconfig-c001
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allmodconfig
s390                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
i386                             allyesconfig
i386                                defconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a013
x86_64                        randconfig-a015
ia64                             allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
arm                        cerfcube_defconfig
sh                               alldefconfig
sh                        sh7757lcr_defconfig
arm                                 defconfig
x86_64                              defconfig
s390                       zfcpdump_defconfig
powerpc                      arches_defconfig
powerpc                     sequoia_defconfig
mips                         cobalt_defconfig
mips                             allyesconfig
arm                      footbridge_defconfig
xtensa                  cadence_csp_defconfig
mips                         db1xxx_defconfig
arm                        spear6xx_defconfig
powerpc                      pasemi_defconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                               rhel-8.3
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           allyesconfig
powerpc              randconfig-c003-20221110
m68k                             allyesconfig
m68k                             allmodconfig
sh                           se7722_defconfig
arm                         lpc18xx_defconfig
nios2                         10m50_defconfig
powerpc                 mpc837x_rdb_defconfig
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                    amigaone_defconfig
arm64                            allyesconfig
arm                              allyesconfig
powerpc                       ppc64_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
arm                       imx_v4_v5_defconfig
arm                          ep93xx_defconfig
arm                     am200epdkit_defconfig
arm                           omap1_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
riscv                randconfig-r042-20221110
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221110
hexagon              randconfig-r045-20221110
powerpc                        fsp2_defconfig
powerpc                    gamecube_defconfig
s390                 randconfig-r044-20221110
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
