Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39E7633A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiKVKcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiKVKbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:31:33 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1CC6245
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669112830; x=1700648830;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=CpxMePLRHTkV63A8OZ6Jw8JSRPa/ObvGh8xFrb33meM=;
  b=DcT7xktAgKDQXWbqzz4kzAoZWlKx5x2Ghh4AcNkaiMuz+kt7B6DCOBwI
   vn6rFnb1hBV2V3euZ3T0Ys5opJi69DGenGpYhDgFKm+ZraqlaPeUiS8TZ
   lfMznCVCTLGKHePF+E4AWW0nogGQDQkBMg+xnm+NMP28qb1vYmyTiiisW
   zWBD3LUMUSrKUceK4XtoQkcaoiEETwcSbWTJqny8PFcZU5BxxL0x0Pevc
   PPUVuoLt5snm0K16QPgK6ZGN/26tEJopixIwxn4NCGJOmuHTe0CZ7tS8Z
   0AfykY1rlxHS7HYn04W0EpU9C7WoyEeYcUDbfmm3V3tFYJenXx1Um3o7j
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="314933589"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="314933589"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 02:27:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="641370593"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="641370593"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Nov 2022 02:27:07 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxQUe-0001Mp-0l;
        Tue, 22 Nov 2022 10:27:08 +0000
Date:   Tue, 22 Nov 2022 18:26:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 1a63b58082869273bfbab1b945007193f7bd3a78
Message-ID: <637ca3d1.EDaUlOnEX/UPn06n%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/microcode
branch HEAD: 1a63b58082869273bfbab1b945007193f7bd3a78  Revert "platform/x86/intel/ifs: Mark as BROKEN"

elapsed time: 3962m

configs tested: 130
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                            allnoconfig
s390                 randconfig-r044-20221121
riscv                randconfig-r042-20221121
arc                  randconfig-r043-20221121
arm                      footbridge_defconfig
powerpc                       eiger_defconfig
sh                        sh7763rdp_defconfig
m68k                            q40_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 mpc837x_mds_defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
x86_64               randconfig-a011-20221121
x86_64               randconfig-a014-20221121
x86_64               randconfig-a012-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                          hp300_defconfig
arm                        realview_defconfig
powerpc                    sam440ep_defconfig
sh                         ap325rxa_defconfig
i386                 randconfig-a014-20221121
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a016-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a015-20221121
arm                            hisi_defconfig
sh                          sdk7786_defconfig
sparc                       sparc64_defconfig
sh                          rsk7264_defconfig
sh                           se7712_defconfig
i386                          randconfig-c001
mips                             allyesconfig
arc                              allyesconfig
m68k                        m5272c3_defconfig
arm                         nhk8815_defconfig
mips                           jazz_defconfig
powerpc                      ep88xc_defconfig
m68k                       m5249evb_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                           sama5_defconfig
arc                           tb10x_defconfig
mips                          rb532_defconfig
powerpc                      bamboo_defconfig
sh                               alldefconfig
m68k                        m5307c3_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                               defconfig
csky                                defconfig
x86_64                                  kexec
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                  randconfig-r043-20221120
powerpc                     tqm8541_defconfig
powerpc                     asp8347_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
xtensa                    xip_kc705_defconfig
powerpc                      pasemi_defconfig
arm                              allyesconfig
sparc                       sparc32_defconfig
sparc                            alldefconfig
sh                           se7705_defconfig
m68k                        stmark2_defconfig
powerpc                 mpc8540_ads_defconfig
arm                      jornada720_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221120
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
arm64                            allyesconfig

clang tested configs:
x86_64               randconfig-a002-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a003-20221121
powerpc                    mvme5100_defconfig
arm                         bcm2835_defconfig
arm                         lpc32xx_defconfig
i386                 randconfig-a001-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                    gamecube_defconfig
powerpc                  mpc866_ads_defconfig
arm                        neponset_defconfig
powerpc                     ksi8560_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                  mpc885_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
