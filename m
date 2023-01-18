Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DA7671A24
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjARLM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjARLLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:11:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6A678AB2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674037242; x=1705573242;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=A7rU203JGpSSZDO4Vof/BUG2CEyJDLSbbSQEbMzEHbk=;
  b=IyWbQMo0u1I63+zyJKtHKnAI3zippQ8ouUT843Ea+cOD7acpsH3Xp8p1
   JESyiQrbOwbbgIFdDmCvh9ZbElhcgVusiDej/ZLxaeqbKcgtBrjFOlouz
   Xec09CwAKRWBGxhH+Z2uyUYea6Kmx/bBb5yS0wOUx1Te1iLLY982wdu9k
   2GKX4xgs5cqjVizbtV4+h2Ul6EgAejfViwDoPQbXYSW+PsYqrBvE8/P8u
   4JtYLirqWlv4mCxl6oNVpr2/2gky87QPbiNlstEDAyyItbG4Okd9CHyOu
   bUxIdl1Lvig2mTT1Pqq/I6C+jfEeT2RA8675iKJKvFZylQ48nRsXdG7Rx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="352197685"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="352197685"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 02:20:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="652869090"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="652869090"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Jan 2023 02:20:40 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pI5Yd-0000Cm-36;
        Wed, 18 Jan 2023 10:20:39 +0000
Date:   Wed, 18 Jan 2023 18:20:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 ac8f29aef2f1695956ff6773b33f975290437f29
Message-ID: <63c7c7db.8QemO5/tH1Bp2o+f%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: ac8f29aef2f1695956ff6773b33f975290437f29  genirq/msi: Free the fwnode created by msi_create_device_irq_domain()

elapsed time: 722m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
s390                                defconfig
sh                               allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
m68k                             allmodconfig
x86_64                           allyesconfig
m68k                             allyesconfig
x86_64                            allnoconfig
alpha                            allyesconfig
mips                             allyesconfig
arc                              allyesconfig
powerpc                          allmodconfig
s390                             allyesconfig
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
i386                 randconfig-a014-20230116
i386                 randconfig-a013-20230116
x86_64                           rhel-8.3-syz
x86_64               randconfig-a011-20230116
i386                 randconfig-a012-20230116
x86_64               randconfig-a013-20230116
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a012-20230116
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a015-20230116
i386                 randconfig-a011-20230116
x86_64                           rhel-8.3-bpf
x86_64               randconfig-a014-20230116
i386                 randconfig-a015-20230116
x86_64               randconfig-a016-20230116
i386                 randconfig-a016-20230116
arm                  randconfig-r046-20230117
arc                  randconfig-r043-20230117
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
riscv                randconfig-r042-20230116
arm                  randconfig-r046-20230115
s390                 randconfig-r044-20230116
arc                  randconfig-r043-20230116
arc                  randconfig-r043-20230115
ia64                        generic_defconfig
sh                 kfr2r09-romimage_defconfig
openrisc                         alldefconfig
i386                          randconfig-c001
powerpc                     tqm8548_defconfig
mips                        vocore2_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                 randconfig-c001-20230116
x86_64                        randconfig-c001
arm                  randconfig-c002-20230117
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a001-20230116
x86_64               randconfig-a003-20230116
hexagon              randconfig-r045-20230117
x86_64               randconfig-a004-20230116
x86_64               randconfig-a002-20230116
x86_64               randconfig-a005-20230116
s390                 randconfig-r044-20230117
hexagon              randconfig-r041-20230117
riscv                randconfig-r042-20230117
x86_64               randconfig-a006-20230116
i386                 randconfig-a002-20230116
i386                 randconfig-a004-20230116
i386                 randconfig-a001-20230116
i386                 randconfig-a003-20230116
i386                 randconfig-a005-20230116
i386                 randconfig-a006-20230116
powerpc                      acadia_defconfig
arm                        magician_defconfig
riscv                             allnoconfig
x86_64                        randconfig-k001
arm                           sama7_defconfig
riscv                          rv32_defconfig
powerpc                    mvme5100_defconfig
arm                         hackkit_defconfig
mips                          malta_defconfig
mips                        qi_lb60_defconfig
powerpc                        fsp2_defconfig
mips                           rs90_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                       cns3420vb_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                    ge_imp3a_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
