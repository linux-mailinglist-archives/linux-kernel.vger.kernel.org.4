Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2158472102B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 15:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjFCNWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 09:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFCNWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 09:22:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8BDCE
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 06:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685798555; x=1717334555;
  h=date:from:to:cc:subject:message-id;
  bh=z7cpKogphrm3fgcDZFtMe6kTi1Xsua9BcANyOQYzB34=;
  b=TIPjGwQDmsH84feYoFHle1ODHKCeMuDM7AoBD1tnBX0td1Gg9TtGc50T
   DzoXDghZMraFP23ZhM3KQGct9sZObV3rHvyB6g+WREZN+ivls00xs/2UX
   ryWvc5iphX6Gd/jazukso6MFdDP+S8Bcnb5ZB3SN62ohbK5JEekHqLyBO
   lhS4XZ3m2pazlLllb1MOL1PQJZ3zwcbopvx1xikcewHH0wMrCqFpUPjhi
   XkeXMUhECs0nx5QdsuEwX8mmci3ZNJOFIinfGIF3lE06N6j77AAozarrt
   q942oLdOCOWbKw4Ng5pKlMBp09+PGP9exXmQTmJh/CED/jjgp1taGZN98
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="335689007"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="335689007"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 06:22:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="702256709"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="702256709"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 03 Jun 2023 06:22:33 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5RDF-0001cQ-0e;
        Sat, 03 Jun 2023 13:22:33 +0000
Date:   Sat, 03 Jun 2023 21:21:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230602] BUILD REGRESSION
 20aaaa40b39f5178aee00e3982b68ab8fd0c59a8
