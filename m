Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2A46B047D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjCHKdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCHKdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:33:15 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328F91556F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678271565; x=1709807565;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KxT+NcCVNWwpygX5Ya+olEb7B8nFEB3DjQjHHmuTYFM=;
  b=FjY5TZymtoW0MlttHfCh0obUobP24UJcmNyiLBxperVuWHUHjT436/FW
   7E752F1XR4QbvS8BM14EGqFefGaPI0iq1aTOS4bs4bbZ6a39u6Uu8IeD3
   PG6DG1dJYghn78X1EFj9IzT1bCoj90Z5xQChyGuwruB3AvCRLVUYrJ3TY
   GY3XxQFbvzBC4BMTfKNSOssFPoted71HSiIzkimT5ISWIoZMGxPOxc4lr
   lbtDDIl3v2gluugPM7BAGAs2PyK2RsLd8wZp8O8bNW0oookMRxDV2+DDA
   dJlvtFqvPRihczrVbcPRHoJ5xgtirUI+cPHlWSMa0CXvfk65zQcktZW0w
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="324432642"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="324432642"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 02:32:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="709382186"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="709382186"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Mar 2023 02:32:43 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZr6A-00023c-1T;
        Wed, 08 Mar 2023 10:32:42 +0000
Date:   Wed, 08 Mar 2023 18:32:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:joel-boqun.2023.03.07a] BUILD SUCCESS
 2bf29372b82b781e1c765c6ac9ee6342c46a90b4
Message-ID: <64086449.vQR/FL0p5Ma+Letm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git joel-boqun.2023.03.07a
branch HEAD: 2bf29372b82b781e1c765c6ac9ee6342c46a90b4  rcu/kvfree: Eliminate k[v]free_rcu() single argument macro

elapsed time: 739m

configs tested: 116
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r003-20230307   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r033-20230307   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230305   gcc  
arc                  randconfig-r014-20230305   gcc  
arc                  randconfig-r035-20230307   gcc  
arc                  randconfig-r043-20230305   gcc  
arc                  randconfig-r043-20230306   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230305   gcc  
arm                  randconfig-r021-20230306   gcc  
arm                  randconfig-r031-20230307   gcc  
arm                  randconfig-r046-20230305   clang
arm                  randconfig-r046-20230306   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r006-20230307   clang
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230306   clang
arm64                randconfig-r015-20230305   gcc  
arm64                randconfig-r022-20230305   gcc  
arm64                randconfig-r036-20230307   clang
csky         buildonly-randconfig-r005-20230307   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230305   gcc  
hexagon              randconfig-r002-20230305   clang
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
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230307   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r013-20230305   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r021-20230305   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230307   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r026-20230305   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r016-20230306   gcc  
parisc               randconfig-r022-20230306   gcc  
parisc               randconfig-r024-20230305   gcc  
parisc               randconfig-r032-20230307   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r014-20230306   clang
powerpc              randconfig-r016-20230305   gcc  
powerpc              randconfig-r025-20230306   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230305   gcc  
riscv                randconfig-r042-20230306   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230305   clang
s390                 randconfig-r044-20230305   gcc  
s390                 randconfig-r044-20230306   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230305   gcc  
sparc        buildonly-randconfig-r004-20230307   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r023-20230306   gcc  
sparc64              randconfig-r025-20230305   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
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
x86_64               randconfig-r024-20230306   clang
x86_64               randconfig-r026-20230306   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r011-20230306   gcc  
xtensa               randconfig-r034-20230307   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
