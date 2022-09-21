Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C4D5E567F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 01:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiIUXDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 19:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiIUXDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 19:03:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EBE7F139
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663801428; x=1695337428;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LT9AwxAvHXydj5s8fjKEFayyARrzNjNxUD/fJp9YTcc=;
  b=hGc4I35uX/79wNpWEq0q+p1OMUAxCIjJ9QUK9vh5tLmujXWv0Xt+CrQj
   PPglFfxSJ17AepEpLG5H5hxPmw3OxuUOuzwX5waGu+t8Luc3mk0vpRqSF
   m3WFGi9Z6Wt9SfMtyi9qUkXKsO8H4CctFYbbibWiLI47kUndZrmZ6mxL1
   hsGqv75Wvyj1JVlaISyvfYraQt8C5GdKTtxmCfNDazjY5u3AlWzRynSFq
   GQvhoUwSoev+Dxi9hk2JLIMy1wG4/LLOktEbSjgQbCbIDrIu2nkmojxvx
   Ro9k3eCW0G8HO+OWDshp2lcU1g2/hnOwMM6805N7+V1ZPMAlUXBoeS9+g
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="301552109"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="301552109"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 16:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="681974097"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Sep 2022 16:03:46 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ob8kr-00043j-2E;
        Wed, 21 Sep 2022 23:03:45 +0000
Date:   Thu, 22 Sep 2022 07:03:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 dca6344d7a77dd0501a73745f4a9fb1ee2bc9d7c
Message-ID: <632b9836.3JjI9FpEXP6xjUTs%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: dca6344d7a77dd0501a73745f4a9fb1ee2bc9d7c  perf/core: Convert snprintf() to scnprintf()

elapsed time: 723m

configs tested: 82
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arm                                 defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20220921
s390                                defconfig
arm64                            allyesconfig
m68k                             allyesconfig
arm                              allyesconfig
riscv                randconfig-r042-20220921
s390                 randconfig-r044-20220921
x86_64                        randconfig-a013
x86_64                        randconfig-a011
s390                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a015
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                                defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
i386                          randconfig-a012
x86_64                           rhel-8.3-kvm
mips                             allyesconfig
i386                          randconfig-a016
powerpc                           allnoconfig
i386                          randconfig-a014
powerpc                          allmodconfig
sh                               allmodconfig
ia64                             allmodconfig
i386                             allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                         ap325rxa_defconfig
xtensa                    smp_lx200_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     tqm8555_defconfig
nios2                            alldefconfig
powerpc                      cm5200_defconfig
openrisc                 simple_smp_defconfig
arm                         nhk8815_defconfig
i386                          randconfig-c001
arm                             pxa_defconfig
sh                      rts7751r2d1_defconfig
riscv                            allyesconfig
mips                        vocore2_defconfig
arc                          axs101_defconfig
sh                             espt_defconfig
powerpc                  storcenter_defconfig
loongarch                           defconfig

clang tested configs:
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a016
x86_64                        randconfig-a014
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001
powerpc                    gamecube_defconfig
arm                         orion5x_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