Message-ID: <20230603132144.8MuAQ%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230602
branch HEAD: 20aaaa40b39f5178aee00e3982b68ab8fd0c59a8  Makefile: Enable -Warray-bounds

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306030807.GiXzVRcZ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306030823.XYmbFKNB-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306030848.Vd0VuRBq-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306031638.zmtz006C-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/arm/include/asm/memory.h:318:22: warning: array subscript -1 is outside array bounds of 'char[2147483647]' [-Warray-bounds]
arch/arm/kernel/hibernate.c:29:40: warning: array subscript -1 is outside array bounds of 'const void[2147483647]' [-Warray-bounds]
arch/s390/include/asm/ptrace.h:69:26: warning: array subscript 0 is outside array bounds of 'struct psw_bits[0]' [-Warray-bounds]
arch/sparc/kernel/irq_32.c:258:14: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]
arch/sparc/mm/init_64.c:3057:31: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds]
arch/x86/include/asm/io.h:56:3: warning: array subscript 0 is outside array bounds of 'void[0]' [-Warray-bounds]
drivers/base/arch_topology.c:734:67: warning: array subscript 16 is above array bounds of 'struct cpu_topology[16]' [-Warray-bounds]
drivers/base/arch_topology.c:734:67: warning: array subscript 64 is above array bounds of 'struct cpu_topology[64]' [-Warray-bounds]
drivers/cpufreq/brcmstb-avs-cpufreq.c:449:28: warning: array subscript 5 is outside array bounds of 'void[60]' [-Warray-bounds]
drivers/dma/sh/rcar-dmac.c:914:36: warning: array subscript 4294967295 is above array bounds of 'const u32[7]' {aka 'const unsigned int[7]'} [-Warray-bounds]
drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c:199:24: warning: array subscript [0, 63] is outside array bounds of 'struct komeda_component_output[5]' [-Warray-bounds]
drivers/isdn/hardware/mISDN/hfcsusb.c:1218:47: warning: array subscript [0, 31] is outside array bounds of 'int[8]' [-Warray-bounds]
drivers/leds/trigger/ledtrig-netdev.c:190:41: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
drivers/mmc/host/sdhci-msm.c:2557:48: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]
drivers/net/ethernet/broadcom/tg3.c:17787:51: warning: array subscript 5 is above array bounds of 'struct tg3_napi[5]' [-Warray-bounds]
drivers/net/ethernet/mellanox/mlx4/alloc.c:691:47: warning: array subscript -1 is below array bounds of 'long unsigned int *[2]' [-Warray-bounds]
drivers/net/ethernet/mellanox/mlx4/alloc.c:761:37: warning: array subscript [0, 31] is outside array bounds of 'long unsigned int *[2]' [-Warray-bounds]
drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c:167:31: warning: array subscript 4 is above array bounds of 'const struct sparx5_psfp_gce[4]' [-Warray-bounds]
drivers/soc/qcom/llcc-qcom.c:1039:17: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]
drivers/spi/spi-imx.c:1705:34: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]
fs/jffs2/nodelist.h:43:28: warning: array subscript 'union jffs2_sum_mem[0]' is partly outside array bounds of 'unsigned char[26]' [-Warray-bounds]
fs/jffs2/summary.c:79:73: warning: array subscript 'union jffs2_sum_mem[0]' is partly outside array bounds of 'unsigned char[26]' [-Warray-bounds]
include/asm-generic/percpu.h:21:44: warning: array subscript [0, 31] is outside array bounds of 'long unsigned int[32]' [-Warray-bounds]
include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile long long unsigned int[0]' [-Warray-bounds]
include/asm-generic/unaligned.h:14:15: warning: array subscript -1 is outside array bounds of 'char[]' [-Warray-bounds]
include/linux/compiler_types.h:332:20: warning: array subscript 0 is outside array bounds of 'struct dentry[0]' [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: array subscript -32 is outside array bounds of 'char[]' [-Warray-bounds]
include/net/xfrm.h:1363:19: warning: array subscript 'xfrm_address_t[0]' is partly outside array bounds of '__be32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
net/socket.c:654:21: warning: array subscript -1 is outside array bounds of 'struct inode[3397917]' [-Warray-bounds]
net/socket.c:654:21: warning: array subscript -1 is outside array bounds of 'struct inode[6100805]' [-Warray-bounds]
net/socket.c:654:21: warning: array subscript -1 is outside array bounds of 'struct inode[7585009898729256]' [-Warray-bounds]

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/m68k/include/asm/io_no.h:23:72: warning: array subscript 0 is outside array bounds of 'volatile u8[0]' {aka 'volatile unsigned char[]'} [-Warray-bounds]
kernel/bpf/net_namespace.c:437:27: warning: array subscript 2 is above array bounds of 'struct bpf_prog *[2]' [-Warray-bounds]
kernel/bpf/net_namespace.c:437:27: warning: array subscript [0, 1] is outside array bounds of 'struct bpf_prog *[2]' [-Warray-bounds]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-s031-20230531
|   `-- kernel-bpf-net_namespace.c:warning:array-subscript-is-above-array-bounds-of-struct-bpf_prog
|-- arm-allmodconfig
|   |-- arch-arm-kernel-hibernate.c:warning:array-subscript-is-outside-array-bounds-of-const-void
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   |-- drivers-dma-sh-rcar-dmac.c:warning:array-subscript-is-above-array-bounds-of-const-u32-aka-const-unsigned-int
|   `-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|-- arm-allyesconfig
|   `-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|-- arm-randconfig-r046-20230531
|   |-- arch-arm-include-asm-memory.h:warning:array-subscript-is-outside-array-bounds-of-char
|   `-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- arm-rpc_defconfig
|   `-- arch-arm-include-asm-memory.h:warning:array-subscript-is-outside-array-bounds-of-char
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-arm-display-komeda-komeda_pipeline_state.c:warning:array-subscript-is-outside-array-bounds-of-struct-komeda_component_output
|   |-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|   `-- include-asm-generic-unaligned.h:warning:array-subscript-is-outside-array-bounds-of-char
|-- arm64-randconfig-c023-20230531
|   `-- kernel-bpf-net_namespace.c:warning:array-subscript-is-above-array-bounds-of-struct-bpf_prog
|-- arm64-randconfig-s051-20230531
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   `-- net-socket.c:warning:array-subscript-is-outside-array-bounds-of-struct-inode
|-- i386-allyesconfig
|   `-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|-- i386-buildonly-randconfig-r001-20230531
|   `-- include-net-xfrm.h:warning:array-subscript-xfrm_address_t-is-partly-outside-array-bounds-of-__be32-aka-unsigned-int
|-- i386-randconfig-i003-20230531
|   `-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|-- i386-randconfig-i006-20230531
|   `-- drivers-net-ethernet-mellanox-mlx4-alloc.c:warning:array-subscript-is-below-array-bounds-of-long-unsigned-int
|-- i386-randconfig-r004-20230602
|   `-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|-- i386-randconfig-s001-20230601
|   |-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|   `-- drivers-net-ethernet-broadcom-tg3.c:warning:array-subscript-is-above-array-bounds-of-struct-tg3_napi
|-- i386-randconfig-s003-20230601
|   `-- kernel-bpf-net_namespace.c:warning:array-subscript-is-outside-array-bounds-of-struct-bpf_prog
|-- m68k-randconfig-s043-20230531
|   `-- arch-m68k-include-asm-io_no.h:warning:array-subscript-is-outside-array-bounds-of-volatile-u8-aka-volatile-unsigned-char
|-- mips-allmodconfig
|   `-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|-- mips-allyesconfig
|   |-- drivers-isdn-hardware-mISDN-hfcsusb.c:warning:array-subscript-is-outside-array-bounds-of-int
|   `-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|-- mips-randconfig-c032-20230531
|   `-- net-socket.c:warning:array-subscript-is-outside-array-bounds-of-struct-inode
|-- parisc-randconfig-s032-20230531
|   `-- drivers-base-arch_topology.c:warning:array-subscript-is-above-array-bounds-of-struct-cpu_topology
|-- powerpc-allmodconfig
|   |-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|   |-- drivers-net-ethernet-mellanox-mlx4-alloc.c:warning:array-subscript-is-outside-array-bounds-of-long-unsigned-int
|   `-- include-asm-generic-percpu.h:warning:array-subscript-is-outside-array-bounds-of-long-unsigned-int
|-- powerpc-mgcoge_defconfig
|   `-- net-socket.c:warning:array-subscript-is-outside-array-bounds-of-struct-inode
|-- powerpc-ppc6xx_defconfig
|   `-- drivers-net-ethernet-broadcom-tg3.c:warning:array-subscript-is-above-array-bounds-of-struct-tg3_napi
|-- powerpc-randconfig-s033-20230531
|   |-- drivers-net-ethernet-broadcom-tg3.c:warning:array-subscript-is-above-array-bounds-of-struct-tg3_napi
|   `-- net-socket.c:warning:array-subscript-is-outside-array-bounds-of-struct-inode
|-- riscv-allmodconfig
|   |-- drivers-isdn-hardware-mISDN-hfcsusb.c:warning:array-subscript-is-outside-array-bounds-of-int
|   |-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|   |-- drivers-net-ethernet-broadcom-tg3.c:warning:array-subscript-is-above-array-bounds-of-struct-tg3_napi
|   |-- drivers-net-ethernet-mellanox-mlx4-alloc.c:warning:array-subscript-is-outside-array-bounds-of-long-unsigned-int
|   `-- include-asm-generic-unaligned.h:warning:array-subscript-is-outside-array-bounds-of-char
|-- riscv-defconfig
|   `-- drivers-base-arch_topology.c:warning:array-subscript-is-above-array-bounds-of-struct-cpu_topology
|-- s390-allmodconfig
|   |-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|   `-- include-linux-fortify-string.h:warning:array-subscript-is-outside-array-bounds-of-char
|-- s390-allyesconfig
|   `-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|-- s390-defconfig
|   |-- arch-s390-include-asm-ptrace.h:warning:array-subscript-is-outside-array-bounds-of-struct-psw_bits
|   |-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-int
|   |-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-long-long-unsigned-int
|   `-- include-linux-compiler_types.h:warning:array-subscript-is-outside-array-bounds-of-struct-dentry
|-- sh-allmodconfig
|   `-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|-- sparc-allyesconfig
|   `-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|-- sparc-randconfig-c043-20230531
|   `-- arch-sparc-kernel-irq_32.c:error:array-subscript-is-outside-array-bounds-of-struct-tt_entry
|-- sparc64-randconfig-c033-20230531
|   `-- arch-sparc-mm-init_64.c:error:array-subscript-is-outside-array-bounds-of-char
|-- sparc64-randconfig-r001-20230602
|   `-- arch-sparc-mm-init_64.c:error:array-subscript-is-outside-array-bounds-of-char
|-- x86_64-allyesconfig
|   `-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|-- x86_64-buildonly-randconfig-r003-20230531
|   |-- arch-x86-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-void
|   |-- drivers-mmc-host-sdhci-msm.c:warning:array-subscript-is-outside-array-bounds-of-const-bool-aka-const-_Bool
|   |-- drivers-soc-qcom-llcc-qcom.c:warning:array-subscript-is-outside-array-bounds-of-const-bool-aka-const-_Bool
|   |-- drivers-spi-spi-imx.c:warning:array-subscript-is-outside-array-bounds-of-const-bool-aka-const-_Bool
|   |-- fs-jffs2-nodelist.h:warning:array-subscript-union-jffs2_sum_mem-is-partly-outside-array-bounds-of-unsigned-char
|   `-- fs-jffs2-summary.c:warning:array-subscript-union-jffs2_sum_mem-is-partly-outside-array-bounds-of-unsigned-char
|-- x86_64-randconfig-s023-20230531
|   `-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
`-- x86_64-randconfig-s042-20230531
    `-- kernel-bpf-net_namespace.c:warning:array-subscript-is-outside-array-bounds-of-struct-bpf_prog

elapsed time: 884m

configs tested: 127
configs skipped: 5

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230531   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230602   gcc  
arc                  randconfig-r043-20230531   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                          collie_defconfig   clang
arm                                 defconfig   gcc  
arm                        multi_v5_defconfig   clang
arm                  randconfig-r021-20230531   gcc  
arm                  randconfig-r034-20230602   clang
arm                  randconfig-r046-20230531   gcc  
arm                             rpc_defconfig   gcc  
arm                           sama7_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230531   clang
csky         buildonly-randconfig-r002-20230531   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230602   gcc  
csky                 randconfig-r025-20230531   gcc  
hexagon              randconfig-r003-20230602   clang
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r001-20230531   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230531   gcc  
i386                 randconfig-i002-20230531   gcc  
i386                 randconfig-i003-20230531   gcc  
i386                 randconfig-i004-20230531   gcc  
i386                 randconfig-i005-20230531   gcc  
i386                 randconfig-i006-20230531   gcc  
i386                 randconfig-i011-20230601   gcc  
i386                 randconfig-i013-20230601   gcc  
i386                 randconfig-i014-20230601   gcc  
i386                 randconfig-i015-20230601   gcc  
i386                 randconfig-i016-20230601   gcc  
i386                 randconfig-i051-20230602   gcc  
i386                 randconfig-i052-20230602   gcc  
i386                 randconfig-i053-20230602   gcc  
i386                 randconfig-i054-20230602   gcc  
i386                 randconfig-i055-20230602   gcc  
i386                 randconfig-i056-20230602   gcc  
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i066-20230531   gcc  
i386                 randconfig-r004-20230602   gcc  
i386                 randconfig-r032-20230602   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r004-20230531   gcc  
m68k                                defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                     loongson2k_defconfig   clang
mips                        maltaup_defconfig   clang
mips                      pic32mzda_defconfig   clang
mips                          rm200_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230602   gcc  
nios2                randconfig-r026-20230531   gcc  
openrisc             randconfig-r031-20230602   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r035-20230602   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                       eiger_defconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                      mgcoge_defconfig   gcc  
powerpc                    mvme5100_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                      ppc44x_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc              randconfig-r015-20230602   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230531   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230531   clang
sh                               allmodconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r001-20230602   gcc  
sparc64              randconfig-r005-20230602   gcc  
sparc64              randconfig-r012-20230602   gcc  
sparc64              randconfig-r013-20230602   gcc  
sparc64              randconfig-r016-20230602   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r003-20230531   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x051-20230603   gcc  
x86_64               randconfig-x052-20230603   gcc  
x86_64               randconfig-x053-20230603   gcc  
x86_64               randconfig-x054-20230603   gcc  
x86_64               randconfig-x055-20230603   gcc  
x86_64               randconfig-x056-20230603   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r023-20230531   gcc  
xtensa               randconfig-r033-20230602   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
