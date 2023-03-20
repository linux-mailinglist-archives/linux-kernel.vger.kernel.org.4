Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC086C2594
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCTXZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCTXZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:25:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB57158A6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679354721; x=1710890721;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WjGAX+Pnfs8sXGzCzJz4J4ShhSzXFwtBHRbjNhjOVbM=;
  b=Ky8/BkQPbfiCsI0Y2FZEnSqI93eCTIzkBzRNSM15EZ3pETfYyprLzDFa
   z8hpSXHriLb5nVS5a1te2ckSzKkFuMrhVfhd660fw5nldPO3FHIGFvpX2
   PFF2qs/Y5uok3NIBvegY3l22j88KHQEjIsKJrBthbDLY5oM2xDZmKcglv
   BUTq+ZzzwzQ3QAdHFPXpoOAOBSwXmgnG0WH07KpIgLdidVYU3esuJX3/2
   fAb40rigcrK+benkFDi107XkZfnagHxdZeWAjFFW7Q1D5AEmNY8GAYrgQ
   5WEAJV+m77WXKtd0YEfoyWanXoCirIMYDED0KHs+ozpU31ih9Sh9NBBC8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="319197812"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="319197812"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 16:25:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="750308379"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="750308379"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Mar 2023 16:25:06 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peOs8-000BOu-2Y;
        Mon, 20 Mar 2023 23:25:00 +0000
Date:   Tue, 21 Mar 2023 07:24:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/urgent] BUILD REGRESSION
 3e2619c4ebba2cab8414c55b131b7a28f628de3b
Message-ID: <6418eb16./q+x8yXlZAZv6aTu%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent
branch HEAD: 3e2619c4ebba2cab8414c55b131b7a28f628de3b  entry: Fix noinstr warning in __enter_from_user_mode()

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303202052.lv1EF1t6-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

include/linux/context_tracking.h:99:19: error: redefinition of '__ct_state'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- alpha-randconfig-r012-20230320
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- arc-allyesconfig
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- arc-defconfig
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- arc-randconfig-r005-20230320
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- arc-randconfig-r022-20230313
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- arc-randconfig-r024-20230312
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- arc-randconfig-r032-20230318
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- arm-allmodconfig
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- arm-allyesconfig
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- arm-defconfig
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- arm-randconfig-r034-20230318
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- arm-randconfig-r046-20230319
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- arm64-allyesconfig
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- arm64-defconfig
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- csky-randconfig-r022-20230312
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- i386-allyesconfig
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- i386-debian-10.3
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- i386-defconfig
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- i386-randconfig-a003
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- i386-randconfig-a005
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- i386-randconfig-a014
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- i386-randconfig-a016
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- ia64-allmodconfig
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state
|-- ia64-defconfig
|   `-- include-linux-context_tracking.h:error:redefinition-of-__ct_state

elapsed time: 720m

configs tested: 128
configs skipped: 7

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230319   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r032-20230319   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230320   gcc  
arc                  randconfig-r022-20230313   gcc  
arc                  randconfig-r024-20230312   gcc  
arc                  randconfig-r043-20230319   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230319   gcc  
arm                  randconfig-r046-20230320   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230320   clang
arm64                randconfig-r023-20230312   gcc  
arm64                randconfig-r036-20230319   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230319   gcc  
csky                 randconfig-r022-20230312   gcc  
csky                 randconfig-r034-20230319   gcc  
hexagon      buildonly-randconfig-r003-20230320   clang
hexagon      buildonly-randconfig-r006-20230319   clang
hexagon              randconfig-r024-20230313   clang
hexagon              randconfig-r026-20230320   clang
hexagon              randconfig-r031-20230319   clang
hexagon              randconfig-r041-20230319   clang
hexagon              randconfig-r041-20230320   clang
hexagon              randconfig-r045-20230319   clang
hexagon              randconfig-r045-20230320   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230319   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230319   gcc  
microblaze           randconfig-r021-20230320   gcc  
microblaze           randconfig-r025-20230312   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230319   clang
mips                 randconfig-r001-20230320   gcc  
mips                 randconfig-r021-20230312   clang
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230319   gcc  
nios2                randconfig-r023-20230313   gcc  
openrisc             randconfig-r001-20230319   gcc  
parisc       buildonly-randconfig-r002-20230320   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230320   gcc  
parisc               randconfig-r035-20230319   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230319   clang
powerpc      buildonly-randconfig-r004-20230320   gcc  
powerpc      buildonly-randconfig-r005-20230320   gcc  
powerpc              randconfig-r016-20230319   clang
powerpc              randconfig-r026-20230312   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230319   gcc  
riscv                randconfig-r042-20230319   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230319   clang
s390                                defconfig   gcc  
s390                 randconfig-r044-20230319   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r021-20230313   gcc  
sh                   randconfig-r022-20230320   gcc  
sh                   randconfig-r033-20230319   gcc  
sparc        buildonly-randconfig-r001-20230319   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230319   gcc  
sparc                randconfig-r012-20230319   gcc  
sparc                randconfig-r015-20230319   gcc  
sparc                randconfig-r023-20230320   gcc  
sparc64              randconfig-r011-20230319   gcc  
sparc64              randconfig-r024-20230320   gcc  
sparc64              randconfig-r025-20230320   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64               randconfig-a011-20230320   gcc  
x86_64               randconfig-a012-20230320   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230320   gcc  
x86_64               randconfig-a014-20230320   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230320   gcc  
x86_64               randconfig-a016-20230320   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-r003-20230320   clang
x86_64               randconfig-r025-20230313   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
