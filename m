Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06A0654C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 07:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiLWGr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 01:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbiLWGrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 01:47:08 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CCA1DA6F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671778027; x=1703314027;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5tQjERKE0rKTVVuvCnvXwBiEENlTSnTM1GULZ7Q2xgw=;
  b=beFimWGYKWxeZw/R0x+GwjRnB/FqK61zDiWNCCbdIn5UjqCmT98W2Jtf
   ixty6oQKnKa1JhwAkV1QTNOI4yZP6o3gmWGO+TfnZAJrQvMPhUNb/rOkb
   V9MoETU7clN3h1l0fjrfOw8F+wAfO//kbi5qYh3/e4N52HC2Ncti9fxpm
   ii/MEoZclcO0Vet6zccVrKDuZX8zYJbenL6qCQ9HU0zObm7QSw6w4JYD7
   zPLsZrr5sy9Ssnz5TCRbwV2+/zeOuEkYnpBtUyoqPnFXU2OP8Z/3YkSPK
   gLoLv5ZSn5RYVv58DKUXR8mCJKdHjUEEnTRNKqb63xC+d34TLcBuqgg/C
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="318980178"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="318980178"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 22:47:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="684451764"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="684451764"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Dec 2022 22:47:04 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p8bpg-000CV1-0R;
        Fri, 23 Dec 2022 06:47:04 +0000
Date:   Fri, 23 Dec 2022 14:46:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:haltnmi2.2022.12.19a] BUILD SUCCESS
 f7f35d3e8eda8463384354a752a7c068fce216d5
Message-ID: <63a54eb7.0SMnHNRcbWgMQAdm%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git haltnmi2.2022.12.19a
branch HEAD: f7f35d3e8eda8463384354a752a7c068fce216d5  x86/nmi: Test commit for exc_nmi handler not being reached

elapsed time: 725m

configs tested: 100
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
powerpc                           allnoconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                              defconfig
sh                               allmodconfig
ia64                             allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                               rhel-8.3
x86_64               randconfig-a003-20221219
x86_64               randconfig-a001-20221219
x86_64               randconfig-a004-20221219
x86_64               randconfig-a002-20221219
x86_64                           allyesconfig
i386                                defconfig
x86_64               randconfig-a006-20221219
x86_64               randconfig-a005-20221219
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
riscv                randconfig-r042-20221218
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
m68k                             allmodconfig
arc                  randconfig-r043-20221219
i386                             allyesconfig
arm                  randconfig-r046-20221219
m68k                             allyesconfig
arc                  randconfig-r043-20221218
arm                                 defconfig
s390                 randconfig-r044-20221218
arc                              allyesconfig
alpha                            allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                            allnoconfig
i386                          randconfig-c001
i386                 randconfig-a005-20221219
i386                 randconfig-a002-20221219
i386                 randconfig-a003-20221219
i386                 randconfig-a006-20221219
i386                 randconfig-a001-20221219
i386                 randconfig-a004-20221219
arm                        trizeps4_defconfig
sh                            shmin_defconfig
um                               alldefconfig
powerpc                      makalu_defconfig
m68k                        mvme147_defconfig
powerpc                    amigaone_defconfig
m68k                         amcore_defconfig
m68k                        m5272c3_defconfig
s390                 randconfig-r044-20221222
arc                  randconfig-r043-20221222
riscv                randconfig-r042-20221222
sh                           se7724_defconfig
sh                          rsk7203_defconfig
arm                            xcep_defconfig
mips                           xway_defconfig
m68k                          multi_defconfig
powerpc                 mpc8540_ads_defconfig
mips                            ar7_defconfig
openrisc                    or1ksim_defconfig
sh                          lboxre2_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                 randconfig-a011-20221219
i386                 randconfig-a014-20221219
i386                 randconfig-a012-20221219
i386                 randconfig-a013-20221219
arm                  randconfig-r046-20221218
i386                 randconfig-a015-20221219
hexagon              randconfig-r041-20221218
hexagon              randconfig-r045-20221219
s390                 randconfig-r044-20221219
i386                 randconfig-a016-20221219
hexagon              randconfig-r041-20221219
i386                          randconfig-a002
hexagon              randconfig-r045-20221218
i386                          randconfig-a004
riscv                randconfig-r042-20221219
i386                          randconfig-a006
x86_64                        randconfig-k001
x86_64               randconfig-a015-20221219
x86_64               randconfig-a013-20221219
x86_64               randconfig-a012-20221219
x86_64               randconfig-a016-20221219
x86_64               randconfig-a014-20221219
x86_64               randconfig-a011-20221219
x86_64               randconfig-k001-20221219

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
