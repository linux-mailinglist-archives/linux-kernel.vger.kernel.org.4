Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871C0608C64
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiJVLOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiJVLOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:14:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA3517358A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 03:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666434994; x=1697970994;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cZ9C0V7oVIjU5zlRyIb1tIsNV3U3LpOVPmhANRff850=;
  b=JJphKIsj6IXon6aq7vVJ3IjBAn8bzECog0X22hwDkANdmJEMGOaxP1zL
   0RUwp71T5xD/KZVK6B5KnfCHnGcIQYAQ/59R7vYEz9Nz/elllxNTffZ4z
   4T9nlY9jOr8MCz2hFON/7NTIwhvxGVhfNbx80PyxujXYqeJOO8smBSgWr
   CRuTh1hGUCkM82tKBVhJHnKrzB/mJycH+dZRHqShsNRudmb/KTQACcXhz
   GEYu2RaApV3ODVuNcJMaYt5sM7nW0ESJ9nPXbya7qb1Y9vOd/CGSjhi2S
   v/2ApV8r98RUyODgGa5jixl71yC2mUyhgklPmbZb/jFlUc4ze/CkEV6Sp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="305907669"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="305907669"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 03:36:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="661896753"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="661896753"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 22 Oct 2022 03:36:32 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1omBrj-0003ZP-2z;
        Sat, 22 Oct 2022 10:36:31 +0000
Date:   Sat, 22 Oct 2022 18:35:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 471f0aa7fa64e23766a1473b32d9ec3f0718895a
Message-ID: <6353c78f.6asboXpYzIkByrvb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 471f0aa7fa64e23766a1473b32d9ec3f0718895a  x86/fpu: Fix copy_xstate_to_uabi() to copy init states correctly

elapsed time: 724m

configs tested: 94
configs skipped: 83

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
i386                          randconfig-a001
x86_64                               rhel-8.3
i386                                defconfig
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a015
i386                          randconfig-a014
x86_64                        randconfig-a013
x86_64                        randconfig-a006
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
arc                  randconfig-r043-20221019
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
csky                                defconfig
sh                           se7722_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
sh                         microdev_defconfig
arm                            qcom_defconfig
m68k                            q40_defconfig
sh                           se7721_defconfig
m68k                        mvme147_defconfig
nios2                            allyesconfig
arm                       omap2plus_defconfig
arm                        clps711x_defconfig
powerpc                 linkstation_defconfig
arc                            hsdk_defconfig
openrisc                 simple_smp_defconfig
i386                          randconfig-c001
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arm                           u8500_defconfig
parisc                generic-64bit_defconfig
arm                            zeus_defconfig
sh                               alldefconfig
loongarch                         allnoconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
x86_64                        randconfig-a014
i386                          randconfig-a006
x86_64                        randconfig-a005
i386                          randconfig-a011
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a015
mips                       rbtx49xx_defconfig
arm                           spitz_defconfig
x86_64                        randconfig-k001
arm                       netwinder_defconfig
mips                        maltaup_defconfig
powerpc                 mpc8560_ads_defconfig
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
