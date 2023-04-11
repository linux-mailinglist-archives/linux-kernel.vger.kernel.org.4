Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4246DDBB7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjDKNF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjDKNFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:05:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7327525B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681218316; x=1712754316;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=m9JsYrlzg84sZs3bK8BwTp7dMHboxBPXjAv59sYAChE=;
  b=YGD81YeBCLOA5GTjS8W+MZ0tYkDy5JHZxna3sjPIuUUkcPdMbp9+2/8I
   62GVnse3a8BfoYwxTSoJ3m/MFTq6XTql43Zq3fPk4pa0ZYZ8Yi/2ZC8Gp
   2vW9GlviZco2vKtbE9/SaUth6qi8aW6GOAWHHyGF8hWw7s3REKauGkeVJ
   P50lXK9AxtCbTxBzXjSX4U5TpfiL/LQbr09Kt9J6MhgC4PVFVI3kegyFU
   p+KnDXLHF4oiNdrNYTUKSVv3dJnL1Mh33q4/hoSMd9ZSQ6ySUr3Kr6IiA
   Pm2D8CODI82cVouHp7s6VpOFgICDZo8oBJOWm0Oupm3OVTZVuaNFA5BFO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="371459614"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="371459614"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 06:05:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="1018362174"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018362174"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Apr 2023 06:05:11 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmDgM-000WJj-13;
        Tue, 11 Apr 2023 13:05:10 +0000
Date:   Tue, 11 Apr 2023 21:04:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.04.06a] BUILD SUCCESS
 9cabf358d0426d07cc6216fc2df7aafe4e5c27be
Message-ID: <64355acf./pHX9psIhBLHpbIk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.04.06a
branch HEAD: 9cabf358d0426d07cc6216fc2df7aafe4e5c27be  rcu: Mark rcu_cpu_kthread() accesses to ->rcu_cpu_has_work

elapsed time: 722m

configs tested: 89
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r031-20230410   gcc  
alpha                randconfig-r034-20230409   gcc  
alpha                randconfig-r035-20230410   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230409   gcc  
arc                  randconfig-r043-20230410   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r032-20230410   gcc  
arm                  randconfig-r033-20230410   gcc  
arm                  randconfig-r046-20230409   clang
arm                  randconfig-r046-20230410   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r031-20230409   clang
csky                                defconfig   gcc  
csky                 randconfig-r034-20230410   gcc  
hexagon              randconfig-r041-20230409   clang
hexagon              randconfig-r041-20230410   clang
hexagon              randconfig-r045-20230409   clang
hexagon              randconfig-r045-20230410   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r035-20230409   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r032-20230409   gcc  
microblaze           randconfig-r035-20230409   gcc  
microblaze           randconfig-r036-20230409   gcc  
microblaze           randconfig-r036-20230410   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r031-20230410   gcc  
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r036-20230410   clang
riscv                randconfig-r042-20230409   gcc  
riscv                randconfig-r042-20230410   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230409   gcc  
s390                 randconfig-r044-20230410   gcc  
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r032-20230409   gcc  
sparc                randconfig-r033-20230409   gcc  
sparc                randconfig-r033-20230410   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r034-20230410   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
