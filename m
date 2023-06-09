Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112A8728ED4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbjFIEQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFIEQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:16:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB7F2D7F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 21:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686284176; x=1717820176;
  h=date:from:to:cc:subject:message-id;
  bh=L8TQoNoyOjmJccgFP0Tw46x24guKSINgTVzcYqc4gMQ=;
  b=cf0OcL52TUSP1NJuxcDfnnYL5H9GSyuVUMAdfNXJ3hYgvmL0FAtwgaWt
   4cQk1LxyKDibR30/UuLdHkhJzAQnBEGhAlcwdlfIsgN6pX4FW1FidZkZO
   RJ3hN58DuuSZd9PbFR2egmLGzhoU8CtxCj4lSAmajnMmi+B4s3nXJ/dkg
   VM6Gzyqt3cPrLpEPfVHyHPse8UXSPxzwjDMi0vvhww8FUD+dfqmydt6Ac
   P9Hdfz1qeynvTlGcEr/NIPX+6KOxitW/UllSWc6+zH1pOcJejur9FXxgA
   64DqCOvPR1pQkdjR63uckyJcCv8tD08gqU+rXzuH10Caq4rB6tUaDusmZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="360865623"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="360865623"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 21:16:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="834482285"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="834482285"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Jun 2023 21:16:13 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7TXo-0008cN-1U;
        Fri, 09 Jun 2023 04:16:12 +0000
Date:   Fri, 09 Jun 2023 12:15:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230606] BUILD REGRESSION
 deff3c1ef49381ffa232906f49f03e8d712755b7
