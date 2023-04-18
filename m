Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B786E6FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 01:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjDRXWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 19:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjDRXWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 19:22:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F6E46AA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 16:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681860138; x=1713396138;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5gLyYdJzwV9LWNd+nqtYWxK9za+8EO302Vs8Fgdo7TM=;
  b=R81Zm/OmtAdz/gqqHLUZVAjZfEbNmhpGkDa2UN8sycf9GxKp2G7jJmAb
   CsRlfnnC3PXXIEX0TFT60gJ3o18E4+HF6iM9kJeFZ4zojwHaiQBLK/JoQ
   8XYx7MXSJPa1dJX8+IUIxTEgFkFYsTXFBE0NUm6hCeEr3tLm6W2Qrqy6Q
   ptpJlN/2xsqZ5gU8cFthzuPykB2N+tq7Ptg4nVFHuqgKYXA9EvJmIlKKf
   gtyNhCh7e9DYhOu2q6zzwNHMtGHDte1uHlNH5BxCjfBW/tOI8RnXrSBCu
   7MI/emxybBXd2NB8dfhdP0WDvSrzZbYCAZ4c0NeMqRJun43hE02uwENM0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="345303616"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="345303616"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 16:22:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="684779077"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="684779077"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Apr 2023 16:22:16 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poueN-000eCf-3B;
        Tue, 18 Apr 2023 23:22:15 +0000
Date:   Wed, 19 Apr 2023 07:22:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 66f0d3f79c23210822aaec1e9c3a985129258d01
Message-ID: <643f2625.NpPahw/uyo7FHsQY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 66f0d3f79c23210822aaec1e9c3a985129258d01  Merge branch into tip/master: 'x86/tdx'

elapsed time: 733m

configs tested: 137
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230417   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230409   gcc  
alpha                randconfig-r021-20230417   gcc  
alpha                randconfig-r025-20230410   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230416   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r014-20230416   gcc  
arc                  randconfig-r024-20230409   gcc  
arc                  randconfig-r025-20230417   gcc  
arc                  randconfig-r035-20230417   gcc  
arc                  randconfig-r043-20230418   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230416   clang
arm          buildonly-randconfig-r002-20230418   clang
arm                                 defconfig   gcc  
arm                  randconfig-r021-20230418   clang
arm                  randconfig-r026-20230409   clang
arm                  randconfig-r026-20230415   gcc  
arm                  randconfig-r035-20230416   gcc  
arm                  randconfig-r046-20230418   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r024-20230415   clang
arm64                randconfig-r033-20230417   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230416   gcc  
csky                 randconfig-r024-20230410   gcc  
csky                 randconfig-r034-20230417   gcc  
hexagon      buildonly-randconfig-r006-20230416   clang
hexagon      buildonly-randconfig-r006-20230417   clang
hexagon              randconfig-r002-20230417   clang
hexagon              randconfig-r012-20230416   clang
hexagon              randconfig-r023-20230415   clang
hexagon              randconfig-r041-20230418   clang
hexagon              randconfig-r045-20230418   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
i386                 randconfig-r026-20230417   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r023-20230409   gcc  
ia64                 randconfig-r023-20230410   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230417   gcc  
loongarch            randconfig-r003-20230416   gcc  
loongarch            randconfig-r036-20230416   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230416   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r021-20230410   gcc  
m68k                 randconfig-r022-20230409   gcc  
m68k                 randconfig-r032-20230416   gcc  
m68k                 randconfig-r033-20230416   gcc  
microblaze   buildonly-randconfig-r004-20230418   gcc  
microblaze           randconfig-r024-20230418   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r025-20230409   clang
mips                 randconfig-r025-20230418   clang
mips                 randconfig-r026-20230410   clang
nios2        buildonly-randconfig-r003-20230416   gcc  
nios2        buildonly-randconfig-r006-20230418   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230417   gcc  
openrisc             randconfig-r005-20230416   gcc  
parisc       buildonly-randconfig-r004-20230417   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230417   gcc  
parisc               randconfig-r031-20230416   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230418   gcc  
powerpc              randconfig-r001-20230416   clang
powerpc              randconfig-r022-20230410   gcc  
powerpc              randconfig-r023-20230417   clang
powerpc              randconfig-r034-20230416   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r024-20230417   clang
riscv                randconfig-r042-20230418   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230418   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r022-20230415   clang
s390                 randconfig-r044-20230418   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230417   gcc  
sh                   randconfig-r023-20230418   gcc  
sh                   randconfig-r026-20230418   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r021-20230415   gcc  
sparc                randconfig-r022-20230418   gcc  
sparc64      buildonly-randconfig-r003-20230417   gcc  
sparc64              randconfig-r013-20230416   gcc  
sparc64              randconfig-r016-20230416   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a011-20230417   clang
x86_64               randconfig-a012-20230417   clang
x86_64               randconfig-a013-20230417   clang
x86_64               randconfig-a014-20230417   clang
x86_64               randconfig-a015-20230417   clang
x86_64               randconfig-a016-20230417   clang
x86_64               randconfig-r031-20230417   gcc  
x86_64               randconfig-r032-20230417   gcc  
x86_64               randconfig-r036-20230417   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r003-20230418   gcc  
xtensa               randconfig-r002-20230416   gcc  
xtensa               randconfig-r004-20230416   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
