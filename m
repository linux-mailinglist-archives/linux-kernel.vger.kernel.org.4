Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F3F663DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjAJKSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237868AbjAJKRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:17:24 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A7A631AE
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673345810; x=1704881810;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+G4IgpiHgdjRGrHprM3b8bdmTzZsbYovdjT/JKIBonQ=;
  b=jwTVJeazKBzYLkhZ3pHllMIcT7YvtEbSLeiyxGq89LA3e5pbvaFQ3pC1
   JxsV/P+IEZzlMzux2H/N/PH9jN2pCkzdOpmhnApZVB+lyWI9uXkDRyBZ9
   0P10Zno8LW0QJ5RQw4Q5tV3hh600KVAD6zj2+vZF4m0njNuApuZynVwUU
   CGuSo1SDD6hRxZFrV+x8Dz7nLGRdvOYQm+hoY0mv1Z4hjLp3KEPHziTL6
   KC9GC/aMOi6DwuE4cHNTYb0MuZZaf0Kj0e/LVsaRbRBFcWTtTScSZx2Eb
   E96PpE4cW7kLCOJLoe5K76A7DxUCTzB1ipt5INdBbxJdLAq0D7+byINjd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="320803695"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="320803695"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 02:16:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="650314139"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="650314139"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 10 Jan 2023 02:16:35 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFBgJ-0007ru-0E;
        Tue, 10 Jan 2023 10:16:35 +0000
Date:   Tue, 10 Jan 2023 18:16:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.01.05a] BUILD SUCCESS
 5ceaf736da841c4bdb03049c7d6e0c0c41253161
Message-ID: <63bd3af8.EE8dynb70luMDPNX%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.01.05a
branch HEAD: 5ceaf736da841c4bdb03049c7d6e0c0c41253161  rcu: Avoid stack overflow due to __rcu_irq_enter_check_tick() being kprobe-ed

elapsed time: 728m

configs tested: 119
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
i386                 randconfig-a011-20230109
i386                 randconfig-a013-20230109
arc                                 defconfig
i386                 randconfig-a012-20230109
s390                             allmodconfig
i386                 randconfig-a014-20230109
alpha                               defconfig
i386                 randconfig-a016-20230109
i386                 randconfig-a015-20230109
s390                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                              defconfig
x86_64               randconfig-a011-20230109
x86_64               randconfig-a013-20230109
ia64                             allmodconfig
x86_64                           rhel-8.3-bpf
x86_64               randconfig-a012-20230109
x86_64                           rhel-8.3-syz
i386                                defconfig
x86_64               randconfig-a014-20230109
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a016-20230109
x86_64               randconfig-a015-20230109
arm                                 defconfig
x86_64                           rhel-8.3-kvm
x86_64                               rhel-8.3
arm                              allyesconfig
arm64                            allyesconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                             allyesconfig
riscv                randconfig-r042-20230109
s390                 randconfig-r044-20230109
arm                  randconfig-r046-20230108
arc                  randconfig-r043-20230108
arc                  randconfig-r043-20230109
x86_64                        randconfig-a002
x86_64                        randconfig-a006
mips                            gpr_defconfig
x86_64                        randconfig-a004
mips                           jazz_defconfig
sparc64                          alldefconfig
arc                         haps_hs_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                             pxa_defconfig
powerpc                         ps3_defconfig
sh                          polaris_defconfig
powerpc                 canyonlands_defconfig
m68k                           sun3_defconfig
powerpc                      ppc6xx_defconfig
x86_64                           alldefconfig
powerpc                 mpc834x_mds_defconfig
m68k                        stmark2_defconfig
arm                             rpc_defconfig
arm                           corgi_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     asp8347_defconfig
parisc                generic-32bit_defconfig
sh                     sh7710voipgw_defconfig
i386                          randconfig-c001
m68k                        m5407c3_defconfig
xtensa                           allyesconfig
ia64                         bigsur_defconfig
m68k                        mvme147_defconfig
sh                           se7712_defconfig
riscv                randconfig-r042-20230110
s390                 randconfig-r044-20230110
arc                  randconfig-r043-20230110

clang tested configs:
i386                 randconfig-a004-20230109
x86_64               randconfig-a003-20230109
x86_64               randconfig-a002-20230109
i386                 randconfig-a002-20230109
x86_64               randconfig-a004-20230109
x86_64               randconfig-a005-20230109
x86_64               randconfig-a001-20230109
i386                 randconfig-a003-20230109
x86_64                          rhel-8.3-rust
x86_64               randconfig-a006-20230109
i386                 randconfig-a006-20230109
i386                 randconfig-a001-20230109
i386                 randconfig-a005-20230109
hexagon              randconfig-r045-20230109
arm                  randconfig-r046-20230109
hexagon              randconfig-r041-20230108
hexagon              randconfig-r041-20230109
hexagon              randconfig-r045-20230108
s390                 randconfig-r044-20230108
riscv                randconfig-r042-20230108
arm                           omap1_defconfig
x86_64                        randconfig-a001
arm                          pxa168_defconfig
arm                           spitz_defconfig
x86_64                        randconfig-a003
mips                           rs90_defconfig
powerpc                   lite5200b_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-k001
arm                        multi_v5_defconfig
arm                          ep93xx_defconfig
powerpc                     ksi8560_defconfig
arm                          pcm027_defconfig
powerpc                       ebony_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