Message-ID: <202306091223.MGvzR4KI-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230606
branch HEAD: deff3c1ef49381ffa232906f49f03e8d712755b7  ARM: OMAP2+: Fix -Warray-bounds warning _pwrdm_state_switch()

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306081931.EoJfyobB-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/arc/include/asm/io.h:130:9: warning: array subscript 0 is outside array bounds of 'volatile void[0]' [-Warray-bounds]
arch/arc/include/asm/io.h:54:9: warning: array subscript 0 is outside array bounds of 'const volatile void[0]' [-Warray-bounds]
arch/arm/include/asm/io.h:113:9: warning: array subscript 0 is outside array bounds of 'void[0]' [-Warray-bounds]
arch/x86/kvm/ioapic.c:214:33: error: array subscript 32 is above array bounds of 'union kvm_ioapic_redirect_entry[24]' [-Werror=array-bounds]
drivers/gpu/drm/nouveau/dispnv04/dac.c:432:39: warning: array subscript -1 is below array bounds of 'uint32_t[4]' {aka 'unsigned int[4]'} [-Warray-bounds]
drivers/gpu/drm/nouveau/nvif/object.c:161:9: warning: 'memcpy' specified bound between 4294967264 and 4294967287 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c:1194:25: warning: array subscript 1 is outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
drivers/platform/chrome/cros_ec_vbc.c:36:15: warning: array subscript 'struct ec_params_vbnvcontext[1]' is partly outside array bounds of 'unsigned char[36]' [-Warray-bounds]
fs/xfs/libxfs/xfs_iext_tree.c:767:36: warning: array subscript 16 is above array bounds of 'void *[16]' [-Warray-bounds]
fs/xfs/libxfs/xfs_iext_tree.c:767:36: warning: array subscript 21 is above array bounds of 'void *[21]' [-Warray-bounds]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-r012-20230608
|   `-- fs-xfs-libxfs-xfs_iext_tree.c:warning:array-subscript-is-above-array-bounds-of-void
|-- arc-allyesconfig
|   |-- arch-arc-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   |-- arch-arc-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|   `-- drivers-net-ethernet-qlogic-qed-qed_init_fw_funcs.c:warning:array-subscript-is-outside-array-bounds-of-u32-aka-unsigned-int
|-- arc-randconfig-c032-20230608
|   |-- arch-arc-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- arch-arc-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- arc-randconfig-r043-20230608
|   |-- arch-arc-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-void
|   `-- arch-arc-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-volatile-void
|-- arm-allmodconfig
|   |-- drivers-net-ethernet-qlogic-qed-qed_init_fw_funcs.c:warning:array-subscript-is-outside-array-bounds-of-u32-aka-unsigned-int
|   `-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|-- arm-allyesconfig
|   |-- drivers-net-ethernet-qlogic-qed-qed_init_fw_funcs.c:warning:array-subscript-is-outside-array-bounds-of-u32-aka-unsigned-int
|   `-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|-- arm-buildonly-randconfig-r005-20230608
|   |-- arch-arm-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-void
|   `-- drivers-net-ethernet-qlogic-qed-qed_init_fw_funcs.c:warning:array-subscript-is-outside-array-bounds-of-u32-aka-unsigned-int
|-- arm-defconfig
|   `-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|-- arm64-allyesconfig
|   `-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|-- arm64-defconfig
|   `-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|-- i386-allyesconfig
|   |-- drivers-net-ethernet-qlogic-qed-qed_init_fw_funcs.c:warning:array-subscript-is-outside-array-bounds-of-u32-aka-unsigned-int
|   `-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|-- i386-randconfig-i004-20230608
|   `-- arch-x86-kvm-ioapic.c:error:array-subscript-is-above-array-bounds-of-union-kvm_ioapic_redirect_entry
|-- i386-randconfig-i005-20230608
|   `-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|-- i386-randconfig-i054-20230608
|   `-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-nouveau-dispnv04-dac.c:warning:array-subscript-is-below-array-bounds-of-uint32_t-aka-unsigned-int
|   `-- drivers-net-ethernet-qlogic-qed-qed_init_fw_funcs.c:warning:array-subscript-is-outside-array-bounds-of-u32-aka-unsigned-int
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-nouveau-dispnv04-dac.c:warning:array-subscript-is-below-array-bounds-of-uint32_t-aka-unsigned-int
|   `-- drivers-net-ethernet-qlogic-qed-qed_init_fw_funcs.c:warning:array-subscript-is-outside-array-bounds-of-u32-aka-unsigned-int
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-nouveau-dispnv04-dac.c:warning:array-subscript-is-below-array-bounds-of-uint32_t-aka-unsigned-int
|   |-- drivers-gpu-drm-nouveau-nvif-object.c:warning:memcpy-specified-bound-between-and-exceeds-maximum-object-size
|   `-- drivers-net-ethernet-qlogic-qed-qed_init_fw_funcs.c:warning:array-subscript-is-outside-array-bounds-of-u32-aka-unsigned-int
|-- powerpc-allmodconfig
|   `-- drivers-net-ethernet-qlogic-qed-qed_init_fw_funcs.c:warning:array-subscript-is-outside-array-bounds-of-u32-aka-unsigned-int
|-- riscv-allmodconfig
|   `-- drivers-gpu-drm-nouveau-dispnv04-dac.c:warning:array-subscript-is-below-array-bounds-of-uint32_t-aka-unsigned-int
|-- riscv-allyesconfig
|   `-- drivers-gpu-drm-nouveau-dispnv04-dac.c:warning:array-subscript-is-below-array-bounds-of-uint32_t-aka-unsigned-int
|-- s390-randconfig-r006-20230608
|   `-- fs-xfs-libxfs-xfs_iext_tree.c:warning:array-subscript-is-above-array-bounds-of-void
|-- sparc-buildonly-randconfig-r003-20230608
|   `-- fs-xfs-libxfs-xfs_iext_tree.c:warning:array-subscript-is-above-array-bounds-of-void
|-- x86_64-allyesconfig
|   `-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
`-- x86_64-kexec
    `-- fs-xfs-libxfs-xfs_iext_tree.c:warning:array-subscript-is-above-array-bounds-of-void

