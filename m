Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495A86E18EF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjDNAZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNAZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:25:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A05132
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 17:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681431910; x=1712967910;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Fs2VFDRCoL8ueWMrrphYOep+Z6kjmQv1CyNXp4IhtnU=;
  b=PDDhcCWTQgFgs/M1Yt2ce0UZnTRn2M1YXiuMZxA5OocupsqPKVMLaeS6
   J4RFI0O417bTCcSlt7SvcmHfNnvwSjg7VBJPeNeE4BgJ8UnYsIUTKXblD
   Gw9msbd+8cDKdyy661rHW5VnKOVbGqF1pLV9FvbpTrW1aI1QtCr8RIyW1
   EXz5WO7y4lmqfPggNQ+TMSHQEavJAEiB1k7wpAmfP5DBarcLDmHkLsLn/
   FqUHv4MXQBsM8Bwj2oTeIXjYpsXYcG7Uaexre9/l0IDSDYsvvFKhBgyBd
   +kcCfiJz3y782qgRcBnEoVLTcosKfVeYLFxrcZyOFZjTotHXXMZQvhUCj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346168345"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="346168345"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 17:25:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="692172791"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="692172791"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 13 Apr 2023 17:25:08 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pn7FT-000Z3x-1k;
        Fri, 14 Apr 2023 00:25:07 +0000
Date:   Fri, 14 Apr 2023 08:24:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 8930264852dace3e2e3743b8b5058512014c955a
Message-ID: <64389d2e.BbTRRJLiTms6Pw37%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 8930264852dace3e2e3743b8b5058512014c955a  Merge branch into tip/master: 'sched/core'

elapsed time: 726m

configs tested: 128
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230409   gcc  
alpha                randconfig-r005-20230410   gcc  
alpha                randconfig-r011-20230410   gcc  
alpha                randconfig-r011-20230413   gcc  
alpha                randconfig-r013-20230409   gcc  
alpha                randconfig-r022-20230412   gcc  
alpha                randconfig-r022-20230413   gcc  
alpha                randconfig-r024-20230413   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r036-20230413   gcc  
arc                  randconfig-r043-20230412   gcc  
arc                  randconfig-r043-20230413   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r013-20230413   gcc  
arm                  randconfig-r021-20230413   gcc  
arm                  randconfig-r023-20230413   gcc  
arm                  randconfig-r032-20230413   clang
arm                  randconfig-r046-20230412   clang
arm                  randconfig-r046-20230413   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230410   gcc  
arm64                randconfig-r035-20230412   clang
csky                                defconfig   gcc  
csky                 randconfig-r016-20230413   gcc  
csky                 randconfig-r025-20230413   gcc  
hexagon              randconfig-r013-20230410   clang
hexagon              randconfig-r016-20230409   clang
hexagon              randconfig-r024-20230412   clang
hexagon              randconfig-r031-20230413   clang
hexagon              randconfig-r034-20230413   clang
hexagon              randconfig-r041-20230412   clang
hexagon              randconfig-r041-20230413   clang
hexagon              randconfig-r045-20230412   clang
hexagon              randconfig-r045-20230413   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230409   gcc  
ia64                 randconfig-r032-20230412   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r031-20230412   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230413   gcc  
m68k                 randconfig-r014-20230409   gcc  
m68k                 randconfig-r015-20230409   gcc  
m68k                 randconfig-r026-20230413   gcc  
microblaze           randconfig-r003-20230409   gcc  
microblaze           randconfig-r015-20230410   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r014-20230413   gcc  
mips                 randconfig-r016-20230410   clang
mips                 randconfig-r036-20230412   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r006-20230409   gcc  
openrisc             randconfig-r015-20230413   gcc  
openrisc             randconfig-r021-20230412   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230409   gcc  
parisc               randconfig-r011-20230409   gcc  
parisc               randconfig-r014-20230410   gcc  
parisc               randconfig-r035-20230413   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r003-20230410   clang
powerpc              randconfig-r012-20230409   gcc  
powerpc              randconfig-r033-20230412   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230412   gcc  
riscv                randconfig-r042-20230413   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230412   gcc  
s390                 randconfig-r044-20230413   clang
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r001-20230410   gcc  
sparc64              randconfig-r004-20230410   gcc  
sparc64              randconfig-r006-20230410   gcc  
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
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64               randconfig-r002-20230410   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r034-20230412   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
