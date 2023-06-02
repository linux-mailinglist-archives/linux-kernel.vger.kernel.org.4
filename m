Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738FC71FA2F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjFBGhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjFBGhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:37:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E993A19B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685687836; x=1717223836;
  h=date:from:to:cc:subject:message-id;
  bh=0ngopru3qi2B7ssBZMgeeJYf1kFuNNhzY646plCK4Hg=;
  b=DKUcfYNRHN0rk8P5Q7YGuAYr3OGiii7PTca7xvb8P6/MZ92Dl+S+mqrq
   sLN9XkpucjBFnA2aW9iY4yIpS2zzm3Nt9Q8alxGb7sbWt3MvW3RhGO03t
   t2utt7kLzjiuPOcS2anf4i7XzKNROxbK8+Vg1iljIUN4t+3NknIapuawM
   YjT6uPwWVtG5AuPVYuo7GxqWm8xQRFL1aw1CgRMef9XRHJylwWpgY0Vhm
   GLYA15feNfRVJcb7h6hrI3+EsBvNlr3sXa0SxC1bWvpd5cwslM1f+cZs3
   0Kw99+hhMsOoWP2lDgG2JGgB8CFVfYMtEUdIwkRupT+xmGfXBwT0g7rCd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="354640417"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="354640417"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 23:37:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="831857896"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="831857896"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Jun 2023 23:37:15 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4yPS-0000Aq-2c;
        Fri, 02 Jun 2023 06:37:14 +0000
Date:   Fri, 02 Jun 2023 14:36:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230601] BUILD SUCCESS
 9660c8acc7a78dbad1faf1af23b381986022221f
Message-ID: <20230602063636.YbkJ3%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230601
branch HEAD: 9660c8acc7a78dbad1faf1af23b381986022221f  firewire: Replace zero-length array with flexible-array member

elapsed time: 722m

configs tested: 113
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230531   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                                 defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                             mxs_defconfig   clang
arm                        neponset_defconfig   clang
arm                  randconfig-r001-20230531   clang
arm                  randconfig-r046-20230531   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r036-20230531   gcc  
hexagon      buildonly-randconfig-r001-20230531   clang
hexagon              randconfig-r031-20230531   clang
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230531   gcc  
i386                 randconfig-i002-20230531   gcc  
i386                 randconfig-i003-20230531   gcc  
i386                 randconfig-i004-20230531   gcc  
i386                 randconfig-i005-20230531   gcc  
i386                 randconfig-i006-20230531   gcc  
i386                 randconfig-i051-20230531   gcc  
i386                 randconfig-i052-20230531   gcc  
i386                 randconfig-i053-20230531   gcc  
i386                 randconfig-i054-20230531   gcc  
i386                 randconfig-i055-20230531   gcc  
i386                 randconfig-i056-20230531   gcc  
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i066-20230531   gcc  
i386                 randconfig-r004-20230531   gcc  
ia64                            zx1_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r025-20230531   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230601   gcc  
microblaze           randconfig-r003-20230531   gcc  
microblaze           randconfig-r035-20230531   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230531   clang
mips                           ci20_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230601   gcc  
openrisc     buildonly-randconfig-r003-20230531   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230531   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc              randconfig-r014-20230601   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230531   gcc  
riscv                randconfig-r021-20230531   clang
riscv                randconfig-r042-20230531   clang
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r033-20230531   gcc  
s390                 randconfig-r044-20230531   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230531   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r016-20230601   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230531   gcc  
sparc64      buildonly-randconfig-r002-20230531   gcc  
sparc64      buildonly-randconfig-r004-20230531   gcc  
sparc64              randconfig-r023-20230531   gcc  
sparc64              randconfig-r032-20230531   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230531   gcc  
x86_64               randconfig-a002-20230531   gcc  
x86_64               randconfig-a003-20230531   gcc  
x86_64               randconfig-a004-20230531   gcc  
x86_64               randconfig-a005-20230531   gcc  
x86_64               randconfig-a006-20230531   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa               randconfig-r034-20230531   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
