Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898866C8D07
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 11:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjCYKLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 06:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCYKLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 06:11:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F88812856
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 03:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679739059; x=1711275059;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DrYo4TOJ27AHUhqVc67ZF9luCQrypAsQGMA5z171mh0=;
  b=dWJzwbp5YJioYM+PtBIdtBol4A4UCewegFssm+zgDODlyD5ZwK7yRjGt
   UMuE2Awforr47DlZNbLrIng3Zvj3q1p8LUuf/0mh4D/+VBNGReonP8P3E
   tacIy5dgUWXRneIBT/eOmoAhLFWU3Sk0FxgP4PjVU80+T+YF07L7mMNqG
   Wme4Ds5+kYx4X4I1xBaEOrOPu+SEXKbwoUTqRBuhbCadimooKmbN2r/Ah
   m2f6ETfL/Zk3o2bTIt3zuZ79VFzw/35Z2cPNXwPu1XFoiqbRQvGJtJby2
   E5zJrxdwaIshulnj4roTjSWdA8JSMQzoFrDTxc3iywpylsN5OE8KD4cvG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="339980200"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="339980200"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 03:10:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="752167248"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="752167248"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Mar 2023 03:10:57 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pg0rR-000GBt-0z;
        Sat, 25 Mar 2023 10:10:57 +0000
Date:   Sat, 25 Mar 2023 18:10:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fsfa3] BUILD REGRESSION
 2226ddb6a576f7f89a8a06a3f89b68f5109ded53
