Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A920A700A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241544AbjELOXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjELOW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:22:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EB993F8
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683901371; x=1715437371;
  h=date:from:to:cc:subject:message-id;
  bh=ZsfG8ShUMdF14hAapNA8MHe8j3NeVksGZdB/FfTaP5c=;
  b=Iw1ECxqXopFx0Cu3Wau6P+WN6be+4KHCCnnP8LRCsmFlo6WicpFyNOun
   c3ZVf7rPZ3wgjDibO6YooZ1D6OY3SLjpCBgDt5RXh3s1TGkZCZaWr/JPM
   iO42coGkcgYAZmimaYfE/TJKAFnKuBASPTdg2Z+ijSjPl4IAdHSsrfrVA
   6tgoxdkjdwHeQagpN2A1bKdJmwMU2onIn6vPSwMma54PnKzgwgmEjPvA6
   o7BsYfUu6duA/Jpou1nl1u1iwL+LlIcdrHv7YqxUlZG7Q1RJ92+0h9Hd3
   G+bI5pJ3RKP3HdmvpNQJ7p4f2tHFPXJSEZHA1I6PJwxreVPEJA63nJPKp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="414170401"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="414170401"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:22:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="812095901"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="812095901"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 12 May 2023 07:22:49 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxTfV-0004vU-09;
        Fri, 12 May 2023 14:22:49 +0000
Date:   Fri, 12 May 2023 22:22:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 89151873967048cafed3e3db408a96abba154481
Message-ID: <20230512142210.XlL6G%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 89151873967048cafed3e3db408a96abba154481  Merge branch 'atomicdoc.2023.05.11a' into HEAD

elapsed time: 724m

configs tested: 124
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r016-20230509   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230511   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230509   gcc  
arc                  randconfig-r006-20230509   gcc  
arc                  randconfig-r015-20230509   gcc  
arc                  randconfig-r036-20230512   gcc  
arc                  randconfig-r043-20230509   gcc  
arc                  randconfig-r043-20230511   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230509   clang
arm                  randconfig-r023-20230511   clang
arm                  randconfig-r046-20230509   gcc  
arm                  randconfig-r046-20230511   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230511   clang
arm64                randconfig-r013-20230509   clang
arm64                randconfig-r025-20230509   clang
csky                                defconfig   gcc  
hexagon              randconfig-r016-20230511   clang
hexagon              randconfig-r041-20230509   clang
hexagon              randconfig-r041-20230511   clang
hexagon              randconfig-r045-20230509   clang
hexagon              randconfig-r045-20230511   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230509   gcc  
m68k                             allmodconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r011-20230509   gcc  
m68k                 randconfig-r023-20230509   gcc  
m68k                 randconfig-r031-20230512   gcc  
microblaze           randconfig-r002-20230509   gcc  
microblaze           randconfig-r025-20230511   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r005-20230509   clang
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230509   gcc  
nios2                randconfig-r021-20230509   gcc  
nios2                randconfig-r033-20230512   gcc  
openrisc             randconfig-r013-20230511   gcc  
openrisc             randconfig-r022-20230511   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230511   gcc  
riscv        buildonly-randconfig-r006-20230511   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230509   clang
riscv                randconfig-r042-20230511   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r014-20230509   clang
s390                 randconfig-r014-20230511   gcc  
s390                 randconfig-r044-20230509   clang
s390                 randconfig-r044-20230511   gcc  
sh                               allmodconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                   randconfig-r003-20230511   gcc  
sh                   randconfig-r004-20230511   gcc  
sh                   randconfig-r006-20230511   gcc  
sh                   randconfig-r011-20230511   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230511   gcc  
sparc                randconfig-r015-20230511   gcc  
sparc                randconfig-r024-20230509   gcc  
sparc                randconfig-r026-20230509   gcc  
sparc                randconfig-r035-20230512   gcc  
sparc64              randconfig-r032-20230512   gcc  
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
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r003-20230511   gcc  
xtensa               randconfig-r001-20230511   gcc  
xtensa               randconfig-r012-20230511   gcc  
xtensa               randconfig-r021-20230511   gcc  
xtensa               randconfig-r022-20230509   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
