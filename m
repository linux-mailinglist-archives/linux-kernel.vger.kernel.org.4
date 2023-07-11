Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B3D74F92D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjGKUib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGKUi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:38:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5401A11B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689107906; x=1720643906;
  h=date:from:to:cc:subject:message-id;
  bh=oeFHXhyptyY1VLz4t5hwcGia160dyf0AaH6V8pt1fHM=;
  b=ew2odeAPGKs+pR2/KsSFNlhCHDVRgvF9f3/+Uw97f5R//7uBooZIxxD0
   P40K45S0OEX0H28wUQQTxGRvJGoVBeAZHkSoIUo6G0L7WWaencExq76cS
   Yg2Vpmvcu3V7BD+Owx/Y3srQBE/dGH/NCqHutFTidXPg3j1iQcW5xWwur
   Ug4wdM3OkaL0IR/GfFPkGRkz4VaXs8N1eIygq+7FDUuqTjSOPqnq8Ogyz
   pWfj8FG28HMcQ6Q0HQNUzT0bxr8o3aHCwR9Bk90DqiWSx7gOC9PcT82aS
   R5EuXEhC3I1dySeqK6+OswJWyTisY0mNcXGBRwAxL3Pq26uo/4mawGIpL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="368266535"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="368266535"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 13:38:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="967954885"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="967954885"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jul 2023 13:38:20 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJK7n-00056P-1Y;
        Tue, 11 Jul 2023 20:38:19 +0000
Date:   Wed, 12 Jul 2023 04:37:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1a2945f27157825a561be7840023e3664111ab2f
Message-ID: <202307120418.DjUm7ZeF-lkp@intel.com>
User-Agent: s-nail v14.9.24
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
branch HEAD: 1a2945f27157825a561be7840023e3664111ab2f  Merge branch into tip/master: 'x86/urgent'

elapsed time: 724m

configs tested: 126
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230710   gcc  
alpha                randconfig-r005-20230710   gcc  
alpha                randconfig-r021-20230710   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230711   gcc  
arc                  randconfig-r043-20230711   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r001-20230710   clang
arm                  randconfig-r015-20230712   gcc  
arm                  randconfig-r025-20230710   gcc  
arm                  randconfig-r046-20230711   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r015-20230711   gcc  
arm64                randconfig-r034-20230710   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230710   gcc  
hexagon              randconfig-r041-20230711   clang
hexagon              randconfig-r045-20230711   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230711   clang
i386         buildonly-randconfig-r005-20230711   clang
i386         buildonly-randconfig-r006-20230711   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230710   gcc  
i386                 randconfig-i001-20230711   clang
i386                 randconfig-i002-20230710   gcc  
i386                 randconfig-i002-20230711   clang
i386                 randconfig-i003-20230710   gcc  
i386                 randconfig-i003-20230711   clang
i386                 randconfig-i004-20230710   gcc  
i386                 randconfig-i004-20230711   clang
i386                 randconfig-i005-20230710   gcc  
i386                 randconfig-i005-20230711   clang
i386                 randconfig-i006-20230710   gcc  
i386                 randconfig-i006-20230711   clang
i386                 randconfig-i011-20230711   gcc  
i386                 randconfig-i012-20230711   gcc  
i386                 randconfig-i013-20230711   gcc  
i386                 randconfig-i014-20230711   gcc  
i386                 randconfig-i015-20230711   gcc  
i386                 randconfig-i016-20230711   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230712   gcc  
microblaze           randconfig-r026-20230710   gcc  
microblaze           randconfig-r033-20230710   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r014-20230711   clang
mips                 randconfig-r035-20230710   clang
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230712   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230712   gcc  
parisc               randconfig-r024-20230710   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230710   gcc  
riscv                randconfig-r042-20230711   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r032-20230710   gcc  
s390                 randconfig-r036-20230710   gcc  
s390                 randconfig-r044-20230711   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r023-20230710   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230712   gcc  
sparc                randconfig-r016-20230711   gcc  
sparc                randconfig-r031-20230710   gcc  
sparc64              randconfig-r011-20230711   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r016-20230712   gcc  
um                   randconfig-r025-20230711   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230711   clang
x86_64       buildonly-randconfig-r002-20230711   clang
x86_64       buildonly-randconfig-r003-20230711   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230710   clang
x86_64               randconfig-x001-20230711   gcc  
x86_64               randconfig-x002-20230710   clang
x86_64               randconfig-x002-20230711   gcc  
x86_64               randconfig-x003-20230710   clang
x86_64               randconfig-x003-20230711   gcc  
x86_64               randconfig-x004-20230710   clang
x86_64               randconfig-x004-20230711   gcc  
x86_64               randconfig-x005-20230710   clang
x86_64               randconfig-x005-20230711   gcc  
x86_64               randconfig-x006-20230710   clang
x86_64               randconfig-x006-20230711   gcc  
x86_64               randconfig-x011-20230710   gcc  
x86_64               randconfig-x012-20230710   gcc  
x86_64               randconfig-x013-20230710   gcc  
x86_64               randconfig-x014-20230710   gcc  
x86_64               randconfig-x015-20230710   gcc  
x86_64               randconfig-x016-20230710   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r012-20230711   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
