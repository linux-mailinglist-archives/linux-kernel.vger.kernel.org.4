Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462C3701BA2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 07:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjENFc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 01:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENFcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 01:32:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7012129
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 22:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684042342; x=1715578342;
  h=date:from:to:cc:subject:message-id;
  bh=+b7Ps+vZlBrbkSGOhUF7a1e6vN7lR07IdBh+1apGtmQ=;
  b=Y3pN7SxLdUaCu4ncKhpP1wMuWPo0jzFdpTmT0QY6PpmEYu+hVGNbWhAy
   FoyDR7ZaMuACddfeKdnN6+yPqI9tKIQMskqCIjKawnBaUsOYjshYhSsLt
   Jwh0DOoj0ttic/h8uAa+o0mR+wj3Nku/ZrDk77Z1d7X1Y1L7NObqAVP7l
   VLMcG1clcCdrx7SGLg1IIOL34Jc4aF6WRFL1AdQ5x8cor4Ib774jtVvcn
   Yod545xHjraa5vCPHulG4BoZMHL9ix3Alt9SqU4YFWx+aJOdC9UBUJjSd
   0+s4sXpx+1p7Bg1lXLatsutbcKbeyYYLcDnC9xB+YnNQiLI8rA9Z1k+Xk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="351041533"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="351041533"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 22:32:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="844847312"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="844847312"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2023 22:32:21 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1py4LF-0005qQ-05;
        Sun, 14 May 2023 05:32:21 +0000
Date:   Sun, 14 May 2023 13:32:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f585d5177e1aad174fd6da0e3936b682ed58ced0
Message-ID: <20230514053202.ioZ20%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f585d5177e1aad174fd6da0e3936b682ed58ced0  Merge x86/alternatives into tip/master

elapsed time: 775m

configs tested: 127
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r023-20230514   gcc  
arc                  randconfig-r036-20230513   gcc  
arc                  randconfig-r043-20230514   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230514   gcc  
arm                                 defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                  randconfig-r012-20230514   gcc  
arm                  randconfig-r016-20230514   gcc  
arm                  randconfig-r046-20230514   gcc  
arm                           sama7_defconfig   clang
arm                        shmobile_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230514   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r033-20230509   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r031-20230513   gcc  
csky                 randconfig-r033-20230511   gcc  
csky                 randconfig-r034-20230511   gcc  
hexagon              randconfig-r004-20230514   clang
hexagon              randconfig-r005-20230514   clang
hexagon              randconfig-r032-20230512   clang
hexagon              randconfig-r032-20230513   clang
hexagon              randconfig-r035-20230512   clang
hexagon              randconfig-r041-20230514   clang
hexagon              randconfig-r045-20230514   clang
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
ia64                             alldefconfig   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r031-20230509   gcc  
ia64                 randconfig-r035-20230511   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230514   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r024-20230514   gcc  
loongarch            randconfig-r032-20230509   gcc  
loongarch            randconfig-r034-20230513   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230514   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                 randconfig-r033-20230513   gcc  
m68k                 randconfig-r035-20230513   gcc  
microblaze           randconfig-r031-20230511   gcc  
microblaze           randconfig-r033-20230512   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                     decstation_defconfig   gcc  
mips                      malta_kvm_defconfig   clang
nios2                         3c120_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230514   gcc  
openrisc             randconfig-r003-20230514   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r014-20230514   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230514   gcc  
riscv                randconfig-r031-20230512   gcc  
riscv                randconfig-r042-20230514   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230514   clang
sh                               allmodconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230514   gcc  
sparc                randconfig-r013-20230514   gcc  
sparc                randconfig-r015-20230514   gcc  
sparc                randconfig-r035-20230509   gcc  
sparc64      buildonly-randconfig-r006-20230514   gcc  
um                               alldefconfig   gcc  
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
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r036-20230512   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
