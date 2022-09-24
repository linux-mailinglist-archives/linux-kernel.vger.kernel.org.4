Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C375E8C27
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 14:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiIXMQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 08:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbiIXMQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 08:16:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B999A6C1F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664021792; x=1695557792;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=svm7QrMFZBm/qlOJR8CXUcjpft3ZakFJnDWvemrbohw=;
  b=AwtdTKOHNTS6iCjRPezQhUZcYD8ziFb0cB0GlLk5jr9aUO0xCodXw4/y
   kVI+7GlxWYs/yXPTeYFund+lQi0/GB8LB5QCMEy0FI+MvoefP/PAX4zlY
   XLuSwYy9lsX/v1C1iA+fsPfrM3oPto0y/3BxLWjw8E3mlppKQFexjvhs/
   2jef3fonqQYfpHaHKnOYYPdbKn8n4LNyuvpZWZc2wbZa9/YoNJBlOv6gh
   DavraYJbyCXy7WQCwtHQIgT0QJfSvHiSr6cK9RbHzu1LkYig/TY31GlWZ
   EAo06TXiOQWiZWk4PCIEomGnSeR1n7dRZgAf5tDiFt6rYkcAoyp4AOpHN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10480"; a="283885228"
X-IronPort-AV: E=Sophos;i="5.93,342,1654585200"; 
   d="scan'208";a="283885228"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 05:16:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,342,1654585200"; 
   d="scan'208";a="651271058"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 24 Sep 2022 05:16:30 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oc457-0006TU-2g;
        Sat, 24 Sep 2022 12:16:29 +0000
Date:   Sat, 24 Sep 2022 20:15:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 712f210a457d9c32414df246a72781550bc23ef6
Message-ID: <632ef4f4.JumoDjEMOzTj8bkX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        LONGWORDS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 712f210a457d9c32414df246a72781550bc23ef6  x86/microcode/AMD: Track patch allocation size explicitly

elapsed time: 1441m

configs tested: 123
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
alpha                               defconfig
x86_64                              defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                               rhel-8.3
s390                 randconfig-r044-20220923
arc                  randconfig-r043-20220923
riscv                randconfig-r042-20220923
s390                             allyesconfig
x86_64                           allyesconfig
arm                                 defconfig
arc                              allyesconfig
x86_64                        randconfig-a015
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                          randconfig-a016
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
ia64                             allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
xtensa                              defconfig
powerpc                     tqm8555_defconfig
arc                      axs103_smp_defconfig
i386                          randconfig-c001
arm                        clps711x_defconfig
m68k                        mvme147_defconfig
powerpc                     stx_gp3_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220923
sh                        edosk7760_defconfig
sh                        sh7785lcr_defconfig
arm                       omap2plus_defconfig
powerpc                     tqm8541_defconfig
xtensa                    smp_lx200_defconfig
sh                        dreamcast_defconfig
sh                         ap325rxa_defconfig
powerpc                     mpc83xx_defconfig
powerpc                       holly_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
um                               alldefconfig
arm                         axm55xx_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                       common_defconfig
ia64                            zx1_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arm64                               defconfig
ia64                             allyesconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014

clang tested configs:
hexagon              randconfig-r041-20220923
hexagon              randconfig-r045-20220923
x86_64                        randconfig-a016
i386                          randconfig-a006
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a013
i386                             allyesconfig
powerpc                      pmac32_defconfig
mips                           rs90_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
powerpc                 mpc836x_mds_defconfig
mips                     cu1830-neo_defconfig
x86_64                        randconfig-c007
arm                  randconfig-c002-20220923
i386                          randconfig-c001
s390                 randconfig-c005-20220923
riscv                randconfig-c006-20220923
mips                 randconfig-c004-20220923
powerpc              randconfig-c003-20220923
x86_64                        randconfig-k001
arm                           sama7_defconfig
powerpc                    gamecube_defconfig
arm                         s3c2410_defconfig
mips                       lemote2f_defconfig
powerpc                     ppa8548_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
