Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BBC74BD94
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 15:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGHNMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 09:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGHNMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 09:12:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A64EE55
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 06:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688821952; x=1720357952;
  h=date:from:to:cc:subject:message-id;
  bh=OhnAeDu/8UBlMAUF+IPmagfhEqXgHcmk7OlA+XKKXRI=;
  b=TI/Uc8jcLAdDh6adjgRdDNPdOHQyzaCOOXZITHE7jm2vLshLu8f6lzJn
   4wT7u6fYaFrUu/d0N0b1FH/qtBi3wCPoQsvgm8xvLBbhOxa1is2A+ymYB
   qjvmN1LvgL7X8eJ8KFut92ABZ2eCvhbmpDom5PxtaoBdvVTeXHDMhA5I5
   RVWqkOyyDG/JrCr2CrgBuPEUc/VqIbSII3mxVqOBHRDdY7SONpQBXPkqw
   HYMjxDlFSZHRD3sJLiD//U+SV22MFvQj7tZuOZeXfe1Ri15e5K2JvYOAZ
   qDZ58kQ0RVCUrkZjGkRBsnOPZziQp9LkSJOr7os+5prOR/wscGeb7wj+F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10765"; a="353911251"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="353911251"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2023 06:12:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10765"; a="966912433"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="966912433"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jul 2023 06:12:27 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qI7jf-0002j5-0h;
        Sat, 08 Jul 2023 13:12:27 +0000
Date:   Sat, 08 Jul 2023 21:12:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.06.21a] BUILD SUCCESS
 933d3bf8f96d7cedf78081030e004d23aee2b56c
Message-ID: <202307082113.Qw2fQmSh-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.06.21a
branch HEAD: 933d3bf8f96d7cedf78081030e004d23aee2b56c  refscale: Fix uninitalized use of wait_queue_head_t

elapsed time: 788m

configs tested: 112
configs skipped: 17

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r032-20230708   gcc  
alpha                randconfig-r034-20230708   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                  randconfig-r043-20230708   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   gcc  
arm                      footbridge_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                  randconfig-r012-20230708   clang
arm                  randconfig-r022-20230707   gcc  
arm                  randconfig-r046-20230708   clang
arm                        spear6xx_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r013-20230708   clang
hexagon              randconfig-r041-20230708   clang
hexagon              randconfig-r045-20230708   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230707   gcc  
i386         buildonly-randconfig-r005-20230707   gcc  
i386         buildonly-randconfig-r006-20230707   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230708   clang
i386                 randconfig-i002-20230708   clang
i386                 randconfig-i003-20230708   clang
i386                 randconfig-i004-20230708   clang
i386                 randconfig-i005-20230708   clang
i386                 randconfig-i006-20230708   clang
i386                 randconfig-i011-20230708   gcc  
i386                 randconfig-i012-20230708   gcc  
i386                 randconfig-i013-20230708   gcc  
i386                 randconfig-i014-20230708   gcc  
i386                 randconfig-i015-20230708   gcc  
i386                 randconfig-i016-20230708   gcc  
i386                 randconfig-r024-20230707   clang
i386                 randconfig-r025-20230707   clang
i386                 randconfig-r036-20230708   clang
loongarch            randconfig-r005-20230708   gcc  
m68k                             allmodconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230708   gcc  
nios2                randconfig-r031-20230708   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc                    mvme5100_defconfig   clang
powerpc              randconfig-r003-20230708   clang
powerpc                    socrates_defconfig   clang
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230708   gcc  
riscv                randconfig-r026-20230707   clang
riscv                randconfig-r042-20230708   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230708   gcc  
sh                               allmodconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r035-20230708   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230708   gcc  
sparc                randconfig-r014-20230708   gcc  
sparc                randconfig-r023-20230707   gcc  
sparc64              randconfig-r004-20230708   gcc  
sparc64              randconfig-r006-20230708   gcc  
sparc64              randconfig-r021-20230707   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230707   gcc  
x86_64       buildonly-randconfig-r002-20230707   gcc  
x86_64       buildonly-randconfig-r003-20230707   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r002-20230708   clang
x86_64               randconfig-r011-20230708   gcc  
x86_64               randconfig-x001-20230708   gcc  
x86_64               randconfig-x002-20230708   gcc  
x86_64               randconfig-x003-20230708   gcc  
x86_64               randconfig-x004-20230708   gcc  
x86_64               randconfig-x005-20230708   gcc  
x86_64               randconfig-x006-20230708   gcc  
x86_64               randconfig-x011-20230708   clang
x86_64               randconfig-x012-20230708   clang
x86_64               randconfig-x013-20230708   clang
x86_64               randconfig-x014-20230708   clang
x86_64               randconfig-x015-20230708   clang
x86_64               randconfig-x016-20230708   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
