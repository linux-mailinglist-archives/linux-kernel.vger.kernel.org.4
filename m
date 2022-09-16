Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7861A5BA49A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 04:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiIPC3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 22:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIPC33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 22:29:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9402D107
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 19:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663295366; x=1694831366;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2Uh5Q7jQ/GZgQHQUG4jf6liBFVf7yMzBjAe8L9odvE8=;
  b=KKUCowB1WwiLmczocV1DlWBrvdgxCUoQEVh3k1kYnmmYuRtCoBTe1Gzw
   V63wW/Ln1NUfb1BE8EJPQV3KNYlTgm5jVZt/Qit2c9wcBcLA9X59AA2DZ
   t/U1jSS17bEORbVNJsPkuHcS3HFiC33EUtei6fo/NOLnY9fErVqLydZVB
   qgaGbMBkBltLFTFCJt64k233uqV8SbwDasjN/zD18iGHYpJn0PdF1IKeZ
   Q9/Q6uylSNFMAD31NUMJo7h7YuAnceN7+L/xc5dxnHBS7V+ThHr5fxySs
   dsHWPRs6cANAykT6iIetuAThwXh4Vj/C7TuWom28UH+MX8y4HgUYOUQt8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="285934209"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="285934209"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 19:29:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="619929234"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 15 Sep 2022 19:29:24 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZ16a-0001LK-0m;
        Fri, 16 Sep 2022 02:29:24 +0000
Date:   Fri, 16 Sep 2022 10:28:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 b4e12b2d70fd9eccdb3cef8015dc1788ca38e3fd
Message-ID: <6323df49.mpDEBOPUlQTuIO/8%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: b4e12b2d70fd9eccdb3cef8015dc1788ca38e3fd  perf: Kill __PERF_SAMPLE_CALLCHAIN_EARLY

elapsed time: 728m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
i386                                defconfig
arc                                 defconfig
s390                                defconfig
s390                             allmodconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
riscv                randconfig-r042-20220915
arc                  randconfig-r043-20220915
s390                 randconfig-r044-20220915
x86_64                        randconfig-a002
i386                          randconfig-a001
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-a003
x86_64                        randconfig-a006
i386                          randconfig-a005
x86_64                        randconfig-a004
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
ia64                             allmodconfig
x86_64                        randconfig-a015
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                          randconfig-c001
powerpc                      ep88xc_defconfig
sparc                       sparc32_defconfig
powerpc                      arches_defconfig
sh                          rsk7203_defconfig
arm                         vf610m4_defconfig
powerpc                        warp_defconfig
xtensa                           alldefconfig
powerpc                      mgcoge_defconfig
m68k                        m5307c3_defconfig
arm                           viper_defconfig
mips                     decstation_defconfig
sh                             sh03_defconfig
powerpc                         wii_defconfig
openrisc                       virt_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220916
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                         lubbock_defconfig
sh                            titan_defconfig
sparc                            allyesconfig
ia64                                defconfig
sh                           se7750_defconfig
powerpc                      pcm030_defconfig
arm                           tegra_defconfig
arm                            zeus_defconfig
arm64                               defconfig
ia64                             allyesconfig
arm                              allmodconfig
m68k                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig

clang tested configs:
hexagon              randconfig-r041-20220915
hexagon              randconfig-r045-20220915
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
powerpc                 xes_mpc85xx_defconfig
mips                           ip28_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
