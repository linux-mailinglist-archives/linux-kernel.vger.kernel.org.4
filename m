Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24295620328
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiKGXC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiKGXCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:02:25 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D09129834
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 15:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667862144; x=1699398144;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ga0JU5EE7319D6sTTvsh6UxouEvyJ56aP86u6JkqelY=;
  b=FNZ8bQEn8+s7Q/7Ppn9DdPYjx/nN7sWoy5FZZpgVb+AOQSHWEoeCYecM
   DGByyah6K6FQw/bofCJcx+wntVvYY2JOyp0nnvBPEeOqAOH4JZQpyl++Y
   s086vPRxPaD7UtEB/MX8Kz/bFFRH6HttRH0ZYaVaDqpcVSBJLFcDNT2uc
   JkNKjtJGz4+3WFKyiL6Xw3jm5RLajcXY3f5GNuUkezPHC3gBgTKfZkv7Y
   utBcZUyZ/OLFcwnJNO4wEPGKm08Fth7vHcAhjd4Zi/o4/Ah+8JaKQaInf
   ojRF8mYttPwyNw4AkDhgdp6r3A/c9aJfgA1BD6BEVhOtHg6yMrmz7OHd3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="312331839"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="312331839"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 15:02:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="761270525"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="761270525"
Received: from lkp-server01.sh.intel.com (HELO 462403710aa9) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Nov 2022 15:02:22 -0800
Received: from kbuild by 462403710aa9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1osB8H-0001Fw-1g;
        Mon, 07 Nov 2022 23:02:21 +0000
Date:   Tue, 08 Nov 2022 07:01:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 0008712a508f72242d185142cfdbd0646a661a18
Message-ID: <63698e55.4nXUy/okAIBVUhD7%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 0008712a508f72242d185142cfdbd0646a661a18  x86/mm: Remove P*D_PAGE_MASK and P*D_PAGE_SIZE macros

elapsed time: 725m

configs tested: 97
configs skipped: 87

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20221107
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
x86_64               randconfig-a006-20221107
x86_64               randconfig-a001-20221107
x86_64               randconfig-a004-20221107
x86_64               randconfig-a003-20221107
x86_64               randconfig-a005-20221107
x86_64               randconfig-a002-20221107
i386                 randconfig-a001-20221107
i386                 randconfig-a006-20221107
i386                 randconfig-a003-20221107
i386                 randconfig-a002-20221107
i386                 randconfig-a005-20221107
i386                 randconfig-a004-20221107
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20221107
mips                 randconfig-c004-20221107
powerpc                       ppc64_defconfig
loongarch                           defconfig
parisc64                         alldefconfig
sh                   sh7724_generic_defconfig
x86_64                           alldefconfig
powerpc                        warp_defconfig
microblaze                          defconfig
m68k                        stmark2_defconfig
powerpc                      pasemi_defconfig
powerpc                      bamboo_defconfig
sh                           se7721_defconfig
sh                           se7705_defconfig
sh                     sh7710voipgw_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                      footbridge_defconfig
arm                           tegra_defconfig
sh                           sh2007_defconfig
arc                    vdk_hs38_smp_defconfig
sparc                            alldefconfig
m68k                         apollo_defconfig
sh                            shmin_defconfig
riscv                            allmodconfig
powerpc                       holly_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
um                           x86_64_defconfig
um                             i386_defconfig
i386                          randconfig-c001

clang tested configs:
x86_64               randconfig-a013-20221107
x86_64               randconfig-a012-20221107
x86_64               randconfig-a011-20221107
x86_64               randconfig-a014-20221107
x86_64               randconfig-a016-20221107
x86_64               randconfig-a015-20221107
i386                 randconfig-a013-20221107
i386                 randconfig-a015-20221107
i386                 randconfig-a016-20221107
i386                 randconfig-a011-20221107
i386                 randconfig-a014-20221107
i386                 randconfig-a012-20221107
mips                      malta_kvm_defconfig
mips                        omega2p_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64               randconfig-k001-20221107
powerpc                        fsp2_defconfig
arm                           omap1_defconfig
arm                       netwinder_defconfig
arm                         palmz72_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     mpc512x_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
