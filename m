Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0324E6103A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbiJ0VA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbiJ0U7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:59:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3BF37F8B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666903912; x=1698439912;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WrR9cJfEj8HgKhAQRX167u2Zy6esXaespjk9+37w+qw=;
  b=JMSV0+Z/WyXY1TN7jG9fohy48rUuEMo2UG08eTjGlgin9y+gC8zriKvl
   0LLHj1rftoIM63oxuo5wVGBmfsd7I2sN90tPZW3jUG14wgdg/y2kIo9pG
   kD2ajG9eRSIIAKj0uEvw/i5v7zHLK8GkB6yiQC5QgMnlk7QRpDTPq3Ysq
   SGvOGTvOKY8znJdm8fd1AYxx4Z+PERRfAIYoajQvinPSNl8M0XchKEGDG
   aP+M5lOUc5OAO893bPpdAU5wBoGFRtU4SVnL0v8DD5yIpceMwYhJYS/uG
   3j4uubOe+XvIfcaSzKs+Y3QxmsAxLPSfV3D5BX6jO+IRumDRhUgrTL6al
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="288055287"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="288055287"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 13:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="701491603"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="701491603"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 27 Oct 2022 13:51:50 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oo9qv-00099v-2F;
        Thu, 27 Oct 2022 20:51:49 +0000
Date:   Fri, 28 Oct 2022 04:51:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 d0c006402e7941558e5283ae434e2847c7999378
Message-ID: <635aef45.p7GKpZI/uTDQrjkw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: d0c006402e7941558e5283ae434e2847c7999378  jump_label: Use atomic_try_cmpxchg() in static_key_slow_inc_cpuslocked()

elapsed time: 720m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                        randconfig-a002
arc                                 defconfig
alpha                               defconfig
x86_64                        randconfig-a004
mips                             allyesconfig
s390                             allmodconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
i386                          randconfig-a001
s390                                defconfig
x86_64                        randconfig-a006
i386                          randconfig-a003
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
um                             i386_defconfig
sh                               allmodconfig
um                           x86_64_defconfig
arc                              allyesconfig
x86_64                              defconfig
alpha                            allyesconfig
i386                          randconfig-a005
s390                             allyesconfig
x86_64                               rhel-8.3
m68k                             allmodconfig
x86_64                           allyesconfig
riscv                randconfig-r042-20221026
i386                                defconfig
arc                  randconfig-r043-20221026
s390                 randconfig-r044-20221026
ia64                             allmodconfig
m68k                             allyesconfig
arm                                 defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm64                            allyesconfig
i386                             allyesconfig
arm                              allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a013
powerpc                    amigaone_defconfig
sh                           se7724_defconfig
sh                          rsk7201_defconfig
x86_64                        randconfig-a011
i386                          randconfig-a016
sparc                               defconfig
m68k                       m5249evb_defconfig
parisc                generic-32bit_defconfig
arm                          pxa910_defconfig
x86_64                        randconfig-a015
arc                              alldefconfig
arm                            pleb_defconfig
mips                      maltasmvp_defconfig
mips                            ar7_defconfig
arc                            hsdk_defconfig
arm                             ezx_defconfig
sh                            migor_defconfig
nios2                         3c120_defconfig
i386                          randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sparc                             allnoconfig
m68k                        m5272c3_defconfig
xtensa                    smp_lx200_defconfig
m68k                            q40_defconfig
arm                           imxrt_defconfig
arm                         assabet_defconfig
arm                          gemini_defconfig
arm                            hisi_defconfig
alpha                            alldefconfig
powerpc                 mpc834x_mds_defconfig
m68k                       m5208evb_defconfig
riscv                               defconfig
sh                        dreamcast_defconfig
powerpc                 canyonlands_defconfig
mips                 randconfig-c004-20221026
m68k                         amcore_defconfig
m68k                           sun3_defconfig
microblaze                      mmu_defconfig
mips                         bigsur_defconfig
sh                             shx3_defconfig
openrisc                  or1klitex_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r041-20221026
i386                          randconfig-a006
hexagon              randconfig-r045-20221026
i386                          randconfig-a013
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
s390                 randconfig-r044-20221027
hexagon              randconfig-r041-20221027
riscv                randconfig-r042-20221027
hexagon              randconfig-r045-20221027
i386                          randconfig-a011
i386                          randconfig-a015
powerpc                      pmac32_defconfig
mips                      bmips_stb_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
