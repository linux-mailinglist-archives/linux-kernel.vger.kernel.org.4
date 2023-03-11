Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAACA6B5976
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 09:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjCKIW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 03:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCKIWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 03:22:54 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6911E14267F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 00:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678522967; x=1710058967;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RkLuyQrgJxBodKXaZKotjBZrfX+XY20UkmTlfCcKin0=;
  b=cZzm5nSbneLIg1z6k5DVsMzFu8YOCItiDiOoDpdKyA0A0MozslU05kMu
   7v0Ao0VH4pSnQzIpjD6jMACKhI9y9jfjvVbA9jsBaCwIj8JZFNNBs0rPd
   G+in+zvFtsO2XwCc0bKPf1lbsaRnHoXiCLssGYxJCxn3yoXBOteEYAG2E
   SzvdV2Zy3geyTkK+lV2anPg0xlUFDKoiRneVrLzJ7wyqSlydhJ4wzVYw7
   jFoTUbjV95h+iNVCQWrsapJ2FeKDcJXtuh14y7nNliPO8kTsVFWE+kMpj
   ON4LLOlrzm5pCDAqETdnlwk8NXrVxKONeT91HINkjpz+1Zgua3kttfW8R
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="401749714"
X-IronPort-AV: E=Sophos;i="5.98,252,1673942400"; 
   d="scan'208";a="401749714"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 00:22:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="742273104"
X-IronPort-AV: E=Sophos;i="5.98,252,1673942400"; 
   d="scan'208";a="742273104"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 11 Mar 2023 00:22:45 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pauV3-0004S1-0Y;
        Sat, 11 Mar 2023 08:22:45 +0000
Date:   Sat, 11 Mar 2023 16:22:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 5910f06503aae3cc4890e562683abc3e38857ff9
Message-ID: <640c3a28.T4E7OMD6QP4k3YhU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: 5910f06503aae3cc4890e562683abc3e38857ff9  MAINTAINERS: Add x86 hardware vulnerabilities section

elapsed time: 1290m

configs tested: 113
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230310   gcc  
arc                  randconfig-r013-20230310   gcc  
arc                  randconfig-r043-20230310   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r003-20230310   clang
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230310   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230310   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230310   gcc  
csky                 randconfig-r006-20230310   gcc  
csky                 randconfig-r023-20230310   gcc  
csky                 randconfig-r036-20230310   gcc  
hexagon              randconfig-r041-20230310   clang
hexagon              randconfig-r045-20230310   clang
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
ia64         buildonly-randconfig-r005-20230310   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230310   gcc  
ia64                 randconfig-r021-20230310   gcc  
ia64                 randconfig-r035-20230310   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r004-20230310   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r011-20230310   gcc  
m68k                 randconfig-r034-20230310   gcc  
microblaze           randconfig-r001-20230310   gcc  
microblaze           randconfig-r004-20230310   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r015-20230310   clang
mips                 randconfig-r025-20230310   clang
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230310   gcc  
nios2                randconfig-r025-20230310   gcc  
openrisc             randconfig-r002-20230310   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r031-20230310   gcc  
parisc               randconfig-r032-20230310   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230310   gcc  
powerpc      buildonly-randconfig-r002-20230310   gcc  
powerpc              randconfig-r005-20230310   clang
powerpc              randconfig-r012-20230310   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r022-20230310   gcc  
riscv                randconfig-r042-20230310   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230310   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r022-20230310   gcc  
s390                 randconfig-r026-20230310   gcc  
s390                 randconfig-r044-20230310   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230310   gcc  
sh                   randconfig-r014-20230310   gcc  
sh                   randconfig-r024-20230310   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r021-20230310   gcc  
sparc64              randconfig-r006-20230310   gcc  
sparc64              randconfig-r016-20230310   gcc  
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
xtensa               randconfig-r024-20230310   gcc  
xtensa               randconfig-r026-20230310   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
