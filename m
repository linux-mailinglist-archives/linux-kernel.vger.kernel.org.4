Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54524708E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 04:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjESC6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 22:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjESC57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 22:57:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03866E7F
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 19:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684465077; x=1716001077;
  h=date:from:to:cc:subject:message-id;
  bh=XnBTp9Z4F+Xmgf7zLtNEFrd6hq64Kdqb07glVyzd0ws=;
  b=HR2hMpuNJKp80ePKmi+DDlR+mnuFpXWdFHp0gO2lpiwnsW/aiPdPbeMW
   GSJgaPaErZqWqCjQ7p/TH68uVNhayUGi1gDZuSFfFvng5jqRMtVuHwmZc
   AafCE5Fpqpw6CTA35sVQMlBPSRxTjbTsumVTtHPohcsBpywN05T09GqkS
   eScBLp7mgsjfathMTFJobHMO1cWHGBBBbtwozPZrMsUKn2KG9Y1/Kl2GX
   4GarElYFwjLLETX5tg6zoCIwqClCv08sdsp+eFQMLgBgKcDah2cQvKie9
   WjdcEcZfHOf9h8J4ELoUcgd7OzmvYjTs41NukZRNkBRlRHi+qymceVVZ3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="355485195"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="355485195"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 19:57:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="679898924"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="679898924"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2023 19:57:56 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pzqJX-000AWz-2T;
        Fri, 19 May 2023 02:57:55 +0000
Date:   Fri, 19 May 2023 10:57:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.05.15a] BUILD REGRESSION
 eeafa3194074221a7ffc4823f47da9a99218252f
Message-ID: <20230519025754.bPunv%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230517200055/lkp-src/repo/*/paulmck-rcu
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.05.15a
branch HEAD: eeafa3194074221a7ffc4823f47da9a99218252f  squash! rcuscale: Permit blocking delays between writers

Unverified Error/Warning (likely false positive, please contact us if interested):

kernel/rcu/rcuscale.c:340:27: error: 'get_rcu_tasks_trace_gp_kthread' undeclared here (not in a function); did you mean 'show_rcu_tasks_trace_gp_kthread'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- arm-allmodconfig
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a001
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a003
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a005
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a012
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a014
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a016
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- i386-randconfig-c021
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- ia64-allmodconfig
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- loongarch-allmodconfig
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- m68k-allmodconfig
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- mips-allmodconfig
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- powerpc-allmodconfig
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- riscv-allmodconfig
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- sparc-randconfig-c032-20230517
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-a002
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-a004
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-a006
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-a011
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-a013
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-a015
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-c022
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-m001
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-x051
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-x053
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-x055
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-x061
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-x063
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
`-- x86_64-randconfig-x065
    `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)

elapsed time: 722m

configs tested: 120
configs skipped: 6

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230517   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                  randconfig-r043-20230517   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                  randconfig-r011-20230517   clang
arm                  randconfig-r015-20230517   clang
arm                  randconfig-r046-20230517   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230517   gcc  
arm64                randconfig-r023-20230517   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230517   gcc  
hexagon              randconfig-r041-20230517   clang
hexagon              randconfig-r045-20230517   clang
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
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230517   gcc  
ia64                 randconfig-r016-20230517   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230517   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230517   gcc  
loongarch            randconfig-r021-20230517   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230517   gcc  
m68k                                defconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                     loongson1c_defconfig   clang
mips                 randconfig-r031-20230517   gcc  
mips                 randconfig-r034-20230517   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230517   gcc  
openrisc             randconfig-r024-20230517   gcc  
openrisc             randconfig-r025-20230517   gcc  
openrisc             randconfig-r035-20230517   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230517   gcc  
parisc               randconfig-r013-20230517   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc              randconfig-r026-20230517   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230517   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230517   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230517   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230517   gcc  
sh                   randconfig-r022-20230517   gcc  
sh                           se7705_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230517   gcc  
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
x86_64                        randconfig-x051   gcc  
x86_64                        randconfig-x052   clang
x86_64                        randconfig-x053   gcc  
x86_64                        randconfig-x054   clang
x86_64                        randconfig-x055   gcc  
x86_64                        randconfig-x056   clang
x86_64                        randconfig-x061   gcc  
x86_64                        randconfig-x062   clang
x86_64                        randconfig-x063   gcc  
x86_64                        randconfig-x064   clang
x86_64                        randconfig-x065   gcc  
x86_64                        randconfig-x066   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r032-20230517   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
