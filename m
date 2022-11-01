Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986FF6155F7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiKAXOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiKAXOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:14:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458576565
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 16:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667344471; x=1698880471;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nPh3+60EmNTELzIo99w5dA7f/vwWEAXuyy6DSr53nfA=;
  b=G1W/9TEc+F6JrnuupKJjQDe6L1J2U12LAmuciqpysEB9X3wbN4WjqEGN
   ACVzDOFPL9JryW3qraMksRJOCuX6+ofCeK5zEHCMTkD5Lcx6L6VjuBZJS
   oIeKSUOLQvA4vaNYHOm7N8lQ4xTNAdCyFoR7IrGBzdcjT5rutIE9W/X00
   kgj96n3hL4W0OcAfAfeicWYNN4yxx/uwasMX+cpc+JP6VeidNhbdNW9cH
   3qrlu5mPig63vlFaaCQR5xGgemARGzSZuGExFEcCdwcbPZ0XaVHgOG0ir
   EET0lv95VwPzrIueST+tX43vBbo9EPmakFAhXqXoxutErvv6hyV3Tf1Bn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="306879998"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="306879998"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 16:14:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="612019860"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="612019860"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 01 Nov 2022 16:14:29 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oq0Sj-000E9g-06;
        Tue, 01 Nov 2022 23:14:29 +0000
Date:   Wed, 02 Nov 2022 07:13:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 74f2af2d5393451ff1a104f0187826e44f45fc84
Message-ID: <6361a82c.eR/b4ON4NJP4XDTa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 74f2af2d5393451ff1a104f0187826e44f45fc84  Merge branch into tip/master: 'x86/sgx'

elapsed time: 727m

configs tested: 120
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                                defconfig
arc                                 defconfig
arm                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                              defconfig
x86_64                        randconfig-a004
arm                              allyesconfig
arc                  randconfig-r043-20221101
s390                                defconfig
arm64                            allyesconfig
i386                          randconfig-a014
m68k                             allmodconfig
sh                               allmodconfig
s390                             allyesconfig
mips                             allyesconfig
x86_64                        randconfig-a002
arc                              allyesconfig
i386                          randconfig-a012
powerpc                          allmodconfig
x86_64                               rhel-8.3
i386                          randconfig-a016
x86_64                           allyesconfig
i386                             allyesconfig
x86_64               randconfig-a016-20221031
x86_64               randconfig-a011-20221031
x86_64               randconfig-a013-20221031
x86_64               randconfig-a012-20221031
x86_64               randconfig-a014-20221031
x86_64               randconfig-a015-20221031
x86_64               randconfig-k001-20221031
alpha                            allyesconfig
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a006
m68k                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
arm                         lubbock_defconfig
powerpc                      chrp32_defconfig
m68k                                defconfig
arm                            mps2_defconfig
i386                 randconfig-a016-20221031
i386                 randconfig-a012-20221031
i386                 randconfig-a015-20221031
i386                 randconfig-a013-20221031
i386                 randconfig-a014-20221031
i386                 randconfig-a011-20221031
sparc                             allnoconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                       common_defconfig
mips                           jazz_defconfig
arm                           tegra_defconfig
mips                 decstation_r4k_defconfig
arm                          lpd270_defconfig
sh                              ul2_defconfig
powerpc                 mpc8540_ads_defconfig
openrisc                       virt_defconfig
powerpc                 canyonlands_defconfig
i386                          randconfig-c001
i386                 randconfig-c001-20221031
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
arm64                            alldefconfig
powerpc                 linkstation_defconfig
m68k                        stmark2_defconfig
um                                  defconfig
arm                         s3c6400_defconfig
m68k                       m5249evb_defconfig
arm                            qcom_defconfig
arm                      footbridge_defconfig
powerpc                     taishan_defconfig
sh                  sh7785lcr_32bit_defconfig
alpha                             allnoconfig
powerpc                      arches_defconfig
powerpc                    klondike_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
i386                 randconfig-a001-20221031
i386                 randconfig-a003-20221031
i386                 randconfig-a002-20221031
i386                 randconfig-a004-20221031
i386                 randconfig-a006-20221031
i386                 randconfig-a005-20221031
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221101
i386                          randconfig-a013
i386                          randconfig-a011
hexagon              randconfig-r045-20221101
s390                 randconfig-r044-20221101
riscv                randconfig-r042-20221101
x86_64                        randconfig-a005
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                   bluestone_defconfig
arm                        magician_defconfig
arm                        vexpress_defconfig
powerpc                       ebony_defconfig
powerpc                      obs600_defconfig
arm                      pxa255-idp_defconfig
mips                      bmips_stb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
