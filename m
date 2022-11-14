Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E438D628B50
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbiKNVZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbiKNVZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:25:46 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B841662D8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668461145; x=1699997145;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FaJy8unhWegnIG1G6eqGDECFEaLZ1GollgDQtifF1rw=;
  b=eoqb26B3mJE+9iyfC3UBhLwF4ANX3fhXEDoE+sN5xfIbIuZ1D4I08N5E
   tGsKhOo42CNE8ctHDCs/72RQG8Xqg4VAzYNSU5LyZGw0aQeFfR4XPh6lK
   d4Ty/A17i7iripa8wWu/trR1acj9nsl6G1f6VZoR31tw31VxPRYaN9Mfa
   EmUGxbjWzenAsZuFPujBBKopNA5Moms+vF1cQdhv2/Y1grLrth+WFkVOM
   m7rgka7gDsrU5nHam3fwaX0znwouQdVJgTxVEAOPBgXwNiM79Wtq89JQO
   ikL66PJR2YJeLH8KtGXcp/MBnYlHEo2AUsA+mdyU+6fh74ZMKy6eim69d
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="292484593"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="292484593"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 13:25:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="813418662"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="813418662"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 14 Nov 2022 13:25:44 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ougxb-0000kx-1B;
        Mon, 14 Nov 2022 21:25:43 +0000
Date:   Tue, 15 Nov 2022 05:24:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 91dabf33ae5df271da63e87ad7833e5fdb4a44b9
Message-ID: <6372b220.tIfE6Ez2wkyvZw69%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 91dabf33ae5df271da63e87ad7833e5fdb4a44b9  sched: Fix race in task_call_func()

elapsed time: 723m

configs tested: 111
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
x86_64                            allnoconfig
i386                 randconfig-a001-20221114
sh                               allmodconfig
i386                                defconfig
i386                 randconfig-a004-20221114
i386                 randconfig-a002-20221114
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
s390                             allmodconfig
i386                 randconfig-a005-20221114
m68k                             allyesconfig
alpha                               defconfig
i386                             allyesconfig
x86_64                              defconfig
s390                             allyesconfig
s390                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a006-20221114
i386                 randconfig-a003-20221114
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20221114
ia64                             allmodconfig
x86_64               randconfig-a002-20221114
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64               randconfig-a001-20221114
x86_64               randconfig-a004-20221114
x86_64               randconfig-a005-20221114
x86_64               randconfig-a003-20221114
x86_64               randconfig-a006-20221114
microblaze                      mmu_defconfig
m68k                          sun3x_defconfig
arc                     haps_hs_smp_defconfig
arm                          pxa910_defconfig
mips                       bmips_be_defconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                 randconfig-c001-20221114
powerpc                     ep8248e_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                  decstation_64_defconfig
arm                               allnoconfig
sh                   sh7724_generic_defconfig
sh                   rts7751r2dplus_defconfig
arm                         cm_x300_defconfig
mips                      loongson3_defconfig
sh                        edosk7760_defconfig
csky                                defconfig
powerpc                      ppc6xx_defconfig
sh                           se7343_defconfig
powerpc                    adder875_defconfig
ia64                          tiger_defconfig
powerpc                     sequoia_defconfig
sh                          rsk7201_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
xtensa                         virt_defconfig
sh                            shmin_defconfig
xtensa                              defconfig
mips                        vocore2_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                           sunxi_defconfig
loongarch                 loongson3_defconfig
arc                         haps_hs_defconfig
powerpc                    sam440ep_defconfig
sparc64                          alldefconfig
powerpc                     stx_gp3_defconfig
sh                           sh2007_defconfig

clang tested configs:
i386                 randconfig-a011-20221114
i386                 randconfig-a014-20221114
i386                 randconfig-a013-20221114
i386                 randconfig-a012-20221114
i386                 randconfig-a015-20221114
i386                 randconfig-a016-20221114
x86_64               randconfig-a012-20221114
x86_64               randconfig-a013-20221114
s390                 randconfig-r044-20221114
riscv                randconfig-r042-20221114
hexagon              randconfig-r041-20221114
hexagon              randconfig-r045-20221114
x86_64               randconfig-a011-20221114
x86_64               randconfig-a014-20221114
x86_64               randconfig-a016-20221114
x86_64               randconfig-a015-20221114
mips                           mtx1_defconfig
powerpc                 mpc8560_ads_defconfig
x86_64               randconfig-k001-20221114
arm                       mainstone_defconfig
i386                             allyesconfig
mips                  cavium_octeon_defconfig
mips                      bmips_stb_defconfig
arm                        multi_v5_defconfig
arm                        vexpress_defconfig
arm                         s3c2410_defconfig
mips                        maltaup_defconfig
arm                         mv78xx0_defconfig
arm                                 defconfig
powerpc                     mpc512x_defconfig
arm                        magician_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
