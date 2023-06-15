Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA11F730EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243331AbjFOGBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243249AbjFOGAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:00:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2B6294E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686808848; x=1718344848;
  h=date:from:to:cc:subject:message-id;
  bh=TrcSEKWXfc+u3sWHJGzLs2kAVCjIXdXyk7fndaD2itk=;
  b=kiOMfad6suOZ6IVo3fcuAetX7S3NOrCEqkk3xyT6aCQiVnpCGSKiq6TZ
   Y+S91eP1OtuvBPyW77MWHvNJOS6FQp5WoxhpNC8gtLrPhsDU05oyclpBX
   wxDs929h7Qak+ZzwamBr36UmjqrSPS7inW8SrEEqialYMHPfQ2M5GmNt8
   hqN4kytvHpMTdEWXMI9bPrpf+tUO+XYTd5elSSg20Mh5RMCUz9DLtJxay
   TxWrt6d1NyeY+uWIVO9BrDejMy6o1Za37ptHqyMXUybBl1a4i4KVpgQ65
   orJ+qYDxysfbnn/BhhlYTFlGxx8+VC+H4FubpFSEl3SCOQN6uGYb8IfcA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="357702400"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="357702400"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 23:00:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="959053070"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="959053070"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jun 2023 23:00:46 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9g2H-0001Wx-2C;
        Thu, 15 Jun 2023 06:00:45 +0000
Date:   Thu, 15 Jun 2023 13:59:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/alternatives] BUILD SUCCESS
 2bd4aa9325821551648cf9738d6aa3a49317d7e5
Message-ID: <202306151336.YAJk2qSi-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/alternatives
branch HEAD: 2bd4aa9325821551648cf9738d6aa3a49317d7e5  x86/alternative: PAUSE is not a NOP

Unverified Warning (likely false positive, please contact us if interested):

arch/x86/kernel/alternative.c:1474:32: warning: no previous prototype for '__alt_reloc_selftest' [-Wmissing-prototypes]
arch/x86/kernel/alternative.c:1474:32: warning: no previous prototype for function '__alt_reloc_selftest' [-Wmissing-prototypes]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allyesconfig
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- i386-debian-10.3
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- i386-defconfig
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- i386-randconfig-i001-20230615
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- i386-randconfig-i002-20230615
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- i386-randconfig-i003-20230615
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- i386-randconfig-i004-20230615
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- i386-randconfig-i005-20230615
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- i386-randconfig-i006-20230615
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- i386-randconfig-i011-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- i386-randconfig-i012-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- i386-randconfig-i013-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- i386-randconfig-i014-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- i386-randconfig-i015-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- i386-randconfig-i016-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- i386-randconfig-r014-20230614
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- x86_64-allyesconfig
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- x86_64-defconfig
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- x86_64-kexec
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- x86_64-randconfig-a011-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- x86_64-randconfig-a012-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- x86_64-randconfig-a013-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- x86_64-randconfig-a014-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- x86_64-randconfig-a015-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
|-- x86_64-randconfig-a016-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
`-- x86_64-rhel-8.3
    `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-__alt_reloc_selftest
clang_recent_errors
|-- x86_64-buildonly-randconfig-r001-20230614
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-function-__alt_reloc_selftest
|-- x86_64-randconfig-a001-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-function-__alt_reloc_selftest
|-- x86_64-randconfig-a002-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-function-__alt_reloc_selftest
|-- x86_64-randconfig-a003-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-function-__alt_reloc_selftest
|-- x86_64-randconfig-a004-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-function-__alt_reloc_selftest
|-- x86_64-randconfig-a005-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-function-__alt_reloc_selftest
|-- x86_64-randconfig-a006-20230612
|   `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-function-__alt_reloc_selftest
`-- x86_64-rhel-8.3-rust
    `-- arch-x86-kernel-alternative.c:warning:no-previous-prototype-for-function-__alt_reloc_selftest

elapsed time: 724m

configs tested: 99
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230614   gcc  
alpha                randconfig-r013-20230614   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r025-20230612   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230612   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r002-20230614   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r005-20230612   gcc  
hexagon              randconfig-r003-20230612   clang
hexagon              randconfig-r015-20230614   clang
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r045-20230612   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230615   gcc  
i386                 randconfig-i002-20230615   gcc  
i386                 randconfig-i003-20230615   gcc  
i386                 randconfig-i004-20230615   gcc  
i386                 randconfig-i005-20230615   gcc  
i386                 randconfig-i006-20230615   gcc  
i386                 randconfig-i011-20230612   gcc  
i386                 randconfig-i012-20230612   gcc  
i386                 randconfig-i013-20230612   gcc  
i386                 randconfig-i014-20230612   gcc  
i386                 randconfig-i015-20230612   gcc  
i386                 randconfig-i016-20230612   gcc  
i386                 randconfig-r014-20230614   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r023-20230612   gcc  
m68k                 randconfig-r035-20230612   gcc  
m68k                 randconfig-r036-20230612   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r005-20230614   gcc  
mips                 randconfig-r031-20230612   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230614   gcc  
nios2                randconfig-r022-20230612   gcc  
openrisc             randconfig-r024-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r003-20230614   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r032-20230612   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r034-20230612   clang
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r026-20230612   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r033-20230612   gcc  
sparc64              randconfig-r021-20230612   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230614   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230612   clang
x86_64               randconfig-a002-20230612   clang
x86_64               randconfig-a003-20230612   clang
x86_64               randconfig-a004-20230612   clang
x86_64               randconfig-a005-20230612   clang
x86_64               randconfig-a006-20230612   clang
x86_64               randconfig-a011-20230612   gcc  
x86_64               randconfig-a012-20230612   gcc  
x86_64               randconfig-a013-20230612   gcc  
x86_64               randconfig-a014-20230612   gcc  
x86_64               randconfig-a015-20230612   gcc  
x86_64               randconfig-a016-20230612   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r002-20230612   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
