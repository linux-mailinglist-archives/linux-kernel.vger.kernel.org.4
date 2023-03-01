Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC0C6A76DF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 23:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCAWhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 17:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCAWhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 17:37:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBAF53296
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 14:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677710259; x=1709246259;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HL7HNb7gy7GdifS7kpj2eZMAcKm1rR7YFJsNeV0Q94A=;
  b=fdiIPDGoiQlq3lKtr0Bz3M1MoLz18C+ACm6oEK95jhJZnsBBbGEo6FrA
   vrrOp8g4ov9Nr3DaurcPPM5XXthC3kkVsCwZa/WH6zwd+qCygSiID4CtV
   E6eTm2lps64EQsnQBSz99F+0IqVC5u6eE878EFPnEEWiWMo7WB8ToqrWv
   cGK0La0vCMDSP3M3n6A3kI1wJs6wK70LLwsLRkp4+wxkIjhCC6kAJ83QC
   SgtacPitqAI+pQWWPjSKwQRQvyN22JUDcqOVJTVdx97Xmg7BpNJn6AyGR
   o+oRLwP5o9Qo3G53wMc7MxBCtlx4NN26kg6UifIJYGueGVSB+v18EkeOP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="332020172"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="332020172"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 14:37:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="798584345"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="798584345"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2023 14:37:37 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXV4q-0006TH-2x;
        Wed, 01 Mar 2023 22:37:36 +0000
Date:   Thu, 02 Mar 2023 06:37:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 dd093fb08e8f8a958fec4eef36f9f09eac047f60
Message-ID: <63ffd38d.IXnibGcMoKmgZZF+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: dd093fb08e8f8a958fec4eef36f9f09eac047f60  virt/sev-guest: Return -EIO if certificate buffer is not large enough

elapsed time: 758m

configs tested: 129
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r014-20230226   gcc  
arc                  randconfig-r016-20230226   gcc  
arc                  randconfig-r022-20230226   gcc  
arc                  randconfig-r043-20230226   gcc  
arc                  randconfig-r043-20230227   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230228   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r011-20230226   gcc  
arm                  randconfig-r046-20230226   gcc  
arm                  randconfig-r046-20230227   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230227   clang
csky                                defconfig   gcc  
csky                 randconfig-r021-20230226   gcc  
csky                 randconfig-r021-20230227   gcc  
hexagon              randconfig-r002-20230226   clang
hexagon              randconfig-r026-20230226   clang
hexagon              randconfig-r041-20230226   clang
hexagon              randconfig-r041-20230227   clang
hexagon              randconfig-r045-20230226   clang
hexagon              randconfig-r045-20230227   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230227   clang
i386                 randconfig-a002-20230227   clang
i386                 randconfig-a003-20230227   clang
i386                 randconfig-a004-20230227   clang
i386                 randconfig-a005-20230227   clang
i386                 randconfig-a006-20230227   clang
i386                 randconfig-a011-20230227   gcc  
i386                 randconfig-a012-20230227   gcc  
i386                 randconfig-a013-20230227   gcc  
i386                 randconfig-a014-20230227   gcc  
i386                 randconfig-a015-20230227   gcc  
i386                 randconfig-a016-20230227   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230226   gcc  
ia64                 randconfig-r023-20230226   gcc  
ia64                 randconfig-r024-20230226   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230226   gcc  
loongarch            randconfig-r012-20230227   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230227   gcc  
microblaze   buildonly-randconfig-r001-20230227   gcc  
microblaze   buildonly-randconfig-r006-20230228   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r005-20230226   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r013-20230226   gcc  
parisc       buildonly-randconfig-r004-20230226   gcc  
parisc       buildonly-randconfig-r006-20230227   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230227   gcc  
parisc               randconfig-r035-20230301   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230226   clang
powerpc      buildonly-randconfig-r003-20230228   clang
powerpc      buildonly-randconfig-r006-20230226   clang
powerpc              randconfig-r015-20230227   gcc  
powerpc              randconfig-r025-20230227   gcc  
powerpc              randconfig-r034-20230301   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230226   clang
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230227   clang
riscv                randconfig-r006-20230226   gcc  
riscv                randconfig-r016-20230227   gcc  
riscv                randconfig-r042-20230226   clang
riscv                randconfig-r042-20230227   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230226   gcc  
s390                 randconfig-r044-20230226   clang
s390                 randconfig-r044-20230227   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230228   gcc  
sh                   randconfig-r025-20230226   gcc  
sh                   randconfig-r026-20230227   gcc  
sparc        buildonly-randconfig-r005-20230227   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230227   gcc  
sparc                randconfig-r024-20230227   gcc  
sparc                randconfig-r033-20230301   gcc  
sparc64      buildonly-randconfig-r005-20230228   gcc  
sparc64              randconfig-r003-20230226   gcc  
sparc64              randconfig-r005-20230226   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230227   clang
x86_64               randconfig-a002-20230227   clang
x86_64               randconfig-a003-20230227   clang
x86_64               randconfig-a004-20230227   clang
x86_64               randconfig-a005-20230227   clang
x86_64               randconfig-a006-20230227   clang
x86_64               randconfig-a011-20230227   gcc  
x86_64               randconfig-a012-20230227   gcc  
x86_64               randconfig-a013-20230227   gcc  
x86_64               randconfig-a014-20230227   gcc  
x86_64               randconfig-a015-20230227   gcc  
x86_64               randconfig-a016-20230227   gcc  
x86_64               randconfig-r023-20230227   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230227   gcc  
xtensa               randconfig-r004-20230227   gcc  
xtensa               randconfig-r011-20230227   gcc  
xtensa               randconfig-r013-20230227   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
