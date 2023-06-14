Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7FB715D94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjE3LmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjE3Ll7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:41:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069B1EA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685446913; x=1716982913;
  h=date:from:to:cc:subject:message-id;
  bh=zYGHRuH8xM6zAUjJJaIQN2yGprD0TtpGuuQ1jvsViW0=;
  b=LlkufBbrhfznHAHMh7FoWvuSOrPtuqLR53MaH/Dw1E+Ur6hEll0bqSI8
   2S07cnBHyeWb+Z9sNfeGj5GzuPGmoPkVLvcmLmTq/HuWPuLTBf0iUOUpG
   /ytCa6ga73YnIKtUVTNvu0i0HcfJIF3re2+I9BOA1ZTKskQhbw/NmRt68
   F+pPHPM3fbhPenGg9YN+bF2g7G3K2yQ0Ft+7vaB0e2V8fbQf/Owpjp9rj
   Dh6ve5xinbtNA5K8GfCq1JrZlBmwM2+watYjj2mxLtuKqoUcK1QrbLfvu
   hBchyWJZYd8tIYUF2C6mZaakMTZhYi5UTEKB4cLZoP+SiaVP3CpYPhZ1P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="344392613"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="344392613"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 04:41:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739497987"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="739497987"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 30 May 2023 04:41:51 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3xja-000078-1U;
        Tue, 30 May 2023 11:41:50 +0000
Date:   Tue, 30 May 2023 19:41:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:smp/core] BUILD SUCCESS
 5da80b28bf25c3458c7beb23794ff53622ce7eb4
Message-ID: <20230530114105.oqsmG%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
branch HEAD: 5da80b28bf25c3458c7beb23794ff53622ce7eb4  x86/smp: Initialize cpu_primary_thread_mask late

elapsed time: 953m

configs tested: 180
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230529   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230529   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230529   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230529   gcc  
csky                 randconfig-r014-20230529   gcc  
hexagon      buildonly-randconfig-r006-20230530   clang
hexagon              randconfig-r041-20230529   clang
hexagon              randconfig-r045-20230529   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r001-20230529   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230529   clang
i386                 randconfig-i002-20230529   clang
i386                 randconfig-i003-20230529   clang
i386                 randconfig-i004-20230529   clang
i386                 randconfig-i005-20230529   clang
i386                 randconfig-i006-20230529   clang
i386                 randconfig-i011-20230529   gcc  
i386                 randconfig-i011-20230530   gcc  
i386                 randconfig-i012-20230529   gcc  
i386                 randconfig-i012-20230530   gcc  
i386                 randconfig-i013-20230529   gcc  
i386                 randconfig-i013-20230530   gcc  
i386                 randconfig-i014-20230529   gcc  
i386                 randconfig-i014-20230530   gcc  
i386                 randconfig-i015-20230529   gcc  
i386                 randconfig-i015-20230530   gcc  
i386                 randconfig-i016-20230529   gcc  
i386                 randconfig-i016-20230530   gcc  
i386                 randconfig-i051-20230530   clang
i386                 randconfig-i052-20230530   clang
i386                 randconfig-i053-20230530   clang
i386                 randconfig-i054-20230530   clang
i386                 randconfig-i055-20230530   clang
i386                 randconfig-i056-20230530   clang
i386                 randconfig-i061-20230529   clang
i386                 randconfig-i061-20230530   clang
i386                 randconfig-i062-20230529   clang
i386                 randconfig-i062-20230530   clang
i386                 randconfig-i063-20230529   clang
i386                 randconfig-i063-20230530   clang
i386                 randconfig-i064-20230529   clang
i386                 randconfig-i064-20230530   clang
i386                 randconfig-i065-20230529   clang
i386                 randconfig-i065-20230530   clang
i386                 randconfig-i066-20230529   clang
i386                 randconfig-i066-20230530   clang
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
i386                 randconfig-r004-20230529   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230529   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r024-20230529   gcc  
microblaze           randconfig-r012-20230530   gcc  
microblaze           randconfig-r023-20230529   gcc  
microblaze           randconfig-r033-20230530   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2        buildonly-randconfig-r004-20230529   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230529   gcc  
nios2                randconfig-r011-20230530   gcc  
openrisc             randconfig-r011-20230529   gcc  
openrisc             randconfig-r012-20230529   gcc  
openrisc             randconfig-r036-20230530   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230529   gcc  
parisc               randconfig-r026-20230529   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230529   clang
riscv                randconfig-r022-20230529   gcc  
riscv                randconfig-r036-20230529   clang
riscv                randconfig-r042-20230529   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r013-20230530   gcc  
s390                 randconfig-r014-20230530   gcc  
s390                 randconfig-r035-20230529   clang
s390                 randconfig-r044-20230529   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230529   gcc  
sh           buildonly-randconfig-r005-20230529   gcc  
sh                   randconfig-r025-20230529   gcc  
sh                   randconfig-r035-20230530   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230529   gcc  
sparc                randconfig-r016-20230530   gcc  
sparc64              randconfig-r031-20230529   gcc  
sparc64              randconfig-r032-20230530   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230530   clang
x86_64       buildonly-randconfig-r002-20230529   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230530   clang
x86_64               randconfig-a002-20230530   clang
x86_64               randconfig-a003-20230530   clang
x86_64               randconfig-a004-20230530   clang
x86_64               randconfig-a005-20230530   clang
x86_64               randconfig-a006-20230530   clang
x86_64               randconfig-a011-20230530   gcc  
x86_64               randconfig-a012-20230530   gcc  
x86_64               randconfig-a013-20230530   gcc  
x86_64               randconfig-a014-20230530   gcc  
x86_64               randconfig-a015-20230530   gcc  
x86_64               randconfig-a016-20230530   gcc  
x86_64               randconfig-x051-20230529   gcc  
x86_64               randconfig-x052-20230529   gcc  
x86_64               randconfig-x053-20230529   gcc  
x86_64               randconfig-x054-20230529   gcc  
x86_64               randconfig-x055-20230529   gcc  
x86_64               randconfig-x056-20230529   gcc  
x86_64               randconfig-x061-20230529   gcc  
x86_64               randconfig-x061-20230530   gcc  
x86_64               randconfig-x062-20230529   gcc  
x86_64               randconfig-x062-20230530   gcc  
x86_64               randconfig-x063-20230529   gcc  
x86_64               randconfig-x063-20230530   gcc  
x86_64               randconfig-x064-20230529   gcc  
x86_64               randconfig-x064-20230530   gcc  
x86_64               randconfig-x065-20230529   gcc  
x86_64               randconfig-x065-20230530   gcc  
x86_64               randconfig-x066-20230529   gcc  
x86_64               randconfig-x066-20230530   gcc  
x86_64               randconfig-x071-20230529   clang
x86_64               randconfig-x072-20230529   clang
x86_64               randconfig-x073-20230529   clang
x86_64               randconfig-x074-20230529   clang
x86_64               randconfig-x075-20230529   clang
x86_64               randconfig-x076-20230529   clang
x86_64               randconfig-x091-20230530   gcc  
x86_64               randconfig-x092-20230530   gcc  
x86_64               randconfig-x093-20230530   gcc  
x86_64               randconfig-x094-20230530   gcc  
x86_64               randconfig-x095-20230530   gcc  
x86_64               randconfig-x096-20230530   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r021-20230529   gcc  
xtensa               randconfig-r033-20230529   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
