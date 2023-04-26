Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD096EF65E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241376AbjDZO0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240591AbjDZO0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:26:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B036E8F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682519202; x=1714055202;
  h=date:from:to:cc:subject:message-id;
  bh=cQmJrCFb7AoMZZ/xOghRkCrYz3wPWhERHZi9yEZVoRY=;
  b=PzxLheoJea6yvmYgPMpgYaB99cMX425dpnYAIjgdpanmI5tnwCQOyCeh
   JiUP+3gzdxgAsHW+1MPfDe21r74EnGaTa1Jb/VV7R/DRbtLQup6J6XgU2
   ef+K1h8GMEVqFg9B8IJec1Q2mhU1xEkCEXQ4G/+OhzyCm4k7FEodcgr4V
   47bnp8jJhNGyhD729dUqJmkdGwkYNJrKrjPXlRlGx1cTRaH1kESjS/GJf
   llCzYPoAt0/bGUXcTzkDlYr8V2ipdju0DETvCPOs49sRPf2hindvM3dhh
   JyYX+0OD/qJW7K8DLUtZJ4q0n6ZHA2tSmcmH0W0S0ifCbbS6DlHwHNEqt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="331346879"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="331346879"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 07:26:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="724456433"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="724456433"
Received: from lkp-server01.sh.intel.com (HELO 041f065c1b1b) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Apr 2023 07:26:40 -0700
Received: from kbuild by 041f065c1b1b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prg6R-0000Ha-2H;
        Wed, 26 Apr 2023 14:26:39 +0000
Date:   Wed, 26 Apr 2023 22:25:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fsfa3-next-20230425] BUILD SUCCESS WITH
 WARNING b82a35ff486df1d6737f532e08e060c466f9e652
Message-ID: <20230426142545.kRUS5%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fsfa3-next-20230425
branch HEAD: b82a35ff486df1d6737f532e08e060c466f9e652  Makefile: Enable -Wstringop-overflow and -Warray-bounds

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202304260539.vm2qQLzo-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304260540.8xVWxKhO-lkp@intel.com

Warning: (recently discovered and may have been fixed)

