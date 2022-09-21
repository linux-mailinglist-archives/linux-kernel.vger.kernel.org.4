Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B135E569A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 01:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiIUXKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 19:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiIUXKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 19:10:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C3FA6C40
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663801848; x=1695337848;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2Wk5OP8Jb7y7jKSTMdeqO6qOZ6BskQLFFWOpbDGz4SE=;
  b=Kr35yCfv5Kgvr/D78kWDuEo2K9ewLdjXA8sQAtt5iYroQ/LAUcIUI13e
   lnjUWPzeCZ9Rog+Myk2ejqW2EDUtIE4iM+i9vQuqEiFeQ/E3Z34P3KI93
   eTQCD+b/0I7CJIgPIawnvY3jyHO/f88GsWocTLI88S70/y8l8xTC6Hdab
   0eV629TgpGUvCsw0tiaObPVcWnGFi0VTPslKHilmuhCC28It2vWjH/dKP
   eSLmIuEpFtTQE0t/laqp4IYcupGlCCdTxUQC0Bu6g97pSqS7rC20uUC7Z
   W701SIVCqIwlHfCohkeXQqGY9L9Zxp8tSXlfrpO0HgVlHkDmI1/vRb1Dx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="283197241"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="283197241"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 16:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="761954845"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Sep 2022 16:10:46 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ob8rd-000444-2t;
        Wed, 21 Sep 2022 23:10:45 +0000
Date:   Thu, 22 Sep 2022 07:10:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/paravirt] BUILD SUCCESS
 f92ff8f5dca2acfa475842c71212657b0703c3be
Message-ID: <632b99de.UzorczrkBroKgp7S%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/paravirt
branch HEAD: f92ff8f5dca2acfa475842c71212657b0703c3be  x86/paravirt: Ensure proper alignment

elapsed time: 721m

configs tested: 102
configs skipped: 88

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a015
i386                          randconfig-a005
x86_64                        randconfig-a002
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                              defconfig
x86_64                               rhel-8.3
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                           rhel-8.3-syz
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
ia64                             allmodconfig
x86_64                           allyesconfig
sh                             sh03_defconfig
s390                                defconfig
sh                              ul2_defconfig
powerpc                      ppc6xx_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                             alldefconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                      bamboo_defconfig
arm                           h5000_defconfig
m68k                        mvme147_defconfig
powerpc                        cell_defconfig
sparc64                          alldefconfig
i386                          randconfig-c001
sh                         ap325rxa_defconfig
xtensa                    smp_lx200_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     tqm8555_defconfig
nios2                            alldefconfig
powerpc                      cm5200_defconfig
openrisc                 simple_smp_defconfig
arm                         nhk8815_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                             pxa_defconfig
sh                      rts7751r2d1_defconfig
mips                        vocore2_defconfig
arc                          axs101_defconfig
sh                             espt_defconfig
powerpc                  storcenter_defconfig
loongarch                           defconfig

clang tested configs:
x86_64                        randconfig-a012
i386                          randconfig-a002
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
x86_64                        randconfig-c007
arm                  randconfig-c002-20220921
i386                          randconfig-c001
s390                 randconfig-c005-20220921
riscv                randconfig-c006-20220921
mips                 randconfig-c004-20220921
powerpc              randconfig-c003-20220921
powerpc                    gamecube_defconfig
arm                         orion5x_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
