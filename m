Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F498671484
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjARGqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjARG20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:28:26 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4381DB96
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674022837; x=1705558837;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XCN/SExdHkdJsQOFL3CmptmyuewqKYPv66rpGpuL984=;
  b=lQ1cd6UsPWJeEblEeNY9BTlMKjjHPTmKtFEgw3m3OypusnOHjzR/e90o
   +azrj2q3pH0FensImb9V2L+Bh+yC0r0GAmDKpoKKeMqiTB/OiXSYMNtMx
   SKXwj21CGzmQ/MybJLMISxeF0o2vzGhUx8YFYom1P2shrFhbCD4ZjBUhi
   jzA3siOnGpfJ9uQVIjzo+72Xo2Wyr/dCgOcsSZoyxTPqfWyS3uObVNw9i
   BjH8kJxQj2iik5zxJ54YMuFm5OQbAFRE1ywpQQEIED+O1jfEU0hpC//FP
   IUeYjF8qOZ1QTQkvzia26kzjxS8qj2y2khpdk/GVDiR3WVmZkqMxFZDwZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="308473197"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="308473197"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 22:20:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="661591430"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="661591430"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jan 2023 22:20:33 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pI1oH-00003U-0D;
        Wed, 18 Jan 2023 06:20:33 +0000
Date:   Wed, 18 Jan 2023 14:20:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 6a6dcae8f486c3f3298d0767d34505121c7b0b81
Message-ID: <63c78f98.DSlkb0HIBfiEkdub%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 6a6dcae8f486c3f3298d0767d34505121c7b0b81  blk-mq: Build default queue map via group_cpus_evenly()

elapsed time: 722m

configs tested: 101
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
x86_64                            allnoconfig
s390                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                            allyesconfig
m68k                             allmodconfig
s390                                defconfig
arc                              allyesconfig
i386                                defconfig
x86_64                              defconfig
m68k                             allyesconfig
arm                                 defconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
i386                 randconfig-a014-20230116
x86_64               randconfig-a011-20230116
i386                 randconfig-a013-20230116
x86_64               randconfig-a013-20230116
powerpc                          allmodconfig
s390                             allyesconfig
x86_64               randconfig-a012-20230116
i386                 randconfig-a012-20230116
x86_64                          rhel-8.3-func
i386                 randconfig-a011-20230116
x86_64               randconfig-a015-20230116
x86_64               randconfig-a014-20230116
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a015-20230116
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
arm                              allyesconfig
x86_64               randconfig-a016-20230116
i386                 randconfig-a016-20230116
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
arm64                            allyesconfig
i386                             allyesconfig
x86_64                           rhel-8.3-bpf
ia64                             allmodconfig
riscv                randconfig-r042-20230116
arc                  randconfig-r043-20230116
arm                  randconfig-r046-20230117
arc                  randconfig-r043-20230117
s390                 randconfig-r044-20230116
i386                          randconfig-c001
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm                  randconfig-r046-20230115
arc                  randconfig-r043-20230115
i386                 randconfig-c001-20230116
m68k                          hp300_defconfig
arm                            lart_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                      bamboo_defconfig
arm                           imxrt_defconfig
powerpc                      makalu_defconfig
arm                        cerfcube_defconfig
ia64                        generic_defconfig
sh                 kfr2r09-romimage_defconfig
openrisc                         alldefconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a001-20230116
x86_64               randconfig-a003-20230116
x86_64               randconfig-a004-20230116
x86_64               randconfig-a002-20230116
x86_64               randconfig-a005-20230116
x86_64               randconfig-a006-20230116
i386                 randconfig-a002-20230116
i386                 randconfig-a004-20230116
i386                 randconfig-a003-20230116
hexagon              randconfig-r041-20230116
hexagon              randconfig-r045-20230117
hexagon              randconfig-r041-20230117
arm                  randconfig-r046-20230116
hexagon              randconfig-r045-20230116
riscv                randconfig-r042-20230117
i386                 randconfig-a005-20230116
s390                 randconfig-r044-20230117
i386                 randconfig-a006-20230116
i386                 randconfig-a001-20230116
x86_64                        randconfig-k001
powerpc                      acadia_defconfig
arm                        magician_defconfig
riscv                             allnoconfig
arm                          sp7021_defconfig
powerpc                     ppa8548_defconfig
powerpc                     tqm8560_defconfig
arm                  colibri_pxa270_defconfig
arm                         hackkit_defconfig
mips                          malta_defconfig
mips                        qi_lb60_defconfig
arm                           sama7_defconfig
riscv                          rv32_defconfig
powerpc                    mvme5100_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
