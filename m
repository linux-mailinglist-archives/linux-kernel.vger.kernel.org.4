Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E4F6E36A0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 11:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjDPJdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 05:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjDPJdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 05:33:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5232F2132
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 02:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681637587; x=1713173587;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5zreMxGjZKIJANb1TexdmE2H++2UviPWu1yEdXkZRsA=;
  b=WlY4zhEbyrm/eZZqUSy8nQM8xLKNX46NLeobXyf1B3znHYjmZD7N+J0n
   DNhknk2CXAZeB3osfQG8fZ/YR5OG2CMtU5UP/iJz9nf8zpGe8Os4Q72fz
   DrqJmz++QhcOt5m8pWn6J9HvufAyaLRZ4YZXGEVHTF/16Vtjw0/svMhXA
   oV22IQ1N1lqwRhmkQAhTIlJPziOQLWfvagToZtMkIQ9eMDRNkd1/4VGCi
   JZGakEwWhykE0RYigYR775p3GoBHajj0J93odW0omte1uODMt8+hQKg+9
   dHtAqEAvSYV/Qc/xf47pken25yL99cND/xQJQShctHM+isGZ/VzQn5WCs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10681"; a="344714604"
X-IronPort-AV: E=Sophos;i="5.99,201,1677571200"; 
   d="scan'208";a="344714604"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 02:33:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10681"; a="667808632"
X-IronPort-AV: E=Sophos;i="5.99,201,1677571200"; 
   d="scan'208";a="667808632"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Apr 2023 02:33:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnykq-000bbK-14;
        Sun, 16 Apr 2023 09:33:04 +0000
Date:   Sun, 16 Apr 2023 17:32:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD REGRESSION
 84d9651e13fb9820041d19262a55906851524c0f
Message-ID: <643bc0a0.V0FO3QYbUJgRGcVd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 84d9651e13fb9820041d19262a55906851524c0f  PCI/MSI: Remove over-zealous hardware size check in pci_msix_validate_entries()

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202304160752.QJiM8zR3-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304160832.bMSgCZQD-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304160844.cCgXqLn2-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/pci/msi/msi.c:763:18: error: use of undeclared identifier 'nvec'; did you mean 'nvev'?
drivers/pci/msi/msi.c:763:25: error: 'nvec' undeclared (first use in this function); did you mean 'nvev'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- ia64-randconfig-r002-20230416
|   `-- drivers-pci-msi-msi.c:error:nvec-undeclared-(first-use-in-this-function)
|-- mips-allyesconfig
|   `-- drivers-pci-msi-msi.c:error:nvec-undeclared-(first-use-in-this-function)
|-- powerpc-allmodconfig
|   `-- drivers-pci-msi-msi.c:error:nvec-undeclared-(first-use-in-this-function)
|-- s390-allyesconfig
|   `-- drivers-pci-msi-msi.c:error:nvec-undeclared-(first-use-in-this-function)
|-- x86_64-allyesconfig
|   `-- drivers-pci-msi-msi.c:error:nvec-undeclared-(first-use-in-this-function)
|-- x86_64-defconfig
|   `-- drivers-pci-msi-msi.c:error:nvec-undeclared-(first-use-in-this-function)
`-- x86_64-rhel-8.3
    `-- drivers-pci-msi-msi.c:error:nvec-undeclared-(first-use-in-this-function)
clang_recent_errors
|-- mips-loongson2k_defconfig
|   `-- drivers-pci-msi-msi.c:error:use-of-undeclared-identifier-nvec
|-- powerpc-ppc44x_defconfig
|   `-- drivers-pci-msi-msi.c:error:use-of-undeclared-identifier-nvec
|-- s390-randconfig-r035-20230416
|   `-- drivers-pci-msi-msi.c:error:use-of-undeclared-identifier-nvec
`-- x86_64-randconfig-a012
    `-- drivers-pci-msi-msi.c:error:use-of-undeclared-identifier-nvec

elapsed time: 725m

configs tested: 101
configs skipped: 11

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r021-20230416   gcc  
arc                  randconfig-r043-20230416   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                  randconfig-r046-20230416   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r045-20230416   clang
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
ia64                 randconfig-r002-20230416   gcc  
ia64                 randconfig-r026-20230416   gcc  
ia64                 randconfig-r036-20230416   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r002-20230416   gcc  
microblaze           randconfig-r001-20230416   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                     loongson2k_defconfig   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r006-20230416   gcc  
openrisc             randconfig-r011-20230416   gcc  
openrisc             randconfig-r016-20230416   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      ppc44x_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230416   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r025-20230416   gcc  
riscv                randconfig-r042-20230416   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230416   gcc  
s390                 randconfig-r022-20230416   gcc  
s390                 randconfig-r035-20230416   clang
s390                 randconfig-r044-20230416   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r013-20230416   gcc  
sh                   randconfig-r024-20230416   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sparc        buildonly-randconfig-r001-20230416   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230416   gcc  
sparc                randconfig-r031-20230416   gcc  
sparc                       sparc32_defconfig   gcc  
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
xtensa               randconfig-r023-20230416   gcc  
xtensa               randconfig-r032-20230416   gcc  
xtensa               randconfig-r034-20230416   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