arch/alpha/include/asm/string.h:22:16: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
arch/s390/include/asm/ptrace.h:69:26: warning: array subscript 0 is outside array bounds of 'struct psw_bits[0]' [-Warray-bounds]
arch/sparc/include/asm/string.h:15:25: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
drivers/base/arch_topology.c:734:67: warning: array subscript 4 is above array bounds of 'struct cpu_topology[4]' [-Warray-bounds]
drivers/base/arch_topology.c:734:67: warning: array subscript 64 is above array bounds of 'struct cpu_topology[64]' [-Warray-bounds]
drivers/cpufreq/brcmstb-avs-cpufreq.c:449:28: warning: array subscript 5 is outside array bounds of 'void[60]' [-Warray-bounds]
drivers/dma/sh/rcar-dmac.c:914:36: warning: array subscript 4294967295 is above array bounds of 'const u32[7]' {aka 'const unsigned int[7]'} [-Warray-bounds]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c:535:17: warning: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c:472:25: warning: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]
drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c:199:24: warning: array subscript [0, 63] is outside array bounds of 'struct komeda_component_output[5]' [-Warray-bounds]
drivers/gpu/drm/nouveau/nvif/outp.c:140:9: warning: array subscript '__int128 unsigned[0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
drivers/gpu/drm/nouveau/nvif/outp.c:140:9: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
drivers/hwmon/pc87360.c:341:49: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
drivers/media/dvb-frontends/cxd2880/cxd2880_devio_spi.c:95:17: warning: 'memcpy' writing 255 bytes into a region of size 129 [-Wstringop-overflow=]
drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c:167:31: warning: array subscript 4 is above array bounds of 'const struct sparx5_psfp_gce[4]' [-Warray-bounds]
drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2743:30: warning: array subscript 'struct iwl_wowlan_info_notif[0]' is partly outside array bounds of 'unsigned char[612]' [-Warray-bounds]
fs/cifs/cifssmb.c:2987:31: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
fs/jffs2/nodelist.h:43:28: warning: array subscript 'union jffs2_sum_mem[0]' is partly outside array bounds of 'unsigned char[22]' [-Warray-bounds]
fs/jffs2/summary.c:79:73: warning: array subscript 'union jffs2_sum_mem[0]' is partly outside array bounds of 'unsigned char[22]' [-Warray-bounds]
include/asm-generic/percpu.h:21:44: warning: array subscript 4 is above array bounds of 'long unsigned int[4]' [-Warray-bounds]
include/asm-generic/percpu.h:21:44: warning: array subscript [0, 31] is outside array bounds of 'long unsigned int[32]' [-Warray-bounds]
include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile long long unsigned int[0]' [-Warray-bounds]
include/asm-generic/unaligned.h:14:15: warning: array subscript -1 is outside array bounds of 'char[]' [-Warray-bounds]
include/linux/compiler_types.h:332:20: warning: array subscript 0 is outside array bounds of 'struct dentry[0]' [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified bound between 2147483648 and 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
include/linux/fortify-string.h:57:33: warning: array subscript '__int128 unsigned[0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]
kernel/bpf/net_namespace.c:437:27: warning: array subscript [0, 1] is outside array bounds of 'struct bpf_prog *[2]' [-Warray-bounds]
kernel/cgroup/cgroup.c:1222:16: warning: 'find_existing_css_set' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
kernel/cgroup/cgroup.c:1272:15: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- arch-alpha-include-asm-string.h:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|   `-- drivers-hwmon-pc87360.c:warning:writing-byte-into-a-region-of-size
|-- alpha-randconfig-r013-20230424
|   `-- arch-alpha-include-asm-string.h:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|-- alpha-randconfig-r035-20230424
|   `-- arch-alpha-include-asm-string.h:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|-- arc-randconfig-r043-20230424
|   `-- include-asm-generic-percpu.h:warning:array-subscript-is-above-array-bounds-of-long-unsigned-int
|-- arm-allmodconfig
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   |-- drivers-dma-sh-rcar-dmac.c:warning:array-subscript-is-above-array-bounds-of-const-u32-aka-const-unsigned-int
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|-- arm-allyesconfig
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|-- arm-defconfig
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   |-- drivers-gpu-drm-nouveau-nvif-outp.c:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|   |-- kernel-cgroup-cgroup.c:warning:css_set_hash-accessing-bytes-in-a-region-of-size
|   `-- kernel-cgroup-cgroup.c:warning:find_existing_css_set-accessing-bytes-in-a-region-of-size
|-- arm-randconfig-c024-20230423
|   `-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- arm-randconfig-r046-20230423
|   `-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- arm-wpcm450_defconfig
|   |-- kernel-cgroup-cgroup.c:warning:css_set_hash-accessing-bytes-in-a-region-of-size
|   `-- kernel-cgroup-cgroup.c:warning:find_existing_css_set-accessing-bytes-in-a-region-of-size
|-- arm64-allyesconfig
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   |-- drivers-gpu-drm-arm-display-komeda-komeda_pipeline_state.c:warning:array-subscript-is-outside-array-bounds-of-struct-komeda_component_output
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-d3.c:warning:array-subscript-struct-iwl_wowlan_info_notif-is-partly-outside-array-bounds-of-unsigned-char
|   |-- include-asm-generic-unaligned.h:warning:array-subscript-is-outside-array-bounds-of-char
|   |-- include-linux-fortify-string.h:warning:array-subscript-__int128-unsigned-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- arm64-defconfig
|   |-- drivers-cpufreq-brcmstb-avs-cpufreq.c:warning:array-subscript-is-outside-array-bounds-of-void
|   `-- drivers-gpu-drm-nouveau-nvif-outp.c:warning:array-subscript-__int128-unsigned-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|-- csky-buildonly-randconfig-r005-20230424
|   `-- drivers-media-dvb-frontends-cxd2880-cxd2880_devio_spi.c:warning:memcpy-writing-bytes-into-a-region-of-size
|-- csky-buildonly-randconfig-r006-20230424
|   |-- drivers-gpu-drm-nouveau-nvif-outp.c:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|   |-- fs-jffs2-nodelist.h:warning:array-subscript-union-jffs2_sum_mem-is-partly-outside-array-bounds-of-unsigned-char
|   `-- fs-jffs2-summary.c:warning:array-subscript-union-jffs2_sum_mem-is-partly-outside-array-bounds-of-unsigned-char
|-- i386-allyesconfig
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|-- i386-debian-10.3
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|-- i386-randconfig-a014-20230424
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|-- i386-randconfig-s002
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|-- loongarch-allmodconfig
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-d3.c:warning:array-subscript-struct-iwl_wowlan_info_notif-is-partly-outside-array-bounds-of-unsigned-char
|   `-- include-asm-generic-unaligned.h:warning:array-subscript-is-outside-array-bounds-of-char
|-- loongarch-buildonly-randconfig-r005-20230423
|   `-- include-asm-generic-unaligned.h:warning:array-subscript-is-outside-array-bounds-of-char
|-- loongarch-defconfig
|   `-- include-asm-generic-unaligned.h:warning:array-subscript-is-outside-array-bounds-of-char
|-- microblaze-randconfig-r002-20230424
|   `-- kernel-bpf-net_namespace.c:warning:array-subscript-is-outside-array-bounds-of-struct-bpf_prog
|-- mips-allmodconfig
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-d3.c:warning:array-subscript-struct-iwl_wowlan_info_notif-is-partly-outside-array-bounds-of-unsigned-char
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|   `-- include-linux-fortify-string.h:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|-- mips-allyesconfig
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|-- openrisc-randconfig-r001-20230423
|   `-- drivers-gpu-drm-nouveau-nvif-outp.c:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|-- parisc-defconfig
|   |-- kernel-cgroup-cgroup.c:warning:css_set_hash-accessing-bytes-in-a-region-of-size
|   `-- kernel-cgroup-cgroup.c:warning:find_existing_css_set-accessing-bytes-in-a-region-of-size
|-- parisc-randconfig-c041-20230423
|   `-- drivers-base-arch_topology.c:warning:array-subscript-is-above-array-bounds-of-struct-cpu_topology
|-- powerpc-allmodconfig
|   |-- include-asm-generic-percpu.h:warning:array-subscript-is-outside-array-bounds-of-long-unsigned-int
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|-- riscv-allmodconfig
|   `-- include-asm-generic-unaligned.h:warning:array-subscript-is-outside-array-bounds-of-char
|-- riscv-defconfig
|   |-- drivers-base-arch_topology.c:warning:array-subscript-is-above-array-bounds-of-struct-cpu_topology
|   `-- drivers-gpu-drm-nouveau-nvif-outp.c:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|-- riscv-rv32_defconfig
|   `-- drivers-gpu-drm-nouveau-nvif-outp.c:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|-- s390-allmodconfig
|   |-- arch-s390-include-asm-ptrace.h:warning:array-subscript-is-outside-array-bounds-of-struct-psw_bits
|   |-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-int
|   |-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-long-long-unsigned-int
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- s390-allyesconfig
|   |-- arch-s390-include-asm-ptrace.h:warning:array-subscript-is-outside-array-bounds-of-struct-psw_bits
|   |-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-int
|   |-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-long-long-unsigned-int
|   |-- include-linux-fortify-string.h:warning:array-subscript-__int128-unsigned-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- s390-defconfig
|   |-- arch-s390-include-asm-ptrace.h:warning:array-subscript-is-outside-array-bounds-of-struct-psw_bits
|   |-- fs-cifs-cifssmb.c:warning:writing-byte-into-a-region-of-size
|   |-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-int
|   |-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-long-long-unsigned-int
|   `-- include-linux-compiler_types.h:warning:array-subscript-is-outside-array-bounds-of-struct-dentry
|-- s390-randconfig-c031-20230423
|   |-- arch-s390-include-asm-ptrace.h:warning:array-subscript-is-outside-array-bounds-of-struct-psw_bits
|   |-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-int
|   `-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-long-long-unsigned-int
|-- s390-randconfig-c44-20230423
|   |-- arch-s390-include-asm-ptrace.h:warning:array-subscript-is-outside-array-bounds-of-struct-psw_bits
|   |-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-int
|   `-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-long-long-unsigned-int
|-- s390-randconfig-r044-20230424
|   |-- arch-s390-include-asm-ptrace.h:warning:array-subscript-is-outside-array-bounds-of-struct-psw_bits
|   |-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-int
|   |-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-long-long-unsigned-int
|   `-- include-linux-fortify-string.h:warning:array-subscript-__int128-unsigned-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|-- s390-randconfig-s051-20230423
|   |-- arch-s390-include-asm-ptrace.h:warning:array-subscript-is-outside-array-bounds-of-struct-psw_bits
|   |-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-int
|   `-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-long-long-unsigned-int
|-- s390-randconfig-s052-20230423
|   |-- arch-s390-include-asm-ptrace.h:warning:array-subscript-is-outside-array-bounds-of-struct-psw_bits
|   |-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-int
|   `-- include-asm-generic-rwonce.h:warning:array-subscript-is-outside-array-bounds-of-const-volatile-long-long-unsigned-int
|-- sh-allmodconfig
|   `-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|-- sparc64-randconfig-r035-20230423
|   `-- arch-sparc-include-asm-string.h:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
`-- xtensa-randconfig-r002-20230423
    |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_training_dpia.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
    `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_training_fixed_vs_pe_retimer.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size

elapsed time: 1168m

configs tested: 143
configs skipped: 6

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230424   gcc  
alpha                randconfig-r031-20230424   gcc  
alpha                randconfig-r035-20230424   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230423   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230424   gcc  
arc                  randconfig-r016-20230424   gcc  
arc                  randconfig-r043-20230423   gcc  
arc                  randconfig-r043-20230424   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r004-20230424   clang
arm                                 defconfig   gcc  
arm                  randconfig-r023-20230425   gcc  
arm                  randconfig-r046-20230423   gcc  
arm                  randconfig-r046-20230424   clang
arm                         wpcm450_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r015-20230423   clang
csky         buildonly-randconfig-r005-20230424   gcc  
csky         buildonly-randconfig-r006-20230424   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r021-20230425   gcc  
hexagon      buildonly-randconfig-r004-20230423   clang
hexagon              randconfig-r003-20230423   clang
hexagon              randconfig-r006-20230424   clang
hexagon              randconfig-r041-20230423   clang
hexagon              randconfig-r041-20230424   clang
hexagon              randconfig-r045-20230423   clang
hexagon              randconfig-r045-20230424   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230424   clang
i386                 randconfig-a002-20230424   clang
i386                 randconfig-a003-20230424   clang
i386                 randconfig-a004-20230424   clang
i386                 randconfig-a005-20230424   clang
i386                 randconfig-a006-20230424   clang
i386                 randconfig-a011-20230424   gcc  
i386                 randconfig-a012-20230424   gcc  
i386                 randconfig-a013-20230424   gcc  
i386                 randconfig-a014-20230424   gcc  
i386                 randconfig-a015-20230424   gcc  
i386                 randconfig-a016-20230424   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230424   gcc  
ia64                 randconfig-r005-20230423   gcc  
ia64                 randconfig-r014-20230423   gcc  
ia64                 randconfig-r026-20230425   gcc  
ia64                 randconfig-r032-20230423   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230423   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r033-20230424   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230423   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230423   gcc  
m68k                 randconfig-r032-20230424   gcc  
microblaze   buildonly-randconfig-r002-20230424   gcc  
microblaze           randconfig-r002-20230424   gcc  
microblaze           randconfig-r011-20230423   gcc  
microblaze           randconfig-r011-20230424   gcc  
microblaze           randconfig-r015-20230424   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                           ip27_defconfig   clang
mips                      pic32mzda_defconfig   clang
mips                 randconfig-r005-20230424   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230423   gcc  
openrisc     buildonly-randconfig-r003-20230423   gcc  
openrisc     buildonly-randconfig-r003-20230424   gcc  
openrisc             randconfig-r001-20230423   gcc  
openrisc             randconfig-r006-20230423   gcc  
parisc                           alldefconfig   gcc  
parisc       buildonly-randconfig-r002-20230423   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230423   gcc  
parisc               randconfig-r025-20230425   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc                      ppc64e_defconfig   clang
powerpc                     taishan_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r036-20230424   clang
riscv                randconfig-r042-20230423   clang
riscv                randconfig-r042-20230424   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230424   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230423   clang
s390                 randconfig-r044-20230424   gcc  
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                   randconfig-r012-20230424   gcc  
sh                           se7619_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230425   gcc  
sparc                randconfig-r036-20230423   gcc  
sparc64              randconfig-r013-20230423   gcc  
sparc64              randconfig-r034-20230424   gcc  
sparc64              randconfig-r035-20230423   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230424   clang
x86_64               randconfig-a002-20230424   clang
x86_64               randconfig-a003-20230424   clang
x86_64               randconfig-a004-20230424   clang
x86_64               randconfig-a005-20230424   clang
x86_64               randconfig-a006-20230424   clang
x86_64               randconfig-a011-20230424   gcc  
x86_64               randconfig-a012-20230424   gcc  
x86_64               randconfig-a013-20230424   gcc  
x86_64               randconfig-a014-20230424   gcc  
x86_64               randconfig-a015-20230424   gcc  
x86_64               randconfig-a016-20230424   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r002-20230423   gcc  
xtensa               randconfig-r003-20230424   gcc  
xtensa               randconfig-r024-20230425   gcc  
xtensa               randconfig-r033-20230423   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
