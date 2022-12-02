Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A752E63FD38
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiLBAm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiLBAmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:42:52 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660F11056F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669941770; x=1701477770;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=A5FCiDFPQkYkvk6ZPuCte5Lv/AlgXqGUiVuKYwPuyTA=;
  b=FEpSguHG7kxFBLjXFC3X6Cp70z7yIwcPMhB+O1fIh8mcl/5mU2B+zZv4
   l6G8Dqr9U2sEEzQCxxbRnNV+iIBduVfQZ6ng7xZpfKutDskR2LYr5cziL
   z0tyDwO+eLBbgfJ3po05KH4VmUxWTmUm5sMHRdUTLMcfPBrVt+8KztYM5
   LtxdEt+rGlAb9TA7WXSrMzELtCJeQN2EKV8IvZf4s5VW+YGNufEA9aNqv
   T3R1yszUyprpWmC1ndaByzGrKegBfJnL4FtBJpp2oB3tDJomtAwuH7lvw
   FCHoGXXjM6Dq6zDzYJhmgD16UUFPlML2IyyIJbZ20jVBHc/jDGvp/kGxt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="377994900"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="377994900"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 16:42:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="889948518"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="889948518"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Dec 2022 16:42:48 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0u8d-000D45-38;
        Fri, 02 Dec 2022 00:42:47 +0000
Date:   Fri, 02 Dec 2022 08:42:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 c3e54872bc2d167bc5b8568dd5c65eeb91e1bea5
Message-ID: <638949dc.CpLTPjAq4DgggrY5%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: c3e54872bc2d167bc5b8568dd5c65eeb91e1bea5  Merge branch 'nolibc.2022.10.28a' into HEAD

elapsed time: 1467m

configs tested: 74
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
s390                             allyesconfig
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
sh                               allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                          allmodconfig
mips                             allyesconfig
arc                  randconfig-r043-20221128
i386                 randconfig-a002-20221128
i386                 randconfig-a003-20221128
i386                 randconfig-a001-20221128
i386                 randconfig-a004-20221128
i386                 randconfig-a005-20221128
i386                 randconfig-a006-20221128
ia64                             allmodconfig
i386                                defconfig
x86_64                            allnoconfig
arm                                 defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arc                        nsim_700_defconfig
arm                           h3600_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                          hp300_defconfig
sh                          r7785rp_defconfig
powerpc                 mpc837x_rdb_defconfig
xtensa                       common_defconfig
i386                          randconfig-c001
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
sparc                       sparc64_defconfig
alpha                             allnoconfig
sh                 kfr2r09-romimage_defconfig
powerpc                       holly_defconfig
i386                             allyesconfig
arm                  randconfig-c002-20221201
x86_64                        randconfig-c001
arc                  randconfig-r043-20221201
riscv                randconfig-r042-20221201
s390                 randconfig-r044-20221201
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
hexagon              randconfig-r045-20221128
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
s390                 randconfig-r044-20221128
x86_64                        randconfig-k001
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
