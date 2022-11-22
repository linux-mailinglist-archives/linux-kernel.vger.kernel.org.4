Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8671634A35
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiKVWpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiKVWpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:45:39 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD066BEB71
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669157138; x=1700693138;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FEV0+DZKCI3H9dk7htJRWs8LFscat8BrrIvTLtRK7yY=;
  b=fG/rM7NxReDRUsr0omjrlkzFUFT73MCvRsPt20J+nsc9RLHkAzJQ12jm
   1OQwoNYNWrAkxjKBqqQfaS8Y6OgqKfF3eH+fc+NvqYBR/tas/KtGPVQKm
   4/FL58WLrTf7WD9d6CCf7nZ84U7jkI71cWvqbpTPDcmyeEncsIoEdWLlW
   88oxbQqV5kiwbG9MqmdQ6k28QRDzT6MDqga47kDt9MnVe9MmiionwO1UI
   DNkCBZ3nzZN5kvmSRX281PgJh/6S6zGf3zS4tTPC1k5X6UcA8FBWEPNbQ
   zt7z4teLf4BR6W692qrvV8pgoJn25NaHQ0fNa5C6EJS9kjQk7T0yg3VO7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="400221755"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="400221755"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 14:45:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="672647807"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="672647807"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Nov 2022 14:45:37 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxc1I-0001x9-22;
        Tue, 22 Nov 2022 22:45:36 +0000
Date:   Wed, 23 Nov 2022 06:44:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 0ce096db719ebaf46d4faf93e1ed1341c1853919
Message-ID: <637d50e4.BXcTqSHdT68/YADo%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 0ce096db719ebaf46d4faf93e1ed1341c1853919  Merge tag 'v6.1-rc6' into x86/core, to resolve conflicts

elapsed time: 1446m

configs tested: 113
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a014-20221121
i386                 randconfig-a015-20221121
i386                 randconfig-a016-20221121
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
mips                           jazz_defconfig
powerpc                      ep88xc_defconfig
m68k                       m5249evb_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                           sama5_defconfig
arm                                 defconfig
x86_64               randconfig-a011-20221121
x86_64               randconfig-a014-20221121
x86_64               randconfig-a012-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
s390                 randconfig-r044-20221121
riscv                randconfig-r042-20221121
arc                  randconfig-r043-20221120
arc                  randconfig-r043-20221121
i386                          randconfig-c001
sparc                       sparc32_defconfig
powerpc                    sam440ep_defconfig
sparc                            alldefconfig
sh                           se7705_defconfig
m68k                        stmark2_defconfig
powerpc                 mpc8540_ads_defconfig
arm                      jornada720_defconfig
arc                              allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                             allyesconfig
arm                      footbridge_defconfig
powerpc                       eiger_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
arm                              allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arc                           tb10x_defconfig
mips                          rb532_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
m68k                        m5272c3_defconfig
arm                         nhk8815_defconfig
arm                        trizeps4_defconfig
m68k                       m5275evb_defconfig
arc                          axs103_defconfig
sh                              ul2_defconfig
sh                           se7780_defconfig
sh                          sdk7780_defconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
arm                          simpad_defconfig
powerpc                  iss476-smp_defconfig
sh                             espt_defconfig
sparc                               defconfig
csky                                defconfig
x86_64                                  kexec
arm64                            allyesconfig

clang tested configs:
powerpc                    mvme5100_defconfig
arm                         bcm2835_defconfig
arm                         lpc32xx_defconfig
x86_64                        randconfig-k001
i386                 randconfig-a001-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
x86_64               randconfig-a002-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a003-20221121
powerpc                   bluestone_defconfig
arm                          moxart_defconfig
hexagon                             defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