elapsed time: 1444m

configs tested: 135
configs skipped: 6

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230608   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230608   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r005-20230608   gcc  
arm                                 defconfig   clang
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230608   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230608   clang
csky         buildonly-randconfig-r004-20230608   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r026-20230608   gcc  
hexagon              randconfig-r015-20230608   clang
hexagon              randconfig-r041-20230608   clang
hexagon              randconfig-r045-20230608   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230608   gcc  
i386                 randconfig-i002-20230608   gcc  
i386                 randconfig-i003-20230608   gcc  
i386                 randconfig-i004-20230608   gcc  
i386                 randconfig-i005-20230608   gcc  
i386                 randconfig-i006-20230608   gcc  
i386                 randconfig-i011-20230608   clang
i386                 randconfig-i012-20230608   clang
i386                 randconfig-i013-20230608   clang
i386                 randconfig-i014-20230608   clang
i386                 randconfig-i015-20230608   clang
i386                 randconfig-i016-20230608   clang
i386                 randconfig-i051-20230608   gcc  
i386                 randconfig-i052-20230608   gcc  
i386                 randconfig-i053-20230608   gcc  
i386                 randconfig-i054-20230608   gcc  
i386                 randconfig-i055-20230608   gcc  
i386                 randconfig-i056-20230608   gcc  
i386                 randconfig-i061-20230608   gcc  
i386                 randconfig-i062-20230608   gcc  
i386                 randconfig-i063-20230608   gcc  
i386                 randconfig-i064-20230608   gcc  
i386                 randconfig-i065-20230608   gcc  
i386                 randconfig-i066-20230608   gcc  
i386                 randconfig-r011-20230608   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230608   gcc  
loongarch    buildonly-randconfig-r002-20230608   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230608   gcc  
loongarch            randconfig-r005-20230608   gcc  
loongarch            randconfig-r021-20230608   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230608   gcc  
m68k                 randconfig-r016-20230608   gcc  
m68k                 randconfig-r036-20230608   gcc  
m68k                           virt_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                           ip27_defconfig   clang
mips                 randconfig-r031-20230608   clang
nios2                               defconfig   gcc  
nios2                randconfig-r034-20230608   gcc  
openrisc             randconfig-r022-20230608   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      ppc64e_defconfig   clang
powerpc              randconfig-r033-20230608   gcc  
powerpc                     tqm8541_defconfig   gcc  
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230608   gcc  
riscv                randconfig-r042-20230608   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230608   gcc  
s390                 randconfig-r014-20230608   clang
s390                 randconfig-r044-20230608   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230608   gcc  
sh                          rsk7264_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r003-20230608   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r025-20230608   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230608   gcc  
x86_64               randconfig-a002-20230608   gcc  
x86_64               randconfig-a003-20230608   gcc  
x86_64               randconfig-a004-20230608   gcc  
x86_64               randconfig-a005-20230608   gcc  
x86_64               randconfig-a006-20230608   gcc  
x86_64               randconfig-a011-20230608   clang
x86_64               randconfig-a012-20230608   clang
x86_64               randconfig-a013-20230608   clang
x86_64               randconfig-a014-20230608   clang
x86_64               randconfig-a015-20230608   clang
x86_64               randconfig-a016-20230608   clang
x86_64               randconfig-x051-20230608   clang
x86_64               randconfig-x052-20230608   clang
x86_64               randconfig-x053-20230608   clang
x86_64               randconfig-x054-20230608   clang
x86_64               randconfig-x055-20230608   clang
x86_64               randconfig-x056-20230608   clang
x86_64               randconfig-x061-20230608   clang
x86_64               randconfig-x062-20230608   clang
x86_64               randconfig-x063-20230608   clang
x86_64               randconfig-x064-20230608   clang
x86_64               randconfig-x065-20230608   clang
x86_64               randconfig-x066-20230608   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r035-20230608   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
