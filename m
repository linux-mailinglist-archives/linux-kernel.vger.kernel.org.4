Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F4F6A9084
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 06:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCCFkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 00:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCCFkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 00:40:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFD71F93B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 21:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677822052; x=1709358052;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=W6LZAhVRhpCOhxdpPwd9plf4H6C8ObNaR6bidOMqvr4=;
  b=IHwviwoN8mxrGxmIwjDbwglEVzM2vUSIVIA752y0zFUEyhS8CEpzd0S5
   J88ooVBkpKluSszye5KcZqm/83jbUKt/XVYiMPms2wWPihzZ2egeaZN2Y
   eVTx8X6uVvfR+JaBGVc1UkKnanZDmn+wCnU2ugz6xJOC4sbNYuBgkOeEF
   TwkmszbpooQPbIK4b24mo63HlNuBNzwOSzoUL+4XtH1lt8gFJTkPopoFe
   ZorA2eLsJZRJPQODv/QKf6ly9z8yCf7fet7ZVu49kJpLYRdHe9iyGdcyV
   G2MgRl2eKwOdsfdVID0PMnIuOX2SoStQNpc0IzdnhxdXMTIsI84tqbsPK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="314618900"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="314618900"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 21:40:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="785150985"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="785150985"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2023 21:40:51 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXy9y-0001EI-18;
        Fri, 03 Mar 2023 05:40:50 +0000
Date:   Fri, 03 Mar 2023 13:40:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 0fb7fb713461e44b12e72c292bf90ee300f40710
Message-ID: <64018853.+/5G7u+pLB6pDILz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 0fb7fb713461e44b12e72c292bf90ee300f40710  genirq/msi, platform-msi: Ensure that MSI descriptors are unreferenced

elapsed time: 727m

configs tested: 136
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230302   gcc  
alpha                randconfig-r006-20230302   gcc  
alpha                randconfig-r016-20230303   gcc  
alpha                randconfig-r033-20230302   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230302   gcc  
arc                  randconfig-r013-20230302   gcc  
arc                  randconfig-r023-20230302   gcc  
arc                  randconfig-r043-20230302   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r011-20230302   gcc  
arm                  randconfig-r012-20230302   gcc  
arm                  randconfig-r012-20230303   clang
arm                  randconfig-r014-20230303   clang
arm                  randconfig-r015-20230302   gcc  
arm                  randconfig-r036-20230302   clang
arm                  randconfig-r046-20230302   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230303   gcc  
arm64                randconfig-r014-20230302   clang
csky         buildonly-randconfig-r002-20230302   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r016-20230302   gcc  
csky                 randconfig-r034-20230302   gcc  
csky                 randconfig-r035-20230302   gcc  
hexagon              randconfig-r025-20230302   clang
hexagon              randconfig-r026-20230302   clang
hexagon              randconfig-r031-20230302   clang
hexagon              randconfig-r041-20230302   clang
hexagon              randconfig-r045-20230302   clang
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
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230302   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230302   gcc  
ia64                 randconfig-r012-20230302   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r014-20230303   gcc  
loongarch            randconfig-r021-20230302   gcc  
loongarch            randconfig-r032-20230302   gcc  
loongarch            randconfig-r035-20230302   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r004-20230302   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230302   gcc  
m68k                 randconfig-r013-20230302   gcc  
m68k                 randconfig-r014-20230302   gcc  
m68k                 randconfig-r021-20230302   gcc  
microblaze   buildonly-randconfig-r001-20230302   gcc  
microblaze   buildonly-randconfig-r003-20230302   gcc  
microblaze           randconfig-r005-20230302   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r005-20230302   clang
mips                     decstation_defconfig   gcc  
mips                 randconfig-r034-20230302   clang
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230302   gcc  
openrisc             randconfig-r004-20230302   gcc  
openrisc             randconfig-r015-20230303   gcc  
openrisc             randconfig-r024-20230302   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230303   gcc  
parisc               randconfig-r031-20230302   gcc  
parisc               randconfig-r033-20230302   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r006-20230302   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r013-20230303   gcc  
riscv                randconfig-r016-20230303   gcc  
riscv                randconfig-r042-20230302   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230302   clang
sh                               allmodconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                   randconfig-r001-20230302   gcc  
sh                   randconfig-r003-20230302   gcc  
sh                   randconfig-r016-20230302   gcc  
sh                          sdk7786_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r023-20230302   gcc  
sparc64      buildonly-randconfig-r003-20230302   gcc  
sparc64              randconfig-r001-20230302   gcc  
sparc64              randconfig-r025-20230302   gcc  
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
xtensa       buildonly-randconfig-r005-20230302   gcc  
xtensa               randconfig-r015-20230302   gcc  
xtensa               randconfig-r022-20230302   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
