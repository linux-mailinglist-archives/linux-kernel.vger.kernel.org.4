Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E766E583B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 06:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjDRE51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 00:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRE5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 00:57:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6C22D4C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681793843; x=1713329843;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1LyaED5FSKCAWbB09ZS85INsZWOdEOFe7xIFQnVY3mg=;
  b=YqmB2CQ3NAQLLCco0PTFBwIc5ok3LupGSDzKAkiLKVCRPHgnE1nDVmX/
   O2ZwNJBqeTPbEQPhiVakoFqj/cJekCvitu71HWMPUNdIDu16tQaKFQ+Mx
   nOuvv+a0En8MIFOOa2Dv7fdvPrGLdGEEfW0mRVLxcYdu3C85UqSeZOYfA
   Wp5Tut8k+NCBULkGb3XhHdPJS+68xjUOEVn9xLKfw9tWkgcIWlKVjuRU3
   pCWIsP3KxpPG+4h8SeR8Ex3DDLh39ZGgkQcL2FOKPLMdEoPtdsvu6ElW5
   A2opkAnsVI9PBTK45Svu38iDxzDedSM1bczLodhRj2EC0VadAXxwlz4ff
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410294296"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="410294296"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 21:57:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="834716521"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="834716521"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2023 21:57:21 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1podP7-000d0F-04;
        Tue, 18 Apr 2023 04:57:21 +0000
Date:   Tue, 18 Apr 2023 12:57:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7d866e111ecda0551f7270ab932fde37ddba1470
Message-ID: <643e231e.3zzveRmHggiVsSSz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 7d866e111ecda0551f7270ab932fde37ddba1470  Merge x86/microcode into tip/master

elapsed time: 903m

configs tested: 150
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230416   gcc  
alpha                randconfig-r013-20230416   gcc  
alpha                randconfig-r035-20230416   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230417   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                  randconfig-r043-20230416   gcc  
arc                  randconfig-r043-20230417   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r022-20230416   clang
arm                  randconfig-r031-20230416   gcc  
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230417   gcc  
arm                           sama5_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230417   gcc  
arm64        buildonly-randconfig-r004-20230416   clang
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230416   clang
csky         buildonly-randconfig-r004-20230417   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r015-20230416   gcc  
csky                 randconfig-r023-20230417   gcc  
csky                 randconfig-r032-20230416   gcc  
csky                 randconfig-r033-20230416   gcc  
csky                 randconfig-r034-20230417   gcc  
hexagon                             defconfig   clang
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r041-20230417   clang
hexagon              randconfig-r045-20230416   clang
hexagon              randconfig-r045-20230417   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230417   gcc  
ia64                 randconfig-r015-20230417   gcc  
ia64                 randconfig-r022-20230417   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230416   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230417   gcc  
loongarch            randconfig-r013-20230417   gcc  
loongarch            randconfig-r031-20230417   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r014-20230417   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze           randconfig-r001-20230417   gcc  
microblaze           randconfig-r003-20230416   gcc  
microblaze           randconfig-r016-20230416   gcc  
microblaze           randconfig-r036-20230416   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                 randconfig-r005-20230416   gcc  
nios2        buildonly-randconfig-r001-20230416   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230417   gcc  
nios2                randconfig-r025-20230417   gcc  
nios2                randconfig-r032-20230417   gcc  
openrisc     buildonly-randconfig-r005-20230417   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r012-20230417   gcc  
parisc       buildonly-randconfig-r002-20230416   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r023-20230416   gcc  
parisc               randconfig-r034-20230416   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc      buildonly-randconfig-r005-20230416   gcc  
powerpc                        cell_defconfig   gcc  
powerpc              randconfig-r026-20230417   clang
powerpc              randconfig-r036-20230417   gcc  
powerpc                    socrates_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230417   clang
riscv                               defconfig   gcc  
riscv                randconfig-r025-20230416   gcc  
riscv                randconfig-r042-20230416   gcc  
riscv                randconfig-r042-20230417   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230417   clang
s390                                defconfig   gcc  
s390                 randconfig-r012-20230416   gcc  
s390                 randconfig-r044-20230416   gcc  
s390                 randconfig-r044-20230417   clang
sh                               allmodconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                   randconfig-r026-20230416   gcc  
sh                           se7722_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230417   gcc  
sparc                randconfig-r021-20230416   gcc  
sparc                randconfig-r033-20230417   gcc  
sparc64              randconfig-r024-20230416   gcc  
sparc64              randconfig-r024-20230417   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230417   gcc  
x86_64               randconfig-a002-20230417   gcc  
x86_64               randconfig-a003-20230417   gcc  
x86_64               randconfig-a004-20230417   gcc  
x86_64               randconfig-a005-20230417   gcc  
x86_64               randconfig-a006-20230417   gcc  
x86_64               randconfig-a011-20230417   clang
x86_64               randconfig-a012-20230417   clang
x86_64               randconfig-a013-20230417   clang
x86_64               randconfig-a014-20230417   clang
x86_64               randconfig-a015-20230417   clang
x86_64               randconfig-a016-20230417   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r003-20230417   gcc  
xtensa               randconfig-r006-20230416   gcc  
xtensa               randconfig-r011-20230416   gcc  
xtensa               randconfig-r035-20230417   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
