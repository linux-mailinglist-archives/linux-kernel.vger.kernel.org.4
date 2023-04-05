Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F3E6D7FA2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbjDEOfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjDEOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:35:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19B565B9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680705322; x=1712241322;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fnK5AYX8YRjNpcu/SufvtqA78jBP3l9AvlwPRJGeHDs=;
  b=JeONkNMBf7Da669R9Lo2hTINJHUxSfm2SvobZNUuoDLimZrA6LG5Od+9
   Wums1k+F+V2BwsvMNoVYwhIc8y78QZ0tlAYc6fYZ+4/XYxiExrdKSdgI8
   jh3YQFin+1QtphoPGCXcAP3IC9r8S0sf5P9pEsLeIBKDSzN8mbnwLoD9z
   wrd4KfkTxExbsEgq3K8IGIlb6UgJH4zg4PjzJc1RmggJv4Q+w0OmlrY6U
   v9++fOtaKMbzWp4kvwMGLXgdzVSGJYzz7Ms/8S7c4n9mh4fMJtNW7XMvs
   u3Iu2BUVzcEdQlh97MRTUWL3ODX/+9Kinq7eGungTs0y/acgu3aIDgfGC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="322846765"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="322846765"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 07:35:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="797940157"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="797940157"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2023 07:35:20 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pk4EF-000Qa8-0x;
        Wed, 05 Apr 2023 14:35:15 +0000
Date:   Wed, 05 Apr 2023 22:34:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fsfa3] BUILD SUCCESS WITH WARNING
 91ba9bf02e0d11bbe0b6fe49f40fb90818f2a06d
Message-ID: <642d86fa.zFpyPeovdDi70fya%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fsfa3
branch HEAD: 91ba9bf02e0d11bbe0b6fe49f40fb90818f2a06d  uapi: netfilter: ebtables: Replace zero-length array with flexible-array  member

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303250602.DR5hZJXz-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303250644.7mtCknON-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304051623.Cvewnzo2-lkp@intel.com

Warning: (recently discovered and may have been fixed)

