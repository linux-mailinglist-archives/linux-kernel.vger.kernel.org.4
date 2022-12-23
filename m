Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35D9654C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 07:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbiLWGrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 01:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbiLWGrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 01:47:08 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57E81DA75
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671778027; x=1703314027;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=YzXXsWQs+LE9/GBotxfKCBtuwO9kk+t8Rm6BZwrAuj0=;
  b=nxmAZjJNJ5O/xGmpRfy/H9Vqr4PAvnqf6Um5d4knrU/f4WJ08E43/qZ+
   fJysgdNjYhr2SM+DyqM0lCau2hax6mHPMKtnSzCdfIPmyWfSYcQq7ijCr
   w22Ythfdlm7bEpkmvy+m8daownSIovHMxRqqtOXxyTm8e0KEs1/How5wF
   33iwlGOKRDH/bh17CbPME6ogeKWK+5gfiZpZbJrNSxdjUBC0OfQu1aFvh
   ZYcW6IiLq/b9VTLl7KlBcf0vlT1xEWoWcsOuhU1hnS7u8z6iiWwSgNq59
   ChnpyhrcFUpONmBiN33wkgmKkPTvTItGbQdVWQS/RGjwcShBj9f29cX45
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="347439557"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="347439557"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 22:47:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="759265091"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="759265091"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 22 Dec 2022 22:47:04 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p8bpg-000CUy-0M;
        Fri, 23 Dec 2022 06:47:04 +0000
Date:   Fri, 23 Dec 2022 14:46:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:slownmi.2022.12.19a] BUILD SUCCESS
 d333cecea3024fa2c5c97896234b9b9eb8e6a99a
Message-ID: <63a54ec7.2BJcyWszG/OGuquS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git slownmi.2022.12.19a
branch HEAD: d333cecea3024fa2c5c97896234b9b9eb8e6a99a  x86/nmi: Test commit for delayed NMI handlers

elapsed time: 723m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
powerpc                           allnoconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64               randconfig-a003-20221219
x86_64               randconfig-a001-20221219
x86_64                               rhel-8.3
x86_64               randconfig-a004-20221219
x86_64               randconfig-a002-20221219
x86_64               randconfig-a005-20221219
x86_64               randconfig-a006-20221219
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
i386                                defconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
m68k                             allmodconfig
riscv                randconfig-r042-20221218
sh                               allmodconfig
x86_64                           rhel-8.3-bpf
m68k                             allyesconfig
i386                 randconfig-a001-20221219
arc                              allyesconfig
i386                 randconfig-a003-20221219
i386                             allyesconfig
i386                 randconfig-a002-20221219
alpha                            allyesconfig
arm                                 defconfig
powerpc                          allmodconfig
i386                 randconfig-a006-20221219
mips                             allyesconfig
i386                 randconfig-a005-20221219
i386                 randconfig-a004-20221219
arc                  randconfig-r043-20221219
arm                              allyesconfig
arm                  randconfig-r046-20221219
arc                  randconfig-r043-20221218
arm64                            allyesconfig
s390                 randconfig-r044-20221218
x86_64                            allnoconfig
i386                          randconfig-c001
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
i386                 randconfig-a014-20221219
i386                 randconfig-a012-20221219
i386                 randconfig-a013-20221219
i386                 randconfig-a011-20221219
i386                 randconfig-a015-20221219
i386                 randconfig-a016-20221219
arm                  randconfig-r046-20221218
hexagon              randconfig-r041-20221218
hexagon              randconfig-r045-20221219
s390                 randconfig-r044-20221219
hexagon              randconfig-r041-20221219
hexagon              randconfig-r045-20221218
riscv                randconfig-r042-20221219
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
