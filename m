Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62C45BF8C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiIUIPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiIUIPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:15:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D655A38A4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663748074; x=1695284074;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=32zhBtiLO8SGRT1bTZT+W0++sarGY2cVnFnbbaxamAY=;
  b=ciQgRj6WkLaQ3eqT4YjRKhf5T6aeD1sSW66+oNKTVaCK7pRgfeVRGjo5
   Vi5bdcdevQveJ8YH5BH26MVf/3iJGvV9yp5/OKk6vnCgNyzWt3A15MlOu
   WyfA12Ezjm1ufRHGU1Qre1hDKIeb/Dq7h/melGMx1rqABQXgspEqWwPkV
   PJKxeYQDkXcOpFqi3/aGOh2T3kD5itbSD7ZCYJLaAaFvW1MTRneDAo7W7
   SKVzPqCK8MY6+K2w0XuKrdnzbWHi2TJhLVFBdaRFKyTEOkZxZFxQ+jr/u
   lfh8OZwkCuEontbxqKE7rcfa+Kgt3jwHZqLtPjIYC0pm3eyzB9bxe57aX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="279662458"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="279662458"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 01:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="570437509"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Sep 2022 01:14:11 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaury-0003PF-2J;
        Wed, 21 Sep 2022 08:14:10 +0000
Date:   Wed, 21 Sep 2022 16:13:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 fdb6649ab7c142e497539a471e573c2593b9c923
Message-ID: <632ac7ad.53E2zpBT+odrasoD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
branch HEAD: fdb6649ab7c142e497539a471e573c2593b9c923  x86/asm/bitops: Use __builtin_ctzl() to evaluate constant expressions

elapsed time: 722m

configs tested: 98
configs skipped: 86

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allyesconfig
i386                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
ia64                        generic_defconfig
sh                   rts7751r2dplus_defconfig
sh                          rsk7203_defconfig
nios2                         3c120_defconfig
ia64                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arm                          simpad_defconfig
powerpc                    sam440ep_defconfig
sh                             espt_defconfig
arm                            xcep_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
ia64                          tiger_defconfig
powerpc                  iss476-smp_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sh                        sh7763rdp_defconfig
sparc64                             defconfig
powerpc                      makalu_defconfig
m68k                        mvme147_defconfig
sh                           se7705_defconfig
m68k                            mac_defconfig
sparc                             allnoconfig
microblaze                      mmu_defconfig
arc                      axs103_smp_defconfig
i386                 randconfig-c001-20220919
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
m68k                       m5275evb_defconfig
loongarch                 loongson3_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-k001
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
mips                      pic32mzda_defconfig
riscv                             allnoconfig
mips                           ip28_defconfig
powerpc                     pseries_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
