Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323F46DA896
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 07:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjDGFpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 01:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjDGFpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 01:45:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E894486A6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 22:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680846331; x=1712382331;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vGLtLE5hnvGX+Jp9CYHEBAcFZBiB2kUwckCpFQ0usAI=;
  b=NP+yiVDxdee85fqj2k0QkoqzjmarFBDaXcCzGhIPpd/JlBCT/tjpGt3x
   D00cbYwdbrZa6H/OWh7ALVm+YOQf3xiWUOiXCDbB7mYc433rVMTPqKiNA
   PHFrBZHqs9bOVzP4sOLvIDilDKq14xDCd+3R5eGdaWpxpMxK7O2QrUgD7
   KC9JnaN8wJm/0vRLCO3dELFww0UIVuJFcqzW3fGIUh78NU8cy82brnVt/
   8qSCirddxh06qPMHfCEyG8pwOEO7AdH+gx0JcicOt5OvQH3ZivZZntzj6
   w8o8GSM725UtwnHNuZ84jDMNXyXdmnt53zsCC4Kswhmpq69S2RsWXGnPI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="322573883"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="322573883"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 22:45:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="798597183"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="798597183"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Apr 2023 22:45:30 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkeuf-000SAa-2Q;
        Fri, 07 Apr 2023 05:45:29 +0000
Date:   Fri, 07 Apr 2023 13:44:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp] BUILD SUCCESS
 58312b27497553f81a60dc5b5261a501a65588e5
Message-ID: <642fadcf.s2b1f2KAUVrSJF8P%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp
branch HEAD: 58312b27497553f81a60dc5b5261a501a65588e5  rxrpc: Replace fake flex-array with flexible-array member

elapsed time: 730m

configs tested: 129
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230405   gcc  
alpha                randconfig-r021-20230403   gcc  
alpha                randconfig-r024-20230403   gcc  
alpha                randconfig-r026-20230403   gcc  
alpha                randconfig-r034-20230403   gcc  
alpha                randconfig-r036-20230403   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r033-20230403   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r034-20230403   gcc  
arm                  randconfig-r046-20230403   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230403   clang
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230403   clang
csky                                defconfig   gcc  
csky                 randconfig-r002-20230405   gcc  
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r045-20230403   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                 randconfig-a012-20230403   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                 randconfig-r022-20230403   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r006-20230406   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230405   gcc  
loongarch            randconfig-r013-20230403   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230403   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230406   gcc  
m68k                 randconfig-r012-20230403   gcc  
m68k                 randconfig-r026-20230403   gcc  
microblaze   buildonly-randconfig-r005-20230403   gcc  
microblaze           randconfig-r031-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230403   gcc  
mips         buildonly-randconfig-r004-20230403   gcc  
mips                 randconfig-r014-20230403   clang
mips                 randconfig-r025-20230403   clang
nios2        buildonly-randconfig-r004-20230403   gcc  
nios2        buildonly-randconfig-r006-20230403   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230406   gcc  
nios2                randconfig-r023-20230403   gcc  
nios2                randconfig-r024-20230403   gcc  
openrisc             randconfig-r006-20230405   gcc  
openrisc             randconfig-r011-20230403   gcc  
parisc       buildonly-randconfig-r003-20230403   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r012-20230403   gcc  
powerpc              randconfig-r025-20230403   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230403   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230403   clang
s390                 randconfig-r005-20230406   gcc  
s390                 randconfig-r035-20230403   clang
s390                 randconfig-r044-20230403   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230403   gcc  
sh                   randconfig-r002-20230406   gcc  
sh                   randconfig-r005-20230405   gcc  
sh                   randconfig-r013-20230403   gcc  
sh                   randconfig-r036-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230403   gcc  
sparc                randconfig-r023-20230403   gcc  
sparc                randconfig-r032-20230403   gcc  
sparc64      buildonly-randconfig-r006-20230403   gcc  
sparc64              randconfig-r004-20230405   gcc  
sparc64              randconfig-r004-20230406   gcc  
sparc64              randconfig-r014-20230403   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r003-20230403   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64               randconfig-a006-20230403   clang
x86_64               randconfig-a011-20230403   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64               randconfig-r001-20230403   clang
x86_64               randconfig-r021-20230403   gcc  
x86_64               randconfig-r022-20230403   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r016-20230403   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
