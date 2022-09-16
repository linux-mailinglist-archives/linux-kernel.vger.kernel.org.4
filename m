Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A981D5BA49C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 04:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiIPC3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 22:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiIPC3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 22:29:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C279610C3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 19:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663295370; x=1694831370;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=G7JEdUjCVAR2LnFoNLveWgWEJA7A/bLd9qhejabxWeg=;
  b=UhFBZqF54oqcU6m7LJ06xu578og/XPPOTxj6Cgve/9uZwnT3NHjiMsLt
   dgDPDbeIquEXoca3xoCbKM6cLXaqLtuY4KpUQkGDA02gx71aQaBl38KzH
   7fdDAOBdyYMw1BlRt3NmokAa/o/JwOJ0cubNg6Asbs014xShPt/umZTrZ
   tP1gePi8tyq8rAyTw0bTAmbAAG/DPBqyEQzVuZ6m/Gx5vcthWWcFt3XM4
   Ksd3G0BrJN+o2r4rufKU84uvtxGhK/BNuxntjKDK5+8fHgIR3H3Xy7NQM
   lISoRBSXqLkb/nJlb9L0r+Z7cyatUC0fg1z95UvufqO5W6DGTOJeDb4MW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="281921757"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="281921757"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 19:29:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="613111913"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Sep 2022 19:29:25 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZ16a-0001LQ-1I;
        Fri, 16 Sep 2022 02:29:24 +0000
Date:   Fri, 16 Sep 2022 10:28:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/core] BUILD SUCCESS
 7a7621dfa417aa3715d2a3bd1bdd6cf5018274d0
Message-ID: <6323df4d.THUUTpaJxiaPGCWn%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
branch HEAD: 7a7621dfa417aa3715d2a3bd1bdd6cf5018274d0  objtool,x86: Teach decode about LOOP* instructions

elapsed time: 728m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
x86_64                              defconfig
powerpc                           allnoconfig
s390                                defconfig
x86_64                               rhel-8.3
s390                             allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                           allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
i386                                defconfig
s390                             allyesconfig
arc                  randconfig-r043-20220915
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-a001
ia64                             allmodconfig
riscv                randconfig-r042-20220915
i386                          randconfig-a003
s390                 randconfig-r044-20220915
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                          randconfig-a005
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
hexagon              randconfig-r045-20220915
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
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
