Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C320672D37
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjARX7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjARX64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:58:56 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0E838E82
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674086306; x=1705622306;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MDml57goNm9aFbw1RyY5xqdXhKQaLJ2a1uq4OnNWFpk=;
  b=eaWhjq6Nnrsny7xo4owqdDdtZwUULMaGtZs78rt+rzczFT0NZCbbkhma
   GyqSXNWatYN8gmtQTIxIuH0B9TjM3dtZuv71shKen0+ndSf7/TVD1mInj
   dvRjsb5uLl6dM28zKpRNNPBKy4fCJmaEUrfB/Pd6FUmgYsvgbOZ9B/lDg
   HP4Fut81mEMn36477kU/oLEPg0M3wVjtwUVK9D6P1pPncGAI8j3380QDG
   O7MtGvGFyFoRa2afaSHigUYU+a82T5KHLDYx/uG1iR+5taO1wxvpUPqOC
   xcd4g+XSnHLMIWbmNg0vIK7Woj42CCrpWMFzZbMyVY+zs57CzuP284FBi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322829261"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322829261"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 15:58:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="748680451"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="748680451"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jan 2023 15:58:25 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIIJv-0000pm-2U;
        Wed, 18 Jan 2023 23:58:19 +0000
Date:   Thu, 19 Jan 2023 07:57:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 5a8a05f165fb18d37526062419774d9088c2a9b9
Message-ID: <63c8877b.3MYBlUzUtI2gh0Ke%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 5a8a05f165fb18d37526062419774d9088c2a9b9  perf/x86/intel/cstate: Add Emerald Rapids

elapsed time: 728m

configs tested: 86
configs skipped: 60

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
sh                             sh03_defconfig
powerpc                     ep8248e_defconfig
powerpc                      ppc6xx_defconfig
m68k                        m5307c3_defconfig
powerpc                      cm5200_defconfig
arm64                            alldefconfig
sh                 kfr2r09-romimage_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
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
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
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
