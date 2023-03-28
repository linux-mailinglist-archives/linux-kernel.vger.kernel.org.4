Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3826B6CBA5B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjC1JVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjC1JVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:21:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553135272
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679995260; x=1711531260;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hbGJvgGRae3alSbsJ4r4Vy/RfR9KZM8wn9pxikVMdeY=;
  b=Tb1cDDYwAujRTEdR/EYPjInZMiggK5z9LeWk759Xj5JzY8/vRTWU+Uop
   IqbgP8nOK5tubEx8Ohieqm8BJsMC7kgUI2AsiB+RI+1KsfqUCRClXGCgY
   YSTyIjCWZIsNa8WXFPKlQY/RtMbOe4aic2WuQE/zThTv7qBl91KmGkYJ5
   jRviHm8htpCe2godOiFdcSYrcR9iAgtvTj32PRuD6Y7/uvdSiyRn3lh7+
   mgUaHLAN4oW6/YjOn7mseD3QNDHqgBiaINT1mhbkQjb8V6PNSBllcaAIh
   mvtDsMt3+uHz3VT2e7Co+hs/fun9aKJNukCl8ZXjQ+UtqwQuAuu7nSJmH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="403127332"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="403127332"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 02:20:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="794736121"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="794736121"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2023 02:20:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ph5Vh-000IQb-2T;
        Tue, 28 Mar 2023 09:20:57 +0000
Date:   Tue, 28 Mar 2023 17:20:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 09a81ebff8c6036514b788328d2309fa22833ea6
Message-ID: <6422b15c.nb9MAFr4CEQwnSr4%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 09a81ebff8c6036514b788328d2309fa22833ea6  Merge x86/sev into tip/master

elapsed time: 727m

configs tested: 133
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r016-20230327   gcc  
arc                  randconfig-r043-20230326   gcc  
arc                  randconfig-r043-20230327   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r021-20230327   gcc  
arm                  randconfig-r024-20230327   gcc  
arm                  randconfig-r036-20230327   clang
arm                  randconfig-r046-20230326   clang
arm                  randconfig-r046-20230327   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230327   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230326   gcc  
arm64                randconfig-r013-20230327   clang
csky                                defconfig   gcc  
csky                 randconfig-r003-20230327   gcc  
csky                 randconfig-r012-20230326   gcc  
csky                 randconfig-r016-20230326   gcc  
csky                 randconfig-r035-20230327   gcc  
hexagon              randconfig-r006-20230326   clang
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
ia64                 randconfig-r003-20230326   gcc  
ia64                 randconfig-r015-20230327   gcc  
ia64                 randconfig-r016-20230326   gcc  
ia64                 randconfig-r032-20230327   gcc  
ia64                 randconfig-r034-20230326   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230326   gcc  
loongarch    buildonly-randconfig-r003-20230326   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r015-20230326   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230327   gcc  
microblaze           randconfig-r004-20230327   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2        buildonly-randconfig-r006-20230327   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230327   gcc  
nios2                randconfig-r013-20230326   gcc  
openrisc     buildonly-randconfig-r001-20230326   gcc  
openrisc     buildonly-randconfig-r004-20230326   gcc  
openrisc             randconfig-r004-20230326   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230327   gcc  
parisc               randconfig-r005-20230326   gcc  
parisc               randconfig-r035-20230326   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r012-20230327   clang
powerpc              randconfig-r023-20230327   clang
powerpc              randconfig-r036-20230326   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230327   clang
riscv                               defconfig   gcc  
riscv                randconfig-r013-20230326   gcc  
riscv                randconfig-r033-20230327   gcc  
riscv                randconfig-r042-20230326   gcc  
riscv                randconfig-r042-20230327   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r004-20230327   clang
s390                                defconfig   gcc  
s390                 randconfig-r014-20230326   gcc  
s390                 randconfig-r014-20230327   clang
s390                 randconfig-r044-20230326   gcc  
s390                 randconfig-r044-20230327   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230326   gcc  
sh                   randconfig-r011-20230326   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r032-20230326   gcc  
sparc64      buildonly-randconfig-r006-20230326   gcc  
sparc64              randconfig-r031-20230326   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r005-20230327   gcc  
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
x86_64               randconfig-r002-20230327   gcc  
x86_64               randconfig-r025-20230327   clang
x86_64               randconfig-r026-20230327   clang
x86_64               randconfig-r031-20230327   gcc  
x86_64               randconfig-r034-20230327   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r011-20230326   gcc  
xtensa               randconfig-r011-20230327   gcc  
xtensa               randconfig-r022-20230327   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
