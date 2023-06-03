Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23058720E7D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 09:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjFCHdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 03:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFCHd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 03:33:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10F2198
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 00:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685777606; x=1717313606;
  h=date:from:to:cc:subject:message-id;
  bh=XcMcT6okuiaafGky4WI7h6hSdilfS87e/8m/3EBPPr8=;
  b=kTqjJ2GBxgdInIonpkDvd9BARqyFNjVYJWlmD4VlcIBd494+7DTJdQds
   YVU1afT/QNhYJv3sJpY1jM192MKxINr42em/QgQo3LDovFc3VOmAItoJu
   f5zhatKia+x8B04bgmaJMZ8dPZXFloCWvcl6KjkLhZUn7RUnr75GoxTLW
   l0pqPjCNG5tyIz5QnEkjY6iQD0N9OogCGTDCSCs+CqR/kPgzlOdpyrK/y
   BWIEUH/dShcEmOhBZddiNJS696lLSDJpCMRYCCydaaUiW2qxHOnOe/85j
   MMEVUwg7jvVQAwspkiyEROqDAPTWOwU/Ble/853RBOwab4hJyaZNxMQTL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="419585475"
X-IronPort-AV: E=Sophos;i="6.00,215,1681196400"; 
   d="scan'208";a="419585475"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 00:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="658512050"
X-IronPort-AV: E=Sophos;i="6.00,215,1681196400"; 
   d="scan'208";a="658512050"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2023 00:33:24 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5LlM-0001QD-0h;
        Sat, 03 Jun 2023 07:33:24 +0000
Date:   Sat, 03 Jun 2023 15:33:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/core] BUILD SUCCESS
 ff9a6459bbec06df7da2545020d7383aba13b3fb
Message-ID: <20230603073304.qMJPF%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
branch HEAD: ff9a6459bbec06df7da2545020d7383aba13b3fb  objtool: Add __kunit_abort() to noreturns

elapsed time: 720m

