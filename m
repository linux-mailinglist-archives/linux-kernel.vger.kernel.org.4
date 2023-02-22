Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CC369ED4A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjBVDJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjBVDIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:08:50 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA283C29
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 19:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677035329; x=1708571329;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QwVSWHDC2uZI2bebwrxtdJXCdoGjlN9bIdhCwhiKPB4=;
  b=bueUeQU8ELNuyfPsGKvqG91PUwgVsJrqw6/ZOqoFpwHYci4HCHIUvzb1
   ijXP8BaKnJAchEanqdYtrJMCA23EnT6onMQ7U3M2vgUtntas6+J2riy0C
   i/9I/ochZtD9pYNPPwIWLacYmU567YYhKb7Ji6Em8BwCExfTteUzDUMht
   4zmpHFjNn3EyYhX5X4YEhWDQPQVqfRo5EOluSH1LBYx5y5a+CtpZRt901
   e9hRQiTTTQvtBSTm94fxsj9Tn7H2IqAGPdadnn1w4obPDeRWc4FopQ8/Q
   aAj4JbYbh90vK1f3y9ewoVZUixmfMJU9y38FIErh8Jz6Hd28TRqE2uNpV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="332823662"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="332823662"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 19:07:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="845960298"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="845960298"
Received: from lkp-server01.sh.intel.com (HELO eac18b5d7d93) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Feb 2023 19:07:57 -0800
Received: from kbuild by eac18b5d7d93 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUfU4-0000Wl-2a;
        Wed, 22 Feb 2023 03:07:56 +0000
Date:   Wed, 22 Feb 2023 11:07:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 ce7980ae9080f72f08d50355c4d9084d57aece63
Message-ID: <63f58700.4bj1OtCmGsp81TAd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LONGWORDS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: ce7980ae9080f72f08d50355c4d9084d57aece63  genirq/irqdesc: Make kobj_type structures constant

elapsed time: 764m

configs tested: 90
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                              allyesconfig
arc                                 defconfig
arc                  randconfig-r043-20230219
arc                  randconfig-r043-20230220
arm                              allmodconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                                 defconfig
arm                           h3600_defconfig
arm                  randconfig-r046-20230220
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                 randconfig-a001-20230220
i386                 randconfig-a002-20230220
i386                 randconfig-a003-20230220
i386                 randconfig-a004-20230220
i386                 randconfig-a005-20230220
i386                 randconfig-a006-20230220
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
mips                             allmodconfig
mips                             allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc                generic-32bit_defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv             nommu_k210_sdcard_defconfig
riscv                randconfig-r042-20230219
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
s390                 randconfig-r044-20230219
sh                               allmodconfig
sh                      rts7751r2d1_defconfig
sparc                               defconfig
sparc                       sparc32_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64               randconfig-a001-20230220
x86_64                        randconfig-a002
x86_64               randconfig-a002-20230220
x86_64               randconfig-a003-20230220
x86_64                        randconfig-a004
x86_64               randconfig-a004-20230220
x86_64               randconfig-a005-20230220
x86_64               randconfig-a006-20230220
x86_64                               rhel-8.3

clang tested configs:
arm                  randconfig-r046-20230219
hexagon              randconfig-r041-20230219
hexagon              randconfig-r041-20230220
hexagon              randconfig-r045-20230219
hexagon              randconfig-r045-20230220
i386                 randconfig-a011-20230220
i386                 randconfig-a012-20230220
i386                 randconfig-a013-20230220
i386                 randconfig-a014-20230220
i386                 randconfig-a015-20230220
i386                 randconfig-a016-20230220
powerpc                     ksi8560_defconfig
riscv                randconfig-r042-20230220
s390                 randconfig-r044-20230220
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64               randconfig-a011-20230220
x86_64               randconfig-a012-20230220
x86_64               randconfig-a013-20230220
x86_64               randconfig-a014-20230220
x86_64               randconfig-a015-20230220
x86_64               randconfig-a016-20230220

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
