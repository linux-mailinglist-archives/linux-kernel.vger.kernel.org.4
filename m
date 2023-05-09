Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622866FBF97
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbjEIGwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbjEIGwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:52:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDB649F5
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683615128; x=1715151128;
  h=date:from:to:cc:subject:message-id;
  bh=ef8ak7wcEUiYd8UkzhhxPf0Dd1ZZkWcoA++l+sXlf70=;
  b=geiAQwsbRxHPWkTW4FJ3UH7Vjy0tpN+JSXhWFWXGUWvL7jrAaidPrAXB
   5yb6vPbbFqqGiTQMeo5RrnL8V8q4Hq+RAztwh1I0tBaFOmF3p8UzEM3aD
   u7fAy8hhwWGbfQyJv3hef0uyZgaq/Myeb0IWTyNs00RYAlUqX7WdUOPcr
   Z9dsOBLLlaRHq3wj6NBR5KmibVTQXlhigElKAsrxtop76r2TAzZVEE6QA
   Xx1iP+1cBhBcanG+omqMXqFr41XxElQqdo48mq9XyeGwVbPmJcHorxPo0
   lS23R2ulbZoqrJL+fI7ckBEwwn9xPWQwBMfgeBEaxyvl6YG6Hccsrpssm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="377918744"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="377918744"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 23:52:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="822949515"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="822949515"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 May 2023 23:52:06 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwHCg-0001rv-0e;
        Tue, 09 May 2023 06:52:06 +0000
Date:   Tue, 09 May 2023 14:51:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 cb5d28c01b2d56700e1656cd6c3742b40e840bf9
Message-ID: <20230509065157.YHMha%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: cb5d28c01b2d56700e1656cd6c3742b40e840bf9  Documentation/process: Explain when tip branches get merged into mainline

elapsed time: 846m

configs tested: 126
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230508   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230508   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230508   gcc  
arc                  randconfig-r016-20230508   gcc  
arc                  randconfig-r023-20230508   gcc  
arc                  randconfig-r025-20230508   gcc  
arc                  randconfig-r043-20230507   gcc  
arc                  randconfig-r043-20230508   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230507   clang
arm                  randconfig-r003-20230507   clang
arm                  randconfig-r012-20230508   clang
arm                  randconfig-r046-20230507   gcc  
arm                  randconfig-r046-20230508   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230508   clang
arm64                randconfig-r012-20230507   clang
csky         buildonly-randconfig-r001-20230507   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230507   gcc  
csky                 randconfig-r022-20230507   gcc  
csky                 randconfig-r031-20230507   gcc  
hexagon      buildonly-randconfig-r003-20230507   clang
hexagon      buildonly-randconfig-r005-20230507   clang
hexagon              randconfig-r034-20230507   clang
hexagon              randconfig-r041-20230507   clang
hexagon              randconfig-r041-20230508   clang
hexagon              randconfig-r045-20230507   clang
hexagon              randconfig-r045-20230508   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230508   clang
i386                 randconfig-a002-20230508   clang
i386                 randconfig-a003-20230508   clang
i386                 randconfig-a004-20230508   clang
i386                 randconfig-a005-20230508   clang
i386                 randconfig-a006-20230508   clang
i386                 randconfig-a011-20230508   gcc  
i386                 randconfig-a012-20230508   gcc  
i386                 randconfig-a013-20230508   gcc  
i386                 randconfig-a014-20230508   gcc  
i386                 randconfig-a015-20230508   gcc  
i386                 randconfig-a016-20230508   gcc  
i386                 randconfig-r014-20230508   gcc  
i386                 randconfig-r024-20230508   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230508   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r035-20230507   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r036-20230507   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r033-20230507   gcc  
microblaze   buildonly-randconfig-r003-20230508   gcc  
microblaze           randconfig-r021-20230507   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2        buildonly-randconfig-r004-20230507   gcc  
nios2                               defconfig   gcc  
openrisc     buildonly-randconfig-r005-20230508   gcc  
openrisc             randconfig-r025-20230507   gcc  
parisc       buildonly-randconfig-r001-20230508   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r015-20230507   gcc  
parisc               randconfig-r022-20230508   gcc  
parisc               randconfig-r026-20230508   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r006-20230507   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230507   clang
riscv                randconfig-r042-20230508   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230507   clang
s390                                defconfig   gcc  
s390                 randconfig-r001-20230508   clang
s390                 randconfig-r006-20230508   clang
s390                 randconfig-r014-20230507   clang
s390                 randconfig-r016-20230507   clang
s390                 randconfig-r023-20230507   clang
s390                 randconfig-r024-20230507   clang
s390                 randconfig-r032-20230507   gcc  
s390                 randconfig-r044-20230507   clang
s390                 randconfig-r044-20230508   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230508   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230508   gcc  
sparc64              randconfig-r001-20230507   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230508   clang
x86_64               randconfig-a002-20230508   clang
x86_64               randconfig-a003-20230508   clang
x86_64               randconfig-a004-20230508   clang
x86_64               randconfig-a005-20230508   clang
x86_64               randconfig-a006-20230508   clang
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r011-20230508   gcc  
xtensa               randconfig-r026-20230507   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
