Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82280721586
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 10:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjFDIKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 04:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFDIKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 04:10:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBBAC4
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 01:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685866219; x=1717402219;
  h=date:from:to:cc:subject:message-id;
  bh=J1U02ll0uKNtNDQWrtXw/8TFyvIoFH4TCqu7kKOiWBY=;
  b=Zm3JtfZSlikkvPW6sYBaBB5BJec3BP3TzU3TsJai8DZNjIE6iRACfJuN
   dsyrdhDZCThfSLjKeTvccRQILFlGWL/Bnp+IYWh+f9+HyVafEehOavAr0
   19xwrUROhh09XMkgI5H6jPYQiV0QXmXTsGNq4bzNl4byy8AN8c7NnE62i
   r525V22Yjj9qbQagJeP0ADB/DFxRw5iWfUuMarHpfNll5MqgbdbioFMXZ
   uS5sPqenr8lKHxWGwn+tEot1kJv0cRTeKPjAW+vs6TbmfQU2rkwx+wmH8
   cjgbF/JM2gKN4mKeKGL3TUfLlw/24bdRGinwHyJx2LtGsFNykXDpt3nJ5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="384456731"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="384456731"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 01:10:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="741312163"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="741312163"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Jun 2023 01:10:18 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5iob-0002T7-20;
        Sun, 04 Jun 2023 08:10:17 +0000
Date:   Sun, 04 Jun 2023 16:09:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 2b516c375366af5b9b867d93c9afd1d314034153
Message-ID: <20230604080948.fiX8k%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 2b516c375366af5b9b867d93c9afd1d314034153  Merge branch into tip/master: 'objtool/core'

elapsed time: 722m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230604   gcc  
arc                  randconfig-r023-20230604   gcc  
arc                  randconfig-r043-20230604   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                  randconfig-r032-20230604   clang
arm                  randconfig-r046-20230604   gcc  
arm                        realview_defconfig   gcc  
arm                           sama7_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230604   gcc  
csky                 randconfig-r031-20230604   gcc  
hexagon              randconfig-r001-20230604   clang
hexagon              randconfig-r004-20230604   clang
hexagon              randconfig-r014-20230604   clang
hexagon              randconfig-r041-20230604   clang
hexagon              randconfig-r045-20230604   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230604   gcc  
i386                 randconfig-i002-20230604   gcc  
i386                 randconfig-i003-20230604   gcc  
i386                 randconfig-i004-20230604   gcc  
i386                 randconfig-i005-20230604   gcc  
i386                 randconfig-i006-20230604   gcc  
i386                 randconfig-i051-20230604   gcc  
i386                 randconfig-i052-20230604   gcc  
i386                 randconfig-i053-20230604   gcc  
i386                 randconfig-i054-20230604   gcc  
i386                 randconfig-i055-20230604   gcc  
i386                 randconfig-i056-20230604   gcc  
i386                 randconfig-i061-20230604   gcc  
i386                 randconfig-i062-20230604   gcc  
i386                 randconfig-i063-20230604   gcc  
i386                 randconfig-i064-20230604   gcc  
i386                 randconfig-i065-20230604   gcc  
i386                 randconfig-i066-20230604   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230604   gcc  
loongarch    buildonly-randconfig-r004-20230604   gcc  
loongarch    buildonly-randconfig-r005-20230604   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230604   gcc  
loongarch            randconfig-r016-20230604   gcc  
loongarch            randconfig-r036-20230604   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r011-20230604   gcc  
m68k                 randconfig-r025-20230604   gcc  
microblaze           randconfig-r022-20230604   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips         buildonly-randconfig-r003-20230604   clang
mips                 randconfig-r024-20230604   gcc  
mips                        vocore2_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r034-20230604   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                     rainier_defconfig   gcc  
powerpc              randconfig-r013-20230604   clang
powerpc              randconfig-r015-20230604   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230604   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230604   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230604   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230604   gcc  
sparc                       sparc64_defconfig   gcc  
um                               alldefconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230604   gcc  
x86_64               randconfig-a002-20230604   gcc  
x86_64               randconfig-a003-20230604   gcc  
x86_64               randconfig-a004-20230604   gcc  
x86_64               randconfig-a005-20230604   gcc  
x86_64               randconfig-a006-20230604   gcc  
x86_64               randconfig-r033-20230604   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230604   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa               randconfig-r002-20230604   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
