Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D986CB924
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjC1IQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjC1IP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:15:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F23CD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679991357; x=1711527357;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=su2RAg42HKQ/QqC6G3QAA2ri67/sMLf015KnVUs3GGI=;
  b=VctpGfBuQt/Sij1oNxDrP2o7fdhGiWKVsnS9jSU2qTgmBG/FpaDJP+Mo
   yansjYBJ82klL/FjZpm8hUj5FeUDshdVRZbx6TSXqFi0/boTHLee2vzVg
   1jkvxt0CCW/pHHwMKTC1atiYtb/raLzNX42fb+EuUgZWT1/2Bc0+Hmy5T
   e0npEZZmDEsPohpkTDzqqXoPvYKPGLAtSWmCc/Vq+eoe5C3rR7qy9cR1z
   W54jrFUmpj3F5AxLvgolCJE1klnEZENUk4Hq2cfWuEtE7MYGTaMDV4wKn
   0ziXyu2dTD//be4XjeujbgH8o7E+Jt1U8nUwVt0+eSJK+mpfun0+KHeZ2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320903451"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="320903451"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:15:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="1013459599"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="1013459599"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Mar 2023 01:15:56 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ph4Ul-000IO1-2B;
        Tue, 28 Mar 2023 08:15:55 +0000
Date:   Tue, 28 Mar 2023 16:15:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 812b0597fb4043240724e4c7bed7ba1fe15c0e3f
Message-ID: <6422a21b.f63C/Epl6twvq8nf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: 812b0597fb4043240724e4c7bed7ba1fe15c0e3f  x86/hyperv: Change vTOM handling to use standard coco mechanisms

elapsed time: 721m

configs tested: 129
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230326   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r032-20230326   gcc  
alpha                randconfig-r035-20230327   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230327   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r034-20230326   gcc  
arc                  randconfig-r043-20230326   gcc  
arc                  randconfig-r043-20230327   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r006-20230327   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r006-20230327   clang
arm                  randconfig-r046-20230326   clang
arm                  randconfig-r046-20230327   gcc  
arm                        vexpress_defconfig   clang
arm                    vt8500_v6_v7_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230327   gcc  
arm64                randconfig-r002-20230327   gcc  
csky         buildonly-randconfig-r005-20230327   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230326   gcc  
csky                 randconfig-r013-20230326   gcc  
csky                 randconfig-r016-20230326   gcc  
hexagon      buildonly-randconfig-r002-20230326   clang
hexagon      buildonly-randconfig-r006-20230326   clang
hexagon              randconfig-r041-20230326   clang
hexagon              randconfig-r041-20230327   clang
hexagon              randconfig-r045-20230326   clang
hexagon              randconfig-r045-20230327   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230327   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230327   gcc  
i386                 randconfig-a002-20230327   gcc  
i386                 randconfig-a003-20230327   gcc  
i386                 randconfig-a004-20230327   gcc  
i386                 randconfig-a005-20230327   gcc  
i386                 randconfig-a006-20230327   gcc  
i386                 randconfig-a011-20230327   clang
i386                 randconfig-a012-20230327   clang
i386                 randconfig-a013-20230327   clang
i386                 randconfig-a014-20230327   clang
i386                 randconfig-a015-20230327   clang
i386                 randconfig-a016-20230327   clang
i386                          randconfig-c001   gcc  
i386                 randconfig-r004-20230327   gcc  
i386                 randconfig-r031-20230327   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230327   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r015-20230326   gcc  
loongarch            randconfig-r033-20230327   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230326   gcc  
m68k         buildonly-randconfig-r003-20230326   gcc  
m68k         buildonly-randconfig-r003-20230327   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230327   gcc  
m68k                 randconfig-r014-20230326   gcc  
m68k                 randconfig-r031-20230326   gcc  
microblaze           randconfig-r036-20230326   gcc  
microblaze           randconfig-r036-20230327   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230327   gcc  
nios2                randconfig-r016-20230327   gcc  
nios2                randconfig-r034-20230327   gcc  
openrisc             randconfig-r011-20230326   gcc  
openrisc             randconfig-r014-20230327   gcc  
openrisc             randconfig-r016-20230326   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-c003-20230326   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r013-20230326   gcc  
riscv                randconfig-r042-20230326   gcc  
riscv                randconfig-r042-20230327   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r032-20230327   gcc  
s390                 randconfig-r044-20230326   gcc  
s390                 randconfig-r044-20230327   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r011-20230326   gcc  
sparc        buildonly-randconfig-r005-20230326   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230326   gcc  
sparc                randconfig-r033-20230326   gcc  
sparc64              randconfig-r012-20230326   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230327   gcc  
x86_64               randconfig-a002-20230327   gcc  
x86_64               randconfig-a003-20230327   gcc  
x86_64               randconfig-a004-20230327   gcc  
x86_64               randconfig-a005-20230327   gcc  
x86_64               randconfig-a006-20230327   gcc  
x86_64               randconfig-a011-20230327   clang
x86_64               randconfig-a012-20230327   clang
x86_64               randconfig-a013-20230327   clang
x86_64               randconfig-a014-20230327   clang
x86_64               randconfig-a015-20230327   clang
x86_64               randconfig-a016-20230327   clang
x86_64                        randconfig-k001   clang
x86_64               randconfig-r003-20230327   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r005-20230327   gcc  
xtensa               randconfig-r035-20230326   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
