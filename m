Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619F66C5FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjCWGwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCWGwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:52:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACD72F06E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 23:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679554335; x=1711090335;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pIw6Ymqw7Fay4qLUlViOBTDjhuoo3n1s+dcWnM/HsD0=;
  b=I/l0DLjqu19W5GWqOur29+jBk7aL+fEGAR/xyrHOa7/q2Va1ZvlHaS4G
   O2YQvs+xbfbmQ+2ni8tjNGUNGCBEpCF5bp/NQ5V0FYxx0sn7G2klgh+PB
   MR1Vr230nGJRU3Jz2rcrKUwa2DZIpTgIbwfO3TtEWBCPawe9lUCOVqlck
   L2XFWdi+drkiPru5eqA4IhHSEc98GLv8uk8dMLwkrMSzCmQzvxB1lnLwj
   cWc8I7aogmaDVlqptAWbtf3QoDDl9PYmbB43bGDVoTZ13JJJDGfKwXsJM
   T0ury7oI4ikIE8JKJD7WyGvogAc2cK/DDjaFAhFC4Rvm4l+EoXvs/ryLT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="341774867"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="341774867"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 23:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="659472761"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="659472761"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Mar 2023 23:52:14 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfEo1-000E5T-1f;
        Thu, 23 Mar 2023 06:52:13 +0000
Date:   Thu, 23 Mar 2023 14:52:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/acpi] BUILD SUCCESS
 22767544e9763e82acb60c233051bc426381b61c
Message-ID: <641bf716.Nt39TUwy4VSPgopK%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/acpi
branch HEAD: 22767544e9763e82acb60c233051bc426381b61c  x86/ACPI/boot: Improve __acpi_acquire_global_lock

elapsed time: 720m

configs tested: 72
configs skipped: 140

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230322   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r024-20230322   gcc  
csky                 randconfig-r026-20230322   gcc  
hexagon              randconfig-r004-20230322   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a004   clang
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r031-20230322   gcc  
ia64                 randconfig-r032-20230322   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230322   gcc  
mips                             allmodconfig   gcc  
mips                 randconfig-r034-20230322   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r023-20230322   gcc  
openrisc             randconfig-r033-20230322   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230322   gcc  
parisc64                            defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230322   gcc  
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230322   clang
s390                 randconfig-r003-20230322   clang
s390                 randconfig-r022-20230322   gcc  
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r016-20230322   gcc  
sh                   randconfig-r036-20230322   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230322   gcc  
sparc                randconfig-r035-20230322   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
