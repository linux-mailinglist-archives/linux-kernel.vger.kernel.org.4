Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77454608556
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 09:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJVHGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 03:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiJVHGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 03:06:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D4825E0B4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 00:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666422372; x=1697958372;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HZQnbpQeo9qKndHOiPOZbOLQtOzV55ZGhbo0ZEnRRHg=;
  b=OL15NDZuPzUfeAVNe/ArVaZTbP+OQpJuaQlUjUDnxv2U2YZoZCJJCkiO
   CE6OE8zIIZnv46tFNcgKYPJAY5hRu9EV616LS/KlwsbM1FSemTvUAeSdp
   9rsddu1FmmACROlY5Q9rdDuPgzonewQtlwN9/T4VhPq3mubwmXKxZpw2q
   8qFlC0w+ogc8ZzezqvYukZgrLVyMJ9IfxgXByr2zMcsi4AcL9mIDd5sK9
   lR5j9N8dTYZhKG7kZ6wy+Gk1iusMfajcLfZVuKFbfMM/MUO/0PeH8xsH5
   bRr2YtkEvD75xdl4rY9MFcUtG4A8TyrKBCtKxhg7DTQNh3FdUYVaGA7JN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="307155165"
X-IronPort-AV: E=Sophos;i="5.95,204,1661842800"; 
   d="scan'208";a="307155165"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 00:06:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="719984080"
X-IronPort-AV: E=Sophos;i="5.95,204,1661842800"; 
   d="scan'208";a="719984080"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Oct 2022 00:06:10 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1om8a9-0003RC-1n;
        Sat, 22 Oct 2022 07:06:09 +0000
Date:   Sat, 22 Oct 2022 15:05:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 093c2f3190de37b8acd6902b3224879741bc5b23
Message-ID: <63539653.Yai0OlLoJdKPSnuo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 093c2f3190de37b8acd6902b3224879741bc5b23  Merge x86/core into tip/master

elapsed time: 725m

configs tested: 125
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
x86_64                           rhel-8.3-syz
m68k                             allyesconfig
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
arc                              allyesconfig
alpha                            allyesconfig
s390                             allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                                defconfig
x86_64                           allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
arm                                 defconfig
arc                  randconfig-r043-20221018
riscv                randconfig-r042-20221018
s390                 randconfig-r044-20221018
x86_64                        randconfig-a013
i386                             allyesconfig
x86_64                        randconfig-a011
arm                              allyesconfig
arc                           tb10x_defconfig
sh                            titan_defconfig
powerpc                     pq2fads_defconfig
arm                         nhk8815_defconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a004
arm64                            allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
arc                  randconfig-r043-20221022
s390                 randconfig-r044-20221022
riscv                randconfig-r042-20221022
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
ia64                          tiger_defconfig
arm                        mvebu_v7_defconfig
mips                    maltaup_xpa_defconfig
arm                           u8500_defconfig
csky                                defconfig
parisc                generic-64bit_defconfig
i386                          randconfig-c001
arc                              alldefconfig
m68k                          atari_defconfig
powerpc                     tqm8548_defconfig
arm                          lpd270_defconfig
m68k                            q40_defconfig
sh                           se7721_defconfig
m68k                        mvme147_defconfig
nios2                            allyesconfig
sparc                       sparc32_defconfig
sh                          sdk7786_defconfig
parisc                           alldefconfig
mips                      fuloong2e_defconfig
arm                        multi_v7_defconfig
powerpc                         ps3_defconfig
m68k                           virt_defconfig
sh                           se7722_defconfig
arm                            zeus_defconfig
sh                               alldefconfig
loongarch                         allnoconfig
arm                         lubbock_defconfig
powerpc                      pcm030_defconfig
parisc64                         alldefconfig
sh                         microdev_defconfig
arm                            qcom_defconfig
arm                       omap2plus_defconfig
arm                        clps711x_defconfig
powerpc                 linkstation_defconfig
arc                            hsdk_defconfig
openrisc                 simple_smp_defconfig

clang tested configs:
hexagon              randconfig-r045-20221018
hexagon              randconfig-r041-20221018
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a003
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a006
s390                 randconfig-r044-20221019
hexagon              randconfig-r045-20221019
hexagon              randconfig-r041-20221020
riscv                randconfig-r042-20221019
hexagon              randconfig-r045-20221020
hexagon              randconfig-r041-20221019
i386                          randconfig-a015
powerpc                   microwatt_defconfig
arm                         orion5x_defconfig
powerpc                      obs600_defconfig
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
arm                      pxa255-idp_defconfig
mips                          ath79_defconfig
powerpc                      acadia_defconfig
arm                             mxs_defconfig
arm                       netwinder_defconfig
mips                        maltaup_defconfig
powerpc                 mpc8560_ads_defconfig
x86_64                        randconfig-k001
mips                       rbtx49xx_defconfig
arm                           spitz_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
