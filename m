Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035556331B8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiKVBAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiKVBAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:00:47 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549CAE0B5F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669078845; x=1700614845;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PvQkjA4ehVkncDHpcFGDoc74XyVF6zcYCVSLM05CSs4=;
  b=j4rXSF1ONJ7Fj1rRxEoPZ0nC5KcC1NI89SFzbVHuNefPcC43QmVDsm8r
   sVyA3VQoHdAc7IWaknjMPttxBVM+kcVuG5GUtvrOMJ+iutQnpk61S40Ho
   SicWW43oT+36Pb1d+LN+NN/4oSl2Jm6o5B/Loqy4tkP+BbmSb22/ngmCN
   olJEo3+ngOB1riv2XzL51ivUgnjwhQ39Omz1v2RL6cd0fe6j7fVYwFdcw
   eQdQzQ/wz3M7JvDyDT+ZzUTvgcL1qjdA4gPehbJTwr+2Q0Fo7y/qEmN2V
   StSAc6zGc6pDFtC3rl5KpmWmOkXoJ2kMLsrfUyfzHyscBsvPJOwKq/zWP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="377957332"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="377957332"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 17:00:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="747133853"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="747133853"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Nov 2022 17:00:43 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxHeU-0000uV-38;
        Tue, 22 Nov 2022 01:00:42 +0000
Date:   Tue, 22 Nov 2022 09:00:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 ee92fa03918d114d3ac9c36a8bf2c032ede75a3b
Message-ID: <637c1f34.3JeQKYPcN7AOBzLp%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/cleanups
branch HEAD: ee92fa03918d114d3ac9c36a8bf2c032ede75a3b  x86/kaslr: Fix process_mem_region()'s return value

elapsed time: 3365m

configs tested: 110
configs skipped: 78

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                            allnoconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
i386                             allyesconfig
i386                                defconfig
sh                            migor_defconfig
sh                          urquell_defconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                 randconfig-a014-20221121
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a016-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a015-20221121
arc                              allyesconfig
i386                          randconfig-c001
x86_64               randconfig-a011-20221121
x86_64               randconfig-a014-20221121
x86_64               randconfig-a012-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
mips                      loongson3_defconfig
csky                                defconfig
powerpc                      ppc6xx_defconfig
sh                             espt_defconfig
arm                              allmodconfig
arm                           corgi_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
s390                 randconfig-r044-20221121
riscv                randconfig-r042-20221121
arc                  randconfig-r043-20221121
arc                  randconfig-r043-20221120
powerpc                     sequoia_defconfig
arm                        shmobile_defconfig
arm                      footbridge_defconfig
powerpc                       eiger_defconfig
sh                        sh7763rdp_defconfig
m68k                            q40_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                             allmodconfig
m68k                          hp300_defconfig
arm                        realview_defconfig
powerpc                    sam440ep_defconfig
sh                         ap325rxa_defconfig
arm                            hisi_defconfig
sh                          sdk7786_defconfig
sparc                       sparc64_defconfig
sh                          rsk7264_defconfig
sh                           se7712_defconfig
m68k                        m5272c3_defconfig
arm                         nhk8815_defconfig
arm64                               defconfig
ia64                             allyesconfig
m68k                                defconfig
ia64                                defconfig
sparc                               defconfig
x86_64                                  kexec
x86_64                        randconfig-c001
arm                  randconfig-c002-20221120

clang tested configs:
x86_64               randconfig-a002-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a003-20221121
i386                 randconfig-a001-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
x86_64                        randconfig-k001
arm                                 defconfig
arm                          pxa168_defconfig
riscv                          rv32_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                    mvme5100_defconfig
arm                         bcm2835_defconfig
arm                         lpc32xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                    gamecube_defconfig
powerpc                  mpc866_ads_defconfig
arm                        neponset_defconfig
powerpc                     ksi8560_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
