Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAC166AF7D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 06:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjAOFen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 00:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjAOFek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 00:34:40 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B274BBB6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 21:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673760879; x=1705296879;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dRbFyPRcH+37UzJoUsKYdpJtHTdJG4NkBURNj4I11MU=;
  b=KBEcgt+WloFn2+KNsRuDiv6BZJyFYA2AXdZf9Ak9pTX4nCMHGyQxEQfA
   lr6cgMYHw4B1oF+TAi/k0Oa05AvhaEuGpWho2zOmNs5tUjwkk4BZHkFiF
   hpz7WtQE8zscU7aKoV5EJcxMdnZwtO4QX8dTR8wOE0fH7oun1Dk09WHHh
   kWOnUSiUkCTFptMJhohm5/kxskoL4qED3pvZlf/CC0EDNQ03rmTE8WSP+
   7utqm+rdgFq1XGBlfp9zukJDTKaWKykYJTX8VgZfNrZD/4IJBrGLr1RJl
   ZaKePdz3ztTgMNKH0SpxUS09XQnK6Q7mbKpLaUdw15xe0noFj4N+/goUd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10590"; a="303966394"
X-IronPort-AV: E=Sophos;i="5.97,218,1669104000"; 
   d="scan'208";a="303966394"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2023 21:34:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10590"; a="801025167"
X-IronPort-AV: E=Sophos;i="5.97,218,1669104000"; 
   d="scan'208";a="801025167"
Received: from lkp-server01.sh.intel.com (HELO 82361ecceba2) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jan 2023 21:34:37 -0800
Received: from kbuild by 82361ecceba2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGvfA-00006o-2E;
        Sun, 15 Jan 2023 05:34:36 +0000
Date:   Sun, 15 Jan 2023 13:34:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.01.12a] BUILD SUCCESS
 f7bc7c9aba2d47ec051aabb0aaecb5613422aa07
Message-ID: <63c39064.I9aBTjrqL+BkONQu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.01.12a
branch HEAD: f7bc7c9aba2d47ec051aabb0aaecb5613422aa07  Merge with "rcutorture: Add SRCU deadlock scenarios"

elapsed time: 723m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a006
x86_64                    rhel-8.3-kselftests
x86_64                            allnoconfig
sh                               allmodconfig
x86_64                        randconfig-a004
x86_64                          rhel-8.3-func
m68k                             allmodconfig
i386                                defconfig
x86_64                        randconfig-a002
sh                                  defconfig
arc                        vdk_hs38_defconfig
alpha                            allyesconfig
sh                           se7780_defconfig
x86_64                           allyesconfig
m68k                             allyesconfig
i386                          randconfig-a001
arm                        trizeps4_defconfig
mips                             allyesconfig
i386                          randconfig-a003
arm                                 defconfig
arc                              allyesconfig
sh                        apsh4ad0a_defconfig
powerpc                          allmodconfig
arm                           h3600_defconfig
sh                           se7712_defconfig
x86_64                        randconfig-a013
i386                          randconfig-a005
x86_64                        randconfig-a011
i386                          randconfig-a014
arc                                 defconfig
s390                             allmodconfig
x86_64                        randconfig-a015
alpha                               defconfig
i386                          randconfig-a012
s390                                defconfig
i386                          randconfig-a016
s390                             allyesconfig
powerpc                    adder875_defconfig
arm64                            allyesconfig
riscv                             allnoconfig
arm                              allyesconfig
i386                             allyesconfig
sh                               alldefconfig
riscv                    nommu_virt_defconfig
x86_64                           rhel-8.3-bpf
arm                             pxa_defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                            hisi_defconfig
mips                           xway_defconfig
m68k                       bvme6000_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
powerpc                       maple_defconfig
powerpc                 canyonlands_defconfig
sh                               j2_defconfig
alpha                             allnoconfig
mips                            ar7_defconfig
m68k                          hp300_defconfig
mips                         bigsur_defconfig
sh                             shx3_defconfig
sh                            hp6xx_defconfig
i386                          randconfig-c001

clang tested configs:
x86_64                          rhel-8.3-rust
mips                malta_qemu_32r6_defconfig
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a003
powerpc                    gamecube_defconfig
i386                          randconfig-a013
x86_64                        randconfig-a005
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a011
x86_64                        randconfig-a014
i386                          randconfig-a004
i386                          randconfig-a015
arm                      tct_hammer_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     mpc5200_defconfig
mips                  cavium_octeon_defconfig
arm                                 defconfig
arm                       versatile_defconfig
riscv                            alldefconfig
arm                         palmz72_defconfig
arm                            dove_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
