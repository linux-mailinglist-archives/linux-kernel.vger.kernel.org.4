Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EB25BF5CD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 07:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIUFKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 01:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiIUFKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 01:10:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6436838691
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 22:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663737006; x=1695273006;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aWUfJzGgptRSeC30F67QbYL2ZF+WOq0EjQ5TrEiGcQw=;
  b=AL51h9YkxNAA6DC+AhIWnhBaVaVrClXlJTX+wVWA9zFXQKIYRSVMGutY
   06dbypliTHqzPstJb/pjEas6wG3OzTR2DraFUw95vtrayLNWOURllMYHm
   7rD3oYwcoKZ8ew7GhN8WmQ/ckqLMLDV+axKfJWkk8Zk5Jhpxj1cCFeQ87
   WLTydeh3yZkGE+kCy4pUOUfmPBqFqbdDudaNjgg5dG1l05VGUA++Nix/i
   m9Nn4QG+SyjyM+US6qXOGALxFD5BdIfFpG97uGtZZN+tJyAYFRkAkpzCB
   HCQee8dS9hhsGMe/Qiv0Wbnvm373GV61VG2ok2J3azlYmREiBKQmJ0oxx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="363876375"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="363876375"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 22:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="652384860"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Sep 2022 22:10:04 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oarzo-0003G9-0l;
        Wed, 21 Sep 2022 05:10:04 +0000
Date:   Wed, 21 Sep 2022 13:09:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 5258b80e60da6d8908ae2846b234ed8d9d9d4a19
Message-ID: <632a9c9c.BPS3jSySiUO4DRb/%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: 5258b80e60da6d8908ae2846b234ed8d9d9d4a19  x86/dumpstack: Don't mention RIP in "Code: "

elapsed time: 727m

configs tested: 87
configs skipped: 80

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a014
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
sh                        sh7763rdp_defconfig
sparc64                             defconfig
powerpc                      makalu_defconfig
m68k                        mvme147_defconfig
sh                           se7705_defconfig
m68k                            mac_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arm                        mini2440_defconfig
arc                        nsimosci_defconfig
powerpc                     tqm8541_defconfig
arm                             ezx_defconfig
mips                         cobalt_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-c001
ia64                             allmodconfig
ia64                        generic_defconfig
sh                   rts7751r2dplus_defconfig
sh                          rsk7203_defconfig
nios2                         3c120_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                             allnoconfig
microblaze                      mmu_defconfig
powerpc                  iss476-smp_defconfig
arc                      axs103_smp_defconfig
i386                 randconfig-c001-20220919

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
arm                        multi_v5_defconfig
mips                        bcm63xx_defconfig
powerpc                          allyesconfig
powerpc                      acadia_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
