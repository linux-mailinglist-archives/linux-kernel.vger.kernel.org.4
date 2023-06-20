Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F27736183
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 04:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjFTCYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 22:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFTCYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 22:24:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB05BA6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 19:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687227889; x=1718763889;
  h=date:from:to:cc:subject:message-id;
  bh=klnLOfb1ZRIYwd0kkkqr7JukkNbtOMrPpS3CE/bGWVs=;
  b=hVion/B4M1d9sIJ6KOyX2WppDO2BOGinWccC61SYrAhB4zByn/hNE13Q
   /8pl9L7ZoRcwbfm6m++9T/wMC6/T8N13LQIVfciuFBaWVgw6Lrk2mRVub
   G+gA495b8lOV5fLH8OR278UDQi/3EcalryjDup3NUdChuBtFqwS3UtTiB
   2FASxzlLCDHXlqdNRM4v+9k9lZeH6RFp5Jqp7r3FNyprFxTee3mMovBzk
   ulDUMaC7ZJ6wMkAj07cWoivcCLZ4kKLUVstQK4REk/9kKhzg2cmaB3zWM
   Q7ktxKNMDV3hK7ieaJTze743yg+du1BVsftTrd2nhp3gWIyoFbAe9/oia
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="446122459"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="446122459"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 19:24:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="888090555"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="888090555"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 19 Jun 2023 19:24:46 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBR2z-0005Ms-1q;
        Tue, 20 Jun 2023 02:24:45 +0000
Date:   Tue, 20 Jun 2023 10:24:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 4251566ebc1cf95ae26a1e5a24cdac1ac25e942f
Message-ID: <202306201031.4yniIP3F-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 4251566ebc1cf95ae26a1e5a24cdac1ac25e942f  EDAC/amd64: Cache and use GPU node map

elapsed time: 884m

configs tested: 127
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230619   gcc  
alpha                randconfig-r034-20230619   gcc  
alpha                randconfig-r035-20230619   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230619   gcc  
arc                  randconfig-r043-20230619   gcc  
arc                  randconfig-r043-20230620   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                  randconfig-r003-20230619   clang
arm                  randconfig-r046-20230619   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r006-20230619   clang
hexagon              randconfig-r041-20230619   clang
hexagon              randconfig-r045-20230619   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230619   gcc  
i386         buildonly-randconfig-r005-20230619   gcc  
i386         buildonly-randconfig-r006-20230619   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230619   gcc  
i386                 randconfig-i002-20230619   gcc  
i386                 randconfig-i003-20230619   gcc  
i386                 randconfig-i004-20230619   gcc  
i386                 randconfig-i005-20230619   gcc  
i386                 randconfig-i006-20230619   gcc  
i386                 randconfig-i011-20230619   clang
i386                 randconfig-i012-20230619   clang
i386                 randconfig-i013-20230619   clang
i386                 randconfig-i014-20230619   clang
i386                 randconfig-i015-20230619   clang
i386                 randconfig-i016-20230619   clang
i386                 randconfig-r032-20230619   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230619   gcc  
loongarch            randconfig-r036-20230619   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230619   gcc  
m68k                 randconfig-r021-20230619   gcc  
m68k                 randconfig-r034-20230619   gcc  
microblaze           randconfig-r011-20230619   gcc  
microblaze           randconfig-r031-20230619   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                 randconfig-r013-20230619   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r011-20230619   gcc  
openrisc             randconfig-r016-20230619   gcc  
openrisc             randconfig-r033-20230619   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230619   gcc  
parisc               randconfig-r004-20230619   gcc  
parisc               randconfig-r024-20230619   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc              randconfig-r023-20230619   clang
powerpc                     taishan_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230619   clang
riscv                randconfig-r042-20230620   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r032-20230619   gcc  
s390                 randconfig-r044-20230619   clang
s390                 randconfig-r044-20230620   gcc  
sh                               allmodconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                   randconfig-r025-20230619   gcc  
sh                   secureedge5410_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230619   gcc  
sparc                randconfig-r025-20230619   gcc  
sparc                randconfig-r035-20230619   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r005-20230619   clang
um                   randconfig-r015-20230619   gcc  
um                   randconfig-r016-20230619   gcc  
um                   randconfig-r026-20230619   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230619   gcc  
x86_64       buildonly-randconfig-r002-20230619   gcc  
x86_64       buildonly-randconfig-r003-20230619   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230619   gcc  
x86_64               randconfig-a002-20230619   gcc  
x86_64               randconfig-a003-20230619   gcc  
x86_64               randconfig-a004-20230619   gcc  
x86_64               randconfig-a005-20230619   gcc  
x86_64               randconfig-a006-20230619   gcc  
x86_64               randconfig-a011-20230619   clang
x86_64               randconfig-a012-20230619   clang
x86_64               randconfig-a013-20230619   clang
x86_64               randconfig-a014-20230619   clang
x86_64               randconfig-a015-20230619   clang
x86_64               randconfig-a016-20230619   clang
x86_64               randconfig-r005-20230619   gcc  
x86_64               randconfig-r012-20230619   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r012-20230619   gcc  
xtensa               randconfig-r024-20230619   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
