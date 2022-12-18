Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F2564FE00
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 08:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiLRHGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 02:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiLRHGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 02:06:15 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F735616E
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 23:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671347174; x=1702883174;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Mk4tXhVg7FhZzbLnDclHzkAdSvX9nFjEdgOykiCRWRE=;
  b=ih3rNuphUWNufBTgdidnyEnshPLmlHsKxqFZ+s9B2L2/fBKhVAPrlVmK
   ByK3ntoljx91scXBhEEDM9FT7o44bHYRDfAfjUGAzuv3/JFvOCrFFzkaW
   FszTqOntvi97odF664zWfJY37EKTdSb8OgIlVTPVsfgMxDiIeC34xxtfB
   dcfsfYsmu2IhBngflkgDFOj5ERV9PPUdNtNMnaBrrmBdHuDAujby5Siqh
   qhdApcEPd76tZauwL0lB62yiYG0WI8ZIOMkg3c/kI4kjsidPpjboXqhpb
   9oQ4LbNmVXN6Uv0cDZ3qJXF178E8Z4ioB51xTJYeW0w/PRCCdqtDM7/Wx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="383526501"
X-IronPort-AV: E=Sophos;i="5.96,254,1665471600"; 
   d="scan'208";a="383526501"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2022 23:06:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="600351863"
X-IronPort-AV: E=Sophos;i="5.96,254,1665471600"; 
   d="scan'208";a="600351863"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Dec 2022 23:06:12 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p6nkR-000882-2j;
        Sun, 18 Dec 2022 07:06:11 +0000
Date:   Sun, 18 Dec 2022 15:05:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 3e844d842d49cdbe61a4b338bdd512654179488a
Message-ID: <639ebbd6.OUlRrxaDCIyTVX1G%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 3e844d842d49cdbe61a4b338bdd512654179488a  x86/mm: Ensure forced page table splitting

elapsed time: 3438m

configs tested: 177
configs skipped: 23

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
arc                  randconfig-r043-20221215
arm                  randconfig-r046-20221215
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
ia64                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
m68k                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                            allnoconfig
sh                           se7724_defconfig
m68k                             alldefconfig
powerpc                      chrp32_defconfig
ia64                            zx1_defconfig
powerpc                  storcenter_defconfig
arm                          exynos_defconfig
arc                            hsdk_defconfig
sh                        sh7763rdp_defconfig
powerpc                         wii_defconfig
arm                            lart_defconfig
m68k                       m5249evb_defconfig
sh                            hp6xx_defconfig
m68k                           virt_defconfig
powerpc                     tqm8548_defconfig
i386                          randconfig-c001
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-c001
arm                  randconfig-c002-20221216
powerpc                     taishan_defconfig
powerpc                      mgcoge_defconfig
powerpc                        cell_defconfig
sh                           se7722_defconfig
sh                          sdk7780_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                           stm32_defconfig
powerpc                     redwood_defconfig
sh                         microdev_defconfig
mips                          rb532_defconfig
sh                   rts7751r2dplus_defconfig
sh                          rsk7203_defconfig
arm                           corgi_defconfig
arm                           sama5_defconfig
sh                          r7780mp_defconfig
arm                            qcom_defconfig
arm                           u8500_defconfig
openrisc                            defconfig
arm                          simpad_defconfig
xtensa                  nommu_kc705_defconfig
sh                      rts7751r2d1_defconfig
arm                         s3c6400_defconfig
powerpc                         ps3_defconfig
m68k                          amiga_defconfig
powerpc                        warp_defconfig
xtensa                  cadence_csp_defconfig
arc                    vdk_hs38_smp_defconfig
sh                           se7705_defconfig
powerpc                       maple_defconfig
sparc                             allnoconfig
mips                      loongson3_defconfig
mips                       bmips_be_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
parisc                           allyesconfig
powerpc                      bamboo_defconfig
powerpc                     pq2fads_defconfig
parisc64                         alldefconfig
i386                          randconfig-a016
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a003
arc                         haps_hs_defconfig
arm                        clps711x_defconfig
ia64                             alldefconfig
i386                          randconfig-a005
arc                  randconfig-r043-20221218
i386                          randconfig-a001
s390                 randconfig-r044-20221218
arm                         assabet_defconfig
arm                            xcep_defconfig
riscv                randconfig-r042-20221218
sh                   sh7724_generic_defconfig
sh                        edosk7705_defconfig
xtensa                           alldefconfig
sh                          sdk7786_defconfig
arm                            mps2_defconfig
m68k                       m5208evb_defconfig
arm                           imxrt_defconfig
arm                      integrator_defconfig
arm                  randconfig-c002-20221218
riscv                               defconfig

clang tested configs:
hexagon              randconfig-r041-20221215
hexagon              randconfig-r045-20221215
riscv                randconfig-r042-20221215
s390                 randconfig-r044-20221215
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
arm                          moxart_defconfig
mips                        qi_lb60_defconfig
arm                      tct_hammer_defconfig
powerpc                 mpc8313_rdb_defconfig
x86_64                        randconfig-k001
powerpc                 mpc8560_ads_defconfig
powerpc                     ppa8548_defconfig
arm                         lpc32xx_defconfig
mips                      pic32mzda_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                          malta_defconfig
powerpc                      katmai_defconfig
hexagon              randconfig-r045-20221216
arm                  randconfig-r046-20221216
hexagon              randconfig-r041-20221216
powerpc                     akebono_defconfig
arm                  randconfig-r046-20221218
hexagon              randconfig-r041-20221218
hexagon              randconfig-r045-20221218
mips                  cavium_octeon_defconfig
powerpc                     pseries_defconfig
riscv                    nommu_virt_defconfig
powerpc                     mpc5200_defconfig
mips                     cu1000-neo_defconfig
mips                      malta_kvm_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
