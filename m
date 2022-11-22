Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED628634150
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbiKVQVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbiKVQUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:20:44 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304F47342B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669133964; x=1700669964;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=iSyVd8BAlaE8QxU8b3DLF3zYf0EbCkvzRoRk5/D4JSA=;
  b=DUSFXW3y9FdqNUhTVvsCHuNwxrPJ76OfX9wiwBbTIpvzvi8oe2kiWO5Y
   MuxYQ+6NxoeD5W23Y4gjlr/y3JXWc50dh/9rbzL0A+crPqqTPAIruOc1N
   AKTyHvi4SJDB/vU/3p0jlYMlSAWrx3PNeSTib5uJFgiVOdbdAk1zTFCN7
   BPPJrzvrSP87Ummbw/tvQCmRITGl72r19O494biLFy1OJRA9PjaBEtFXa
   UpfgPT7lF/+6iAKuNQaNZDOjEV9fhFcZPwRXu017CCtM62A6w4T94rD/F
   A1s0Fo2CryaRae2D4t4klGrwugAwY4dRU88BwAoNeb+Evdv+oIfSdTqQ+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="315002983"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="315002983"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 08:19:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="643773676"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="643773676"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 22 Nov 2022 08:19:22 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxVzV-0001cx-3B;
        Tue, 22 Nov 2022 16:19:21 +0000
Date:   Wed, 23 Nov 2022 00:19:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 839a973988a94c15002cbd81536e4af6ced2bd30
Message-ID: <637cf679.KtjTP7+kljd4nhnd%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 839a973988a94c15002cbd81536e4af6ced2bd30  clocksource/drivers/arm_arch_timer: Fix XGene-1 TVAL register math error

elapsed time: 1442m

configs tested: 79
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a011-20221121
x86_64               randconfig-a014-20221121
x86_64               randconfig-a012-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                            allnoconfig
mips                           jazz_defconfig
powerpc                      ep88xc_defconfig
m68k                       m5249evb_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                           sama5_defconfig
arm                                 defconfig
arc                           tb10x_defconfig
mips                          rb532_defconfig
arm                      footbridge_defconfig
powerpc                       eiger_defconfig
arc                              allyesconfig
m68k                        m5272c3_defconfig
powerpc                    sam440ep_defconfig
arm                         nhk8815_defconfig
i386                 randconfig-a014-20221121
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a016-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a015-20221121
i386                          randconfig-c001
i386                                defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
i386                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221120
sparc                               defconfig
csky                                defconfig
x86_64                                  kexec
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
arm64                               defconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
