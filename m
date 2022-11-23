Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C996361E6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbiKWOd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbiKWOdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:33:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861F02711
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669214000; x=1700750000;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5KSlm+Jdq25PM4rLNIkgi/Z8747RlCVc3qkXYjl+2Ng=;
  b=WAqONpGb0/4DIKqQG/YpICYe8qFVL4qj58e3Aa36KVYloqPMPH0yBrKJ
   dOypwPZ37aFtffhN7vRGz4aNJVDY3xlFZCLAymUd6GE4Nv81tCha5ok4/
   LUxesRtFk9P0yUjkBben+ujRX4SAEom9aWChj0+QW6hoT5WxUkb0GU0+x
   OGupRAWSwCbgb+M+Z/IHIVcv4ruyWn27k6reKj9LhRulddBCT81oadPPW
   lG6Nx6VfUvc00x8GLQFjHfEPtjI2eHc4oKKLmWUbGCPfVpq0CN1/JpQGe
   NaIpNeDP+jyaOtZyVSVBj8T8QhyxWVv1PWSxC4evnP10qeJpxDaCqvl5i
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="311706434"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="311706434"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 06:33:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="710603854"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="710603854"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Nov 2022 06:33:18 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxqoQ-0002oN-09;
        Wed, 23 Nov 2022 14:33:18 +0000
Date:   Wed, 23 Nov 2022 22:32:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 6007878a782eb96f50a71c3a06cf3e931cf8aac1
Message-ID: <637e2ef9.ZNsv8Ut5kZPhwjFT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 6007878a782eb96f50a71c3a06cf3e931cf8aac1  x86/cpu: Switch to cpu_feature_enabled() for X86_FEATURE_XENPV

elapsed time: 1228m

configs tested: 107
configs skipped: 85

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                            allnoconfig
i386                             allyesconfig
i386                                defconfig
s390                 randconfig-r044-20221121
riscv                randconfig-r042-20221121
arc                  randconfig-r043-20221121
i386                 randconfig-a014-20221121
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a016-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a015-20221121
mips                             allyesconfig
x86_64               randconfig-a011-20221121
x86_64               randconfig-a014-20221121
x86_64               randconfig-a012-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
ia64                             allmodconfig
s390                             allyesconfig
arm                           sunxi_defconfig
sh                           se7780_defconfig
sh                         ap325rxa_defconfig
arc                              allyesconfig
i386                          randconfig-c001
arm                          simpad_defconfig
powerpc                  iss476-smp_defconfig
sh                             espt_defconfig
arc                    vdk_hs38_smp_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                 mpc837x_mds_defconfig
sh                         microdev_defconfig
arc                               allnoconfig
arc                  randconfig-r043-20221120

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                 mpc832x_rdb_defconfig
mips                     cu1000-neo_defconfig
powerpc                    gamecube_defconfig
i386                 randconfig-a001-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
s390                 randconfig-r044-20221122
hexagon              randconfig-r041-20221122
riscv                randconfig-r042-20221122
hexagon              randconfig-r045-20221122
x86_64               randconfig-a002-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a003-20221121
x86_64                        randconfig-k001
powerpc                     tqm5200_defconfig
powerpc                        fsp2_defconfig
powerpc                     kmeter1_defconfig
i386                              allnoconfig
arm                       versatile_defconfig
arm                         mv78xx0_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
