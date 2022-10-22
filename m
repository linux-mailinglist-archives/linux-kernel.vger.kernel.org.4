Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E38608500
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJVGQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJVGQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:16:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACD025760B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 23:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666419364; x=1697955364;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ytwz65FGZjAagOk07ReB04BN1qcYCgP/Mm9JywdrEbQ=;
  b=nKnuEqIeedJjGxYl5PVhwK47NVHUr35dkX7fH9C1E/BJtw2dm7y0+J/9
   zQXEqeC7ojltGgMWh0qF7PYvb727rNtKRaXTLZc+usYDE4iC2cDysF6cC
   JprWTK3kLglEeIHH/HdXA8o8i71d+VFV51LiM+MQoe9dofhIYgdJy7uPR
   ZHTbt7jRXokTfEsU25tZuJz7Hy5c1YB7V+NGeJy1AsokJkIZe0cm3LJWI
   v7tKkGGqbVIvtJPpVwu7udOe1fQviER4ABfHDdtOGnMea4ZIzk5qPP1r0
   D9FLMS+FrdzqYgin3yPOwJoHCi0TM534UPodRyh8beYGtT10vq1kpAQGl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="290467582"
X-IronPort-AV: E=Sophos;i="5.95,204,1661842800"; 
   d="scan'208";a="290467582"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 23:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="661860010"
X-IronPort-AV: E=Sophos;i="5.95,204,1661842800"; 
   d="scan'208";a="661860010"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 21 Oct 2022 23:16:02 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1om7ne-0003Oh-0E;
        Sat, 22 Oct 2022 06:16:02 +0000
Date:   Sat, 22 Oct 2022 14:15:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:srcunmisafe.2022.10.21a] BUILD SUCCESS
 e29a4915db1480f96e0bc2e928699d086a71f43c
Message-ID: <63538a6a.QHOOb14VfEq4v09b%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git srcunmisafe.2022.10.21a
branch HEAD: e29a4915db1480f96e0bc2e928699d086a71f43c  srcu: Debug NMI safety even on archs that don't require it

elapsed time: 724m

configs tested: 120
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
powerpc                          allmodconfig
mips                             allyesconfig
s390                                defconfig
powerpc                           allnoconfig
s390                             allmodconfig
x86_64                              defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
arc                              alldefconfig
m68k                          atari_defconfig
powerpc                     tqm8548_defconfig
arm                          lpd270_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                             allyesconfig
i386                                defconfig
s390                             allyesconfig
arc                  randconfig-r043-20221019
x86_64                        randconfig-a006
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                         nhk8815_defconfig
arc                           tb10x_defconfig
sh                            titan_defconfig
powerpc                     pq2fads_defconfig
sparc                       sparc32_defconfig
sh                          sdk7786_defconfig
parisc                           alldefconfig
mips                      fuloong2e_defconfig
arm                        multi_v7_defconfig
sh                           se7721_defconfig
powerpc                         ps3_defconfig
m68k                           virt_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arc                  randconfig-r043-20221022
s390                 randconfig-r044-20221022
riscv                randconfig-r042-20221022
arc                  randconfig-r043-20221020
s390                 randconfig-r044-20221020
riscv                randconfig-r042-20221020
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
ia64                          tiger_defconfig
arm                        mvebu_v7_defconfig
mips                    maltaup_xpa_defconfig
i386                          randconfig-c001
arm                           u8500_defconfig
csky                                defconfig
parisc                generic-64bit_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                            q40_defconfig
m68k                        mvme147_defconfig
nios2                            allyesconfig
sh                           se7722_defconfig
arm                            zeus_defconfig
sh                               alldefconfig
loongarch                         allnoconfig
arm                         lubbock_defconfig
powerpc                      pcm030_defconfig
parisc64                         alldefconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
sh                         microdev_defconfig
arm                            qcom_defconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
arm                       netwinder_defconfig
mips                        maltaup_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                   microwatt_defconfig
arm                         orion5x_defconfig
powerpc                      obs600_defconfig
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
x86_64                        randconfig-k001
s390                 randconfig-r044-20221019
hexagon              randconfig-r045-20221019
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221019
hexagon              randconfig-r041-20221020
hexagon              randconfig-r045-20221020
arm                            mmp2_defconfig
arm                      pxa255-idp_defconfig
mips                          ath79_defconfig
powerpc                      acadia_defconfig
arm                             mxs_defconfig
mips                       rbtx49xx_defconfig
arm                           spitz_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
