Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D56E6AE5C0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjCGQCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjCGQCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:02:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B4D28D39
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678204801; x=1709740801;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=D/l7L7RFsR298EnT0m/2b1g97Qo0lmemUhrIDUDxED4=;
  b=UzCw0UiLM0Ron7qAtbXijW06Ks/WVi6gFpP3GjHxsNzJ87nBw9m9ccfy
   wY6NAvPcDkN7vvV8z3S7hBt96P/ChUBJAEDr6VBW1T2sY4HRtuyvNU5WD
   0sR8Vq92U1bMhsveJruHgSW2Tm8Ms9tZvZ+rAve1XrQ1qLTU/e6SHFQAz
   684yK5u0/OS1lj991/fAPmsDU7kly8x+flVOz/05BQC3ZjPkP5HkWLtzE
   HNS7ZqzBUCbuNY5taAOdfEDRCoRPcIxuvCb4pTFAmrZ8bbhbtG8YYTvae
   i2hPgi6Ofre9ZZVj2vBYNuXQMRmj9Dj1eK5Pff7uyKI3aa3B1+rXgrhau
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="422159301"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="422159301"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 07:59:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="745525879"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="745525879"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Mar 2023 07:59:10 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZZiY-0001RL-0v;
        Tue, 07 Mar 2023 15:59:10 +0000
Date:   Tue, 07 Mar 2023 23:58:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fsfa3] BUILD SUCCESS
 1d3c1a224a57726f3189cde2ffc8eabf6da6b6af
Message-ID: <64075f22.bijVyxiayM6yAfg8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fsfa3
branch HEAD: 1d3c1a224a57726f3189cde2ffc8eabf6da6b6af  netxen_nic: Replace fake flex-array with flexible-array member

elapsed time: 787m

configs tested: 127
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230306   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230305   gcc  
arc                  randconfig-r012-20230305   gcc  
arc                  randconfig-r013-20230305   gcc  
arc                  randconfig-r043-20230305   gcc  
arc                  randconfig-r043-20230306   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230305   clang
arm          buildonly-randconfig-r005-20230305   clang
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230305   clang
arm                  randconfig-r046-20230306   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230306   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230306   gcc  
arm64                randconfig-r002-20230305   clang
arm64                randconfig-r002-20230306   gcc  
arm64                randconfig-r014-20230305   gcc  
csky         buildonly-randconfig-r004-20230305   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r032-20230305   gcc  
hexagon              randconfig-r041-20230305   clang
hexagon              randconfig-r041-20230306   clang
hexagon              randconfig-r045-20230305   clang
hexagon              randconfig-r045-20230306   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230306   gcc  
i386                 randconfig-a002-20230306   gcc  
i386                 randconfig-a003-20230306   gcc  
i386                 randconfig-a004-20230306   gcc  
i386                 randconfig-a005-20230306   gcc  
i386                 randconfig-a006-20230306   gcc  
i386                 randconfig-a011-20230306   clang
i386                 randconfig-a012-20230306   clang
i386                 randconfig-a013-20230306   clang
i386                 randconfig-a014-20230306   clang
i386                 randconfig-a015-20230306   clang
i386                 randconfig-a016-20230306   clang
i386                 randconfig-r034-20230306   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r011-20230305   gcc  
ia64                 randconfig-r021-20230305   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r036-20230305   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230306   gcc  
microblaze           randconfig-r003-20230305   gcc  
microblaze           randconfig-r004-20230306   gcc  
microblaze           randconfig-r031-20230306   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230306   clang
mips                 randconfig-r006-20230306   clang
mips                 randconfig-r013-20230306   gcc  
mips                 randconfig-r016-20230306   gcc  
mips                 randconfig-r024-20230305   clang
nios2                               defconfig   gcc  
nios2                randconfig-r035-20230306   gcc  
openrisc     buildonly-randconfig-r001-20230305   gcc  
openrisc     buildonly-randconfig-r002-20230306   gcc  
openrisc             randconfig-r001-20230305   gcc  
openrisc             randconfig-r012-20230306   gcc  
openrisc             randconfig-r016-20230305   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230306   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230305   gcc  
powerpc              randconfig-r005-20230306   gcc  
powerpc              randconfig-r025-20230305   gcc  
powerpc              randconfig-r031-20230305   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230305   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r023-20230305   gcc  
riscv                randconfig-r034-20230305   clang
riscv                randconfig-r042-20230305   gcc  
riscv                randconfig-r042-20230306   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r035-20230305   clang
s390                 randconfig-r044-20230305   gcc  
s390                 randconfig-r044-20230306   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r022-20230305   gcc  
sh                   randconfig-r033-20230305   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230305   gcc  
sparc64              randconfig-r015-20230305   gcc  
sparc64              randconfig-r026-20230305   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r005-20230306   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230306   gcc  
x86_64               randconfig-a002-20230306   gcc  
x86_64               randconfig-a003-20230306   gcc  
x86_64               randconfig-a004-20230306   gcc  
x86_64               randconfig-a005-20230306   gcc  
x86_64               randconfig-a006-20230306   gcc  
x86_64               randconfig-a011-20230306   clang
x86_64               randconfig-a012-20230306   clang
x86_64               randconfig-a013-20230306   clang
x86_64               randconfig-a014-20230306   clang
x86_64               randconfig-a015-20230306   clang
x86_64               randconfig-a016-20230306   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230306   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
