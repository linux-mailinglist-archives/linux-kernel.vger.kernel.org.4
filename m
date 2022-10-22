Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2871608F89
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 22:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJVUPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 16:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJVUPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 16:15:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049E96CD23
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 13:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666469750; x=1698005750;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4jc11Aa57S7HMT1LEqtDk1j6N5z3o+rwwM903deUeD8=;
  b=YFVaGdDE1GaFFreLkNb/Lelmm9vkUv1b1H7kawXFdjbAFKze6IMslzmY
   EJ2BKC3hGHP//qlpZji8WfWgt9s92sM4nl/67o6gFp6Ewz0CnmuObkQXs
   MELEJ2qvh2BHHwIDQXcdtfvTnqqbxyJHao3rV688+Ze1xJAK5HtwbcRm0
   MkNu+m7XMbvWaB97i057QPOLx9QpeXnwSjWz0vaea8TCHPdGWtsIy5CqI
   8BcMYwAMtzszM420UDdkwMd3szfmqi1+PuerYuaS/pXtHlqoJVwkocoZD
   wNMDPf2SGGID64dY60iEQbtphhT/H1gxq7ND3MuKx1I07od5olRup6B0T
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="333791040"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="333791040"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 13:15:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="581955536"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="581955536"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 22 Oct 2022 13:15:49 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1omKuK-0003sZ-1L;
        Sat, 22 Oct 2022 20:15:48 +0000
Date:   Sun, 23 Oct 2022 04:15:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/paravirt] BUILD SUCCESS
 7212c34aac1ec6abadf8b439824c8307ef0dd338
Message-ID: <63544f6e.SIlg91FkxXSPW22z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/paravirt
branch HEAD: 7212c34aac1ec6abadf8b439824c8307ef0dd338  Merge branch 'x86/core' into x86/paravirt, to resolve conflicts

elapsed time: 723m

configs tested: 118
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
s390                             allmodconfig
x86_64                               rhel-8.3
s390                                defconfig
x86_64                           allyesconfig
arm                                 defconfig
x86_64                        randconfig-a004
i386                          randconfig-a001
x86_64                        randconfig-a002
powerpc                           allnoconfig
i386                          randconfig-a003
x86_64                           rhel-8.3-syz
mips                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a006
x86_64                           rhel-8.3-kvm
powerpc                          allmodconfig
i386                             allyesconfig
arm                              allyesconfig
s390                             allyesconfig
i386                          randconfig-a005
m68k                             allmodconfig
i386                          randconfig-a014
arm64                            allyesconfig
sh                               allmodconfig
x86_64                        randconfig-a013
arc                              allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20221020
m68k                             allyesconfig
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a015
s390                 randconfig-r044-20221020
arc                  randconfig-r043-20221018
riscv                randconfig-r042-20221020
riscv                randconfig-r042-20221018
s390                 randconfig-r044-20221018
arm                       omap2plus_defconfig
arm                        clps711x_defconfig
powerpc                 linkstation_defconfig
arc                            hsdk_defconfig
openrisc                 simple_smp_defconfig
arc                              alldefconfig
m68k                          atari_defconfig
powerpc                     tqm8548_defconfig
arm                          lpd270_defconfig
sparc                       sparc32_defconfig
sh                          sdk7786_defconfig
parisc                           alldefconfig
mips                      fuloong2e_defconfig
arm                        multi_v7_defconfig
sh                           se7721_defconfig
powerpc                         ps3_defconfig
m68k                           virt_defconfig
arm                           u8500_defconfig
csky                                defconfig
parisc                generic-64bit_defconfig
i386                          randconfig-c001
arm                          exynos_defconfig
alpha                             allnoconfig
arc                               allnoconfig
arm                            zeus_defconfig
sh                               alldefconfig
loongarch                         allnoconfig
sh                                  defconfig
sh                          polaris_defconfig
powerpc                 mpc834x_mds_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221019
sh                           se7722_defconfig
ia64                          tiger_defconfig
arm                        mvebu_v7_defconfig
mips                    maltaup_xpa_defconfig
arc                        nsimosci_defconfig
microblaze                          defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
loongarch                           defconfig
loongarch                        allmodconfig
mips                       bmips_be_defconfig
arm                            mps2_defconfig
arc                     nsimosci_hs_defconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a013
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a015
x86_64                        randconfig-a014
i386                          randconfig-a011
hexagon              randconfig-r041-20221020
hexagon              randconfig-r045-20221020
i386                          randconfig-a004
hexagon              randconfig-r041-20221018
x86_64                        randconfig-a016
hexagon              randconfig-r045-20221018
x86_64                        randconfig-a012
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
