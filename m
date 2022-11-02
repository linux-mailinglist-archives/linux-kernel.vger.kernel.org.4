Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0384616163
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiKBLF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKBLF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:05:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A1C24945
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 04:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667387156; x=1698923156;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tZQAqVHLx01x3D5Hzmm16roDST4tFxDGQaWNGTJwbKA=;
  b=jhkFCMgjuvnCZjnSuqtjeJsKDvcDC47lo3aQvvuAPA5MCFkQ8L+OuNEn
   ohMlxJFTGx7fKaz5q7iAZcibIDZ/7NwrW8j/PEdwJ1RKN3yx37dGS/MEM
   1Gu9vObQWn8RJslRRPeVEpdn7plV8dpsp+1N+mJlTk9cteZlRBb128KU+
   jL5SMSUFpWhCGSOHpQodosVyrVXmxajtpgy0N8ZWxNISa2FzU/JOJeo3g
   +FPPCxYqmeFmCLocGnXSW66JPDQOKxLy5cLEnzFHDyAcnYrpPCTUm2u4I
   Q19dD/eFWIWAC+f9pWVdJtqnJ/b+OWJqjWZ/MAkyWhuxG/hcAE0plNC2R
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="395687506"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="395687506"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 04:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="612203675"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="612203675"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 02 Nov 2022 04:05:54 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqBZA-000EhL-2q;
        Wed, 02 Nov 2022 11:05:52 +0000
Date:   Wed, 02 Nov 2022 19:05:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 bce5a1e8a34006a5e80213ede5e5c465d53f1dce
Message-ID: <63624ee1.7FLg4EghGJHhrvyC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
branch HEAD: bce5a1e8a34006a5e80213ede5e5c465d53f1dce  x86/mem: Move memmove to out of line assembler

elapsed time: 722m

configs tested: 100
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
powerpc                           allnoconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
arc                  randconfig-r043-20221101
x86_64                          rhel-8.3-func
sh                               allmodconfig
x86_64                        randconfig-a013
mips                             allyesconfig
x86_64                        randconfig-a011
x86_64                    rhel-8.3-kselftests
powerpc                          allmodconfig
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                                defconfig
i386                 randconfig-a011-20221031
i386                 randconfig-a012-20221031
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arm                                 defconfig
i386                 randconfig-a013-20221031
i386                          randconfig-a003
x86_64                           rhel-8.3-syz
x86_64                              defconfig
i386                 randconfig-a015-20221031
ia64                             allmodconfig
i386                          randconfig-a005
x86_64                               rhel-8.3
i386                 randconfig-a014-20221031
i386                 randconfig-a016-20221031
x86_64                           allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a006
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm                       omap2plus_defconfig
arm                          iop32x_defconfig
riscv                    nommu_k210_defconfig
sh                        sh7757lcr_defconfig
openrisc                    or1ksim_defconfig
x86_64               randconfig-k001-20221031
arm                      footbridge_defconfig
powerpc                     taishan_defconfig
sh                  sh7785lcr_32bit_defconfig
alpha                             allnoconfig
m68k                             allyesconfig
arm64                            alldefconfig
powerpc                 linkstation_defconfig
m68k                        stmark2_defconfig
arm                            mps2_defconfig
sparc                             allnoconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                       common_defconfig
powerpc                     stx_gp3_defconfig
ia64                        generic_defconfig
sh                          rsk7203_defconfig
sh                      rts7751r2d1_defconfig
i386                          randconfig-c001
sparc                       sparc64_defconfig
sh                          lboxre2_defconfig
arm                        keystone_defconfig
arm                         cm_x300_defconfig
mips                           xway_defconfig
i386                 randconfig-c001-20221031
powerpc                      arches_defconfig
powerpc                    klondike_defconfig

clang tested configs:
hexagon              randconfig-r041-20221101
hexagon              randconfig-r045-20221101
riscv                randconfig-r042-20221101
s390                 randconfig-r044-20221101
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
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
