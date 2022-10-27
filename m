Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D7B6103A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiJ0VAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237595AbiJ0U7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:59:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FEE2EF0E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666903912; x=1698439912;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TdNRAgGcZjBWX+YXdqYrLh2PZj1dAvL9P813WAwEJwM=;
  b=YL06Hi/lhIYqQpsDGzEQk+6EjSxIsmDnlr0twpFbWQ2gUAK6q5yHZQLQ
   uS/+/4Qu1uI5DSz7OG/6M1BTE/rbe9DOdATCAi5U00QVVmiFZ0Ox/TbCA
   D9XYb9g39e6pBKMeUjHBi4QwNyDSL38ZkU3SE7nz6nxycJkGRR0n0T8IZ
   xovymf7hiyv4Zr7Cy9XZ0PQ6WikMgV/kcbdkKi/awTAKO5VhKiumcCfLY
   yzc819aDzzNRTSPmOrCabroTgKBOV3d5TtCrZTHpGjv3+9peVpWAWLPp0
   LmW0esz96UzbuWtad1/LMMVuT9y+YkRV3oi09oRnq0aXguwLd1zvQh6p7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="334973296"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="334973296"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 13:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="583694586"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="583694586"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 27 Oct 2022 13:51:50 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oo9qv-0009A0-2O;
        Thu, 27 Oct 2022 20:51:49 +0000
Date:   Fri, 28 Oct 2022 04:51:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 dc39beffcfc19a8dd2a09c5818dcd1a4e9099033
Message-ID: <635aef44.eRNqJ814AXKXgqPJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: dc39beffcfc19a8dd2a09c5818dcd1a4e9099033  perf: Optimize perf_tp_event()

elapsed time: 720m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
s390                             allmodconfig
x86_64                        randconfig-a006
s390                                defconfig
powerpc                          allmodconfig
x86_64                         rhel-8.3-kunit
mips                             allyesconfig
um                             i386_defconfig
x86_64                           rhel-8.3-kvm
um                           x86_64_defconfig
powerpc                           allnoconfig
s390                             allyesconfig
sh                               allmodconfig
x86_64                           rhel-8.3-syz
arm                                 defconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a013
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a011
ia64                             allmodconfig
x86_64                        randconfig-a015
x86_64                              defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a016
riscv                randconfig-r042-20221026
arc                  randconfig-r043-20221026
x86_64                               rhel-8.3
s390                 randconfig-r044-20221026
x86_64                           allyesconfig
i386                          randconfig-a005
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                    amigaone_defconfig
sh                           se7724_defconfig
sh                          rsk7201_defconfig
sparc                               defconfig
m68k                       m5249evb_defconfig
parisc                generic-32bit_defconfig
arm                          pxa910_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                             allyesconfig
i386                                defconfig
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
m68k                            q40_defconfig
arm                           imxrt_defconfig
arm                         assabet_defconfig
arm                          gemini_defconfig
sparc                             allnoconfig
m68k                        m5272c3_defconfig
xtensa                    smp_lx200_defconfig
arm                            hisi_defconfig
alpha                            alldefconfig
powerpc                 mpc834x_mds_defconfig
m68k                       m5208evb_defconfig
riscv                               defconfig
sh                        dreamcast_defconfig
powerpc                 canyonlands_defconfig
m68k                         amcore_defconfig
m68k                           sun3_defconfig
microblaze                      mmu_defconfig
mips                         bigsur_defconfig
sh                             shx3_defconfig
openrisc                  or1klitex_defconfig
mips                 randconfig-c004-20221026
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
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20221026
hexagon              randconfig-r041-20221026
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
s390                 randconfig-r044-20221027
hexagon              randconfig-r041-20221027
riscv                randconfig-r042-20221027
hexagon              randconfig-r045-20221027
powerpc                      pmac32_defconfig
mips                      bmips_stb_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
