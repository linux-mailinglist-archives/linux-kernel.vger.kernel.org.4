Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8AC6545DE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiLVSOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiLVSOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:14:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2082B13D4E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671732882; x=1703268882;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MLsZoG3w/wofZAj98krLPXC/JPTNK5PARxNbIkVb9u0=;
  b=az9uAuHUz5MTWTsRgog01e2pLsZKtGATyM1T9+/gsqECWb0fB1Xa2HMI
   CyG+ktnvh7oxftQMWvonw15b8wQIr04wmqcOysCenq5KsYuPLwb7ZH1nQ
   gJUWitz1Eqg2Wrf4Py5sYptmIyV5Fk5Jqz7dDpOJR40zHyYL8cCC/LZ6s
   EjifODgMNRhE0Hmnl2lJGqpR899F+FbKiOCjL6AyDgG5i4AdBJzzlcKTB
   nTyJlczBl3YFgTcRZtw9YKVHFDRtzGyxJdDZFZK4FNyib9J1aYfztN3Xi
   xp9GNxWx3bBf2limANUkeBCgdfv2aXGih5YK+Og9bU0rse9EOlM14F+2S
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="406428319"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="406428319"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 10:14:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="682479432"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="682479432"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Dec 2022 10:14:39 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p8Q5X-000C0Y-0g;
        Thu, 22 Dec 2022 18:14:39 +0000
Date:   Fri, 23 Dec 2022 02:13:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:haltnmi3slow.2022.12.21a] BUILD SUCCESS
 86bee2e421da7c7aed829206357a82cdfb46b3b4
Message-ID: <63a49e61.bVPOVTuj7Ggymwwx%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git haltnmi3slow.2022.12.21a
branch HEAD: 86bee2e421da7c7aed829206357a82cdfb46b3b4  Merge branch 'slownmi.2022.12.19a' into HEAD

elapsed time: 722m

configs tested: 108
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                                defconfig
x86_64                              defconfig
arc                                 defconfig
x86_64                               rhel-8.3
i386                 randconfig-a001-20221219
s390                             allmodconfig
x86_64                          rhel-8.3-func
alpha                               defconfig
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a003-20221219
arm                                 defconfig
s390                                defconfig
x86_64               randconfig-a002-20221219
x86_64                           allyesconfig
x86_64               randconfig-a003-20221219
s390                             allyesconfig
i386                 randconfig-a002-20221219
powerpc                           allnoconfig
x86_64               randconfig-a001-20221219
i386                 randconfig-a006-20221219
i386                 randconfig-a005-20221219
x86_64               randconfig-a004-20221219
x86_64               randconfig-a006-20221219
i386                 randconfig-a004-20221219
x86_64               randconfig-a005-20221219
mips                             allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-bpf
arm                              allyesconfig
m68k                             allyesconfig
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
arc                              allyesconfig
arm64                            allyesconfig
powerpc                          allmodconfig
x86_64                         rhel-8.3-kunit
alpha                            allyesconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
riscv                randconfig-r042-20221218
arc                  randconfig-r043-20221219
arm                  randconfig-r046-20221219
arc                  randconfig-r043-20221218
s390                 randconfig-r044-20221218
m68k                         apollo_defconfig
arm                           viper_defconfig
x86_64                            allnoconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
sparc                               defconfig
sh                          sdk7786_defconfig
nios2                         3c120_defconfig
m68k                          atari_defconfig
arm                          iop32x_defconfig
arm                        oxnas_v6_defconfig
arm                         nhk8815_defconfig
powerpc                       eiger_defconfig
xtensa                              defconfig
m68k                                defconfig
m68k                            mac_defconfig
powerpc                      ep88xc_defconfig
sh                               j2_defconfig
i386                          randconfig-c001
s390                 randconfig-r044-20221222
arc                  randconfig-r043-20221222
riscv                randconfig-r042-20221222
arm                            lart_defconfig
powerpc                 mpc837x_rdb_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64                          rhel-8.3-rust
i386                 randconfig-a014-20221219
i386                 randconfig-a012-20221219
i386                 randconfig-a013-20221219
i386                 randconfig-a015-20221219
x86_64               randconfig-a011-20221219
i386                 randconfig-a016-20221219
i386                 randconfig-a011-20221219
x86_64               randconfig-a012-20221219
x86_64               randconfig-a014-20221219
x86_64               randconfig-a015-20221219
x86_64               randconfig-a013-20221219
arm                  randconfig-r046-20221218
x86_64               randconfig-a016-20221219
hexagon              randconfig-r041-20221218
hexagon              randconfig-r045-20221219
s390                 randconfig-r044-20221219
hexagon              randconfig-r041-20221219
hexagon              randconfig-r045-20221218
riscv                randconfig-r042-20221219
x86_64               randconfig-k001-20221219
x86_64                        randconfig-k001
s390                 randconfig-r044-20221221
riscv                randconfig-r042-20221221
hexagon              randconfig-r045-20221221
hexagon              randconfig-r041-20221221
i386                             allyesconfig
arm                         s3c2410_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
