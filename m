Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D2872B6F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 06:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjFLEtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 00:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbjFLEsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 00:48:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76A910E5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 21:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686545246; x=1718081246;
  h=date:from:to:cc:subject:message-id;
  bh=UI/jlebxX4lshBWCqt7EGK7noIqa0jBQJhQzyQhN+qs=;
  b=UKBtSkzU9KUJbvNT0Wqwz2yfUUFVtTZ4AQtNRxRQBK1oo9ZbGG44oRUX
   r7tJmpn11cPfTAWeDiBrNpWmX/+mCfJ1qE+y1srE+DmS7wkxBD1spgN1V
   K357X+BdLFm7rqs5p/x8aOBW6ktl//6n8TEHpJ2ZIuVY8Zj3gel3hK3yD
   A0CoKdSDOx3qELveP83fte7jF969kP4/rOe+86jt7Ud842U+GehHnWFbI
   e4p7Y/Qpj3Xjdx7DlqanYcTzYokd0jfQ7xGUCbHnSq8MMnL8SpcZRdKPk
   1juPvBCnzxtrRNmvt6WV9ymr4AWfUHrLbNPLFpLUXNAqIG/2BK91hNE7Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="444313974"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="444313974"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 21:46:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="823825699"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="823825699"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2023 21:46:58 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8ZSD-00004K-36;
        Mon, 12 Jun 2023 04:46:57 +0000
Date:   Mon, 12 Jun 2023 12:46:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1ecd3a9b5c7acc4428ae0b349396e626a905be65
Message-ID: <202306121210.ZXaGsUHm-lkp@intel.com>
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
branch HEAD: 1ecd3a9b5c7acc4428ae0b349396e626a905be65  Merge branch into tip/master: 'x86/sev'

elapsed time: 720m

configs tested: 121
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                             mxs_defconfig   clang
arm                       netwinder_defconfig   clang
arm                  randconfig-r015-20230612   clang
arm                  randconfig-r022-20230612   clang
arm                  randconfig-r046-20230612   clang
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230612   clang
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r002-20230612   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r001-20230612   clang
hexagon              randconfig-r013-20230612   clang
hexagon              randconfig-r014-20230612   clang
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r045-20230612   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230612   clang
i386                 randconfig-i002-20230612   clang
i386                 randconfig-i003-20230612   clang
i386                 randconfig-i004-20230612   clang
i386                 randconfig-i005-20230612   clang
i386                 randconfig-i006-20230612   clang
i386                 randconfig-i011-20230612   gcc  
i386                 randconfig-i012-20230612   gcc  
i386                 randconfig-i013-20230612   gcc  
i386                 randconfig-i014-20230612   gcc  
i386                 randconfig-i015-20230612   gcc  
i386                 randconfig-i016-20230612   gcc  
i386                 randconfig-r012-20230612   gcc  
i386                 randconfig-r035-20230612   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r036-20230612   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                 randconfig-r025-20230612   gcc  
microblaze           randconfig-r011-20230612   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r026-20230612   clang
mips                        vocore2_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                    gamecube_defconfig   clang
powerpc                    ge_imp3a_defconfig   clang
powerpc                     kmeter1_defconfig   clang
powerpc              randconfig-r005-20230612   clang
powerpc              randconfig-r033-20230612   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r006-20230612   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230612   gcc  
riscv                randconfig-r024-20230612   gcc  
riscv                randconfig-r032-20230612   clang
riscv                randconfig-r034-20230612   clang
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230612   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r001-20230612   gcc  
sparc        buildonly-randconfig-r004-20230612   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230612   clang
x86_64               randconfig-a002-20230612   clang
x86_64               randconfig-a003-20230612   clang
x86_64               randconfig-a004-20230612   clang
x86_64               randconfig-a005-20230612   clang
x86_64               randconfig-a006-20230612   clang
x86_64               randconfig-a011-20230612   gcc  
x86_64               randconfig-a012-20230612   gcc  
x86_64               randconfig-a013-20230612   gcc  
x86_64               randconfig-a014-20230612   gcc  
x86_64               randconfig-a015-20230612   gcc  
x86_64               randconfig-a016-20230612   gcc  
x86_64               randconfig-r006-20230612   clang
x86_64               randconfig-r023-20230612   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                              defconfig   gcc  
xtensa               randconfig-r002-20230612   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
