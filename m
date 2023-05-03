Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA236F5F7D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjECT5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjECT5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:57:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BD883ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683143851; x=1714679851;
  h=date:from:to:cc:subject:message-id;
  bh=VgzQqXga/U4nCdvQQhyruZuxmX+U1r1BIrNIi2GiOn4=;
  b=Jkj/q964JQr1ybSrdcteREC/1jdqEJMFsBbNV2yXK8dLx0wFB+zP0yjG
   imq486oaHgEStsDCw8l2wsjxah+3j9cWVg+LxroEv6B25YjK6bfR6B0eo
   1QYVUPIA9DGbxIGCk9zgGB58d/aZVw76JdsHktCrwMKwBSvi3PDP5+YTa
   lQIlD+ujStxs2E5vVgw0vCp2hFOlz0uYUUoz3Gmc3O7WizlIpH0vIhgNp
   5Yx96OVYQUJKa6OT7fcX99eN9jM23V5WtXkVkFIWpv7X5aP3ko4RbZbGV
   lTOWbB3MWMrKUJkrsinext1sJmTSy9mRAz4PwkVw2MPhdZQcz+R8MTYhY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="414212828"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="414212828"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 12:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="729485486"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="729485486"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 May 2023 12:57:30 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1puIbR-0002Ee-1M;
        Wed, 03 May 2023 19:57:29 +0000
Date:   Thu, 04 May 2023 03:56:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 da1c4f07aa4dd227a57103fef1215e7cef3f35a9
Message-ID: <20230503195647._91xV%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: da1c4f07aa4dd227a57103fef1215e7cef3f35a9  Merge branch 'x86/shstk'

elapsed time: 725m

configs tested: 127
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230502   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230502   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230502   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230430   gcc  
arc                  randconfig-r004-20230501   gcc  
arc                  randconfig-r015-20230502   gcc  
arc                  randconfig-r022-20230501   gcc  
arc                  randconfig-r043-20230430   gcc  
arc                  randconfig-r043-20230501   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r015-20230430   gcc  
arm                  randconfig-r046-20230430   gcc  
arm                  randconfig-r046-20230501   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230501   gcc  
arm64                randconfig-r016-20230502   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230502   gcc  
hexagon              randconfig-r001-20230501   clang
hexagon              randconfig-r013-20230430   clang
hexagon              randconfig-r014-20230501   clang
hexagon              randconfig-r016-20230501   clang
hexagon              randconfig-r036-20230502   clang
hexagon              randconfig-r041-20230430   clang
hexagon              randconfig-r041-20230501   clang
hexagon              randconfig-r045-20230430   clang
hexagon              randconfig-r045-20230501   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230501   gcc  
i386                 randconfig-a002-20230501   gcc  
i386                 randconfig-a003-20230501   gcc  
i386                 randconfig-a004-20230501   gcc  
i386                 randconfig-a005-20230501   gcc  
i386                 randconfig-a006-20230501   gcc  
i386                 randconfig-a011-20230501   clang
i386                 randconfig-a012-20230501   clang
i386                 randconfig-a013-20230501   clang
i386                 randconfig-a014-20230501   clang
i386                 randconfig-a015-20230501   clang
i386                 randconfig-a016-20230501   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230501   gcc  
loongarch            randconfig-r006-20230430   gcc  
loongarch            randconfig-r015-20230501   gcc  
loongarch            randconfig-r024-20230501   gcc  
loongarch            randconfig-r033-20230502   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230502   gcc  
microblaze           randconfig-r031-20230502   gcc  
microblaze           randconfig-r032-20230502   gcc  
microblaze           randconfig-r035-20230502   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r024-20230430   gcc  
openrisc             randconfig-r003-20230430   gcc  
openrisc             randconfig-r005-20230430   gcc  
openrisc             randconfig-r011-20230430   gcc  
openrisc             randconfig-r034-20230502   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230502   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r013-20230501   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230430   gcc  
riscv                randconfig-r013-20230502   gcc  
riscv                randconfig-r014-20230430   clang
riscv                randconfig-r042-20230430   clang
riscv                randconfig-r042-20230501   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230502   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230430   clang
s390                 randconfig-r044-20230430   clang
s390                 randconfig-r044-20230501   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230502   gcc  
sh                   randconfig-r022-20230430   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r006-20230502   gcc  
sparc64              randconfig-r011-20230501   gcc  
sparc64              randconfig-r012-20230430   gcc  
sparc64              randconfig-r012-20230501   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230501   gcc  
x86_64               randconfig-a002-20230501   gcc  
x86_64               randconfig-a003-20230501   gcc  
x86_64               randconfig-a004-20230501   gcc  
x86_64               randconfig-a005-20230501   gcc  
x86_64               randconfig-a006-20230501   gcc  
x86_64               randconfig-a011-20230501   clang
x86_64               randconfig-a012-20230501   clang
x86_64               randconfig-a013-20230501   clang
x86_64               randconfig-a014-20230501   clang
x86_64               randconfig-a015-20230501   clang
x86_64               randconfig-a016-20230501   clang
x86_64               randconfig-r003-20230501   gcc  
x86_64               randconfig-r006-20230501   gcc  
x86_64               randconfig-r025-20230501   clang
x86_64               randconfig-r026-20230501   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230430   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
