Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBD9612624
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 00:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJ2WIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 18:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJ2WIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 18:08:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9652733A24
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 15:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667081279; x=1698617279;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IBOMjL7Zh5YyolZEJrQCn9V0GlvXjVEX2eneV+DnUFo=;
  b=Jj/TF/YB0rA1uNNXr5eBb4BUvuNQ8ltv6cy0WBKzecTejq68LTmTo0UC
   8yYcWLiAhXGVaU9DWRUdgorRxgwHrCffIFYLDz/nyl5tSwmp+DPZeAMpz
   G+OWS0WreNOgMxEQJkok2fPTsIAMR7fXmnRni5QbYgmJZmoJmaAeWGeXQ
   ircaQ63DrPHidlhnyVKDy2Sx7y8SkZhL6Sy8jrFs0QhI5d0uN5pIZDM4f
   WQATiZvGk4MP/1g35G+BLbfOBDi9h52pRRuGT3rqHSRN40Eiklaai3Afs
   v0jnIiMqAMCIV0FPmGzWd/BgvmlTJOuzCMWucT0cZCjm5OtCvGv4VRkxI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="289090957"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="289090957"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 15:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="664379627"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="664379627"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 29 Oct 2022 15:07:58 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ootzh-000BNW-1G;
        Sat, 29 Oct 2022 22:07:57 +0000
Date:   Sun, 30 Oct 2022 06:07:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 c176a709cc468fef068ca981a884b57fc49894c8
Message-ID: <635da423.opwuNo8K972FDcQt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: c176a709cc468fef068ca981a884b57fc49894c8  Merge x86/mm into tip/master

elapsed time: 788m

configs tested: 81
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
x86_64                              defconfig
arc                  randconfig-r043-20221028
powerpc                           allnoconfig
riscv                randconfig-r042-20221028
mips                             allyesconfig
x86_64                               rhel-8.3
s390                 randconfig-r044-20221028
ia64                             allmodconfig
alpha                            allyesconfig
x86_64                           allyesconfig
arm                                 defconfig
arc                              allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                          rhel-8.3-func
m68k                             allyesconfig
arm                              allyesconfig
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a013
m68k                             allmodconfig
arm64                            allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a015
x86_64                        randconfig-a006
i386                          randconfig-a014
x86_64                        randconfig-a011
x86_64                           rhel-8.3-kvm
i386                          randconfig-a012
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                          randconfig-a016
i386                                defconfig
i386                             allyesconfig
arc                  randconfig-r043-20221029
powerpc                          allmodconfig
i386                          randconfig-c001
mips                     decstation_defconfig
um                               alldefconfig
arm                         at91_dt_defconfig
powerpc                      ppc6xx_defconfig
arc                     nsimosci_hs_defconfig
powerpc                         wii_defconfig
sh                     magicpanelr2_defconfig
arc                    vdk_hs38_smp_defconfig
sh                 kfr2r09-romimage_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                          pxa3xx_defconfig
m68k                           sun3_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                        sh7757lcr_defconfig
sh                        edosk7705_defconfig

clang tested configs:
hexagon              randconfig-r041-20221028
hexagon              randconfig-r045-20221028
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a014
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a012
i386                          randconfig-a013
x86_64                        randconfig-a005
i386                          randconfig-a011
x86_64                        randconfig-a016
i386                          randconfig-a015
riscv                randconfig-r042-20221029
hexagon              randconfig-r045-20221029
hexagon              randconfig-r041-20221029
s390                 randconfig-r044-20221029

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
