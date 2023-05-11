Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA22E6FEC38
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbjEKHDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbjEKHDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:03:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F475FF2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683788559; x=1715324559;
  h=date:from:to:cc:subject:message-id;
  bh=e5Mh/lYoKaOvT43pxsl0fYug8lFs15qEV6uvCBivOqs=;
  b=UBbYycsZuB+2CmmV5BQGV7QvdJUoujwPTzIif+c+Rgt+a1q3tQS9lzHu
   sTTi1agg1Nz/31LLrckRZ9FLQB71pWmzgdhb4bYMltB7La/kIlc18bUkH
   IKz9wdjLyIyRa4ymPhgwM9H31Wr0gdtMj2zEqoUpOlEYVS8+CT6x6hNTN
   Fp4QscpAeOZ38wHj1cRTZdUr8+NrN6d+SH4t6qokLey3G0u+2ocgLSrTZ
   DJfTsdrQDLPk38+LCKrlDnwYYr6BhOCpdM1Hnf/io7XmWL2myfZmsOiXA
   JQhoXxZeKVLe2qCVwhsbxW+4UzINbPUPCgVrXkPzM3nHzB5HrZmmip0pH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="352622070"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="352622070"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 00:01:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="769209843"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="769209843"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2023 00:01:58 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1px0JJ-0003qM-1W;
        Thu, 11 May 2023 07:01:57 +0000
Date:   Thu, 11 May 2023 15:01:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.05.10a] BUILD SUCCESS
 fc22bfe350057e6860378e15f3bdbd58bfd40350
Message-ID: <20230511070148.FnBdB%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.05.10a
branch HEAD: fc22bfe350057e6860378e15f3bdbd58bfd40350  EXP qspinlock: debugging

elapsed time: 724m

configs tested: 121
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                  randconfig-r003-20230509   gcc  
arc                  randconfig-r023-20230509   gcc  
arc                  randconfig-r025-20230509   gcc  
arc                  randconfig-r032-20230509   gcc  
arc                  randconfig-r034-20230509   gcc  
arc                  randconfig-r043-20230509   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230509   gcc  
arm                       spear13xx_defconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230511   clang
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r036-20230509   gcc  
hexagon              randconfig-r004-20230509   clang
hexagon              randconfig-r041-20230509   clang
hexagon              randconfig-r045-20230509   clang
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
ia64                 randconfig-r006-20230509   gcc  
ia64                 randconfig-r014-20230509   gcc  
ia64                 randconfig-r026-20230509   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230511   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r014-20230509   gcc  
loongarch            randconfig-r021-20230509   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230511   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230509   gcc  
microblaze           randconfig-r033-20230509   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230511   gcc  
mips                         db1xxx_defconfig   gcc  
mips                 randconfig-r015-20230509   gcc  
mips                 randconfig-r022-20230509   gcc  
mips                 randconfig-r031-20230509   clang
mips                 randconfig-r035-20230509   clang
nios2                               defconfig   gcc  
openrisc     buildonly-randconfig-r001-20230511   gcc  
openrisc     buildonly-randconfig-r004-20230511   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r011-20230509   gcc  
openrisc             randconfig-r016-20230509   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   clang
powerpc              randconfig-r005-20230509   gcc  
powerpc              randconfig-r013-20230509   clang
powerpc              randconfig-r024-20230509   clang
powerpc                     sequoia_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                randconfig-r012-20230509   clang
riscv                randconfig-r042-20230509   clang
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230509   clang
sh                               allmodconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r012-20230509   gcc  
sh                   randconfig-r016-20230509   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230509   gcc  
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
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
