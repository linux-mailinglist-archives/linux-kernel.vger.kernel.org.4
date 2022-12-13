Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A2A64B469
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbiLMLqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiLMLqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:46:43 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F11CB59
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670932002; x=1702468002;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tLT2JyKwZrtrNGGsmIjoSB+W42DZ9Oie2ljPnHbUkIA=;
  b=NX5uHTwLjR1+hQ9YOO895YOKSoQID5jgFebVianjEAq9/ZQWWwUKIdBF
   HcKhUkoYCbvOm1Tr9sA3gB52bJKbT6Ci7I17ANunMtbE4EcMaP7RPEcyA
   TTxLGpo1jaLesYgjPaE/iB7q4hwlOrQE7wdjszHjy7rLIKMVQssa+kNFH
   1v5RmsQQ1eZ7LD5JL17L8upHsMDpzy0Ay+amNoH1Xxl343cXYmSatDQn8
   U2BWCqaPQGaFgDj1shPYdvOHD8j9FW8RSH5To5svZZOi9CfMUs0/y0Xl0
   eZ3sKhq2WeEaN1uaBiUXAUPxtHnzgDx7IXgLhzj9X0uyhsdJ6GSDbJeF1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="318140258"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="318140258"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 03:46:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="712036427"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="712036427"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Dec 2022 03:46:41 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p53k8-0004I9-1N;
        Tue, 13 Dec 2022 11:46:40 +0000
Date:   Tue, 13 Dec 2022 19:46:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.12.06a] BUILD SUCCESS
 e7473db5e5cc7e770e19948b207c8728c9b38dac
Message-ID: <63986619.IEA9iSxpng0tZjvz%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.12.06a
branch HEAD: e7473db5e5cc7e770e19948b207c8728c9b38dac  squash! rcu: Allow up to five minutes expedited RCU CPU stall-warning timeouts

elapsed time: 3928m

configs tested: 143
configs skipped: 34

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a004
i386                          randconfig-a001
x86_64                        randconfig-a006
arc                  randconfig-r043-20221211
x86_64                        randconfig-a015
i386                          randconfig-a003
i386                          randconfig-a014
arm                  randconfig-r046-20221211
i386                          randconfig-a005
x86_64                            allnoconfig
powerpc                           allnoconfig
i386                          randconfig-a012
i386                          randconfig-a016
powerpc                          allmodconfig
arc                        nsim_700_defconfig
ia64                            zx1_defconfig
arm                        realview_defconfig
powerpc                     tqm8555_defconfig
sh                      rts7751r2d1_defconfig
mips                         cobalt_defconfig
xtensa                generic_kc705_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-rust
loongarch                 loongson3_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
mips                     decstation_defconfig
sh                           se7206_defconfig
um                             i386_defconfig
i386                          randconfig-c001
m68k                            q40_defconfig
riscv                               defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
m68k                       m5475evb_defconfig
m68k                                defconfig
arm                            pleb_defconfig
sparc                            alldefconfig
sh                     sh7710voipgw_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
loongarch                        alldefconfig
openrisc                            defconfig
powerpc                         wii_defconfig
nios2                         10m50_defconfig
mips                          rb532_defconfig
sh                        sh7763rdp_defconfig
openrisc                 simple_smp_defconfig
arm                          badge4_defconfig
sh                          rsk7269_defconfig
powerpc                     rainier_defconfig
xtensa                    xip_kc705_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221211
x86_64               randconfig-a013-20221212
x86_64               randconfig-a011-20221212
x86_64               randconfig-a015-20221212
x86_64               randconfig-a012-20221212
x86_64               randconfig-a016-20221212
x86_64               randconfig-a014-20221212
i386                 randconfig-a013-20221212
arc                  randconfig-r043-20221212
i386                 randconfig-a014-20221212
s390                 randconfig-r044-20221212
i386                 randconfig-a011-20221212
riscv                randconfig-r042-20221212
i386                 randconfig-a012-20221212
i386                 randconfig-a015-20221212
i386                 randconfig-a016-20221212
sh                         ap325rxa_defconfig
arm                            zeus_defconfig
arc                      axs103_smp_defconfig
arc                  randconfig-r043-20221213
arm                  randconfig-r046-20221213

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a016
x86_64                        randconfig-a005
hexagon              randconfig-r041-20221211
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a006
riscv                randconfig-r042-20221211
i386                          randconfig-a004
i386                          randconfig-a011
hexagon              randconfig-r045-20221211
s390                 randconfig-r044-20221211
i386                          randconfig-a015
mips                  cavium_octeon_defconfig
powerpc                     kmeter1_defconfig
powerpc                     tqm8560_defconfig
x86_64                        randconfig-k001
arm                        magician_defconfig
mips                     loongson2k_defconfig
powerpc                 mpc8315_rdb_defconfig
x86_64               randconfig-a002-20221212
x86_64               randconfig-a001-20221212
x86_64               randconfig-a004-20221212
x86_64               randconfig-a003-20221212
x86_64               randconfig-a005-20221212
x86_64               randconfig-a006-20221212
i386                 randconfig-a002-20221212
i386                 randconfig-a003-20221212
i386                 randconfig-a001-20221212
i386                 randconfig-a004-20221212
i386                 randconfig-a006-20221212
i386                 randconfig-a005-20221212
arm                  randconfig-r046-20221212
hexagon              randconfig-r045-20221212
hexagon              randconfig-r041-20221212
hexagon              randconfig-r041-20221213
hexagon              randconfig-r045-20221213
riscv                randconfig-r042-20221213
s390                 randconfig-r044-20221213

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
