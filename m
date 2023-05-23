Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CDC70E68B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbjEWUee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238329AbjEWUec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:34:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C74BF
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684874070; x=1716410070;
  h=date:from:to:cc:subject:message-id;
  bh=nDMPXfq8AV1lMbZrKEwnCAiac3yow3LJawyzIpuGePM=;
  b=KFZbUQPyAKDCrR06EpaMdcQ7at/qAyWZo1kYWG1VC9taqF/UCnNWbe8d
   bvd8OuNquRPLxM4UrTM6nf1oOXJqXsFwKBMIpc5Be3Pu7XtQkhnK0Zf+6
   al/hLGKJW82dxHBTpUsJo9zf2s4Zo9mNSqTGG9ZkpmqqF4tpESqXAFPmL
   hhh20t40AwSobt1mZ+XyIHR2V4PtradiBhD5NmhOw+rtHe6zCVL2zSI34
   f36iCii591zvWEpLvpz6317V+n/8fH5DD9+BaNKUaO6CTohmZGQPQMzYQ
   tLX3bA3NTC5ZTlJ4OE+NycyI2RSmIzGEF15h+vGNj6ARrI4s8d/ytIbcj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="381600233"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="381600233"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 13:34:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="848433450"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="848433450"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 May 2023 13:34:29 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1YiD-000E4D-04;
        Tue, 23 May 2023 20:34:29 +0000
Date:   Wed, 24 May 2023 04:34:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 3c845304d2d723f20d5b91fef5d133ff94825d76
Message-ID: <20230523203403.H6to4%lkp@intel.com>
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

tree/branch: INFO setup_repo_specs: /db/releases/20230524001904/lkp-src/repo/*/tip
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 3c845304d2d723f20d5b91fef5d133ff94825d76  perf/x86/intel: Save/restore cpuc->active_pebs_data_cfg when using guest PEBS

elapsed time: 728m

configs tested: 151
configs skipped: 141

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230522   gcc  
alpha                randconfig-r022-20230521   gcc  
alpha                randconfig-r024-20230521   gcc  
alpha                randconfig-r025-20230521   gcc  
alpha                randconfig-r026-20230522   gcc  
alpha                randconfig-r033-20230522   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230521   gcc  
arc                  randconfig-r013-20230521   gcc  
arc                  randconfig-r016-20230522   gcc  
arc                  randconfig-r023-20230521   gcc  
arc                  randconfig-r023-20230522   gcc  
arc                  randconfig-r034-20230522   gcc  
arc                  randconfig-r035-20230521   gcc  
arc                  randconfig-r036-20230521   gcc  
arc                  randconfig-r043-20230521   gcc  
arc                  randconfig-r043-20230522   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230522   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230522   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230522   gcc  
csky                 randconfig-r015-20230521   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230522   gcc  
i386                 randconfig-a002-20230522   gcc  
i386                 randconfig-a003-20230522   gcc  
i386                 randconfig-a004-20230522   gcc  
i386                 randconfig-a005-20230522   gcc  
i386                 randconfig-a006-20230522   gcc  
i386                 randconfig-i051-20230523   clang
i386                 randconfig-i052-20230523   clang
i386                 randconfig-i053-20230523   clang
i386                 randconfig-i054-20230523   clang
i386                 randconfig-i055-20230523   clang
i386                 randconfig-i056-20230523   clang
i386                 randconfig-i061-20230523   clang
i386                 randconfig-i062-20230523   clang
i386                 randconfig-i063-20230523   clang
i386                 randconfig-i064-20230523   clang
i386                 randconfig-i065-20230523   clang
i386                 randconfig-i066-20230523   clang
i386                 randconfig-r001-20230522   gcc  
ia64                 randconfig-r003-20230522   gcc  
ia64                 randconfig-r015-20230522   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230521   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230522   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230522   gcc  
microblaze           randconfig-r004-20230522   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230521   gcc  
mips                      malta_kvm_defconfig   clang
mips                 randconfig-r001-20230521   gcc  
mips                 randconfig-r006-20230521   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230521   gcc  
nios2                randconfig-r005-20230521   gcc  
openrisc     buildonly-randconfig-r001-20230522   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r031-20230522   gcc  
openrisc             randconfig-r034-20230521   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230522   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r021-20230521   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230521   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r026-20230521   gcc  
s390                 randconfig-r044-20230521   gcc  
sh                               allmodconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sparc        buildonly-randconfig-r005-20230522   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230521   gcc  
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
x86_64                        randconfig-k001   clang
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
x86_64               randconfig-x091-20230523   gcc  
x86_64               randconfig-x092-20230523   gcc  
x86_64               randconfig-x093-20230523   gcc  
x86_64               randconfig-x094-20230523   gcc  
x86_64               randconfig-x095-20230523   gcc  
x86_64               randconfig-x096-20230523   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r002-20230522   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
