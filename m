Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DF3617781
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiKCHUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiKCHUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:20:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3227FB24
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667459999; x=1698995999;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=010qO1fUMypD+42YbjcG+Wadqm0bhn0GofMrJrdC9mA=;
  b=jCyYQTI+vk9BZAkUtTPCGQv81ssxP5w1N0UoTZOv+6XXxFHVgQ1PDFBV
   bKhcVxF2/8W3zY57O5KwGo6KZA2AhtUyMLI1bIuwIcVXX59FJwWL1GNnG
   J/apC5mbW+A+tcrABICv/T+R7kwxMAEJOiDg+u4fR3Bdb55t7E93w3XMG
   QNC9QwPS+sMTjd+NWqZR/hENVB+q03jt1/qPUvfjYbwYPEfFssh2jkYCg
   pwho92xEgJuQmUTubcBVXzIX+VQ+2sDoEUOPKzOUWuMrXM/NMiYltraY2
   f4GAe1jKAwEzQ+PLk8/UJdZI0Ybn90YOtCiOeFWSFu9lftVKPXWI9BUWS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="310720926"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="310720926"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 00:19:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="963829005"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="963829005"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 03 Nov 2022 00:19:57 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqUW4-000FdN-2c;
        Thu, 03 Nov 2022 07:19:56 +0000
Date:   Thu, 03 Nov 2022 15:19:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 801735aabc76157c23f5c2d4711db17abcfd26c3
Message-ID: <63636b8b.XXcCd9l3kAAsSnfR%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 801735aabc76157c23f5c2d4711db17abcfd26c3  Merge branch into tip/master: 'x86/microcode'

elapsed time: 725m

configs tested: 98
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
alpha                            allyesconfig
arc                              allyesconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
ia64                             allmodconfig
m68k                             allyesconfig
i386                          randconfig-a001
x86_64                        randconfig-a002
i386                          randconfig-a003
s390                                defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a006
sh                               allmodconfig
i386                          randconfig-a005
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a004
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
s390                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                                defconfig
arc                  randconfig-r043-20221102
riscv                randconfig-r042-20221102
s390                 randconfig-r044-20221102
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
arm                                 defconfig
x86_64                           allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
mips                     decstation_defconfig
powerpc                   motionpro_defconfig
parisc                generic-32bit_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                               alldefconfig
i386                          randconfig-c001
arm                        multi_v7_defconfig
arm                         s3c6400_defconfig
sh                        apsh4ad0a_defconfig
arm                           tegra_defconfig
sh                          rsk7203_defconfig
arm                            pleb_defconfig
sh                        edosk7760_defconfig
arm                       aspeed_g5_defconfig
um                                  defconfig
riscv                               defconfig
arm                        keystone_defconfig
openrisc                    or1ksim_defconfig
powerpc                      mgcoge_defconfig
m68k                          sun3x_defconfig
arc                            hsdk_defconfig
powerpc                     mpc83xx_defconfig
riscv                            allmodconfig
sh                             sh03_defconfig
powerpc                   currituck_defconfig
sh                           se7712_defconfig
arm                        clps711x_defconfig
csky                                defconfig
powerpc                     stx_gp3_defconfig
sh                      rts7751r2d1_defconfig
mips                       bmips_be_defconfig

clang tested configs:
x86_64                        randconfig-a005
i386                          randconfig-a002
x86_64                        randconfig-a001
i386                          randconfig-a004
x86_64                        randconfig-a003
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
hexagon              randconfig-r041-20221102
hexagon              randconfig-r045-20221102
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
riscv                    nommu_virt_defconfig
mips                       rbtx49xx_defconfig
arm                         socfpga_defconfig
riscv                randconfig-r042-20221103
hexagon              randconfig-r041-20221103
hexagon              randconfig-r045-20221103
s390                 randconfig-r044-20221103
powerpc                  mpc885_ads_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
