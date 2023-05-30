Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E82A715DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjE3Lqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjE3LqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:46:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C6B11D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685447153; x=1716983153;
  h=date:from:to:cc:subject:message-id;
  bh=kLcOmThgMRUBWffJCY07dtPldZBKNW1u1iQmcVV4D30=;
  b=KroAW7QYSCeqpwsMoA7nanSzU1gOH4W1B08kbWcrwm9UYdKe+Ck+Ee/4
   aQNYNnvK0M6hWGf7F4kCM6kZCJhuiRMpHXCuyGSUq34TAUxOSW8XTsdCg
   RyA6/hsLmZAPJ/oLC5VbQh7MeGE5slJPNOby7r4LSL33OyRxw7h4jPEsf
   pE7VQzg/4NKC5RayCqm3MRGN8NEoCfqxmKcMSVJD+KSyrM2/M7eSgbgFp
   a/D3fW8Ph/TcgIHaAK+V5/mBb8z+B/kliySsO52W/cL8FDj60Fb/o2jII
   WQxDlx4OjggJtdQ4D3PjJiGYFezCsDMmxeJO0CbXudHqlwv5Z/WgLUU39
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420649546"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="420649546"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 04:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="830722480"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="830722480"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2023 04:43:52 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3xlX-000095-25;
        Tue, 30 May 2023 11:43:51 +0000
Date:   Tue, 30 May 2023 19:43:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230523] BUILD SUCCESS
 79f37528bdf81098f82051561b82a09b46060fff
Message-ID: <20230530114305.whdKX%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230523
branch HEAD: 79f37528bdf81098f82051561b82a09b46060fff  firewire: Replace zero-length array with flexible-array member

elapsed time: 936m

configs tested: 149
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230529   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230529   gcc  
arc                  randconfig-r005-20230529   gcc  
arc                  randconfig-r006-20230529   gcc  
arc                  randconfig-r043-20230529   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230529   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r024-20230529   gcc  
arm64                randconfig-r026-20230529   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230529   clang
hexagon              randconfig-r045-20230529   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230529   clang
i386                 randconfig-i002-20230529   clang
i386                 randconfig-i003-20230529   clang
i386                 randconfig-i004-20230529   clang
i386                 randconfig-i005-20230529   clang
i386                 randconfig-i006-20230529   clang
i386                 randconfig-i011-20230529   gcc  
i386                 randconfig-i012-20230529   gcc  
i386                 randconfig-i013-20230529   gcc  
i386                 randconfig-i014-20230529   gcc  
i386                 randconfig-i015-20230529   gcc  
i386                 randconfig-i016-20230529   gcc  
i386                 randconfig-i051-20230529   clang
i386                 randconfig-i052-20230529   clang
i386                 randconfig-i053-20230529   clang
i386                 randconfig-i054-20230529   clang
i386                 randconfig-i055-20230529   clang
i386                 randconfig-i056-20230529   clang
i386                 randconfig-i061-20230529   clang
i386                 randconfig-i062-20230529   clang
i386                 randconfig-i063-20230529   clang
i386                 randconfig-i064-20230529   clang
i386                 randconfig-i065-20230529   clang
i386                 randconfig-i066-20230529   clang
i386                 randconfig-i071-20230529   gcc  
i386                 randconfig-i072-20230529   gcc  
i386                 randconfig-i073-20230529   gcc  
i386                 randconfig-i074-20230529   gcc  
i386                 randconfig-i075-20230529   gcc  
i386                 randconfig-i076-20230529   gcc  
i386                 randconfig-i081-20230529   gcc  
i386                 randconfig-i082-20230529   gcc  
i386                 randconfig-i083-20230529   gcc  
i386                 randconfig-i084-20230529   gcc  
i386                 randconfig-i085-20230529   gcc  
i386                 randconfig-i086-20230529   gcc  
i386                 randconfig-i091-20230529   clang
i386                 randconfig-i092-20230529   clang
i386                 randconfig-i093-20230529   clang
i386                 randconfig-i094-20230529   clang
i386                 randconfig-i095-20230529   clang
i386                 randconfig-i096-20230529   clang
i386                 randconfig-r021-20230529   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r004-20230529   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r014-20230529   gcc  
loongarch            randconfig-r036-20230529   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230529   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r015-20230529   clang
nios2        buildonly-randconfig-r005-20230529   gcc  
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230529   gcc  
parisc               randconfig-r032-20230529   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r001-20230529   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r031-20230529   clang
riscv                randconfig-r042-20230529   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230529   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230529   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230529   gcc  
sh                   randconfig-r025-20230529   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r033-20230529   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a011-20230529   gcc  
x86_64               randconfig-a012-20230529   gcc  
x86_64               randconfig-a013-20230529   gcc  
x86_64               randconfig-a014-20230529   gcc  
x86_64               randconfig-a015-20230529   gcc  
x86_64               randconfig-a016-20230529   gcc  
x86_64               randconfig-x051-20230529   gcc  
x86_64               randconfig-x052-20230529   gcc  
x86_64               randconfig-x053-20230529   gcc  
x86_64               randconfig-x054-20230529   gcc  
x86_64               randconfig-x055-20230529   gcc  
x86_64               randconfig-x056-20230529   gcc  
x86_64               randconfig-x061-20230529   gcc  
x86_64               randconfig-x062-20230529   gcc  
x86_64               randconfig-x063-20230529   gcc  
x86_64               randconfig-x064-20230529   gcc  
x86_64               randconfig-x065-20230529   gcc  
x86_64               randconfig-x066-20230529   gcc  
x86_64               randconfig-x071-20230529   clang
x86_64               randconfig-x072-20230529   clang
x86_64               randconfig-x073-20230529   clang
x86_64               randconfig-x074-20230529   clang
x86_64               randconfig-x075-20230529   clang
x86_64               randconfig-x076-20230529   clang
x86_64               randconfig-x081-20230529   clang
x86_64               randconfig-x082-20230529   clang
x86_64               randconfig-x083-20230529   clang
x86_64               randconfig-x084-20230529   clang
x86_64               randconfig-x085-20230529   clang
x86_64               randconfig-x086-20230529   clang
x86_64               randconfig-x091-20230529   gcc  
x86_64               randconfig-x092-20230529   gcc  
x86_64               randconfig-x093-20230529   gcc  
x86_64               randconfig-x094-20230529   gcc  
x86_64               randconfig-x095-20230529   gcc  
x86_64               randconfig-x096-20230529   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r011-20230529   gcc  
xtensa               randconfig-r013-20230529   gcc  
xtensa               randconfig-r022-20230529   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
