Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516D874F015
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjGKN3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjGKN3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:29:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F91318D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689082145; x=1720618145;
  h=date:from:to:cc:subject:message-id;
  bh=iokCTEQcwbJtCojQ9o5dPAUn0ODR9XAw/msNZeUzKM4=;
  b=mxH4ZVLEaRlh6VSWgZQhGvaic5YelaihTT/Xt/IY1b5APPJQ7uaST8RF
   Yid3uYLAlWDNzmBv+1JMDXYmbrkbkhxXbhbqvrMzoVLqhow0ftCuJ81XV
   yjQJoV1w1opuDZ25s0rImoxO9bquTvDN9Yba18zp0yGJQfsjBbXK2cRQI
   LeZ0427L1caPpp3vQMs2e3nKyXTVvy/5mG2noA9XOXG2UrRAcfvRpW2tz
   j5NwO64ivxCh1PyLF4tXi6wvMK+ZW3piuEbiD0wlRRV1pcAqM2YzsnfgV
   wk9pyuKaM55KYR+BwhjcHW9tIIWFzoTgLe43R7owUZigZtv4yaDWChYaf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="344215037"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="344215037"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 06:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="715167818"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="715167818"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2023 06:29:03 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJDQM-0004pJ-2Z;
        Tue, 11 Jul 2023 13:29:02 +0000
Date:   Tue, 11 Jul 2023 21:28:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 c7148d72837a4266a203c99d021543764526ce6d
Message-ID: <202307112120.lk6kfLwR-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: c7148d72837a4266a203c99d021543764526ce6d  rcu: Use WRITE_ONCE() for assignments to ->next for rculist_nulls

elapsed time: 725m

configs tested: 155
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r014-20230710   gcc  
arc                  randconfig-r023-20230710   gcc  
arc                  randconfig-r031-20230710   gcc  
arc                  randconfig-r043-20230711   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                         nhk8815_defconfig   gcc  
arm                  randconfig-r002-20230710   clang
arm                  randconfig-r024-20230710   gcc  
arm                  randconfig-r025-20230710   gcc  
arm                  randconfig-r046-20230711   clang
arm                         s5pv210_defconfig   clang
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230710   clang
arm64                randconfig-r034-20230710   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r005-20230710   gcc  
hexagon              randconfig-r016-20230710   clang
hexagon              randconfig-r041-20230711   clang
hexagon              randconfig-r045-20230710   clang
hexagon              randconfig-r045-20230711   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230710   gcc  
i386         buildonly-randconfig-r004-20230711   clang
i386         buildonly-randconfig-r005-20230710   gcc  
i386         buildonly-randconfig-r005-20230711   clang
i386         buildonly-randconfig-r006-20230710   gcc  
i386         buildonly-randconfig-r006-20230711   clang
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
i386                 randconfig-i011-20230711   gcc  
i386                 randconfig-i012-20230710   clang
i386                 randconfig-i012-20230711   gcc  
i386                 randconfig-i013-20230710   clang
i386                 randconfig-i013-20230711   gcc  
i386                 randconfig-i014-20230710   clang
i386                 randconfig-i014-20230711   gcc  
i386                 randconfig-i015-20230710   clang
i386                 randconfig-i015-20230711   gcc  
i386                 randconfig-i016-20230710   clang
i386                 randconfig-i016-20230711   gcc  
i386                 randconfig-r024-20230710   clang
i386                 randconfig-r031-20230710   gcc  
i386                 randconfig-r032-20230710   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230710   gcc  
loongarch            randconfig-r035-20230710   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
microblaze           randconfig-r004-20230710   gcc  
microblaze           randconfig-r015-20230710   gcc  
microblaze           randconfig-r035-20230710   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                 randconfig-r021-20230710   gcc  
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230710   gcc  
parisc               randconfig-r025-20230710   gcc  
parisc               randconfig-r026-20230710   gcc  
parisc               randconfig-r032-20230710   gcc  
parisc               randconfig-r034-20230710   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc              randconfig-r001-20230710   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r013-20230710   clang
riscv                randconfig-r026-20230710   clang
riscv                randconfig-r042-20230711   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r033-20230710   gcc  
s390                 randconfig-r036-20230710   gcc  
s390                 randconfig-r044-20230710   clang
s390                 randconfig-r044-20230711   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r011-20230710   gcc  
sh                             sh03_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r003-20230710   gcc  
sparc64              randconfig-r013-20230710   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r022-20230710   gcc  
um                   randconfig-r025-20230711   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230710   gcc  
x86_64       buildonly-randconfig-r001-20230711   clang
x86_64       buildonly-randconfig-r002-20230710   gcc  
x86_64       buildonly-randconfig-r002-20230711   clang
x86_64       buildonly-randconfig-r003-20230710   gcc  
x86_64       buildonly-randconfig-r003-20230711   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
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
xtensa               randconfig-r033-20230710   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
