Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEEB617573
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiKCETO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiKCETG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:19:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1235CE14
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 21:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667449145; x=1698985145;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=u/qWCBoPPmFB9n1TvhLYfx93A3h+7N0xfdd7MthDrcs=;
  b=aSkc5bCpexCEfEoudRJtE6fF918vr1POCJsQB9UOhQPJTK2YfOiSSFhC
   9PUneMNxXE2xi9LnELI7dMN3bUuH5Ue9EJD5DgHQj1RFDqbApDcdFXUEl
   yBJK5iKiILDyjZabRv8s2nvexq0hpzyRFLTsYJ5rhQk8sgyRuAbN9Q1yZ
   BTjJ4eUCwRiRI1628qJwMzqu3epIjUznnY5z/1ZLHB9ZG6JmrwSN0CFTN
   ggawWiru5PQFXKUh2qTDjhje7v7KhMLALsP83QI1Ipt1M4gp6N0vZ2MqC
   sGG9IN0r9bQc4XLuISjyK/9vO5yhgORRqyFedCgS25zn8QGQvW6ZZ+ctr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="297037158"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="297037158"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 21:19:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="723801828"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="723801828"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Nov 2022 21:19:04 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqRh1-000FS9-1S;
        Thu, 03 Nov 2022 04:19:03 +0000
Date:   Thu, 03 Nov 2022 12:18:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 254ed7cf4dd79a18bbc496ab53f6c82d45431c78
Message-ID: <63634105.vBCDulsooubDEfrN%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 254ed7cf4dd79a18bbc496ab53f6c82d45431c78  x86/microcode: Drop struct ucode_cpu_info.valid

elapsed time: 727m

configs tested: 102
configs skipped: 68

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-syz
ia64                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a004
x86_64                        randconfig-a006
um                           x86_64_defconfig
um                             i386_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
sh                             sh03_defconfig
powerpc                   currituck_defconfig
sh                           se7712_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arc                           tb10x_defconfig
sh                 kfr2r09-romimage_defconfig
mips                          rb532_defconfig
sh                        sh7757lcr_defconfig
nios2                            alldefconfig
sh                        edosk7705_defconfig
arm                        clps711x_defconfig
csky                                defconfig
powerpc                     stx_gp3_defconfig
sh                      rts7751r2d1_defconfig
mips                       bmips_be_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-c001
m68k                       m5208evb_defconfig
powerpc                         wii_defconfig
m68k                       m5275evb_defconfig
m68k                         apollo_defconfig
mips                     decstation_defconfig
sparc                       sparc32_defconfig
m68k                          multi_defconfig
arm                        multi_v7_defconfig
arm                         s3c6400_defconfig
sh                        apsh4ad0a_defconfig
arm                           tegra_defconfig
sh                          rsk7203_defconfig
sh                        edosk7760_defconfig
arm                       aspeed_g5_defconfig
um                                  defconfig
parisc64                            defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
powerpc                   motionpro_defconfig
parisc                generic-32bit_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                               alldefconfig
sh                                  defconfig
arc                            hsdk_defconfig
parisc                           allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20221102
hexagon              randconfig-r045-20221102
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                 mpc832x_mds_defconfig
arm                          pcm027_defconfig
arm                       cns3420vb_defconfig
riscv                randconfig-r042-20221103
hexagon              randconfig-r041-20221103
hexagon              randconfig-r045-20221103
s390                 randconfig-r044-20221103
mips                     loongson1c_defconfig
mips                           mtx1_defconfig
powerpc               mpc834x_itxgp_defconfig
riscv                    nommu_virt_defconfig
mips                       rbtx49xx_defconfig
arm                         socfpga_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                          g5_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
