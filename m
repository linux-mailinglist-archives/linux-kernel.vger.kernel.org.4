Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E996DEAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjDLFUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLFT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:19:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA334488
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 22:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681276797; x=1712812797;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pkZPUGCNQDRlawo+IsWzUX4zYFOcd2DEA2R4UWwQ2Bc=;
  b=fr8Yk6cmIhQ93HL5xUJbBkIcSQ/0UdD29aTjoF4pCQpRHipDw1Q0H8QQ
   b+0H956eF0xkgqR2BloMRBv3zCL6t6nhI1blexXJIeqv4bFzE3MwArEFF
   SsP3zS6I9m7KuLyoXRbSI6wpiUyHkRHzegVUmN9d+bqZE0iPmT8sps1v6
   eYdWSHwGJ8toHytp+XRyq7I9fcfBGXaHLqiNpmMBAEV6Gqe/mTVf63ITl
   gBGwmPyz+q2AFsxXjAm8xmnhNbRaFwzV5jxUaMtSiXACAIFhtbt4LjF8F
   umCtoFw+rM82WmwQQgz29jiKa+xhE6Ng7TJnBug1AUxjcrHxY+yrCJ23s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="346479294"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="346479294"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 22:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="682360445"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="682360445"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Apr 2023 22:19:55 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmSte-000XJD-37;
        Wed, 12 Apr 2023 05:19:54 +0000
Date:   Wed, 12 Apr 2023 13:19:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp] BUILD SUCCESS
 26476022a5b2aa1f25bf1a14f5f4b8d89460d3a7
Message-ID: <64363f4e.CFfkWawHnL3ZUgVm%lkp@intel.com>
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
branch HEAD: 26476022a5b2aa1f25bf1a14f5f4b8d89460d3a7  s390/fcx: Replace zero-length array with flexible-array member

elapsed time: 727m

configs tested: 120
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230409   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r016-20230410   gcc  
arc                  randconfig-r043-20230409   gcc  
arc                  randconfig-r043-20230410   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r012-20230409   clang
arm                  randconfig-r033-20230412   gcc  
arm                  randconfig-r046-20230409   clang
arm                  randconfig-r046-20230410   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230410   clang
arm64                randconfig-r025-20230412   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r005-20230410   clang
hexagon              randconfig-r011-20230409   clang
hexagon              randconfig-r012-20230409   clang
hexagon              randconfig-r013-20230410   clang
hexagon              randconfig-r041-20230409   clang
hexagon              randconfig-r041-20230410   clang
hexagon              randconfig-r045-20230409   clang
hexagon              randconfig-r045-20230410   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-a011-20230410   gcc  
i386                          randconfig-a011   clang
i386                 randconfig-a012-20230410   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                          randconfig-a013   clang
i386                 randconfig-a014-20230410   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                          randconfig-a015   clang
i386                 randconfig-a016-20230410   gcc  
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230410   gcc  
ia64                 randconfig-r013-20230409   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r034-20230412   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r011-20230410   clang
mips                 randconfig-r032-20230412   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r024-20230412   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230409   gcc  
parisc               randconfig-r011-20230410   gcc  
parisc               randconfig-r026-20230412   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r006-20230409   clang
powerpc              randconfig-r015-20230410   gcc  
powerpc              randconfig-r036-20230412   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230409   clang
riscv                randconfig-r003-20230410   clang
riscv                randconfig-r004-20230409   clang
riscv                randconfig-r021-20230412   gcc  
riscv                randconfig-r031-20230412   clang
riscv                randconfig-r035-20230412   clang
riscv                randconfig-r042-20230409   gcc  
riscv                randconfig-r042-20230410   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230409   gcc  
s390                 randconfig-r044-20230410   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r004-20230410   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r023-20230412   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64               randconfig-r006-20230410   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r005-20230409   gcc  
xtensa               randconfig-r014-20230410   gcc  
xtensa               randconfig-r015-20230409   gcc  
xtensa               randconfig-r016-20230409   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
