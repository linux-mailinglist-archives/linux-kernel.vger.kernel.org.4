Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709676A7785
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCAXEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCAXEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:04:42 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE762E0FC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677711880; x=1709247880;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RXRvHMTP84Qmc5NKf3upG1VX+/4LXtdcY3XZPXxPD9Y=;
  b=dfqycTX3tC7cKQBfTE5F0RMrucZ2W2ytiZ+xoEmW7R4ijd5AWWATAZk3
   CCdacDXqxQMI/+0CbDjMVKxZHRKQLH4f6heUfQkND4S1nK/LJK+NnBQP/
   REcgnFgF3irc5pJoNIIJtwXtnRoSAkM/aXysms2CShBt0aJ9uhkLMSPzP
   PAVR5uCjdCGhqWM1pE4tNSY6XG4dUXia+Mg1vhCEGv5H8Ssh8aKw954dW
   c8wSsbH44S93FVk8HUjiPW0qtYmgrqeDrYJ+S8RuuY6+s0S/0ggPAXVVT
   vYlJ3YYvYsS9OZEE0g98XJcMP+qwtU+/N/Me6YnGpnrHUjyVNXRJDDXsM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="362131338"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="362131338"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:04:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="705025257"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="705025257"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Mar 2023 15:04:38 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXVUz-0006UC-1n;
        Wed, 01 Mar 2023 23:04:37 +0000
Date:   Thu, 02 Mar 2023 07:03:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 239b842d8c45ac8e0794189d2676eea409eab497
Message-ID: <63ffd9d0.ngHz7H4GTiXxvAbd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 239b842d8c45ac8e0794189d2676eea409eab497  Merge branch into tip/master: 'x86/urgent'

elapsed time: 725m

configs tested: 120
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230227   gcc  
alpha        buildonly-randconfig-r006-20230227   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230226   gcc  
arc                  randconfig-r011-20230227   gcc  
arc                  randconfig-r016-20230227   gcc  
arc                  randconfig-r043-20230226   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r022-20230227   clang
arm                  randconfig-r046-20230226   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r006-20230226   clang
hexagon              randconfig-r014-20230226   clang
hexagon              randconfig-r041-20230226   clang
hexagon              randconfig-r045-20230226   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r002-20230227   clang
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
ia64                 randconfig-r002-20230227   gcc  
ia64                 randconfig-r005-20230226   gcc  
ia64                 randconfig-r016-20230226   gcc  
ia64                 randconfig-r021-20230227   gcc  
ia64                 randconfig-r026-20230226   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230226   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230226   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230227   gcc  
m68k                 randconfig-r005-20230227   gcc  
m68k                 randconfig-r025-20230226   gcc  
microblaze           randconfig-r003-20230226   gcc  
microblaze           randconfig-r006-20230227   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230226   clang
mips                 randconfig-r024-20230227   clang
mips                 randconfig-r025-20230227   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230226   gcc  
openrisc     buildonly-randconfig-r003-20230226   gcc  
parisc       buildonly-randconfig-r003-20230227   gcc  
parisc       buildonly-randconfig-r004-20230226   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r035-20230301   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r001-20230226   gcc  
powerpc              randconfig-r022-20230226   clang
powerpc              randconfig-r034-20230301   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230226   gcc  
riscv                randconfig-r024-20230226   clang
riscv                randconfig-r042-20230226   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230227   clang
s390                 randconfig-r012-20230226   clang
s390                 randconfig-r012-20230227   gcc  
s390                 randconfig-r023-20230226   clang
s390                 randconfig-r026-20230227   gcc  
s390                 randconfig-r044-20230226   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r013-20230226   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r033-20230301   gcc  
sparc64              randconfig-r004-20230227   gcc  
sparc64              randconfig-r013-20230227   gcc  
sparc64              randconfig-r015-20230226   gcc  
sparc64              randconfig-r021-20230226   gcc  
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
xtensa               randconfig-r014-20230227   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
