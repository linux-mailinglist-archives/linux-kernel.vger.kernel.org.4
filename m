Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69F76D6D67
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbjDDTrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjDDTrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:47:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CD32727
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680637662; x=1712173662;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dglFCFqJMbhOG22S7JBXUK64ecI6/Tj125OmSiqEWos=;
  b=NUkodbByZdssKxof9jnr9LYUvI7AaVHyVWZgbgAzOnDRX9pyLIsEI793
   hAkAxxEJ6FypfvNxeVAfoqAInnrpXSVMeZ2QUgdNtcmrF9ayRQesfA5hQ
   VwFGX0YnrzcPt7ooDy9UW0siU+tkWW6u+RFWSenfkuLAc+v5usTuk1Kgb
   YvB5zeXwuOtmFNsSfQ0TJxWS+rDinn+2fTU60lUprghdAWhynTfjZGidX
   /6COpOFFmCuOlGspnE8bUxNwalWmQ63B7+JtdeDfEaDSTzGGtNYMilBuu
   grYj0CoC8VB4Co5jl4DbY5WbdiwvgKpnIznz6AUamsyge2nxq8mQMGSTW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="342308477"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="342308477"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 12:47:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="932564631"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="932564631"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 04 Apr 2023 12:47:40 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjmd1-000Pzu-2z;
        Tue, 04 Apr 2023 19:47:39 +0000
Date:   Wed, 05 Apr 2023 03:47:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 37b470d6a9e8456bcd3874ec8de19973a724b9e0
Message-ID: <642c7eb8.U3RDfPMbXqtXrXvQ%lkp@intel.com>
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
branch HEAD: 37b470d6a9e8456bcd3874ec8de19973a724b9e0  Merge branch into tip/master: 'x86/tdx'

elapsed time: 724m

configs tested: 117
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r036-20230404   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r034-20230403   gcc  
arc                  randconfig-r043-20230404   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r011-20230403   clang
arm                  randconfig-r046-20230404   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r006-20230404   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r004-20230403   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r015-20230403   gcc  
csky                 randconfig-r021-20230404   gcc  
csky                 randconfig-r033-20230403   gcc  
hexagon      buildonly-randconfig-r003-20230403   clang
hexagon      buildonly-randconfig-r006-20230403   clang
hexagon              randconfig-r016-20230403   clang
hexagon              randconfig-r035-20230403   clang
hexagon              randconfig-r041-20230404   clang
hexagon              randconfig-r045-20230404   clang
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
i386                 randconfig-r036-20230403   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230403   gcc  
ia64                 randconfig-r014-20230403   gcc  
ia64                 randconfig-r022-20230403   gcc  
ia64                 randconfig-r023-20230403   gcc  
ia64                 randconfig-r026-20230404   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r025-20230403   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230403   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r034-20230404   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230404   clang
mips                 randconfig-r005-20230403   gcc  
mips                 randconfig-r013-20230403   clang
nios2                               defconfig   gcc  
nios2                randconfig-r024-20230403   gcc  
nios2                randconfig-r033-20230404   gcc  
parisc       buildonly-randconfig-r001-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230404   clang
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230404   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230403   clang
s390                 randconfig-r031-20230404   gcc  
s390                 randconfig-r044-20230404   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r031-20230403   gcc  
sparc        buildonly-randconfig-r002-20230403   gcc  
sparc        buildonly-randconfig-r003-20230404   gcc  
sparc        buildonly-randconfig-r004-20230404   gcc  
sparc        buildonly-randconfig-r005-20230404   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230404   gcc  
sparc64              randconfig-r003-20230403   gcc  
sparc64              randconfig-r021-20230403   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
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
x86_64               randconfig-r032-20230403   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r006-20230403   gcc  
xtensa               randconfig-r024-20230404   gcc  
xtensa               randconfig-r026-20230403   gcc  
xtensa               randconfig-r035-20230404   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
