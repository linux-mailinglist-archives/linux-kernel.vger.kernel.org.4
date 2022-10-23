Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E90A609208
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJWJkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJWJku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:40:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326321D0C3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666518049; x=1698054049;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TQTwGQrCCC6DCIpFic9UX3Sgf2TMTRRA9Ba8KgtWpxc=;
  b=lTDWbTdAsBVQbbEp+j9JcF5lBhHsgjy/liJ0nVkYpcFX7PmOT/VLjKqa
   i0f56nBmxxL+l9WTBnH0G9C2BSRpeb6dl0AHPskZCSdlzrdh5CW6Gr47f
   CdRYtIh252i5HeN280ohE3B8YaW6GsfLNhuRkjdftecglO6aI5nZ3X3uc
   WsrbhSvvwNVc3/aDdmGKxMliSXLp5ANIRB1rjV5pGf06tkDuV5lvLUohY
   iQKGyX+M3aOaFEqZJ5v3ZWSTsbk2D03qSa7GsZJMQ2/5tOY5yuAZPL1KK
   dg3UOSQJEKiJK8ty2qsXNMrCJpVHKGeQkI8XIrLseNiPmjYo//9TIZkHP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="286966498"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="286966498"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 02:40:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="582102427"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="582102427"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 23 Oct 2022 02:40:47 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1omXTK-0004Hs-2y;
        Sun, 23 Oct 2022 09:40:46 +0000
Date:   Sun, 23 Oct 2022 17:40:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 df0819e9f275a1110d7be26ac4d57be52b7f4824
Message-ID: <63550bf1.cvbbnUWgmZvZUPKv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: df0819e9f275a1110d7be26ac4d57be52b7f4824  Merge branch into tip/master: 'x86/paravirt'

elapsed time: 1478m

configs tested: 146
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20221019
powerpc                           allnoconfig
x86_64                        randconfig-a004
mips                             allyesconfig
x86_64                        randconfig-a002
powerpc                          allmodconfig
x86_64                        randconfig-a006
s390                             allyesconfig
i386                          randconfig-a001
x86_64                              defconfig
i386                          randconfig-a003
sh                               allmodconfig
x86_64                          rhel-8.3-func
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a013
arm                                 defconfig
x86_64                               rhel-8.3
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a011
arm64                            allyesconfig
x86_64                           allyesconfig
arm                              allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a015
sparc                       sparc32_defconfig
sh                          sdk7786_defconfig
parisc                           alldefconfig
mips                      fuloong2e_defconfig
arm                            zeus_defconfig
sh                               alldefconfig
loongarch                         allnoconfig
arm                           u8500_defconfig
sh                                  defconfig
sh                          polaris_defconfig
powerpc                 mpc834x_mds_defconfig
i386                          randconfig-c001
csky                                defconfig
sh                           se7722_defconfig
ia64                          tiger_defconfig
arm                        mvebu_v7_defconfig
mips                    maltaup_xpa_defconfig
arc                        nsimosci_defconfig
microblaze                          defconfig
arm                          lpd270_defconfig
arm                        clps711x_defconfig
mips                       bmips_be_defconfig
arm                            mps2_defconfig
arc                     nsimosci_hs_defconfig
arm                         s3c6400_defconfig
m68k                         apollo_defconfig
powerpc                  iss476-smp_defconfig
sh                           se7619_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                           se7206_defconfig
sh                          r7780mp_defconfig
sparc64                          alldefconfig
m68k                             alldefconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     tqm8555_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                               defconfig
xtensa                           allyesconfig
sparc                            allyesconfig
x86_64                                  kexec
powerpc                      makalu_defconfig
sh                     sh7710voipgw_defconfig
arm                      footbridge_defconfig
csky                              allnoconfig
arm                          exynos_defconfig
sh                          urquell_defconfig
loongarch                           defconfig
loongarch                        allmodconfig
arm                        realview_defconfig
powerpc                    sam440ep_defconfig
ia64                      gensparse_defconfig
m68k                           virt_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
powerpc                    adder875_defconfig
sparc64                             defconfig
sh                   rts7751r2dplus_defconfig
sh                         ap325rxa_defconfig
powerpc                   currituck_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221023
m68k                             allmodconfig

clang tested configs:
riscv                randconfig-r042-20221019
hexagon              randconfig-r045-20221019
hexagon              randconfig-r041-20221019
s390                 randconfig-r044-20221019
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a003
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                 randconfig-a011-20221017
i386                 randconfig-a013-20221017
i386                 randconfig-a012-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a015-20221017
mips                       rbtx49xx_defconfig
arm                           spitz_defconfig
powerpc                   microwatt_defconfig
arm                         orion5x_defconfig
powerpc                      obs600_defconfig
x86_64                        randconfig-k001
mips                        bcm63xx_defconfig
mips                      bmips_stb_defconfig
mips                      maltaaprp_defconfig
powerpc                      walnut_defconfig
arm                            mmp2_defconfig
arm                      pxa255-idp_defconfig
arm                         socfpga_defconfig
arm                             mxs_defconfig
powerpc                      makalu_defconfig
powerpc                 mpc8540_ads_defconfig
hexagon                          alldefconfig
mips                           rs90_defconfig
powerpc                     pseries_defconfig
arm                        neponset_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
