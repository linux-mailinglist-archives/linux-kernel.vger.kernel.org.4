Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A14A733B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 23:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjFPVlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 17:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjFPVlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 17:41:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1488030F7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686951663; x=1718487663;
  h=date:from:to:cc:subject:message-id;
  bh=h1KtKKQwxWh1hEsaB3VaddkcsufyI7eoM65/MQPckzk=;
  b=V02lzqS0rFabmO7MW7l7/Z/KXzRZygeDfjWdBHBA+1m5D4dJXvnrtHOj
   bhLKDQZgy6eahm9dTAuAQw5iKLByTRMwWnMg5ETVV8ul0YzB9B77n6584
   SOJp6MAG6Zb3naeqG8dbM2PiBDqjoiGVwSrWMq8jSceFLecjWKoFMSMIM
   q2DuRnmpRgtpMDrtgczxgWlK/hidu+iXZ+gw0c9aFOlgQXE4wn/kYFdqG
   5v7mGfBZFcsGYmYiVL+ra+jcttjqHI+onDOtgkky89OCEQmsneSdDLYs/
   K9wI7m+QLQLUKp7+4FvZGSRkhBBvbjAqMxQERoipepSc2q9IVQaQlu0oe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="361853398"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="361853398"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:40:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="716179325"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="716179325"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2023 14:40:54 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qAHBe-0001pw-10;
        Fri, 16 Jun 2023 21:40:54 +0000
Date:   Sat, 17 Jun 2023 05:40:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mtrr] BUILD SUCCESS
 30d65d1b19850c9bc8c17dba8ebe9be5e0c17054
Message-ID: <202306170551.hWYeNPlq-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mtrr
branch HEAD: 30d65d1b19850c9bc8c17dba8ebe9be5e0c17054  x86/xen: Set default memory type for PV guests to WB

elapsed time: 721m

configs tested: 127
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230615   gcc  
alpha                randconfig-r034-20230615   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r022-20230616   gcc  
arc                  randconfig-r031-20230615   gcc  
arc                  randconfig-r036-20230616   gcc  
arc                  randconfig-r043-20230615   gcc  
arc                  randconfig-r043-20230616   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r006-20230616   gcc  
arm                  randconfig-r021-20230616   clang
arm                  randconfig-r025-20230616   clang
arm                  randconfig-r033-20230616   gcc  
arm                  randconfig-r046-20230615   gcc  
arm                  randconfig-r046-20230616   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230615   gcc  
hexagon              randconfig-r025-20230615   clang
hexagon              randconfig-r041-20230615   clang
hexagon              randconfig-r041-20230616   clang
hexagon              randconfig-r045-20230615   clang
hexagon              randconfig-r045-20230616   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r005-20230614   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230616   clang
i386                 randconfig-i002-20230616   clang
i386                 randconfig-i003-20230616   clang
i386                 randconfig-i004-20230616   clang
i386                 randconfig-i005-20230616   clang
i386                 randconfig-i006-20230616   clang
i386                 randconfig-i011-20230616   gcc  
i386                 randconfig-i012-20230616   gcc  
i386                 randconfig-i013-20230616   gcc  
i386                 randconfig-i014-20230616   gcc  
i386                 randconfig-i015-20230616   gcc  
i386                 randconfig-i016-20230616   gcc  
i386                 randconfig-r005-20230616   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230616   gcc  
loongarch            randconfig-r015-20230614   gcc  
loongarch            randconfig-r024-20230615   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r023-20230615   gcc  
microblaze   buildonly-randconfig-r002-20230614   gcc  
microblaze           randconfig-r005-20230615   gcc  
microblaze           randconfig-r026-20230616   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2        buildonly-randconfig-r003-20230614   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r032-20230616   gcc  
nios2                randconfig-r034-20230616   gcc  
openrisc             randconfig-r002-20230616   gcc  
openrisc             randconfig-r012-20230616   gcc  
openrisc             randconfig-r026-20230615   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r001-20230614   gcc  
parisc       buildonly-randconfig-r004-20230614   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r011-20230614   gcc  
powerpc              randconfig-r021-20230615   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230616   gcc  
riscv                randconfig-r014-20230614   gcc  
riscv                randconfig-r016-20230616   gcc  
riscv                randconfig-r042-20230615   clang
riscv                randconfig-r042-20230616   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230615   gcc  
s390                 randconfig-r012-20230614   gcc  
s390                 randconfig-r044-20230615   clang
s390                 randconfig-r044-20230616   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230614   gcc  
sh                   randconfig-r004-20230616   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230616   gcc  
sparc                randconfig-r031-20230616   gcc  
sparc64              randconfig-r006-20230615   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r035-20230616   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230616   clang
x86_64               randconfig-a002-20230616   clang
x86_64               randconfig-a003-20230616   clang
x86_64               randconfig-a004-20230616   clang
x86_64               randconfig-a005-20230616   clang
x86_64               randconfig-a006-20230616   clang
x86_64               randconfig-a011-20230616   gcc  
x86_64               randconfig-a012-20230616   gcc  
x86_64               randconfig-a013-20230616   gcc  
x86_64               randconfig-a014-20230616   gcc  
x86_64               randconfig-a015-20230616   gcc  
x86_64               randconfig-a016-20230616   gcc  
x86_64               randconfig-r024-20230616   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r014-20230616   gcc  
xtensa               randconfig-r016-20230614   gcc  
xtensa               randconfig-r022-20230615   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
