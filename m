Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BFD6CD0BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjC2DgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC2DgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:36:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783D6212E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 20:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680060958; x=1711596958;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pg/NzROeL+vVNp3HSohWmAGXxs3g5hbSAMCZ7mNS/g0=;
  b=JVlziTOP5xdhQ1xnd/ao5MpY6AtUOKey5oum95k9tkOMqa2ztW0yqWAK
   Kv5pjtk9VvvRPCtUVxin/M4ZZsHKeo6wNpNicHNhwv24+c4JBfOcpaMIh
   HYsPqr9CpRDoFhPdahRTpFzVwyMSGKKj4gWSO4xEfZGLdo75XNtVqMa8n
   h5LzecmglLtB9NXmeKC2xvpkodUaeKdbCgTegTNC3ZiMMIg28mzfvJ2Tf
   s3WmqG3HqT184cLWlpO78XG2SOPQ5VYR5KKuuZgF5nBlLZPkBXrgfVk1f
   DS5dgg5AMYzVBF/BYXpdbTiRG8lOH0xOnXsDOUq1bd0bl5+wO7vLi57Yu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="324664583"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="324664583"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 20:35:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="677617451"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="677617451"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2023 20:35:36 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phMb1-000JBp-1b;
        Wed, 29 Mar 2023 03:35:35 +0000
Date:   Wed, 29 Mar 2023 11:34:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fsfa3] BUILD REGRESSION
 c592b273fa80c7e1c042e68c1cfd6e488c00cc7c
Message-ID: <6423b1cc.Sr4yWaE0Cj0R2Uwv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fsfa3
branch HEAD: c592b273fa80c7e1c042e68c1cfd6e488c00cc7c  cgroup: Fix -Warray-bounds warning

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303250602.DR5hZJXz-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303250644.7mtCknON-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303251631.oyjkxqNQ-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/alpha/include/asm/string.h:22:16: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
arch/s390/include/asm/ptrace.h:69:26: warning: array subscript 0 is outside array bounds of 'struct psw_bits[0]' [-Warray-bounds]
arch/sparc/include/asm/string.h:15:25: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
drivers/cpufreq/brcmstb-avs-cpufreq.c:449:28: warning: array subscript 5 is outside array bounds of 'void[60]' [-Warray-bounds]
drivers/dma/sh/rcar-dmac.c:914:36: warning: array subscript 4294967295 is above array bounds of 'const u32[7]' {aka 'const unsigned int[7]'} [-Warray-bounds]
drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c:199:24: warning: array subscript [0, 63] is outside array bounds of 'struct komeda_component_output[5]' [-Warray-bounds]
drivers/gpu/drm/nouveau/nvif/outp.c:140:9: warning: array subscript '__int128 unsigned[0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
drivers/gpu/drm/nouveau/nvif/outp.c:140:9: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c:167:31: warning: array subscript 4 is above array bounds of 'const struct sparx5_psfp_gce[4]' [-Warray-bounds]
drivers/platform/chrome/cros_ec_vbc.c:36:15: warning: array subscript 'struct ec_params_vbnvcontext[1]' is partly outside array bounds of 'unsigned char[36]' [-Warray-bounds]
fs/cifs/cifssmb.c:2980:31: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
include/asm-generic/rwonce.h:44:26: error: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Werror=array-bounds]
include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile long long unsigned int[0]' [-Warray-bounds]
include/asm-generic/unaligned.h:14:15: warning: array subscript -1 is outside array bounds of 'char[]' [-Warray-bounds]
include/linux/compiler_types.h:332:20: warning: array subscript 0 is outside array bounds of 'struct dentry[0]' [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified bound between 2147483648 and 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
include/linux/fortify-string.h:57:33: warning: array subscript '__int128 unsigned[0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]
lib/zstd/decompress/huf_decompress.c:1122:5: warning: 'HUF_fillDTableX2' accessing 624 bytes in a region of size 52 [-Wstringop-overflow=]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- arch-alpha-include-asm-string.h:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   `-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|-- arc-allyesconfig
|   |-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- arc-defconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- arc-randconfig-c44-20230326
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
|-- i386-allyesconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- i386-debian-10.3
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size

elapsed time: 787m

configs tested: 43
configs skipped: 3

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
