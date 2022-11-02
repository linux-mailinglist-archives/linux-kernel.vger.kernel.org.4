Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968AF616F95
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiKBVW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKBVWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:22:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66155CDE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667424139; x=1698960139;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QJ4EjopBeYJXPX0TGZVnRMXBWm5pohTPxXjrqEbbewg=;
  b=AJcz04uXXQio7Dw4DUvQm+ruEqwIU6VwFtZavLjQ1tmxkDTFWOK5LF3O
   lwXiPlOufWmUbmjLP+lITVxwgbkvpSNDl0KWqiFr4baJ8DfTsq/5UD8AM
   kTWUA2sD7WC2bf++jjxWYtQdTqKMHIm3TfqxyJ4QC7I9UHnsBAzX9nCw6
   +nWSrnJx7HM58cezX26+4obtLses02bWy5D+MPUyu0/ZKcQflltsigjPB
   ZFFI7waBfoHIdXE06G+L2x7HpwF6AsShZqxBxdCA93wRJIs7JVJ7t3Ym9
   Bdc+K32oTkaVbAjMVry42WghmRAvAsA2T2VaeVSkgl/Edst9xzhRFcqOF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="296973843"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="296973843"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:22:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="759698335"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="759698335"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Nov 2022 14:22:17 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqLBh-000F8b-0j;
        Wed, 02 Nov 2022 21:22:17 +0000
Date:   Thu, 03 Nov 2022 05:21:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 0daf48b9e44674fb5ffc33cd41a3a17326e26cca
Message-ID: <6362df77.1sZU5Rr5B/16iYDM%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 0daf48b9e44674fb5ffc33cd41a3a17326e26cca  mm: Convert __HAVE_ARCH_P..P_GET to the new style

elapsed time: 725m

configs tested: 109
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
arc                  randconfig-r043-20221102
x86_64                           allyesconfig
s390                 randconfig-r044-20221102
x86_64                          rhel-8.3-func
riscv                randconfig-r042-20221102
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
i386                          randconfig-a012
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a016
i386                          randconfig-a001
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a003
x86_64                        randconfig-a013
arm64                            allyesconfig
x86_64                        randconfig-a011
arm                              allyesconfig
i386                          randconfig-a005
x86_64                        randconfig-a015
i386                             allyesconfig
ia64                         bigsur_defconfig
arm                         axm55xx_defconfig
arm                       multi_v4t_defconfig
nios2                               defconfig
arm                           sama5_defconfig
arm                          pxa910_defconfig
m68k                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
sparc                       sparc32_defconfig
mips                           xway_defconfig
arm                         vf610m4_defconfig
xtensa                       common_defconfig
arm                          lpd270_defconfig
m68k                         apollo_defconfig
mips                     decstation_defconfig
m68k                          multi_defconfig
m68k                             allmodconfig
i386                          randconfig-c001
arm                        multi_v7_defconfig
arm                         s3c6400_defconfig
sh                        apsh4ad0a_defconfig
arm                           tegra_defconfig
sh                          rsk7203_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm                            pleb_defconfig
powerpc                   motionpro_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     tqm8548_defconfig
arc                           tb10x_defconfig
sh                 kfr2r09-romimage_defconfig
mips                          rb532_defconfig
sh                        sh7757lcr_defconfig
nios2                            alldefconfig
sh                        edosk7705_defconfig
sh                             sh03_defconfig
powerpc                   currituck_defconfig
sh                           se7712_defconfig
arm                        clps711x_defconfig
csky                                defconfig
powerpc                     stx_gp3_defconfig
sh                      rts7751r2d1_defconfig
mips                       bmips_be_defconfig

clang tested configs:
hexagon              randconfig-r041-20221102
hexagon              randconfig-r045-20221102
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a006
riscv                randconfig-r042-20221103
hexagon              randconfig-r041-20221103
hexagon              randconfig-r045-20221103
s390                 randconfig-r044-20221103
arm                       netwinder_defconfig
arm                         bcm2835_defconfig
powerpc                      ppc44x_defconfig
riscv                    nommu_virt_defconfig
mips                       rbtx49xx_defconfig
arm                         socfpga_defconfig
powerpc                 mpc832x_mds_defconfig
arm                          pcm027_defconfig
arm                       cns3420vb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
