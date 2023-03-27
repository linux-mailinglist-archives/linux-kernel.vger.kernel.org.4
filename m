Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2966CAAE9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjC0QrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0QrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:47:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779132698
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679935640; x=1711471640;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=n2/lhGReilsNzT2kPNlMhWaiAv78EvToljWfHgP6T8o=;
  b=T5HVre3VGUxB2vIrYfVL1EIWbG01R3HKuGoRdjonqjlQz63oVrKin83/
   5zU22GmBq3dCLdEy37czVuoa6gA6L/261rqCHtlaBVmLLkGWNsDHyGM89
   VQ+QxMSXAIQUGhDIISQz5qSLUwzbp7O+1X20qzPdM21n5oTR1V3lMxPWh
   3UD9bjUzaEA5+YOaeVFa4TJ0/1McmTJdxM/Dk+y7Kz3ZQPSYkIJxKa1Qi
   qgu54E9penxeFXfco+O/J432YvSH5oJyrnvaddy4PirmyyKJQqe0Leqgc
   xoeq7YeR3T+bTTqgtABc/ss4qHvRmjPhZYKp+fSQNQZZOh8crZd5RR0VQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="340349990"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="340349990"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 09:47:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="929530032"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="929530032"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 27 Mar 2023 09:47:19 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pgq06-000Hql-1P;
        Mon, 27 Mar 2023 16:47:18 +0000
Date:   Tue, 28 Mar 2023 00:46:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:srcu-cf.2023.03.26a] BUILD SUCCESS
 9607cde099a20296cf0234f571d60184f277aa37
Message-ID: <6421c85b.sNjh4w0fmWlfOiqM%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git srcu-cf.2023.03.26a
branch HEAD: 9607cde099a20296cf0234f571d60184f277aa37  srcu: Fix long lines in srcu_funnel_gp_start()

elapsed time: 721m

configs tested: 156
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230326   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230326   gcc  
alpha                randconfig-r026-20230327   gcc  
alpha                randconfig-r032-20230327   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230326   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r021-20230326   gcc  
arc                  randconfig-r024-20230326   gcc  
arc                  randconfig-r025-20230326   gcc  
arc                  randconfig-r026-20230326   gcc  
arc                  randconfig-r043-20230326   gcc  
arc                  randconfig-r043-20230327   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230327   clang
arm                  randconfig-r022-20230327   gcc  
arm                  randconfig-r023-20230326   clang
arm                  randconfig-r033-20230326   gcc  
arm                  randconfig-r046-20230326   clang
arm                  randconfig-r046-20230327   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230326   clang
arm64        buildonly-randconfig-r006-20230326   clang
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230326   gcc  
arm64                randconfig-r016-20230327   clang
arm64                randconfig-r026-20230326   gcc  
arm64                randconfig-r031-20230327   gcc  
csky         buildonly-randconfig-r002-20230326   gcc  
csky         buildonly-randconfig-r004-20230327   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230327   gcc  
csky                 randconfig-r024-20230326   gcc  
hexagon              randconfig-r001-20230327   clang
hexagon              randconfig-r012-20230327   clang
hexagon              randconfig-r024-20230327   clang
hexagon              randconfig-r041-20230326   clang
hexagon              randconfig-r041-20230327   clang
hexagon              randconfig-r045-20230326   clang
hexagon              randconfig-r045-20230327   clang
i386                             allyesconfig   gcc  
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
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r013-20230327   gcc  
ia64                 randconfig-r022-20230326   gcc  
ia64                 randconfig-r031-20230326   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r021-20230326   gcc  
loongarch            randconfig-r023-20230327   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r035-20230327   gcc  
microblaze           randconfig-r014-20230326   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230326   gcc  
mips         buildonly-randconfig-r002-20230327   clang
mips         buildonly-randconfig-r003-20230327   clang
mips                 randconfig-r034-20230326   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230326   gcc  
openrisc     buildonly-randconfig-r003-20230327   gcc  
openrisc     buildonly-randconfig-r005-20230327   gcc  
openrisc             randconfig-r001-20230326   gcc  
openrisc             randconfig-r003-20230327   gcc  
openrisc             randconfig-r026-20230327   gcc  
parisc       buildonly-randconfig-r001-20230327   gcc  
parisc       buildonly-randconfig-r005-20230326   gcc  
parisc       buildonly-randconfig-r006-20230327   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230326   gcc  
parisc               randconfig-r004-20230326   gcc  
parisc               randconfig-r016-20230326   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230326   gcc  
powerpc              randconfig-r004-20230327   gcc  
powerpc              randconfig-r014-20230327   clang
powerpc              randconfig-r021-20230327   clang
powerpc              randconfig-r025-20230326   gcc  
powerpc              randconfig-r034-20230327   gcc  
powerpc              randconfig-r036-20230326   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r023-20230327   clang
riscv                randconfig-r042-20230326   gcc  
riscv                randconfig-r042-20230327   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r004-20230327   clang
s390                                defconfig   gcc  
s390                 randconfig-r044-20230326   gcc  
s390                 randconfig-r044-20230327   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r032-20230326   gcc  
sparc        buildonly-randconfig-r006-20230327   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r006-20230326   gcc  
sparc                randconfig-r023-20230326   gcc  
sparc                randconfig-r035-20230326   gcc  
sparc                randconfig-r036-20230327   gcc  
sparc64      buildonly-randconfig-r001-20230327   gcc  
sparc64              randconfig-r005-20230327   gcc  
sparc64              randconfig-r011-20230327   gcc  
sparc64              randconfig-r015-20230327   gcc  
sparc64              randconfig-r022-20230326   gcc  
sparc64              randconfig-r024-20230327   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r002-20230327   gcc  
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
x86_64               randconfig-r033-20230327   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230327   gcc  
xtensa               randconfig-r002-20230326   gcc  
xtensa               randconfig-r021-20230327   gcc  
xtensa               randconfig-r022-20230327   gcc  
xtensa               randconfig-r025-20230327   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