configs tested: 227
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230531   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230531   gcc  
alpha                randconfig-r015-20230601   gcc  
alpha                randconfig-r021-20230531   gcc  
alpha                randconfig-r024-20230531   gcc  
alpha                randconfig-r025-20230531   gcc  
alpha                randconfig-r033-20230602   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc          buildonly-randconfig-r005-20230531   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                  randconfig-r015-20230601   gcc  
arc                  randconfig-r043-20230531   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                          collie_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                  randconfig-r024-20230531   gcc  
arm                  randconfig-r026-20230531   gcc  
arm                  randconfig-r046-20230531   gcc  
arm                             rpc_defconfig   gcc  
arm                           sama7_defconfig   clang
arm                           spitz_defconfig   clang
arm                           sunxi_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230531   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r021-20230531   clang
arm64                randconfig-r031-20230531   gcc  
arm64                randconfig-r031-20230602   gcc  
arm64                randconfig-r036-20230602   gcc  
csky         buildonly-randconfig-r003-20230531   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r005-20230531   gcc  
csky                 randconfig-r023-20230531   gcc  
hexagon      buildonly-randconfig-r004-20230531   clang
hexagon              randconfig-r006-20230602   clang
hexagon              randconfig-r032-20230531   clang
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r002-20230531   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230531   gcc  
i386                 randconfig-i001-20230602   gcc  
i386                 randconfig-i002-20230531   gcc  
i386                 randconfig-i002-20230602   gcc  
i386                 randconfig-i003-20230531   gcc  
i386                 randconfig-i003-20230602   gcc  
i386                 randconfig-i004-20230531   gcc  
i386                 randconfig-i004-20230602   gcc  
i386                 randconfig-i005-20230531   gcc  
i386                 randconfig-i005-20230602   gcc  
i386                 randconfig-i006-20230531   gcc  
i386                 randconfig-i006-20230602   gcc  
i386                 randconfig-i051-20230531   gcc  
i386                 randconfig-i051-20230602   gcc  
i386                 randconfig-i052-20230531   gcc  
i386                 randconfig-i052-20230602   gcc  
i386                 randconfig-i053-20230531   gcc  
i386                 randconfig-i053-20230602   gcc  
i386                 randconfig-i054-20230531   gcc  
i386                 randconfig-i054-20230602   gcc  
i386                 randconfig-i055-20230531   gcc  
i386                 randconfig-i055-20230602   gcc  
i386                 randconfig-i056-20230531   gcc  
i386                 randconfig-i056-20230602   gcc  
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i061-20230602   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i062-20230602   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i063-20230602   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i064-20230602   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i065-20230602   gcc  
i386                 randconfig-i066-20230531   gcc  
i386                 randconfig-i066-20230602   gcc  
i386                 randconfig-r002-20230602   gcc  
i386                 randconfig-r004-20230602   gcc  
i386                 randconfig-r012-20230601   gcc  
i386                 randconfig-r035-20230531   gcc  
i386                 randconfig-r035-20230602   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r004-20230531   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230602   gcc  
loongarch            randconfig-r011-20230601   gcc  
loongarch            randconfig-r016-20230601   gcc  
loongarch            randconfig-r021-20230531   gcc  
loongarch            randconfig-r036-20230531   gcc  
m68k                             allmodconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k         buildonly-randconfig-r006-20230531   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                 randconfig-r013-20230601   gcc  
m68k                 randconfig-r016-20230601   gcc  
m68k                 randconfig-r022-20230531   gcc  
m68k                 randconfig-r023-20230531   gcc  
m68k                 randconfig-r034-20230531   gcc  
m68k                 randconfig-r034-20230602   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
microblaze           randconfig-r013-20230601   gcc  
microblaze           randconfig-r021-20230531   gcc  
microblaze           randconfig-r022-20230531   gcc  
microblaze           randconfig-r025-20230531   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips                           ci20_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                        maltaup_defconfig   clang
mips                          rm200_defconfig   clang
nios2                         3c120_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2        buildonly-randconfig-r002-20230531   gcc  
nios2        buildonly-randconfig-r004-20230531   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230531   gcc  
nios2                randconfig-r001-20230602   gcc  
nios2                randconfig-r012-20230601   gcc  
openrisc     buildonly-randconfig-r003-20230531   gcc  
openrisc             randconfig-r011-20230601   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r032-20230531   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                        icon_defconfig   clang
powerpc                      mgcoge_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                      ppc44x_defconfig   clang
powerpc              randconfig-r006-20230531   gcc  
powerpc              randconfig-r014-20230601   gcc  
powerpc              randconfig-r024-20230531   clang
powerpc              randconfig-r032-20230602   gcc  
powerpc                     tqm8560_defconfig   clang
powerpc                        warp_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230531   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230601   gcc  
s390                 randconfig-r023-20230531   clang
s390                 randconfig-r044-20230531   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230531   gcc  
sh                        edosk7760_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                   randconfig-r003-20230531   gcc  
sh                   randconfig-r005-20230602   gcc  
sh                   randconfig-r016-20230601   gcc  
sh                   randconfig-r025-20230531   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc        buildonly-randconfig-r002-20230531   gcc  
sparc        buildonly-randconfig-r006-20230531   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r013-20230601   gcc  
sparc                randconfig-r015-20230601   gcc  
sparc64      buildonly-randconfig-r002-20230531   gcc  
sparc64      buildonly-randconfig-r004-20230531   gcc  
sparc64              randconfig-r002-20230531   gcc  
sparc64              randconfig-r022-20230531   gcc  
sparc64              randconfig-r025-20230531   gcc  
sparc64              randconfig-r033-20230531   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230531   gcc  
x86_64               randconfig-a002-20230531   gcc  
x86_64               randconfig-a003-20230531   gcc  
x86_64               randconfig-a004-20230531   gcc  
x86_64               randconfig-a005-20230531   gcc  
x86_64               randconfig-a006-20230531   gcc  
x86_64               randconfig-a011-20230603   gcc  
x86_64               randconfig-a012-20230603   gcc  
x86_64               randconfig-a013-20230603   gcc  
x86_64               randconfig-a014-20230603   gcc  
x86_64               randconfig-a015-20230603   gcc  
x86_64               randconfig-a016-20230603   gcc  
x86_64               randconfig-r031-20230531   gcc  
x86_64               randconfig-x051-20230603   gcc  
x86_64               randconfig-x052-20230603   gcc  
x86_64               randconfig-x053-20230603   gcc  
x86_64               randconfig-x054-20230603   gcc  
x86_64               randconfig-x055-20230603   gcc  
x86_64               randconfig-x056-20230603   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r036-20230531   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
