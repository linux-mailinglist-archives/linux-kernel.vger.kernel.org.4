Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E243274F92C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjGKUhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGKUhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:37:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39D211B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689107841; x=1720643841;
  h=date:from:to:cc:subject:message-id;
  bh=VmaWFvjYnYcOZ9h/9QYgOxyhI1pi3O4iIzVB5I/dcbM=;
  b=nBOzojyqH0KCiRpMCTVBwa98E04wZFLkiBjrasKzZ0b1IKhRgIu6EeJl
   QnfMZpyjDFEC+woFnRZ07fRJkGh9K13yKDWE26xVdE++rArfp/LhfEQiZ
   foVtjgQb2//6H57H8BW3wjSiZUuVa/0BJK2TwLPj9z3/hVyC7BwqWr12d
   2PGV7wotg7L+boNxf0vIPVI2Kg9rTK0nyFCgpO5rud2MOzMiGIGSQKF5Y
   ks1BxX94zsg5fqzXzlTcUuuKuDovLQ8UKt+VSZqIQjAidYYduea2hTWMO
   y+iIjk/mJD1CTenh0K/LvyfgMoqJ6gO97/AQb05+jn1yX6CzDK2pfK4Al
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="362197699"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="362197699"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 13:37:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="865848867"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="865848867"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2023 13:37:20 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJK6p-00056J-1L;
        Tue, 11 Jul 2023 20:37:19 +0000
Date:   Wed, 12 Jul 2023 04:37:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 535d0ae39185a266536a1e97ff9a8956d7fbb9df
Message-ID: <202307120413.MiFb5b6A-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 535d0ae39185a266536a1e97ff9a8956d7fbb9df  x86/cfi: Only define poison_cfi() if CONFIG_X86_KERNEL_IBT=y

elapsed time: 724m

configs tested: 94
configs skipped: 89

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                  randconfig-r015-20230712   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230710   gcc  
i386         buildonly-randconfig-r005-20230710   gcc  
i386         buildonly-randconfig-r006-20230710   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230710   gcc  
i386                 randconfig-i001-20230711   clang
i386                 randconfig-i002-20230710   gcc  
i386                 randconfig-i002-20230711   clang
i386                 randconfig-i003-20230710   gcc  
i386                 randconfig-i003-20230711   clang
i386                 randconfig-i004-20230710   gcc  
i386                 randconfig-i004-20230711   clang
i386                 randconfig-i005-20230710   gcc  
i386                 randconfig-i005-20230711   clang
i386                 randconfig-i006-20230710   gcc  
i386                 randconfig-i006-20230711   clang
i386                 randconfig-i011-20230710   clang
i386                 randconfig-i012-20230710   clang
i386                 randconfig-i013-20230710   clang
i386                 randconfig-i014-20230710   clang
i386                 randconfig-i015-20230710   clang
i386                 randconfig-i016-20230710   clang
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230712   gcc  
m68k                           sun3_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip27_defconfig   clang
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230712   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230712   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     redwood_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                          rv32_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                             sh03_defconfig   gcc  
sparc                randconfig-r014-20230712   gcc  
um                   randconfig-r016-20230712   gcc  
um                   randconfig-r025-20230711   clang
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230710   gcc  
x86_64       buildonly-randconfig-r002-20230710   gcc  
x86_64       buildonly-randconfig-r003-20230710   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r025-20230710   clang
x86_64               randconfig-r036-20230710   gcc  
x86_64               randconfig-x001-20230710   clang
x86_64               randconfig-x001-20230711   gcc  
x86_64               randconfig-x002-20230710   clang
x86_64               randconfig-x002-20230711   gcc  
x86_64               randconfig-x003-20230710   clang
x86_64               randconfig-x003-20230711   gcc  
x86_64               randconfig-x004-20230710   clang
x86_64               randconfig-x004-20230711   gcc  
x86_64               randconfig-x005-20230710   clang
x86_64               randconfig-x005-20230711   gcc  
x86_64               randconfig-x006-20230710   clang
x86_64               randconfig-x006-20230711   gcc  
x86_64               randconfig-x011-20230710   gcc  
x86_64               randconfig-x012-20230710   gcc  
x86_64               randconfig-x013-20230710   gcc  
x86_64               randconfig-x014-20230710   gcc  
x86_64               randconfig-x015-20230710   gcc  
x86_64               randconfig-x016-20230710   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
