Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149C67251CC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbjFGBw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240667AbjFGBvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:51:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDA219B9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686102691; x=1717638691;
  h=date:from:to:cc:subject:message-id;
  bh=FXc2GW+y5OkM9SY8QVtJwN5XLigiJBtZWifJtBOg4vQ=;
  b=hmgHfxL1DdMDJ+b825DgUvXZG+J6xha8w4YYZZB68yJr+elIuBiyJEfn
   zOPr6nOXpCnEmyVgBmWCsibzo+vglZzJUPnpmwsioRuuJy6PAoMxEgK0S
   S7WjhccKPjA0kJIgpgPdkJkfHp7msSdopY36VtrkzJrEoHQr5pJDOGw9Z
   4GUbcejpvKNYEvucVniPtOH503LKWFp6i9Do41Q0/SHbe4CwdKlK5yvyh
   dnKIrSz+qqSolYqF6KEmAViYWcSWo/MDssUG1jzFLj1WkUlf23qe9JDvV
   zk4UYcSmquwN3Z2eZjGJUrOyprnaN6VSchyVBxAKCis0QxTNP5L09Lte4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="354346293"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="354346293"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 18:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="1039408393"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="1039408393"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jun 2023 18:51:28 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6iKe-0005zs-0w;
        Wed, 07 Jun 2023 01:51:28 +0000
Date:   Wed, 07 Jun 2023 09:51:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 b26d3d054de18f2334e06985e508083b2f32a101
Message-ID: <20230607015103.I7l_6%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: b26d3d054de18f2334e06985e508083b2f32a101  x86/lib/msr: Clean up kernel-doc notation

elapsed time: 726m

configs tested: 150
configs skipped: 101

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230606   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230606   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc          buildonly-randconfig-r002-20230606   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r012-20230606   gcc  
arc                  randconfig-r016-20230606   gcc  
arc                  randconfig-r043-20230606   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                  randconfig-r046-20230606   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r025-20230606   clang
csky         buildonly-randconfig-r006-20230606   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230606   gcc  
csky                 randconfig-r006-20230606   gcc  
hexagon              randconfig-r022-20230606   clang
hexagon              randconfig-r041-20230606   clang
hexagon              randconfig-r045-20230606   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230606   gcc  
i386                 randconfig-i002-20230606   gcc  
i386                 randconfig-i003-20230606   gcc  
i386                 randconfig-i004-20230606   gcc  
i386                 randconfig-i005-20230606   gcc  
i386                 randconfig-i006-20230606   gcc  
i386                 randconfig-i011-20230606   clang
i386                 randconfig-i012-20230606   clang
i386                 randconfig-i013-20230606   clang
i386                 randconfig-i014-20230606   clang
i386                 randconfig-i015-20230606   clang
i386                 randconfig-i016-20230606   clang
i386                 randconfig-i051-20230606   gcc  
i386                 randconfig-i052-20230606   gcc  
i386                 randconfig-i053-20230606   gcc  
i386                 randconfig-i054-20230606   gcc  
i386                 randconfig-i055-20230606   gcc  
i386                 randconfig-i056-20230606   gcc  
i386                 randconfig-i061-20230606   gcc  
i386                 randconfig-i062-20230606   gcc  
i386                 randconfig-i063-20230606   gcc  
i386                 randconfig-i064-20230606   gcc  
i386                 randconfig-i065-20230606   gcc  
i386                 randconfig-i066-20230606   gcc  
i386                 randconfig-r034-20230606   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230606   gcc  
loongarch    buildonly-randconfig-r006-20230606   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230606   gcc  
loongarch            randconfig-r032-20230606   gcc  
loongarch            randconfig-r033-20230606   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                 randconfig-r022-20230606   gcc  
microblaze   buildonly-randconfig-r002-20230606   gcc  
microblaze           randconfig-r015-20230606   gcc  
microblaze           randconfig-r032-20230606   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                 randconfig-r021-20230606   gcc  
nios2        buildonly-randconfig-r004-20230606   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230606   gcc  
openrisc             randconfig-r003-20230606   gcc  
openrisc             randconfig-r012-20230606   gcc  
openrisc             randconfig-r024-20230606   gcc  
openrisc             randconfig-r026-20230606   gcc  
openrisc             randconfig-r035-20230606   gcc  
parisc       buildonly-randconfig-r005-20230606   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   clang
powerpc                      ppc40x_defconfig   gcc  
powerpc              randconfig-r012-20230606   clang
powerpc              randconfig-r021-20230606   clang
powerpc              randconfig-r033-20230606   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r036-20230606   gcc  
riscv                randconfig-r042-20230606   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230606   clang
sh                               allmodconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r006-20230606   gcc  
sh                   randconfig-r035-20230606   gcc  
sh                           sh2007_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230606   gcc  
sparc                randconfig-r036-20230606   gcc  
sparc64              randconfig-r031-20230606   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230606   gcc  
x86_64               randconfig-a002-20230606   gcc  
x86_64               randconfig-a003-20230606   gcc  
x86_64               randconfig-a004-20230606   gcc  
x86_64               randconfig-a005-20230606   gcc  
x86_64               randconfig-a006-20230606   gcc  
x86_64               randconfig-a011-20230606   clang
x86_64               randconfig-a012-20230606   clang
x86_64               randconfig-a013-20230606   clang
x86_64               randconfig-a014-20230606   clang
x86_64               randconfig-a015-20230606   clang
x86_64               randconfig-a016-20230606   clang
x86_64               randconfig-r005-20230606   gcc  
x86_64               randconfig-r021-20230606   clang
x86_64               randconfig-r023-20230606   clang
x86_64               randconfig-r024-20230606   clang
x86_64               randconfig-x051-20230606   clang
x86_64               randconfig-x052-20230606   clang
x86_64               randconfig-x053-20230606   clang
x86_64               randconfig-x054-20230606   clang
x86_64               randconfig-x055-20230606   clang
x86_64               randconfig-x056-20230606   clang
x86_64               randconfig-x061-20230606   clang
x86_64               randconfig-x062-20230606   clang
x86_64               randconfig-x063-20230606   clang
x86_64               randconfig-x064-20230606   clang
x86_64               randconfig-x065-20230606   clang
x86_64               randconfig-x066-20230606   clang
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa               randconfig-r002-20230606   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
