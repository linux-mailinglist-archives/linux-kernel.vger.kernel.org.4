Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770965BA499
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 04:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiIPC2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 22:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIPC21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 22:28:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B80179638
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 19:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663295306; x=1694831306;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5j8Qjk3fSVoifNQfh4s/9O3xld2aYe+pO5nvXFLyBZE=;
  b=H4v/wxypFLv04YPAb4Zgwt4g6v0FvPaBqwapUyZK7+QX7s0ev69XZ9yA
   6Kbinl5HSDXgeVF7ryJ0pfpWJsID3b7z47m8HwldWkHJOVadoE+gfZqId
   9KAOio0GrUibaUKy/xMmjB8NLV1jQKIaKpRZN4d0Bk8acmxUIVHtaxbAT
   kw1t86UFPc2JJj1XgsaX+Gi3IjQIzpfZZ7R3h7TQe/9HuR3uyFvQp0W0c
   /UsB4DtlF89xqZnEZhZQfwpjtBw8dbSZOTr55L/WIyDNrBpymWiW1yZYh
   ytIRpYQn0sE6d6jOgG1uLLsQkwD+5drXt71pzHB9g+qw8SAdveVskNa16
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="299716830"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="299716830"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 19:28:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="743178576"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Sep 2022 19:28:24 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZ15c-0001LC-0Q;
        Fri, 16 Sep 2022 02:28:24 +0000
Date:   Fri, 16 Sep 2022 10:28:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 8c03af3e090e9d57d90f482d344563dd4bae1e66
Message-ID: <6323df44.D657xNH8Ih8kFovM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 8c03af3e090e9d57d90f482d344563dd4bae1e66  x86,retpoline: Be sure to emit INT3 after JMP *%\reg

elapsed time: 726m

configs tested: 118
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
i386                                defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
ia64                             allmodconfig
s390                 randconfig-r044-20220915
arc                  randconfig-r043-20220915
riscv                randconfig-r042-20220915
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
mips                     decstation_defconfig
sh                             sh03_defconfig
powerpc                         wii_defconfig
openrisc                       virt_defconfig
powerpc                      ep88xc_defconfig
sparc                       sparc32_defconfig
powerpc                      arches_defconfig
sh                          rsk7203_defconfig
arm                         vf610m4_defconfig
powerpc                        cell_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
powerpc                        warp_defconfig
xtensa                           alldefconfig
powerpc                      mgcoge_defconfig
m68k                        m5307c3_defconfig
arm                           viper_defconfig
i386                          randconfig-c001
arm64                               defconfig
ia64                             allyesconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
loongarch                           defconfig
loongarch                         allnoconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-c001
arm                  randconfig-c002-20220916
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                         lubbock_defconfig
sh                            titan_defconfig
ia64                         bigsur_defconfig
powerpc                      pcm030_defconfig
powerpc                       eiger_defconfig
arm                            xcep_defconfig
sh                           se7750_defconfig
arm                           tegra_defconfig
arm                            zeus_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r045-20220915
hexagon              randconfig-r041-20220915
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
powerpc                 xes_mpc85xx_defconfig
mips                           ip28_defconfig
powerpc                    socrates_defconfig
arm                        mvebu_v5_defconfig
mips                   sb1250_swarm_defconfig
powerpc                    gamecube_defconfig
powerpc                     kmeter1_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
