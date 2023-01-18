Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D5B672CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjARXul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjARXuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:50:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4679E6B9AE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674085744; x=1705621744;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+LOfBq+Aao/sEoiKtiPeuf9OfnQ+MpGFZZxuavYpPi8=;
  b=TOihqN+FGzs2dbca5ZclR1UP8c9gP7HPmT0QhU2lMMxSb8lpPEPCTjYh
   x63TMwDanLsnte0JHSwiujIjGj9C53zgMrzMo4kM+4JucfGZNjwNSWYhP
   kQRAEM6N2ybp0zQVZgcpXQam0sdicxN9nP+6AsbYMXNwnAkkpHyMgmrD/
   jl+BpDi69mO2dPqgvKwswAxCaNFu1MX1opKqxspYRl3vdNiYcKnGpjrHr
   pVtdlhzlur+ELtCOuh5C6+SdmIxVJUHlpzSOs2bBc1zwVe2ITdm5qjVK7
   mtxyjIIPcip+arg58Sg1hu617yrSw1yC55D+Qg8Qzbfle8CvalbJl/TrZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="304820879"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="304820879"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 15:48:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="748679588"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="748679588"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jan 2023 15:48:20 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIIAF-0000pA-1a;
        Wed, 18 Jan 2023 23:48:19 +0000
Date:   Thu, 19 Jan 2023 07:47:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 59047d942bedc4ce88a2121a9f9e656b9532dd30
Message-ID: <63c88516.dBM4fCZYB/adkVSb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 59047d942bedc4ce88a2121a9f9e656b9532dd30  x86/microcode: Use the DEVICE_ATTR_RO() macro

elapsed time: 725m

configs tested: 86
configs skipped: 72

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
ia64                             allmodconfig
m68k                       m5208evb_defconfig
arm                         s3c6400_defconfig
sh                        dreamcast_defconfig
xtensa                              defconfig
mips                       bmips_be_defconfig
i386                             allyesconfig
i386                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
sh                             sh03_defconfig
powerpc                     ep8248e_defconfig
powerpc                      ppc6xx_defconfig
m68k                        m5307c3_defconfig
powerpc                      cm5200_defconfig
arm64                            alldefconfig
sh                 kfr2r09-romimage_defconfig
riscv                randconfig-r042-20230118
s390                 randconfig-r044-20230118
arc                  randconfig-r043-20230118
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-c001
nios2                            allyesconfig
nios2                               defconfig
parisc64                            defconfig
sh                                  defconfig
powerpc                mpc7448_hpc2_defconfig
parisc                           allyesconfig
microblaze                      mmu_defconfig
mips                           ip32_defconfig
openrisc                            defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
mips                          rm200_defconfig
powerpc                     skiroot_defconfig
mips                          ath25_defconfig
mips                     loongson2k_defconfig
powerpc                     ppa8548_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                    socrates_defconfig
arm                          ep93xx_defconfig
arm                      tct_hammer_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                              alldefconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
mips                     cu1830-neo_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
