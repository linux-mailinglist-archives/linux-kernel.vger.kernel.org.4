Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250EA6C2AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjCUG72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCUG7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:59:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BF05B99
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679381959; x=1710917959;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=swgp0dxK7LZEegbvFdiT8PalLPJtwUwWJBBsa8W2AuY=;
  b=j9yIZEQ0Cbi1w5E8mBySyzP3iG8Ih/W1mTUwsLRCDyljT6qVPS43NaEc
   Xa39Z5qVgSsq0vs00ERZC6u1vwncNT9GEbbzT6JWD6xJy6pTFhtbQFwKp
   2BlBVyFSoHEaKh+S6PAD9TlwVia3+wB0E8l1EiGbUnQ6sGvw+HLvRb1MV
   4IDhKerThR7lPW/Ns4uf0bH8z8tGGhM/cRlWeLRpDx6PyrjN3UyDzsJ1g
   TZXRoXXhEIPiwXSecHU8dpBh6yyHhL7Lsx8KuKjBySspdNmuPn9AzDcWM
   e4ZUtjuGrL9qMaWZwqd3pMBVWiH9in9HnVDAu3tQQL5Uho+8ZZkqbH3NK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="340408905"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="340408905"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 23:59:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="681393148"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="681393148"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Mar 2023 23:59:17 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peVxl-000BhD-0h;
        Tue, 21 Mar 2023 06:59:17 +0000
Date:   Tue, 21 Mar 2023 14:58:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.03.18a] BUILD SUCCESS
 34cb1b37bdd59b117a8011a25ae56c52ef0137f5
Message-ID: <641955a4.oSI6T6yZSzqORmM2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.03.18a
branch HEAD: 34cb1b37bdd59b117a8011a25ae56c52ef0137f5  squash! srcu: Begin offloading srcu_struct fields to srcu_update

elapsed time: 745m

configs tested: 117
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230320   gcc  
alpha        buildonly-randconfig-r002-20230320   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230320   gcc  
alpha                randconfig-r031-20230319   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230319   gcc  
arc                  randconfig-r012-20230319   gcc  
arc                  randconfig-r016-20230319   gcc  
arc                  randconfig-r043-20230320   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230320   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r021-20230319   clang
arm64                randconfig-r025-20230320   gcc  
arm64                randconfig-r026-20230319   clang
arm64                randconfig-r032-20230319   gcc  
csky         buildonly-randconfig-r006-20230320   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230319   gcc  
hexagon              randconfig-r041-20230320   clang
hexagon              randconfig-r045-20230320   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r003-20230320   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230320   clang
i386                 randconfig-a002-20230320   clang
i386                 randconfig-a003-20230320   clang
i386                 randconfig-a004-20230320   clang
i386                 randconfig-a005-20230320   clang
i386                 randconfig-a006-20230320   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r011-20230320   gcc  
ia64                 randconfig-r026-20230320   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230319   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230319   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r034-20230319   gcc  
microblaze   buildonly-randconfig-r004-20230319   gcc  
microblaze           randconfig-r033-20230319   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230320   gcc  
nios2                randconfig-r014-20230319   gcc  
openrisc             randconfig-r016-20230320   gcc  
parisc       buildonly-randconfig-r006-20230319   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230319   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230319   clang
powerpc              randconfig-r013-20230320   gcc  
powerpc              randconfig-r015-20230320   gcc  
powerpc              randconfig-r023-20230319   clang
powerpc              randconfig-r036-20230319   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230319   gcc  
riscv                randconfig-r004-20230319   gcc  
riscv                randconfig-r035-20230319   gcc  
riscv                randconfig-r042-20230320   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230319   clang
s390                                defconfig   gcc  
s390                 randconfig-r044-20230320   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r013-20230319   gcc  
sh                   randconfig-r014-20230320   gcc  
sh                   randconfig-r024-20230320   gcc  
sh                   randconfig-r025-20230319   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r015-20230319   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230320   clang
x86_64               randconfig-a002-20230320   clang
x86_64               randconfig-a003-20230320   clang
x86_64               randconfig-a004-20230320   clang
x86_64               randconfig-a005-20230320   clang
x86_64               randconfig-a006-20230320   clang
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-r022-20230320   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230320   gcc  
xtensa               randconfig-r003-20230319   gcc  
xtensa               randconfig-r022-20230319   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
