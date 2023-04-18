Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7456E57F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 06:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjDREI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 00:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDREIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 00:08:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8433C3B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681790901; x=1713326901;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=c/1HY1O6cEPwwb8wwUsN1UHl5cKvuLVHJktW5Unm7es=;
  b=LAFytAoJtvJsG/2GX9kZyKSHhEo/PwaQUrFey/oDU27wdzGbFCOpR8OE
   B//gKtJ2+AmnlZSbDDmM0WFldUkrIP+s++o06HiSNsz7q9rq923HNJWhw
   3IlYvkXytawunRo0HzXIJMJVTpTFmv49GShJwBEHp2UfH9I4nwDuxE5Z+
   TnXuHu3fGflF/2KlETbDrMULKoNLVNhiSX5NJKQ3PRJvD5jEOVRhtIQKc
   G2SMgDTNoO6QEHWvBjgVhrMixsfBPZiez7vl1w903tSKXfIXk72ZjwW3p
   FOGCZv18q5f/zU3IlxuZxpEcDCyES4R7oSkRckO6rr+gbbm7yQpqQIbXC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="324687993"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="324687993"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 21:08:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723483537"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="723483537"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 17 Apr 2023 21:08:20 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pocdf-000cxT-0P;
        Tue, 18 Apr 2023 04:08:19 +0000
Date:   Tue, 18 Apr 2023 12:07:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 07cc5639f14dcc3763a926dbe7cc38ac2694de0c
Message-ID: <643e1791.L3gQkPRt3J25NWcF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 07cc5639f14dcc3763a926dbe7cc38ac2694de0c  x86/microcode/AMD: Document which patches are not released for late loading

elapsed time: 853m

configs tested: 131
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230417   gcc  
alpha                randconfig-r004-20230417   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230417   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230416   gcc  
arc                  randconfig-r043-20230417   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r013-20230417   gcc  
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230417   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230417   gcc  
arm64        buildonly-randconfig-r004-20230416   clang
arm64                               defconfig   gcc  
arm64                randconfig-r032-20230416   clang
arm64                randconfig-r036-20230417   gcc  
csky         buildonly-randconfig-r004-20230417   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230417   gcc  
csky                 randconfig-r012-20230416   gcc  
csky                 randconfig-r023-20230417   gcc  
csky                 randconfig-r024-20230417   gcc  
hexagon              randconfig-r003-20230417   clang
hexagon              randconfig-r022-20230416   clang
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
ia64                 randconfig-r031-20230416   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230416   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230416   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230416   gcc  
m68k                 randconfig-r004-20230416   gcc  
m68k                 randconfig-r025-20230417   gcc  
m68k                 randconfig-r035-20230416   gcc  
microblaze           randconfig-r011-20230417   gcc  
microblaze           randconfig-r026-20230416   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r001-20230416   gcc  
nios2        buildonly-randconfig-r001-20230416   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230417   gcc  
openrisc     buildonly-randconfig-r005-20230417   gcc  
openrisc             randconfig-r006-20230416   gcc  
openrisc             randconfig-r012-20230417   gcc  
openrisc             randconfig-r015-20230417   gcc  
openrisc             randconfig-r033-20230417   gcc  
openrisc             randconfig-r034-20230416   gcc  
parisc       buildonly-randconfig-r002-20230416   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230416   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230416   gcc  
powerpc              randconfig-r002-20230417   gcc  
powerpc              randconfig-r032-20230417   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230417   clang
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230416   gcc  
riscv                randconfig-r024-20230416   gcc  
riscv                randconfig-r042-20230416   gcc  
riscv                randconfig-r042-20230417   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230417   clang
s390                                defconfig   gcc  
s390                 randconfig-r005-20230416   clang
s390                 randconfig-r015-20230416   gcc  
s390                 randconfig-r044-20230416   gcc  
s390                 randconfig-r044-20230417   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230417   gcc  
sh                   randconfig-r014-20230416   gcc  
sh                   randconfig-r033-20230416   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r031-20230417   gcc  
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
x86_64               randconfig-r035-20230417   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r021-20230417   gcc  
xtensa               randconfig-r022-20230417   gcc  
xtensa               randconfig-r026-20230417   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
