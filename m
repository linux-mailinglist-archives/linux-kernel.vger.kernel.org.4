Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554C272DA0C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbjFMGnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjFMGnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:43:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550FFE6B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 23:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686638621; x=1718174621;
  h=date:from:to:cc:subject:message-id;
  bh=Ic3iWeQmivw86fUJmlScgYRneoFiBgPTcgGfUBc56Hk=;
  b=aj9cSWcA+9pIxVpsxe3ZsginvXEkEVmvXy6ybtaobmbvPpcSpiiSFx3m
   quUhWIAcZn8/0q3VQrGyI1YVJkpYn7sdw84zJDBXWsArw7YMdedXSIf2X
   mYk8gxThNEt6jVrTwCILl+F5X15qP9ABddTZ4w2g26mWdDSJuPxb3nI9J
   H9Ew2pI2OZiuQV1vRUxvEuNd7/Ravp7t1KcfUyNkqQc6w0Kj9sMltLjrF
   ZUwl9bTGCY7WYNTQKMEsLoMn6qKscbE9PDzR6F6qD3HFtd9p1ERZA5C0D
   9Ikes10xaTQOn746mQD7CIWDMdynEWviIiVSIrajXYcrib1I1zIkBgO5V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="355743230"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="355743230"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 23:43:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="958288880"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="958288880"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jun 2023 23:43:40 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8xkh-00014e-22;
        Tue, 13 Jun 2023 06:43:39 +0000
Date:   Tue, 13 Jun 2023 14:42:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7728822622f78a493273454af746309f852c4c0e
Message-ID: <202306131453.PRwEKpTR-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 7728822622f78a493273454af746309f852c4c0e  Merge x86/microcode into tip/master

elapsed time: 976m

configs tested: 126
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230612   gcc  
alpha                randconfig-r024-20230612   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230612   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r012-20230612   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230612   gcc  
arm                  randconfig-r026-20230612   clang
arm                  randconfig-r046-20230612   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230612   clang
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230612   clang
arm64                randconfig-r011-20230612   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230612   gcc  
csky                 randconfig-r015-20230612   gcc  
csky                 randconfig-r034-20230612   gcc  
csky                 randconfig-r036-20230612   gcc  
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r045-20230612   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230612   clang
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
i386                 randconfig-r031-20230612   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r023-20230612   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k         buildonly-randconfig-r004-20230612   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r021-20230612   gcc  
m68k                 randconfig-r032-20230612   gcc  
m68k                 randconfig-r035-20230612   gcc  
m68k                 randconfig-r036-20230612   gcc  
microblaze   buildonly-randconfig-r002-20230612   gcc  
microblaze           randconfig-r004-20230612   gcc  
microblaze           randconfig-r022-20230612   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r003-20230612   gcc  
mips                 randconfig-r031-20230612   gcc  
nios2        buildonly-randconfig-r004-20230612   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r001-20230612   gcc  
openrisc             randconfig-r006-20230612   gcc  
openrisc             randconfig-r014-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r001-20230612   gcc  
parisc       buildonly-randconfig-r003-20230612   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r033-20230612   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230612   gcc  
powerpc              randconfig-r032-20230612   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r005-20230612   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230612   clang
riscv                randconfig-r006-20230612   clang
riscv                randconfig-r034-20230612   clang
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230612   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r025-20230612   gcc  
sparc                randconfig-r033-20230612   gcc  
sparc64              randconfig-r004-20230612   gcc  
sparc64              randconfig-r035-20230612   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230612   clang
x86_64               randconfig-a001-20230613   gcc  
x86_64               randconfig-a002-20230612   clang
x86_64               randconfig-a002-20230613   gcc  
x86_64               randconfig-a003-20230612   clang
x86_64               randconfig-a003-20230613   gcc  
x86_64               randconfig-a004-20230612   clang
x86_64               randconfig-a004-20230613   gcc  
x86_64               randconfig-a005-20230612   clang
x86_64               randconfig-a005-20230613   gcc  
x86_64               randconfig-a006-20230612   clang
x86_64               randconfig-a006-20230613   gcc  
x86_64               randconfig-a011-20230612   gcc  
x86_64               randconfig-a012-20230612   gcc  
x86_64               randconfig-a013-20230612   gcc  
x86_64               randconfig-a014-20230612   gcc  
x86_64               randconfig-a015-20230612   gcc  
x86_64               randconfig-a016-20230612   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r013-20230612   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
