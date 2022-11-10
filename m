Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F847624D35
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiKJVmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiKJVmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:42:43 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6A35986C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668116562; x=1699652562;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rLm2k0bIk4bYgEuo++n87TknEyKQ8fe6gUnu2WBFTGY=;
  b=mA+sc9efO/hswnwWWSk4E+lEvimZ83NyaF+HDrSlh0ZFHp50W/rKb4Co
   A8J/U/4dkgHzJKmReNyLCdAIkL+4YbtEkUc9JEdBPA4zBepHtm/DPY2eP
   Ry0AxlWtLYHTxGk/Bu8vbubARiMbu9ruorki4FTNHTEpGfnJJ8yJ/HltH
   8MSAFhmn+f/Tm2OFLevtAsNbevH87V1D1VCi/K1suq7TRVWDuTdZXdgvu
   qryCJ+NXkGMJJ0d1m/EH4k9NxwnWrwrfHZCnESgFpkSbOVboOlGtciwCs
   fM6iuQGLHBRS54jsHxabeX834bBmjkUmxVHZTC2wVHe429MjdjYJRIFW/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="310166243"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="310166243"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 13:42:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="668579286"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="668579286"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 10 Nov 2022 13:42:40 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otFJo-0003HB-0D;
        Thu, 10 Nov 2022 21:42:40 +0000
Date:   Fri, 11 Nov 2022 05:41:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 48280042f2c6e3ac2cfb1d8b752ab4a7e0baea24
Message-ID: <636d7016.cSmgRVDU4OxOZ8TK%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/fpu
branch HEAD: 48280042f2c6e3ac2cfb1d8b752ab4a7e0baea24  x86/fpu/xstate: Fix XSTATE_WARN_ON() to emit relevant diagnostics

elapsed time: 1966m

configs tested: 99
configs skipped: 68

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                            allnoconfig
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
arc                                 defconfig
powerpc                           allnoconfig
arm                        cerfcube_defconfig
sh                               alldefconfig
sh                        sh7757lcr_defconfig
arm                                 defconfig
x86_64                              defconfig
s390                       zfcpdump_defconfig
powerpc                      arches_defconfig
powerpc                     sequoia_defconfig
mips                         cobalt_defconfig
arm                      footbridge_defconfig
xtensa                  cadence_csp_defconfig
mips                         db1xxx_defconfig
arm                        spear6xx_defconfig
powerpc                      pasemi_defconfig
sh                           se7722_defconfig
arm                         cm_x300_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc              randconfig-c003-20221110
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
alpha                               defconfig
sh                   secureedge5410_defconfig
powerpc                 mpc837x_rdb_defconfig
xtensa                    xip_kc705_defconfig
xtensa                          iss_defconfig
powerpc                 mpc834x_mds_defconfig
arm                         lpc18xx_defconfig
nios2                         10m50_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7724_defconfig
microblaze                          defconfig
parisc                           alldefconfig
arm                          pxa910_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm64                               defconfig
powerpc                 linkstation_defconfig
parisc                generic-64bit_defconfig
loongarch                           defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                             rpc_defconfig
m68k                          multi_defconfig
arc                         haps_hs_defconfig
powerpc                    amigaone_defconfig
arc                        nsimosci_defconfig
powerpc                       ppc64_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-c001
xtensa                           alldefconfig
parisc                generic-32bit_defconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a004
s390                 randconfig-r044-20221110
riscv                randconfig-r042-20221110
hexagon              randconfig-r041-20221110
hexagon              randconfig-r045-20221110
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a001
powerpc                        fsp2_defconfig
powerpc                    gamecube_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
