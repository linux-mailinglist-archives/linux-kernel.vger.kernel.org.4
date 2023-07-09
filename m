Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357E574C867
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 23:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjGIVaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 17:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGIVaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 17:30:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C497123
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 14:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688938199; x=1720474199;
  h=date:from:to:cc:subject:message-id;
  bh=f1BrwYSMNjkVVV/EOmPQt6Y8X8LATUJ4UsAQGB8JaKQ=;
  b=Wtv0iD3Mmk7LZFXo4MyWlePRkDxP2J3CmWKpnowZbdQWWFlxyUoA4KTw
   NVsE+5rDzxWssKeIrLsd6l8jsek3MdD5zkFQiI+6AgwT4IEfeKWkUi69u
   exOKnxsmiaeCo9wfaqRT8camNpdazVCPONfPb+Xf1MRdlVbTAdMQoYFfF
   fgJ2OEtV5pHWya+1FC7wmmG4W6uhKyqxDU2ldp9BRvblp+xZT4WYiMJ9a
   parZY/m0CwmMGKBM+PDjWIlT9G//3WpmlNlMaZCrKdHjFGcy7QxbIyR06
   HDfQSmIdig+GCDxFfWcgo4hPnu7Fp0DOLcM0vc1RP30O9fV/ZNFBBsenE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="343803391"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="343803391"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 14:29:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="790590673"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="790590673"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2023 14:29:57 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qIbye-0003Og-2E;
        Sun, 09 Jul 2023 21:29:56 +0000
Date:   Mon, 10 Jul 2023 05:29:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ac442f6a364dd23bc08086f07b4bc4ef8476a9fe
Message-ID: <202307100508.haj4Sep2-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: ac442f6a364dd23bc08086f07b4bc4ef8476a9fe  Merge branch into tip/master: 'x86/core'

elapsed time: 725m

configs tested: 119
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230709   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                        neponset_defconfig   clang
arm                  randconfig-r002-20230709   clang
arm                  randconfig-r004-20230709   clang
arm                  randconfig-r046-20230709   gcc  
arm                         s5pv210_defconfig   clang
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r025-20230709   clang
csky                                defconfig   gcc  
csky                 randconfig-r033-20230709   gcc  
hexagon              randconfig-r041-20230709   clang
hexagon              randconfig-r045-20230709   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230709   gcc  
i386         buildonly-randconfig-r005-20230709   gcc  
i386         buildonly-randconfig-r006-20230709   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230709   gcc  
i386                 randconfig-i002-20230709   gcc  
i386                 randconfig-i003-20230709   gcc  
i386                 randconfig-i004-20230709   gcc  
i386                 randconfig-i005-20230709   gcc  
i386                 randconfig-i006-20230709   gcc  
i386                 randconfig-i011-20230709   clang
i386                 randconfig-i012-20230709   clang
i386                 randconfig-i013-20230709   clang
i386                 randconfig-i014-20230709   clang
i386                 randconfig-i015-20230709   clang
i386                 randconfig-i016-20230709   clang
i386                 randconfig-r001-20230709   gcc  
i386                 randconfig-r005-20230709   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze           randconfig-r003-20230709   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                        maltaup_defconfig   clang
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230709   gcc  
parisc               randconfig-r022-20230709   gcc  
parisc               randconfig-r024-20230709   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc              randconfig-r006-20230709   gcc  
powerpc              randconfig-r021-20230709   clang
powerpc              randconfig-r036-20230709   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230709   clang
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230709   clang
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r035-20230709   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r014-20230709   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r034-20230709   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230709   gcc  
x86_64       buildonly-randconfig-r002-20230709   gcc  
x86_64       buildonly-randconfig-r003-20230709   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230709   clang
x86_64               randconfig-x002-20230709   clang
x86_64               randconfig-x003-20230709   clang
x86_64               randconfig-x004-20230709   clang
x86_64               randconfig-x005-20230709   clang
x86_64               randconfig-x006-20230709   clang
x86_64               randconfig-x011-20230709   gcc  
x86_64               randconfig-x012-20230709   gcc  
x86_64               randconfig-x013-20230709   gcc  
x86_64               randconfig-x014-20230709   gcc  
x86_64               randconfig-x015-20230709   gcc  
x86_64               randconfig-x016-20230709   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r016-20230709   gcc  
xtensa               randconfig-r031-20230709   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
