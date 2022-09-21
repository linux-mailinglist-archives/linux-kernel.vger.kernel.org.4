Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B115E544F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiIUUOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiIUUOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:14:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF47CE11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663791281; x=1695327281;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yv6UNJfv2tcIAsKQ+4sBT1SfYicoynXhWnxo8is0ENU=;
  b=VLX2hi481WrFm/uQPp2nCzPykFggQCvb+lRANo2x3gFJxE+EV7C8M3VS
   Qtk8M0wab1zCZKhJ+tuH29PhkW51WGoPPmLqbPodaH/PXbfBbbjuAHeMh
   Gm28hTMe513IwcFFRi6ipzgOplGCQ9ZLKT/j9ATVvWPXDcXhs1qGwwIcI
   +dAcHaxERerN3Xuocs1tfEEr+QOPO1gpgwQSlK4jCkilXGXD91LPe0DSt
   z8M+E5FNMDBDMe35ZThTTlD5xO1DzFCS5Yw1RsLcjr1pT/Yrvj4jSCWQ/
   WeVysvL7w7BXxXyt+FwZLywhdUr+XEVgBWKJKUdxJjHYv5Jeu3P9F1f5v
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="364092865"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="364092865"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 13:14:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="688016598"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2022 13:14:40 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ob67D-0003um-18;
        Wed, 21 Sep 2022 20:14:39 +0000
Date:   Thu, 22 Sep 2022 04:14:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 a3d3163fbe690cfec354fc20808adf0629adf8da
Message-ID: <632b7092.cUTtDuDpDWCgV1Bb%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: a3d3163fbe690cfec354fc20808adf0629adf8da  x86/mm/32: Fix W^X detection when page tables do not support NX

elapsed time: 724m

configs tested: 115
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                        randconfig-a013
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a011
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20220921
riscv                randconfig-r042-20220921
x86_64                        randconfig-a015
s390                 randconfig-r044-20220921
x86_64                        randconfig-c001
arm                  randconfig-c002-20220921
i386                          randconfig-c001
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm64                               defconfig
ia64                             allyesconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
sh                             sh03_defconfig
sh                              ul2_defconfig
powerpc                      ppc6xx_defconfig
i386                             alldefconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                      bamboo_defconfig
arm                           h5000_defconfig
m68k                        mvme147_defconfig
powerpc                        cell_defconfig
sparc64                          alldefconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
powerpc                    mvme5100_defconfig
arm                        magician_defconfig
powerpc                 mpc836x_rdk_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                     ksi8560_defconfig
powerpc                     tqm8560_defconfig
mips                          ath79_defconfig
arm                       versatile_defconfig
arm                        multi_v5_defconfig
powerpc                      ppc64e_defconfig
mips                malta_qemu_32r6_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-c007
arm                  randconfig-c002-20220921
i386                          randconfig-c001
s390                 randconfig-c005-20220921
riscv                randconfig-c006-20220921
mips                 randconfig-c004-20220921
powerpc              randconfig-c003-20220921

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
