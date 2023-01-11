Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E879665917
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbjAKKdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjAKKdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:33:06 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD272019
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673433185; x=1704969185;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DYAvl8k3wcFVfh9vD7ID07degb7NXl1cbO3VyMiGPdY=;
  b=aI9FFeWsTroaSpX7J0y4wqHd375rO+ckGhecPHFFxcAfHN5loB4Dke58
   0HH1W4O2c9W4DHfXajX5o3urZ7RBHtkeOJ8X/tR8kZ0Vz1CccFMPSd19L
   nPnYekHtSIZj59Ygdhfe1mHWbguGRP8HXzolINjG/f4mraE9gx5+tMxMT
   7C6cH/3zviTqJvInY1dX2E2YwfEPBFYtvVGIIVwiPprh6Cl4+8c8M0zHl
   IKjiIJQ4TAx4RuS8Ssh0iSeUArR4k0IPdyuZy10l7nDx5UfF3SjT76trI
   2Vl9g4jW6aSqHhI+6c5GcyVO33pw4doZNYdwQbiiqDT3SqgO3twXW2rRX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303079757"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="303079757"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 02:33:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="725873453"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="725873453"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jan 2023 02:33:04 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFYPn-00091L-1P;
        Wed, 11 Jan 2023 10:33:03 +0000
Date:   Wed, 11 Jan 2023 18:32:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.01.09a] BUILD SUCCESS
 f4e5cfbdfe900a41375d68b6c83e438ecc519b7b
Message-ID: <63be902d.RnU2lx0XcZS7wF4N%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.01.09a
branch HEAD: f4e5cfbdfe900a41375d68b6c83e438ecc519b7b  tools: rcu: Add usage function and check for argument

elapsed time: 720m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
m68k                             allmodconfig
alpha                               defconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                                defconfig
x86_64                            allnoconfig
m68k                             allyesconfig
s390                             allyesconfig
sh                               allmodconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20230110
s390                 randconfig-r044-20230110
riscv                randconfig-r042-20230110
mips                             allyesconfig
powerpc                          allmodconfig
ia64                             allmodconfig
i386                             allyesconfig
i386                                defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
m68k                          amiga_defconfig
riscv                            allmodconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                        keystone_defconfig
sh                          rsk7264_defconfig
sh                           se7722_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arc                           tb10x_defconfig
powerpc                  iss476-smp_defconfig
csky                             alldefconfig
nios2                               defconfig
mips                         bigsur_defconfig
sh                          sdk7786_defconfig
sh                             espt_defconfig
openrisc                         alldefconfig
sh                          r7780mp_defconfig
mips                           gcw0_defconfig
powerpc                     taishan_defconfig
arm                         assabet_defconfig
parisc                generic-64bit_defconfig
mips                        vocore2_defconfig
i386                             alldefconfig
parisc                              defconfig
sh                         microdev_defconfig
sh                          urquell_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig

clang tested configs:
hexagon              randconfig-r041-20230110
arm                  randconfig-r046-20230110
hexagon              randconfig-r045-20230110
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust
riscv                randconfig-r042-20230111
s390                 randconfig-r044-20230111
hexagon              randconfig-r041-20230111
hexagon              randconfig-r045-20230111

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
