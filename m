Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB1A70F036
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbjEXIIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbjEXIIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:08:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244EE132
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684915677; x=1716451677;
  h=date:from:to:cc:subject:message-id;
  bh=NXdyBysXSqELcLNZaY5wSU3KQhy0Z5bIOWnFh1mTnlg=;
  b=A7oErXw9rqzgtgFnUBq+IBZQOU4NgwApr9Wm2c6gVDBO0PhZ0dJRcJyc
   vovEKrTzvKC2rsVh66FnAEkNAweGtQhKlpnuQMoWxoHlLyE9oktSxnUj2
   baOL3X0DNqdgvzMdKisEWJXr1a4rXaSwe7m4VAD4m1Aex13kVOXp7ccru
   1CVy/fYodmqtj11yx6zAnW4Qx2SdQMAoU7pRlPnI8OW1zas4FLkzIkz8g
   0t5FvXn6E+3wJMIKGu2t94DewHgIHI9CBUSvc6asyH2pFLYH9RBgh7UBj
   GRqG6d8ZT0KPAH4xOIj0vq57y5o8/0S9IDiG78cgxZ7eoGyv+GyYj6zLQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="333114811"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="333114811"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 01:07:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="737203561"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="737203561"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 May 2023 01:07:55 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1jXG-000Ea7-1C;
        Wed, 24 May 2023 08:07:54 +0000
Date:   Wed, 24 May 2023 16:07:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 60901dadfadcc152ae5cad7ebae802272497a812
Message-ID: <20230524080721.yiX2k%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230524154417/lkp-src/repo/*/paulmck-rcu
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 60901dadfadcc152ae5cad7ebae802272497a812  rcuscale: Measure grace-period kthread CPU time

elapsed time: 724m

configs tested: 144
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230521   gcc  
alpha        buildonly-randconfig-r006-20230522   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r022-20230521   gcc  
alpha                randconfig-r024-20230521   gcc  
alpha                randconfig-r025-20230521   gcc  
alpha                randconfig-r026-20230522   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230521   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230521   gcc  
arc                  randconfig-r016-20230522   gcc  
arc                  randconfig-r023-20230521   gcc  
arc                  randconfig-r023-20230522   gcc  
arc                  randconfig-r043-20230521   gcc  
arc                  randconfig-r043-20230522   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r004-20230521   clang
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230522   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230521   clang
arm64                randconfig-r012-20230522   clang
arm64                randconfig-r021-20230522   clang
arm64                randconfig-r033-20230521   clang
csky                                defconfig   gcc  
csky                 randconfig-r011-20230522   gcc  
csky                 randconfig-r015-20230521   gcc  
csky                 randconfig-r031-20230521   gcc  
csky                 randconfig-r031-20230522   gcc  
csky                 randconfig-r032-20230522   gcc  
hexagon              randconfig-r024-20230522   clang
hexagon              randconfig-r032-20230521   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230522   gcc  
i386                 randconfig-a002-20230522   gcc  
i386                 randconfig-a003-20230522   gcc  
i386                 randconfig-a004-20230522   gcc  
i386                 randconfig-a005-20230522   gcc  
i386                 randconfig-a006-20230522   gcc  
i386                 randconfig-r003-20230522   gcc  
i386                 randconfig-r033-20230522   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230522   gcc  
ia64         buildonly-randconfig-r002-20230521   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r015-20230522   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230522   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230521   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230522   gcc  
m68k                 randconfig-r036-20230522   gcc  
microblaze   buildonly-randconfig-r005-20230522   gcc  
microblaze   buildonly-randconfig-r006-20230521   gcc  
microblaze           randconfig-r036-20230521   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r004-20230522   clang
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230522   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r021-20230521   gcc  
powerpc              randconfig-r034-20230521   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230521   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r026-20230521   gcc  
s390                 randconfig-r044-20230521   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230521   gcc  
sh                   randconfig-r001-20230522   gcc  
sh                   randconfig-r002-20230521   gcc  
sh                   randconfig-r004-20230521   gcc  
sh                   randconfig-r035-20230522   gcc  
sparc        buildonly-randconfig-r004-20230522   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230522   gcc  
sparc                randconfig-r014-20230521   gcc  
sparc64      buildonly-randconfig-r003-20230522   gcc  
sparc64              randconfig-r011-20230521   gcc  
sparc64              randconfig-r016-20230521   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230522   gcc  
x86_64               randconfig-a002-20230522   gcc  
x86_64               randconfig-a003-20230522   gcc  
x86_64               randconfig-a004-20230522   gcc  
x86_64               randconfig-a005-20230522   gcc  
x86_64               randconfig-a006-20230522   gcc  
x86_64               randconfig-a011-20230522   clang
x86_64               randconfig-a012-20230522   clang
x86_64               randconfig-a013-20230522   clang
x86_64               randconfig-a014-20230522   clang
x86_64               randconfig-a015-20230522   clang
x86_64               randconfig-a016-20230522   clang
x86_64               randconfig-r022-20230522   clang
x86_64               randconfig-r025-20230522   clang
x86_64               randconfig-x051-20230522   clang
x86_64               randconfig-x052-20230522   clang
x86_64               randconfig-x053-20230522   clang
x86_64               randconfig-x054-20230522   clang
x86_64               randconfig-x055-20230522   clang
x86_64               randconfig-x056-20230522   clang
x86_64               randconfig-x061-20230522   clang
x86_64               randconfig-x062-20230522   clang
x86_64               randconfig-x063-20230522   clang
x86_64               randconfig-x064-20230522   clang
x86_64               randconfig-x065-20230522   clang
x86_64               randconfig-x066-20230522   clang
x86_64               randconfig-x071-20230522   gcc  
x86_64               randconfig-x072-20230522   gcc  
x86_64               randconfig-x073-20230522   gcc  
x86_64               randconfig-x074-20230522   gcc  
x86_64               randconfig-x075-20230522   gcc  
x86_64               randconfig-x076-20230522   gcc  
x86_64               randconfig-x081-20230522   gcc  
x86_64               randconfig-x082-20230522   gcc  
x86_64               randconfig-x083-20230522   gcc  
x86_64               randconfig-x084-20230522   gcc  
x86_64               randconfig-x085-20230522   gcc  
x86_64               randconfig-x086-20230522   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r006-20230522   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
