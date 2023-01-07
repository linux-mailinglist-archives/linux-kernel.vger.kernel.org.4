Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A96A660AD8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbjAGAeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbjAGAe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:34:28 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F92C8B77D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673051659; x=1704587659;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5pZZygw2dIXv7UEhsAfmXYF4ld7/K+U4dCheRi3HVIQ=;
  b=WTQnOmoRwgZmKjd2vQ0gbdi+cQMcxMZ+4XCAN9j+HpKFBJEXsCw4iYPt
   wngm8OKXCkxuTF8fLAPptsWKIBrGq3BVP2cQ2jeizcf+OystHxayZjbgu
   /Y3A9cQ8o1OwxedynOz5rU54Lt+gEwYICX9v7obSdycdd2O1sPdtHk3n5
   1LydSPkHvAaJ1CYLrzsNtrR58HgwfRxeDL/3zPsZJOloVr6Bn7ZqZL6S2
   XuAJ1aDrkhnhStQJjoE4pRepfsuNtsMRISIXSRv4LGD0nS9SD9HiY13K+
   8+xmw+rrN2xjackDwGc+B/53pi1QFh9Hg89LzZMhJ4kwlPukeYPymTgeA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="384896814"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="384896814"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 16:34:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="798444170"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="798444170"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jan 2023 16:34:13 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDxA4-00042A-1N;
        Sat, 07 Jan 2023 00:34:12 +0000
Date:   Sat, 07 Jan 2023 08:33:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 47cdfb7b0a2733c157b27f772d852bfb9075384b
Message-ID: <63b8bde7.1vuT0rqEz2EnMTvN%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 47cdfb7b0a2733c157b27f772d852bfb9075384b  x86/boot/e820: Fix typo in e820.c comment

elapsed time: 722m

configs tested: 107
configs skipped: 67

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                              defconfig
i386                          randconfig-a016
x86_64                        randconfig-a015
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                                defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                        randconfig-a006
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
ia64                             allmodconfig
sh                ecovec24-romimage_defconfig
sh                        dreamcast_defconfig
sh                           se7619_defconfig
mips                            gpr_defconfig
sh                                  defconfig
x86_64                           alldefconfig
mips                         rt305x_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
sh                         apsh4a3a_defconfig
sh                          sdk7786_defconfig
arc                    vdk_hs38_smp_defconfig
sparc                            alldefconfig
arc                      axs103_smp_defconfig
arm                            lart_defconfig
arm                        cerfcube_defconfig
mips                         db1xxx_defconfig
powerpc                      ppc6xx_defconfig
mips                         cobalt_defconfig
sparc64                             defconfig
powerpc                       ppc64_defconfig
sh                            titan_defconfig
ia64                             alldefconfig
powerpc                     mpc83xx_defconfig
powerpc                      ppc40x_defconfig
arc                              alldefconfig
mips                           ci20_defconfig
m68k                        mvme147_defconfig
i386                          randconfig-c001
ia64                        generic_defconfig
nios2                            allyesconfig
sh                           sh2007_defconfig
powerpc                   currituck_defconfig
powerpc                      pasemi_defconfig
powerpc                 linkstation_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a011
x86_64                        randconfig-a016
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust
s390                 randconfig-r044-20230106
hexagon              randconfig-r041-20230106
hexagon              randconfig-r045-20230106
riscv                randconfig-r042-20230106
powerpc                   bluestone_defconfig
mips                       rbtx49xx_defconfig
arm                              alldefconfig
hexagon                             defconfig
arm                       cns3420vb_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                          g5_defconfig
arm                          ixp4xx_defconfig
x86_64                        randconfig-k001
arm                          moxart_defconfig
arm                        neponset_defconfig
hexagon              randconfig-r041-20230107
hexagon              randconfig-r045-20230107
arm                  randconfig-r046-20230107

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
