Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38AE736040
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 01:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjFSXuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 19:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFSXuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:50:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A53E139
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687218618; x=1718754618;
  h=date:from:to:cc:subject:message-id;
  bh=zzm5qEut+G2RHqVO7+W1aZ/u+vkLRYFmOrPP4tPT0Rg=;
  b=TzlWxCZ0NhO971DS2MUSfmS5XHS6hA5NYhgsrea2un6PSu5cr2+Jb78c
   U4b1RDf5LG+abFIg/fN28FRzEwLm8Z8sGRvadTS6LPhbn04kk2xa4DiE+
   d2393sNYk8iGde+IwAHzvzp00J2kRkKB2b7rKK5f0ILN4NasP1akvJ4Ed
   khPq1tvW7vgYDoTLZ+1gRbSQ5A90Wg86b+Fzt6VHl3S1jnttB8/+4viZh
   rgO8ngLNA6UscwSU/62w4WSVRF72c3Q/HBRa89r6cK/803r6hRymMO9xV
   e1BpR7wR3Ddq132sZGQuixtDswS4DLRXiUZxApBShWJOtcVo8DvLEFomJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="358597651"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="358597651"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 16:50:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="803755798"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="803755798"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jun 2023 16:50:15 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBOdS-0005Fc-2z;
        Mon, 19 Jun 2023 23:50:14 +0000
Date:   Tue, 20 Jun 2023 07:49:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 ebb83d84e49b54369b0db67136a5fe1087124dcc
Message-ID: <202306200755.ZNl2K1Lt-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: ebb83d84e49b54369b0db67136a5fe1087124dcc  sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()

elapsed time: 729m

configs tested: 154
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230619   gcc  
alpha                randconfig-r023-20230619   gcc  
alpha                randconfig-r034-20230619   gcc  
alpha                randconfig-r036-20230619   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230619   gcc  
arc                  randconfig-r021-20230619   gcc  
arc                  randconfig-r043-20230619   gcc  
arc                  randconfig-r043-20230620   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                  randconfig-r003-20230619   clang
arm                  randconfig-r046-20230619   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r031-20230619   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230619   gcc  
csky                 randconfig-r004-20230619   gcc  
csky                 randconfig-r022-20230619   gcc  
csky                 randconfig-r035-20230619   gcc  
hexagon              randconfig-r006-20230619   clang
hexagon              randconfig-r011-20230619   clang
hexagon              randconfig-r041-20230619   clang
hexagon              randconfig-r045-20230619   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230619   gcc  
i386         buildonly-randconfig-r005-20230619   gcc  
i386         buildonly-randconfig-r006-20230619   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230619   gcc  
i386                 randconfig-i002-20230619   gcc  
i386                 randconfig-i003-20230619   gcc  
i386                 randconfig-i004-20230619   gcc  
i386                 randconfig-i005-20230619   gcc  
i386                 randconfig-i006-20230619   gcc  
i386                 randconfig-i011-20230619   clang
i386                 randconfig-i012-20230619   clang
i386                 randconfig-i013-20230619   clang
i386                 randconfig-i014-20230619   clang
i386                 randconfig-i015-20230619   clang
i386                 randconfig-i016-20230619   clang
i386                 randconfig-r012-20230619   clang
i386                 randconfig-r032-20230619   gcc  
i386                 randconfig-r033-20230619   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230619   gcc  
loongarch            randconfig-r004-20230619   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230619   gcc  
m68k                 randconfig-r021-20230619   gcc  
m68k                 randconfig-r034-20230619   gcc  
m68k                 randconfig-r036-20230619   gcc  
microblaze           randconfig-r005-20230619   gcc  
microblaze           randconfig-r011-20230619   gcc  
microblaze           randconfig-r024-20230619   gcc  
microblaze           randconfig-r031-20230619   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                malta_qemu_32r6_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
mips                 randconfig-r013-20230619   gcc  
mips                   sb1250_swarm_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230619   gcc  
nios2                randconfig-r016-20230619   gcc  
nios2                randconfig-r032-20230619   gcc  
openrisc             randconfig-r033-20230619   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc              randconfig-r003-20230619   gcc  
powerpc              randconfig-r012-20230619   clang
powerpc              randconfig-r013-20230619   clang
powerpc                  storcenter_defconfig   gcc  
powerpc                     taishan_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                randconfig-r042-20230619   clang
riscv                randconfig-r042-20230620   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230619   clang
s390                 randconfig-r044-20230620   gcc  
sh                               allmodconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                   randconfig-r025-20230619   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r032-20230619   gcc  
sparc                randconfig-r033-20230619   gcc  
sparc                randconfig-r035-20230619   gcc  
sparc64              randconfig-r006-20230619   gcc  
sparc64              randconfig-r014-20230619   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r002-20230619   clang
um                   randconfig-r005-20230619   clang
um                   randconfig-r013-20230619   gcc  
um                   randconfig-r016-20230619   gcc  
um                   randconfig-r034-20230619   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230619   gcc  
x86_64       buildonly-randconfig-r002-20230619   gcc  
x86_64       buildonly-randconfig-r003-20230619   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230619   gcc  
x86_64               randconfig-a002-20230619   gcc  
x86_64               randconfig-a003-20230619   gcc  
x86_64               randconfig-a004-20230619   gcc  
x86_64               randconfig-a005-20230619   gcc  
x86_64               randconfig-a006-20230619   gcc  
x86_64               randconfig-a011-20230619   clang
x86_64               randconfig-a012-20230619   clang
x86_64               randconfig-a013-20230619   clang
x86_64               randconfig-a014-20230619   clang
x86_64               randconfig-a015-20230619   clang
x86_64               randconfig-a016-20230619   clang
x86_64               randconfig-r003-20230619   gcc  
x86_64               randconfig-r014-20230619   clang
x86_64               randconfig-r015-20230619   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r012-20230619   gcc  
xtensa               randconfig-r024-20230619   gcc  
xtensa               randconfig-r025-20230619   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
