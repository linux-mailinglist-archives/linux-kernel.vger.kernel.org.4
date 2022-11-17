Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6025D62DC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbiKQNFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiKQNFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:05:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E769445ED9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668690309; x=1700226309;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jRvX/pxCCG2xTdfCqddChD8tZuE8K0P+engR+Y4GNk4=;
  b=XmNI5HaIyAanHKSJ4faOlqV8rMGBy9NeLxsainFP4zwHwxbM6HWVJztq
   o1wcobXrv1Ru1Rp+GccTSRFbkMfM3nohteasHpfOkNtZUNMlQXdTnsNKW
   CiTDs6n3EQcbvpsmlzMAftlmwyJ51rQfeBAbPiWJbZLMxUbR6hpmo3hsi
   qegxvo8Hg/dFC3WweA+zEbjJrmbI3+0g0jTsn6n3JZcgQ0wC44anra/5N
   xdq2zB274NFGpgX802h7Gu7YvvL5kjhlNeJvEYd6HwjkBpjRh850DOMx3
   I3X6tBF8a7MX9cgg2WZzyJOL31qOIYhnKfzwslHytGZEB8ebzqdr+S0xJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="314659036"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="314659036"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 05:03:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="968870184"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="968870184"
Received: from lkp-server01.sh.intel.com (HELO 55744f5052f8) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 17 Nov 2022 05:03:57 -0800
Received: from kbuild by 55744f5052f8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oveYe-0000Kk-1q;
        Thu, 17 Nov 2022 13:03:56 +0000
Date:   Thu, 17 Nov 2022 21:03:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 6ea25770b043c7997ab21d1ce95ba5de4d3d85d9
Message-ID: <63763104.X6UwBS43e/97jARZ%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: 6ea25770b043c7997ab21d1ce95ba5de4d3d85d9  selftests/vm/pkeys: Add a regression test for setting PKRU through ptrace

elapsed time: 832m

configs tested: 91
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                           rhel-8.3-syz
i386                                defconfig
x86_64                              defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arc                  randconfig-r043-20221117
x86_64                        randconfig-a015
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
riscv                randconfig-r042-20221117
x86_64                               rhel-8.3
s390                 randconfig-r044-20221117
x86_64                           allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                             allyesconfig
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                            allnoconfig
ia64                             allmodconfig
sh                          sdk7786_defconfig
arm                            zeus_defconfig
openrisc                            defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
s390                             allmodconfig
s390                             allyesconfig
um                               alldefconfig
sh                           se7722_defconfig
sh                         ap325rxa_defconfig
i386                          randconfig-c001
powerpc                      bamboo_defconfig
powerpc                     mpc83xx_defconfig
openrisc                 simple_smp_defconfig
sh                        sh7757lcr_defconfig
sh                        sh7785lcr_defconfig
arm                            hisi_defconfig
sh                  sh7785lcr_32bit_defconfig
arc                               allnoconfig
powerpc                    klondike_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                ecovec24-romimage_defconfig
arm                           tegra_defconfig
mips                        vocore2_defconfig
arm                       omap2plus_defconfig
arm                           stm32_defconfig
sh                           se7705_defconfig
powerpc                       maple_defconfig
sh                        edosk7705_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a012
i386                          randconfig-a006
x86_64                        randconfig-a014
hexagon              randconfig-r041-20221117
x86_64                        randconfig-a016
hexagon              randconfig-r045-20221117
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
x86_64                        randconfig-a005
i386                          randconfig-a011
i386                          randconfig-a015
powerpc                          g5_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
