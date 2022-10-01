Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D3C5F1FDE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 23:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJAVpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 17:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJAVpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 17:45:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC79A2CCB5
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 14:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664660698; x=1696196698;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TV3ykJieiKd/I7OaSHUxNAgCqg/x8ly23JnYAsJuDmA=;
  b=GHauwpECuqEjslcUlRjfB0fFJ2aifuQN2s939AubyHahupxGUgzpSahH
   Q+j3NpOYZqhiD1HRB7Bj4v7sWwOTUO+ipl+9P0X7lmq5NK87zrrxuBZ8g
   2f4aemyRsLJyGlPns1HuA6AO90/4+W1gtyIo4PNkRN2itZIKUqU6h+/DY
   66djjAu12uxqFoAAeDxgbTVAT2chizw0qLyMkYpxnRaTWJxkXYqXpEmaK
   5eAeG3w/tdFjnNJHhsutRz++lbTp+15HuIMaXkskWpr6i8UpKn3nVP35m
   RJI8W+JssCzcaWOK1fiFPTg3FMOrKy82a3IfKecRMkJxD+8HbT5nbnUKw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="364263602"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="364263602"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 14:44:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="765502564"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="765502564"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Oct 2022 14:44:56 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oekI4-0002lR-0s;
        Sat, 01 Oct 2022 21:44:56 +0000
Date:   Sun, 02 Oct 2022 05:44:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 45e52974a7e77584d215cd07baea75280d98bc9e
Message-ID: <6338b4b1.viTgOEwRKekWLgyS%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 45e52974a7e77584d215cd07baea75280d98bc9e  Merge sched/core into tip/master

elapsed time: 1468m

configs tested: 138
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
powerpc                           allnoconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arc                  randconfig-r043-20220925
s390                             allyesconfig
arm                                 defconfig
riscv                randconfig-r042-20220925
arc                  randconfig-r043-20220926
s390                 randconfig-r044-20220925
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
m68k                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a004
alpha                            allyesconfig
x86_64                    rhel-8.3-kselftests
arm64                            allyesconfig
x86_64                        randconfig-a002
arc                              allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a006
m68k                             allyesconfig
sh                               allmodconfig
i386                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a003-20220926
i386                 randconfig-a001-20220926
i386                 randconfig-a006-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a005-20220926
i386                 randconfig-a002-20220926
x86_64               randconfig-a002-20220926
x86_64               randconfig-a001-20220926
x86_64               randconfig-a004-20220926
x86_64               randconfig-a006-20220926
x86_64               randconfig-a005-20220926
x86_64               randconfig-a003-20220926
riscv                randconfig-r042-20220927
arc                  randconfig-r043-20220927
s390                 randconfig-r044-20220927
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                          randconfig-c001
powerpc                       ppc64_defconfig
arm                           sunxi_defconfig
powerpc                     rainier_defconfig
sh                 kfr2r09-romimage_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                        warp_defconfig
arc                      axs103_smp_defconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220925
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                          simpad_defconfig
m68k                           sun3_defconfig
sh                      rts7751r2d1_defconfig
alpha                            alldefconfig
m68k                        m5307c3_defconfig
sparc                               defconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arm                           h5000_defconfig
m68k                          atari_defconfig
powerpc                      chrp32_defconfig
mips                           gcw0_defconfig
sh                        edosk7705_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm                           stm32_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                    vdk_hs38_smp_defconfig
arm                            xcep_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
x86_64               randconfig-a012-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
x86_64               randconfig-a016-20220926
i386                 randconfig-a011-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
i386                 randconfig-a013-20220926
x86_64               randconfig-a015-20220926
s390                 randconfig-r044-20220926
i386                 randconfig-a012-20220926
x86_64               randconfig-a014-20220926
i386                          randconfig-a002
i386                 randconfig-a016-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a014-20220926
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
arm                          moxart_defconfig
arm                         mv78xx0_defconfig
x86_64                        randconfig-k001
powerpc                          allyesconfig
mips                     loongson1c_defconfig
riscv                    nommu_virt_defconfig
powerpc                        icon_defconfig
riscv                randconfig-r042-20221002
hexagon              randconfig-r041-20221002
s390                 randconfig-r044-20221002
hexagon              randconfig-r045-20221002
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
