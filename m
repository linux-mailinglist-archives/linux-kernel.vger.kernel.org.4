Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062996ADC39
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjCGKoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjCGKoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:44:06 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5F434322
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678185843; x=1709721843;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rG0q7lxYDVv1UdxfjeLxNqfW9ZxNFozqg2846eLMZLA=;
  b=L1UigzlW3CBwI7uTFEMRQw0H20HbwdVkOooXG9/m1YpQKWOFS8YlAqyN
   muPPs64Os6rOq6G/lQHDPgUw+UuLc0ZhpqXnFTx6ekJPNLaO+nD5v5MtZ
   ljBxLYxQRY0Vs0ktcgUaLPA9Dj3U1tSIFTvDmWqAYjya/gukFdtfxYBrp
   9GSlogsuGLuGl1UoCFdilSWFZ0FP/mm315qATy1mpjJ7QenBXzFE9DO1O
   pTj9bk1mPcWkmdpgOMPqzDdpNfi/wrfHbKNHe90mEuiD2RGmZ/+rm9HbM
   g+wiguKwCHodWF484avGNMzG91sdCZaREYENcz6UKzd5JHMAIW++xxVYB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398398945"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="398398945"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 02:44:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="678872499"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="678872499"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 07 Mar 2023 02:44:01 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZUnY-0001EA-2E;
        Tue, 07 Mar 2023 10:44:00 +0000
Date:   Tue, 07 Mar 2023 18:43:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp] BUILD SUCCESS
 edfea16a6dae9c03bdc97babdd69960093263354
Message-ID: <64071565.PQ1k25hcVQxhK8DP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp
branch HEAD: edfea16a6dae9c03bdc97babdd69960093263354  drm/vmwgfx: Replace one-element array with flexible-array member

elapsed time: 859m

configs tested: 132
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230306   gcc  
alpha                randconfig-r016-20230305   gcc  
alpha                randconfig-r033-20230306   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230305   gcc  
arc                  randconfig-r043-20230305   gcc  
arc                  randconfig-r043-20230306   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230305   gcc  
arm                  randconfig-r034-20230305   gcc  
arm                  randconfig-r035-20230306   clang
arm                  randconfig-r046-20230305   clang
arm                  randconfig-r046-20230306   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230305   clang
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r004-20230306   gcc  
csky         buildonly-randconfig-r005-20230306   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230305   gcc  
csky                 randconfig-r004-20230306   gcc  
hexagon      buildonly-randconfig-r001-20230305   clang
hexagon              randconfig-r004-20230305   clang
hexagon              randconfig-r006-20230306   clang
hexagon              randconfig-r011-20230306   clang
hexagon              randconfig-r041-20230305   clang
hexagon              randconfig-r041-20230306   clang
hexagon              randconfig-r045-20230305   clang
hexagon              randconfig-r045-20230306   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230306   gcc  
i386                 randconfig-a002-20230306   gcc  
i386                 randconfig-a003-20230306   gcc  
i386                 randconfig-a004-20230306   gcc  
i386                 randconfig-a005-20230306   gcc  
i386                 randconfig-a006-20230306   gcc  
i386                 randconfig-a011-20230306   clang
i386                 randconfig-a012-20230306   clang
i386                 randconfig-a013-20230306   clang
i386                 randconfig-a014-20230306   clang
i386                 randconfig-a015-20230306   clang
i386                 randconfig-a016-20230306   clang
i386                 randconfig-r001-20230306   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230305   gcc  
ia64                 randconfig-r021-20230305   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230305   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r013-20230305   gcc  
microblaze           randconfig-r013-20230306   gcc  
microblaze           randconfig-r033-20230305   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r015-20230305   clang
mips                 randconfig-r024-20230305   clang
nios2                               defconfig   gcc  
nios2                randconfig-r031-20230306   gcc  
openrisc             randconfig-r014-20230306   gcc  
parisc       buildonly-randconfig-r005-20230305   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230305   gcc  
parisc               randconfig-r014-20230305   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r025-20230305   gcc  
powerpc              randconfig-r036-20230305   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230305   gcc  
riscv        buildonly-randconfig-r006-20230306   clang
riscv                               defconfig   gcc  
riscv                randconfig-r023-20230305   gcc  
riscv                randconfig-r042-20230305   gcc  
riscv                randconfig-r042-20230306   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230306   clang
s390                 randconfig-r044-20230305   gcc  
s390                 randconfig-r044-20230306   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230306   gcc  
sh           buildonly-randconfig-r003-20230305   gcc  
sh                   randconfig-r012-20230306   gcc  
sh                   randconfig-r015-20230306   gcc  
sh                   randconfig-r022-20230305   gcc  
sh                   randconfig-r031-20230305   gcc  
sh                   randconfig-r034-20230306   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230305   gcc  
sparc                randconfig-r005-20230306   gcc  
sparc                randconfig-r032-20230306   gcc  
sparc                randconfig-r035-20230305   gcc  
sparc64      buildonly-randconfig-r001-20230306   gcc  
sparc64              randconfig-r026-20230305   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230306   gcc  
x86_64               randconfig-a002-20230306   gcc  
x86_64               randconfig-a003-20230306   gcc  
x86_64               randconfig-a004-20230306   gcc  
x86_64               randconfig-a005-20230306   gcc  
x86_64               randconfig-a006-20230306   gcc  
x86_64               randconfig-a011-20230306   clang
x86_64               randconfig-a012-20230306   clang
x86_64               randconfig-a013-20230306   clang
x86_64               randconfig-a014-20230306   clang
x86_64               randconfig-a015-20230306   clang
x86_64               randconfig-a016-20230306   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230305   gcc  
xtensa               randconfig-r003-20230306   gcc  
xtensa               randconfig-r032-20230305   gcc  
xtensa               randconfig-r036-20230306   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
