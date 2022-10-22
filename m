Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B9E608F8A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 22:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJVUP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 16:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJVUPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 16:15:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9096CF4A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 13:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666469751; x=1698005751;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZnglPn+5xbW0AIxCLQWJEvFktMC4RkQISjphDtCr0JE=;
  b=OOamsc9VurrAxTItlS2eGwwJnyhqHCl6FPzjTvvM/ulLQou7R/OBDItb
   ysQqTAUwIc6PnY7P1V2bR2PUziVtMGL82nlhZToKuNd31JHK8gjcAx5FW
   vsAl5xjYIRu824Mg8KvaEXBziW/aX/jNPGtqEBjcvrhPNVbtBksx0pJMS
   xP8o65Fc1iV8TDRZisU5mX2eXOFHZn58fq9fAoRs99cM68u5Forxn8yu7
   U0GKBL47uEt72q5f1ay/hTUsDem23653vHczLert6ojf4sXcUeJ+sLvVP
   4ArOegIOLpsXwXBzlxakBNzQD3wFvlRC6brx7tg/9erqWm6iSb68grecx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="308304721"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="308304721"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 13:15:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="699723279"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="699723279"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 22 Oct 2022 13:15:49 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1omKuK-0003sb-1O;
        Sat, 22 Oct 2022 20:15:48 +0000
Date:   Sun, 23 Oct 2022 04:15:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 bd194611444caf7f30e9198b7e2b89522b257462
Message-ID: <63544f6b.W2gIvMSJ8sfStKfp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: bd194611444caf7f30e9198b7e2b89522b257462  Merge branch 'x86/urgent' into x86/core, to resolve conflict

elapsed time: 723m

configs tested: 110
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
alpha                               defconfig
i386                                defconfig
s390                                defconfig
x86_64                           rhel-8.3-syz
s390                             allmodconfig
x86_64                        randconfig-a013
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a011
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
arm                                 defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
powerpc                           allnoconfig
x86_64                        randconfig-a015
arc                  randconfig-r043-20221019
m68k                             allyesconfig
x86_64                               rhel-8.3
powerpc                          allmodconfig
m68k                             allmodconfig
x86_64                        randconfig-a006
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
mips                             allyesconfig
arc                              allyesconfig
arc                  randconfig-r043-20221020
alpha                            allyesconfig
s390                 randconfig-r044-20221020
arm                              allyesconfig
i386                          randconfig-a001
riscv                randconfig-r042-20221020
i386                          randconfig-a003
arm64                            allyesconfig
i386                          randconfig-a005
arm                        multi_v7_defconfig
sh                           se7721_defconfig
powerpc                         ps3_defconfig
m68k                           virt_defconfig
arm                           u8500_defconfig
csky                                defconfig
parisc                generic-64bit_defconfig
sparc                       sparc32_defconfig
sh                          sdk7786_defconfig
parisc                           alldefconfig
mips                      fuloong2e_defconfig
arm                            zeus_defconfig
sh                               alldefconfig
loongarch                         allnoconfig
sh                                  defconfig
sh                          polaris_defconfig
powerpc                 mpc834x_mds_defconfig
i386                          randconfig-c001
sh                           se7722_defconfig
ia64                          tiger_defconfig
arm                        mvebu_v7_defconfig
mips                    maltaup_xpa_defconfig
arc                        nsimosci_defconfig
microblaze                          defconfig
arm                          lpd270_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                        clps711x_defconfig
mips                       bmips_be_defconfig
arm                            mps2_defconfig
arc                     nsimosci_hs_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
i386                 randconfig-a011-20221017
i386                 randconfig-a013-20221017
x86_64                        randconfig-a016
i386                 randconfig-a012-20221017
x86_64                        randconfig-a012
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221020
i386                 randconfig-a014-20221017
x86_64                        randconfig-a001
x86_64                        randconfig-a014
x86_64                        randconfig-a003
hexagon              randconfig-r045-20221020
i386                 randconfig-a016-20221017
hexagon              randconfig-r045-20221019
x86_64                        randconfig-a005
i386                 randconfig-a015-20221017
hexagon              randconfig-r041-20221019
s390                 randconfig-r044-20221019
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
powerpc                   microwatt_defconfig
arm                         orion5x_defconfig
powerpc                      obs600_defconfig
arm                      pxa255-idp_defconfig
mips                          ath79_defconfig
powerpc                      acadia_defconfig
arm                             mxs_defconfig
x86_64                        randconfig-k001
mips                       rbtx49xx_defconfig
arm                           spitz_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