./usr/include/linux/netfilter_bridge/ebtables.h:163:26: warning: field 'target' with variable sized type 'struct ebt_entry_target' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
arch/alpha/include/asm/string.h:22:16: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
arch/m68k/include/asm/io_no.h:17:11: warning: array subscript 0 is outside array bounds of 'volatile u8[0]' {aka 'volatile unsigned char[]'} [-Warray-bounds]
arch/s390/include/asm/ptrace.h:69:26: warning: array subscript 0 is outside array bounds of 'struct psw_bits[0]' [-Warray-bounds]
arch/sparc/include/asm/string.h:15:25: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
drivers/cpufreq/brcmstb-avs-cpufreq.c:449:28: warning: array subscript 5 is outside array bounds of 'void[60]' [-Warray-bounds]
drivers/dma/sh/rcar-dmac.c:914:36: warning: array subscript 4294967295 is above array bounds of 'const u32[7]' {aka 'const unsigned int[7]'} [-Warray-bounds]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c:427:17: warning: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c:467:25: warning: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]
drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c:199:24: warning: array subscript [0, 63] is outside array bounds of 'struct komeda_component_output[5]' [-Warray-bounds]
drivers/gpu/drm/nouveau/nvif/outp.c:140:9: warning: array subscript '__int128 unsigned[0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
drivers/gpu/drm/nouveau/nvif/outp.c:140:9: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
drivers/net/ethernet/broadcom/tg3.c:17787:51: warning: array subscript 5 is above array bounds of 'struct tg3_napi[5]' [-Warray-bounds]
drivers/net/ethernet/i825xx/sun3_82586.c:989:122: warning: array subscript 1 is above array bounds of 'volatile struct transmit_cmd_struct *[1]' [-Warray-bounds]
drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c:167:31: warning: array subscript 4 is above array bounds of 'const struct sparx5_psfp_gce[4]' [-Warray-bounds]
drivers/platform/chrome/cros_ec_vbc.c:36:15: warning: array subscript 'struct ec_params_vbnvcontext[1]' is partly outside array bounds of 'unsigned char[36]' [-Warray-bounds]
fs/omfs/file.c:170:9: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]
include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile long long unsigned int[0]' [-Warray-bounds]
include/asm-generic/unaligned.h:14:15: warning: array subscript -1 is outside array bounds of 'char[]' [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified bound between 2147483648 and 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
include/linux/fortify-string.h:57:33: warning: array subscript '__int128 unsigned[0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]
lib/zstd/decompress/huf_decompress.c:1122:5: warning: 'HUF_fillDTableX2' accessing 624 bytes in a region of size 52 [-Wstringop-overflow=]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- arch-alpha-include-asm-string.h:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   `-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|-- alpha-randconfig-r026-20230403
|   `-- arch-alpha-include-asm-string.h:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|-- arc-allyesconfig
|   |-- drivers-net-ethernet-broadcom-tg3.c:warning:array-subscript-is-above-array-bounds-of-struct-tg3_napi
|   |-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- arm-allmodconfig
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   |-- drivers-dma-sh-rcar-dmac.c:warning:array-subscript-is-above-array-bounds-of-const-u32-aka-const-unsigned-int
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   |-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|   |-- include-linux-fortify-string.h:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- arm-allyesconfig
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   |-- drivers-dma-sh-rcar-dmac.c:warning:array-subscript-is-above-array-bounds-of-const-u32-aka-const-unsigned-int
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   |-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|   |-- include-linux-fortify-string.h:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- arm-defconfig
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   |-- drivers-gpu-drm-nouveau-nvif-outp.c:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|   |-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- arm64-allyesconfig
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   |-- drivers-gpu-drm-arm-display-komeda-komeda_pipeline_state.c:warning:array-subscript-is-outside-array-bounds-of-struct-komeda_component_output
|   |-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|   |-- include-asm-generic-unaligned.h:warning:array-subscript-is-outside-array-bounds-of-char
|   |-- include-linux-fortify-string.h:warning:array-subscript-__int128-unsigned-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- arm64-defconfig
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   |-- drivers-gpu-drm-nouveau-nvif-outp.c:warning:array-subscript-__int128-unsigned-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|   |-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- arm64-randconfig-r013-20230403
|   `-- fs-omfs-file.c:warning:writing-bytes-into-a-region-of-size
|-- i386-randconfig-a011-20230403
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- i386-randconfig-a012-20230403
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
clang_recent_errors
|-- i386-randconfig-a002-20230403
|   `-- usr-include-linux-netfilter_bridge-ebtables.h:warning:field-target-with-variable-sized-type-struct-ebt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|-- i386-randconfig-a003-20230403
|   `-- usr-include-linux-netfilter_bridge-ebtables.h:warning:field-target-with-variable-sized-type-struct-ebt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|-- i386-randconfig-a005-20230403
|   `-- usr-include-linux-netfilter_bridge-ebtables.h:warning:field-target-with-variable-sized-type-struct-ebt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|-- i386-randconfig-a013
|   `-- usr-include-linux-netfilter_bridge-ebtables.h:warning:field-target-with-variable-sized-type-struct-ebt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|-- x86_64-buildonly-randconfig-r002-20230403
|   `-- usr-include-linux-netfilter_bridge-ebtables.h:warning:field-target-with-variable-sized-type-struct-ebt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|-- x86_64-randconfig-a001-20230403
|   `-- usr-include-linux-netfilter_bridge-ebtables.h:warning:field-target-with-variable-sized-type-struct-ebt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
|-- x86_64-randconfig-a002-20230403
|   `-- usr-include-linux-netfilter_bridge-ebtables.h:warning:field-target-with-variable-sized-type-struct-ebt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension
`-- x86_64-randconfig-a016
    `-- usr-include-linux-netfilter_bridge-ebtables.h:warning:field-target-with-variable-sized-type-struct-ebt_entry_target-not-at-the-end-of-a-struct-or-class-is-a-GNU-extension

elapsed time: 727m

configs tested: 167
configs skipped: 8

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230403   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230403   gcc  
alpha                randconfig-r021-20230403   gcc  
alpha                randconfig-r026-20230403   gcc  
alpha                randconfig-r034-20230403   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230403   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230403   gcc  
arc                  randconfig-r016-20230403   gcc  
arc                  randconfig-r022-20230403   gcc  
arc                  randconfig-r032-20230403   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                  randconfig-r021-20230403   clang
arm                  randconfig-r046-20230403   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230403   clang
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230403   clang
arm64                randconfig-r013-20230403   gcc  
arm64                randconfig-r015-20230403   gcc  
csky         buildonly-randconfig-r001-20230403   gcc  
csky         buildonly-randconfig-r002-20230403   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230403   gcc  
csky                 randconfig-r013-20230403   gcc  
hexagon      buildonly-randconfig-r004-20230403   clang
hexagon      buildonly-randconfig-r006-20230403   clang
hexagon              randconfig-r004-20230403   clang
hexagon              randconfig-r006-20230403   clang
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r045-20230403   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                 randconfig-a012-20230403   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                          randconfig-a016   gcc  
i386                 randconfig-r021-20230403   gcc  
i386                 randconfig-r022-20230403   gcc  
i386                 randconfig-r023-20230403   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r004-20230403   gcc  
ia64         buildonly-randconfig-r006-20230403   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r023-20230403   gcc  
ia64                 randconfig-r024-20230403   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r026-20230403   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230403   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r014-20230403   gcc  
m68k                 randconfig-r024-20230403   gcc  
m68k                           sun3_defconfig   gcc  
microblaze   buildonly-randconfig-r005-20230403   gcc  
microblaze   buildonly-randconfig-r006-20230403   gcc  
microblaze           randconfig-r015-20230403   gcc  
microblaze           randconfig-r023-20230403   gcc  
microblaze           randconfig-r024-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230403   gcc  
mips                 randconfig-r015-20230403   clang
mips                 randconfig-r024-20230403   clang
mips                 randconfig-r026-20230403   clang
nios2        buildonly-randconfig-r004-20230403   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230403   gcc  
nios2                randconfig-r035-20230403   gcc  
openrisc                         alldefconfig   gcc  
openrisc     buildonly-randconfig-r003-20230403   gcc  
openrisc             randconfig-r011-20230403   gcc  
openrisc             randconfig-r025-20230403   gcc  
parisc       buildonly-randconfig-r003-20230403   gcc  
parisc       buildonly-randconfig-r005-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r036-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230403   gcc  
powerpc                     pq2fads_defconfig   gcc  
powerpc              randconfig-r005-20230403   clang
powerpc              randconfig-r012-20230403   gcc  
powerpc              randconfig-r013-20230403   gcc  
powerpc              randconfig-r014-20230403   gcc  
powerpc                    sam440ep_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230403   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230403   clang
riscv                randconfig-r012-20230403   gcc  
riscv                randconfig-r016-20230403   gcc  
riscv                randconfig-r021-20230403   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230403   clang
s390                 randconfig-r044-20230403   gcc  
sh                               allmodconfig   gcc  
sh                               j2_defconfig   gcc  
sh                   randconfig-r001-20230403   gcc  
sh                   randconfig-r003-20230403   gcc  
sh                   randconfig-r036-20230403   gcc  
sh                           se7705_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sparc        buildonly-randconfig-r001-20230403   gcc  
sparc        buildonly-randconfig-r004-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r021-20230403   gcc  
sparc                randconfig-r031-20230403   gcc  
sparc64      buildonly-randconfig-r006-20230403   gcc  
sparc64              randconfig-r022-20230403   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64               randconfig-a006-20230403   clang
x86_64               randconfig-a011-20230403   gcc  
x86_64                        randconfig-a011   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64               randconfig-a013-20230403   gcc  
x86_64                        randconfig-a013   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64               randconfig-a015-20230403   gcc  
x86_64                        randconfig-a015   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64               randconfig-r005-20230403   clang
x86_64               randconfig-r016-20230403   gcc  
x86_64               randconfig-r022-20230403   gcc  
x86_64               randconfig-r025-20230403   gcc  
x86_64               randconfig-r026-20230403   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r026-20230403   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