Message-ID: <641ec88a.+049t29qTBVQ35lm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fsfa3
branch HEAD: 2226ddb6a576f7f89a8a06a3f89b68f5109ded53  Makefile: Enable -Wstringop-overflow and -Warray-bounds

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303250602.DR5hZJXz-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303250644.7mtCknON-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303251631.oyjkxqNQ-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/alpha/include/asm/string.h:22:16: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
arch/m68k/include/asm/io_no.h:17:11: warning: array subscript 0 is outside array bounds of 'volatile u8[0]' {aka 'volatile unsigned char[]'} [-Warray-bounds]
arch/m68k/include/asm/string.h:52:25: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
arch/s390/include/asm/ptrace.h:69:26: warning: array subscript 0 is outside array bounds of 'struct psw_bits[0]' [-Warray-bounds]
arch/sparc/include/asm/string.h:15:25: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
drivers/cpufreq/brcmstb-avs-cpufreq.c:449:28: warning: array subscript 5 is outside array bounds of 'void[60]' [-Warray-bounds]
drivers/dma/sh/rcar-dmac.c:914:36: warning: array subscript 4294967295 is above array bounds of 'const u32[7]' {aka 'const unsigned int[7]'} [-Warray-bounds]
drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c:199:24: warning: array subscript [0, 63] is outside array bounds of 'struct komeda_component_output[5]' [-Warray-bounds]
drivers/gpu/drm/nouveau/nvif/outp.c:140:9: warning: array subscript '__int128 unsigned[0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
drivers/gpu/drm/nouveau/nvif/outp.c:140:9: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c:167:31: warning: array subscript 4 is above array bounds of 'const struct sparx5_psfp_gce[4]' [-Warray-bounds]
fs/btrfs/disk-io.c:100:48: warning: array subscript 1 is above array bounds of 'struct page *[1]' [-Warray-bounds]
fs/cifs/cifssmb.c:2980:31: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
fs/jffs2/nodelist.h:43:28: warning: array subscript 'union jffs2_sum_mem[0]' is partly outside array bounds of 'unsigned char[26]' [-Warray-bounds]
fs/jffs2/summary.c:79:73: warning: array subscript 'union jffs2_sum_mem[0]' is partly outside array bounds of 'unsigned char[26]' [-Warray-bounds]
include/asm-generic/rwonce.h:44:26: error: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Werror=array-bounds]
include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile long long unsigned int[0]' [-Warray-bounds]
include/asm-generic/unaligned.h:14:15: warning: array subscript -1 is outside array bounds of 'char[]' [-Warray-bounds]
include/linux/compiler_types.h:332:20: warning: array subscript 0 is outside array bounds of 'struct dentry[0]' [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified bound between 2147483648 and 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
include/linux/fortify-string.h:57:33: warning: array subscript '__int128 unsigned[0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]
kernel/cgroup/cgroup.c:1222:16: warning: 'find_existing_css_set' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
lib/zstd/decompress/huf_decompress.c:1122:5: warning: 'HUF_fillDTableX2' accessing 624 bytes in a region of size 52 [-Wstringop-overflow=]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- arch-alpha-include-asm-string.h:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|   `-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|-- alpha-randconfig-c003-20230322
|   `-- arch-alpha-include-asm-string.h:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|-- alpha-randconfig-r006-20230322
|   `-- arch-alpha-include-asm-string.h:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|-- arc-allyesconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- arc-defconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- arm-allmodconfig
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   |-- drivers-dma-sh-rcar-dmac.c:warning:array-subscript-is-above-array-bounds-of-const-u32-aka-const-unsigned-int
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|   `-- include-linux-fortify-string.h:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|-- arm-allyesconfig
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   |-- drivers-dma-sh-rcar-dmac.c:warning:array-subscript-is-above-array-bounds-of-const-u32-aka-const-unsigned-int
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|   |-- include-linux-fortify-string.h:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- arm-defconfig
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   `-- drivers-gpu-drm-nouveau-nvif-outp.c:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|-- arm64-allyesconfig
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   |-- drivers-gpu-drm-arm-display-komeda-komeda_pipeline_state.c:warning:array-subscript-is-outside-array-bounds-of-struct-komeda_component_output
|   |-- include-asm-generic-unaligned.h:warning:array-subscript-is-outside-array-bounds-of-char
|   |-- include-linux-fortify-string.h:warning:array-subscript-__int128-unsigned-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- arm64-defconfig
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   `-- drivers-gpu-drm-nouveau-nvif-outp.c:warning:array-subscript-__int128-unsigned-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|-- arm64-randconfig-c034-20230322
|   `-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- arm64-randconfig-r026-20230324
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- i386-allyesconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- i386-debian-10.3
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- i386-defconfig
|   `-- lib-zstd-decompress-huf_decompress.c:warning:HUF_fillDTableX2-accessing-bytes-in-a-region-of-size
|-- i386-randconfig-a001

elapsed time: 846m

configs tested: 123
configs skipped: 7

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230322   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230322   gcc  
arc                  randconfig-r034-20230322   gcc  
arc                  randconfig-r043-20230322   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          moxart_defconfig   clang
arm                  randconfig-c002-20230322   clang
arm                  randconfig-r003-20230322   gcc  
arm                  randconfig-r023-20230324   clang
arm                  randconfig-r025-20230322   clang
arm                  randconfig-r046-20230322   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r026-20230324   gcc  
csky                                defconfig   gcc  
hexagon                          alldefconfig   clang
hexagon              randconfig-r033-20230322   clang
hexagon              randconfig-r041-20230322   clang
hexagon              randconfig-r045-20230322   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   clang
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230322   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r015-20230322   gcc  
ia64                 randconfig-r031-20230322   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230322   gcc  
loongarch            randconfig-r005-20230322   gcc  
loongarch            randconfig-r032-20230322   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230322   gcc  
microblaze   buildonly-randconfig-r002-20230322   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r004-20230322   gcc  
mips                 randconfig-c004-20230322   clang
mips                 randconfig-r001-20230322   gcc  
mips                 randconfig-r036-20230322   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230322   gcc  
nios2                randconfig-r016-20230322   gcc  
nios2                randconfig-r036-20230322   gcc  
openrisc             randconfig-r001-20230322   gcc  
openrisc             randconfig-r005-20230322   gcc  
openrisc             randconfig-r021-20230324   gcc  
parisc       buildonly-randconfig-r006-20230322   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r034-20230322   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230322   gcc  
powerpc              randconfig-c003-20230322   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-c006-20230322   clang
riscv                randconfig-r002-20230322   clang
riscv                randconfig-r024-20230324   gcc  
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-c005-20230322   clang
s390                 randconfig-r014-20230322   gcc  
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230322   gcc  
sparc        buildonly-randconfig-r001-20230322   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230322   gcc  
sparc                randconfig-r011-20230322   gcc  
sparc64              randconfig-r022-20230324   gcc  
sparc64              randconfig-r025-20230324   gcc  
sparc64              randconfig-r031-20230322   gcc  
sparc64              randconfig-r035-20230322   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-c007   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r013-20230322   gcc  
xtensa               randconfig-r035-20230322   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
