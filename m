Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2BF616293
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiKBMUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKBMT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:19:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225B924F26
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 05:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667391597; x=1698927597;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Ko5Y3eZJrJX4pOh+MShq2SUt/+e9D21hmBJ+3LBUeeo=;
  b=guHwbL+V5L40VGA5T9GlWyO7dZ7lhyj7RkriprbpPm0iy5Xmaa41du64
   sN6zlPoSweCpr9DKdg2ZEjiDsTWM9SBFKRFD00gxPsKRUguWKuZMUO6w4
   CRB3l7DSzpXDcuenIbbw/oRZuKPtwzd5ImddeF36uIZFaf6FmuFW+UiWP
   sYw6zmEL7oPmgdL1XPiOuAO7MY0rDQj6/EWre2fiKEj1v+IfRtQ0w3dSD
   G0+OCLztiOKImoSi6XQXBKQNySg6PoIHauxbwv6DT5znnBBRKisL9Z347
   LJB2OK47dbztydZ6tSn5xfs3XHja3ak19itPQBZGtj6BEkSvJlxw1u8/J
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310497781"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="310497781"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 05:19:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="585377664"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="585377664"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Nov 2022 05:19:55 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqCio-000EjN-2t;
        Wed, 02 Nov 2022 12:19:54 +0000
Date:   Wed, 02 Nov 2022 20:19:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/productive-frustration] BUILD SUCCESS
 520f63f5351b8d965cccdf7557b9d61ef2f54427
Message-ID: <63626036.QQp3kCGQp/h3dTI9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/productive-frustration
branch HEAD: 520f63f5351b8d965cccdf7557b9d61ef2f54427  drm/amdkfd: Use resource_size() on resource object

elapsed time: 720m

configs tested: 102
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
arc                                 defconfig
alpha                               defconfig
x86_64                           rhel-8.3-syz
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
arc                  randconfig-r043-20221101
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
arc                              allyesconfig
sh                               allmodconfig
i386                          randconfig-a001
alpha                            allyesconfig
i386                          randconfig-a003
i386                          randconfig-a005
ia64                             allmodconfig
mips                             allyesconfig
m68k                             allyesconfig
arm                                 defconfig
powerpc                          allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm                       omap2plus_defconfig
arm                          iop32x_defconfig
riscv                    nommu_k210_defconfig
sh                        sh7757lcr_defconfig
openrisc                    or1ksim_defconfig
arm                      footbridge_defconfig
powerpc                     taishan_defconfig
sh                  sh7785lcr_32bit_defconfig
alpha                             allnoconfig
x86_64               randconfig-k001-20221031
arm                              allyesconfig
i386                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
sparc                             allnoconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                       common_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                     stx_gp3_defconfig
ia64                        generic_defconfig
sh                          rsk7203_defconfig
sh                      rts7751r2d1_defconfig
i386                          randconfig-c001
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                            alldefconfig
powerpc                 linkstation_defconfig
m68k                        stmark2_defconfig
arm                            mps2_defconfig
arm                        keystone_defconfig
arm                         cm_x300_defconfig
mips                           xway_defconfig
i386                 randconfig-a016-20221031
i386                 randconfig-a012-20221031
i386                 randconfig-a015-20221031
i386                 randconfig-a013-20221031
i386                 randconfig-a014-20221031
i386                 randconfig-a011-20221031
i386                 randconfig-c001-20221031
powerpc                      arches_defconfig
powerpc                    klondike_defconfig
sh                           se7724_defconfig
nios2                         3c120_defconfig
m68k                       bvme6000_defconfig
arm                          badge4_defconfig

clang tested configs:
hexagon              randconfig-r041-20221101
hexagon              randconfig-r045-20221101
s390                 randconfig-r044-20221101
riscv                randconfig-r042-20221101
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                        vexpress_defconfig
powerpc                       ebony_defconfig
powerpc                      obs600_defconfig
hexagon              randconfig-r041-20221102
hexagon              randconfig-r045-20221102
arm                      pxa255-idp_defconfig
mips                      bmips_stb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
