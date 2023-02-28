Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A364C6A5FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjB1Tlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjB1Tlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:41:53 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED7DE07E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677613312; x=1709149312;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=98jwjScojf1INnpYly9gjAp+Of0sb5ussY7hkUCbwPU=;
  b=K786pb20IOa5Ko1Os4efspX1mTNFGHctYKfTl9x7meAyMdAfqThFid3G
   +FewETb/Tcwg2KKh9yb71xQWg0wEX62JDumtbnr6o6qE0c+J/Jp3KWJ4L
   ZkbjdTnPfFgWxzYgOzBfobiej6jrC2MlFjfoYFvvGeVcz9OF5+7/MOZz3
   4smtdqOJaItZm9sPQpR24DXB7wMQ1/GAC0mifAxh0sC9H2xFHS9P06c+1
   LUPZIj4F1f+c8+By6dWmh5DSxtruHq2MYbtRQuQc3szM5+sPJ+LJKG0zK
   pwWpRf1uQnIzzEOQFaI4i0/D4UKElt9JVoAg4Mr6NpPCt++DfDYfWiM0E
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="399013900"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="399013900"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 11:41:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="798162430"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="798162430"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Feb 2023 11:41:50 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pX5rB-0005bj-2U;
        Tue, 28 Feb 2023 19:41:49 +0000
Date:   Wed, 01 Mar 2023 03:40:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 edb4f8670f6e337bd34438fe53ccb9a4e44ecb23
Message-ID: <63fe58cb.8westRSmqj94VWe4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: edb4f8670f6e337bd34438fe53ccb9a4e44ecb23  Merge branch into tip/master: 'objtool/core'

elapsed time: 727m

configs tested: 144
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r003-20230226   gcc  
alpha        buildonly-randconfig-r003-20230227   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230227   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230226   gcc  
arc                  randconfig-r015-20230226   gcc  
arc                  randconfig-r024-20230226   gcc  
arc                  randconfig-r043-20230228   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r006-20230226   gcc  
arm                                 defconfig   gcc  
arm                          ep93xx_defconfig   clang
arm                  randconfig-r012-20230226   gcc  
arm                  randconfig-r026-20230226   gcc  
arm                  randconfig-r046-20230228   gcc  
arm                           sama7_defconfig   clang
arm                        spear3xx_defconfig   clang
arm                           spitz_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230226   clang
arm64                randconfig-r023-20230227   gcc  
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r004-20230227   clang
hexagon              randconfig-r015-20230228   clang
hexagon              randconfig-r031-20230226   clang
hexagon              randconfig-r034-20230227   clang
hexagon              randconfig-r041-20230228   clang
hexagon              randconfig-r045-20230228   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230227   clang
i386                 randconfig-a002-20230227   clang
i386                 randconfig-a003-20230227   clang
i386                 randconfig-a004-20230227   clang
i386                 randconfig-a005-20230227   clang
i386                 randconfig-a006-20230227   clang
i386                 randconfig-a011-20230227   gcc  
i386                 randconfig-a012-20230227   gcc  
i386                 randconfig-a013-20230227   gcc  
i386                 randconfig-a014-20230227   gcc  
i386                 randconfig-a015-20230227   gcc  
i386                 randconfig-a016-20230227   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r013-20230228   gcc  
ia64                 randconfig-r025-20230227   gcc  
ia64                 randconfig-r036-20230226   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230226   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230227   gcc  
loongarch            randconfig-r011-20230228   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r003-20230227   gcc  
m68k                 randconfig-r016-20230227   gcc  
microblaze           randconfig-r004-20230227   gcc  
microblaze           randconfig-r011-20230226   gcc  
microblaze           randconfig-r014-20230228   gcc  
microblaze           randconfig-r026-20230227   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r012-20230227   clang
mips                           rs90_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230227   gcc  
nios2                randconfig-r022-20230226   gcc  
openrisc             randconfig-r012-20230228   gcc  
openrisc             randconfig-r014-20230226   gcc  
openrisc             randconfig-r016-20230226   gcc  
openrisc             randconfig-r031-20230227   gcc  
openrisc             randconfig-r035-20230227   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r033-20230227   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r021-20230226   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230227   gcc  
riscv                randconfig-r042-20230228   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230227   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230226   gcc  
s390                 randconfig-r013-20230226   clang
s390                 randconfig-r024-20230227   gcc  
s390                 randconfig-r025-20230226   clang
s390                 randconfig-r044-20230228   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230226   gcc  
sh                         ecovec24_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                   randconfig-r032-20230227   gcc  
sh                   randconfig-r035-20230226   gcc  
sh                           se7724_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230227   gcc  
sparc                randconfig-r005-20230226   gcc  
sparc                randconfig-r013-20230227   gcc  
sparc                randconfig-r015-20230227   gcc  
sparc64      buildonly-randconfig-r005-20230227   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r006-20230227   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64               randconfig-a011-20230227   gcc  
x86_64               randconfig-a012-20230227   gcc  
x86_64               randconfig-a013-20230227   gcc  
x86_64               randconfig-a014-20230227   gcc  
x86_64               randconfig-a015-20230227   gcc  
x86_64               randconfig-a016-20230227   gcc  
x86_64               randconfig-r036-20230227   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230227   gcc  
xtensa               randconfig-r001-20230227   gcc  
xtensa               randconfig-r003-20230226   gcc  
xtensa               randconfig-r004-20230226   gcc  
xtensa               randconfig-r016-20230228   gcc  
xtensa               randconfig-r033-20230226   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
