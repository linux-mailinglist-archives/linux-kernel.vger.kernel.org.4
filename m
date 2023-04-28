Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB666F1306
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345549AbjD1IKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345225AbjD1IKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:10:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF041FF1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 01:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682669428; x=1714205428;
  h=date:from:to:cc:subject:message-id;
  bh=r1QJWwuyHGm9z79/4h7Azz8eXKeEtpUR8eL52Opghz4=;
  b=Q85Wj5MznKzke5pdBri96TDOW2VU4pnOKmclSX743wxGmoVuIY7orkZu
   EHtG/UrqCdhJ2v8QOOeFQ3X/EYS1keY09XNrQ7zN6w+aQv2k5UcHIkskb
   SK0jVNzSFdKQJqSsUmeZxxcNAM8PMfSKhvqoNwXoG4tVcIA+gWqbnxPui
   sYa/XV52YkVHgSEvVWhP8PNXQa4x4uSM6gH8mgMCZlXjHy6qpfJBLfLVF
   V4vVDZksThWnZY7Hm+qE4xnISKfxGNjD2siSmUhPy3HoC9pD3VKYBQeET
   PrQKmczti6CGwZQIcXQIidgL0vRQ0fFoTkiq01hN3yc7szlJ5zoucHSZ6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="328010893"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="328010893"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 01:10:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="1024527157"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="1024527157"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Apr 2023 01:10:27 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psJBS-0000IW-1I;
        Fri, 28 Apr 2023 08:10:26 +0000
Date:   Fri, 28 Apr 2023 16:10:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f63b2d6a42847aee04d0710d67bab6337fe6c373
Message-ID: <20230428081022.JVj86%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f63b2d6a42847aee04d0710d67bab6337fe6c373  Merge branch into tip/master: 'timers/core'

elapsed time: 722m

configs tested: 124
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r034-20230427   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230427   gcc  
arc                  randconfig-r032-20230427   gcc  
arc                  randconfig-r043-20230427   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r005-20230427   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                       netwinder_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                  randconfig-r015-20230427   gcc  
arm                  randconfig-r046-20230427   gcc  
arm                             rpc_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230427   gcc  
arm64        buildonly-randconfig-r004-20230427   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230428   gcc  
csky                 randconfig-r016-20230427   gcc  
hexagon              randconfig-r041-20230427   clang
hexagon              randconfig-r045-20230427   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230427   gcc  
ia64                 randconfig-r014-20230427   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r031-20230427   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze           randconfig-r006-20230427   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                        maltaup_defconfig   clang
mips                 randconfig-r013-20230427   gcc  
mips                 randconfig-r014-20230428   clang
mips                 randconfig-r035-20230427   clang
nios2        buildonly-randconfig-r003-20230427   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230428   gcc  
nios2                randconfig-r012-20230427   gcc  
nios2                randconfig-r022-20230427   gcc  
nios2                randconfig-r036-20230427   gcc  
openrisc     buildonly-randconfig-r001-20230427   gcc  
openrisc             randconfig-r016-20230428   gcc  
openrisc             randconfig-r033-20230427   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230427   gcc  
parisc               randconfig-r024-20230427   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    amigaone_defconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230427   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230427   clang
s390                                defconfig   gcc  
s390                 randconfig-r044-20230427   clang
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                   randconfig-r013-20230428   gcc  
sh                   randconfig-r023-20230427   gcc  
sh                            titan_defconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r025-20230427   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa               randconfig-r015-20230428   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
