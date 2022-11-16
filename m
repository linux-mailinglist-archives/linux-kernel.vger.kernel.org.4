Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32E462CD56
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbiKPWFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbiKPWFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:05:24 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4C4657D6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668636322; x=1700172322;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TRcN4ib6LZEl+bAK2GLxbIo6SXnGdL7Qf7Qh62G03ak=;
  b=Ocg2j492skqIbYZI2X6pNl2PnE1INa5hraunwS4Od4437ZbJJz5RCIeC
   mbpNrercS43PoRghfFVpWOi9F0x0laDxV+IUWY9AXLJv+CmYM2tYMaHpe
   5DwbNtnONY7rcmKY4pgnIprVXE+8LVwy7/gP770pk3p2EmXBvxUpu1A7o
   4U2HJ6qpLZWQqOjAjIM5TO0moaCDw810O9uj6y4VAlZd+3PL9XDESn3Ff
   NweMwLGRdshQjxPqFAxVaR1EX2ZcgjacxikUTA6O67xZEx35maTjxtiwT
   OIOXFzgruYTJt25plkXaom+9TNGhmTTLVoUvu0AmbT6+pB7828ulh/0X0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="313830700"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="313830700"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 14:05:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="884583610"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="884583610"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2022 14:05:20 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovQX2-0002mP-04;
        Wed, 16 Nov 2022 22:05:20 +0000
Date:   Thu, 17 Nov 2022 06:04:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 23df39fc6a36183af5e6e4f47523f1ad2cdc1d30
Message-ID: <63755e7a.xa3f/nYh6TuRuQPr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: 23df39fc6a36183af5e6e4f47523f1ad2cdc1d30  locking: Fix qspinlock/x86 inline asm error

elapsed time: 722m

configs tested: 103
configs skipped: 82

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
i386                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                          randconfig-a005
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                           allyesconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arm                         s3c6400_defconfig
sparc64                             defconfig
arm                       multi_v4t_defconfig
powerpc                     asp8347_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a015
x86_64                        randconfig-a013
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                        randconfig-a011
m68k                          sun3x_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
m68k                           virt_defconfig
i386                          randconfig-c001
um                                  defconfig
sh                ecovec24-romimage_defconfig
arm                           sunxi_defconfig
powerpc                      makalu_defconfig
openrisc                       virt_defconfig
sh                          r7780mp_defconfig
sh                           se7751_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                          r7785rp_defconfig
arm                        realview_defconfig
powerpc                   currituck_defconfig
xtensa                    xip_kc705_defconfig
arm                             ezx_defconfig
arm                        oxnas_v6_defconfig
openrisc                 simple_smp_defconfig
openrisc                            defconfig
powerpc                    amigaone_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7705_defconfig
arm                            qcom_defconfig
sh                            titan_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                            ar7_defconfig
arm                            zeus_defconfig
microblaze                          defconfig
sh                          rsk7203_defconfig
sparc64                          alldefconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
s390                 randconfig-r044-20221116
riscv                randconfig-r042-20221116
hexagon              randconfig-r041-20221116
hexagon              randconfig-r045-20221116
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                     pseries_defconfig
hexagon              randconfig-r041-20221117
hexagon              randconfig-r045-20221117
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
