Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4979D733DBE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 05:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjFQDOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 23:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjFQDOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 23:14:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764A73C0E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 20:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686971650; x=1718507650;
  h=date:from:to:cc:subject:message-id;
  bh=4Zh2+vwnj39tRpU+jBuQP/duYe2usecTXdMCMHASnec=;
  b=IVEXZ5oHYqM6txtZBiW489hkCI3rpzI5eHeuIppgNEXDyz3ccaRdYrao
   8seXBY3wGN+PSEUhC2J5B8vzJQEQip1ELHl0iVtmQgvl0GmGsDiZ47v6e
   9feMzCkTOL4jd5y3UPJdhUJCG6Ty0+o6efO5QTbbcfXNGVsJoGJikvn98
   7aNZ661QIj8G3JK7bQD1NpH2Pmd8agNKY4oZfJn+QVRI6Cm2OEgM26uVg
   0GsxKVMADXJsxCuoPE++OYII+4DrNx9eOJR4hDut2yHpL2AD6D29xtwzf
   1kUepYgrir0+8Z/7I2mlglYACch4YXJDexUcuhrSmHjnD70Yn9fYVnR5/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="425296274"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="425296274"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 20:14:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="713087532"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="713087532"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 16 Jun 2023 20:14:09 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qAMO8-00029H-0R;
        Sat, 17 Jun 2023 03:14:08 +0000
Date:   Sat, 17 Jun 2023 11:13:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 ef73d6a4ef0b35524125c3cfc6deafc26a0c966a
Message-ID: <202306171118.25tFdONe-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: ef73d6a4ef0b35524125c3cfc6deafc26a0c966a  sched/wait: Fix a kthread_park race with wait_woken()

elapsed time: 722m

configs tested: 79
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230616   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r036-20230616   gcc  
arc                  randconfig-r043-20230616   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r033-20230616   gcc  
arm                  randconfig-r046-20230616   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230616   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230616   gcc  
csky                 randconfig-r011-20230616   gcc  
hexagon              randconfig-r024-20230616   clang
hexagon              randconfig-r041-20230616   clang
hexagon              randconfig-r045-20230616   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i011-20230616   gcc  
i386                 randconfig-i012-20230616   gcc  
i386                 randconfig-i013-20230616   gcc  
i386                 randconfig-i014-20230616   gcc  
i386                 randconfig-i015-20230616   gcc  
i386                 randconfig-i016-20230616   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230616   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r022-20230616   gcc  
microblaze           randconfig-r025-20230616   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r032-20230616   gcc  
nios2                randconfig-r034-20230616   gcc  
openrisc             randconfig-r003-20230616   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230616   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230616   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r021-20230616   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r031-20230616   gcc  
sparc64              randconfig-r016-20230616   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r013-20230616   clang
um                   randconfig-r035-20230616   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r014-20230616   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r005-20230616   gcc  
xtensa               randconfig-r026-20230616   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
