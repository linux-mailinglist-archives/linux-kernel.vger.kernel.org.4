Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C41A7410D8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjF1MWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:22:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:63468 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbjF1MWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687954962; x=1719490962;
  h=date:from:to:cc:subject:message-id;
  bh=u/fCpMxmLYcZwj8E97tLzCLUp6WVk/Q6Ei+BiQ6fO3c=;
  b=JtSFqz+KhyhTGvNx1ByTEdfEB1iCmkGAnglKe3GE8n53oIaH7bH8FQjO
   aITB0pLiMEdldyBT+s6aPV2cTVsZA7qZ3DO9FNV6htWlER/qUrfeNKSx3
   24D053FcHWQKJLRjfj0SEA3SCVIkmt0SxHAqg653UnuF/WfJ3ALdbJ5PS
   HmzvNGevYBb9z2u5uSca+IfaudXXlmrh5JaJcv51dLHRX1CiLeZNhtxR5
   UzQ8p2AYL9906N3+GV06McjnORzh4Ea2XQAwMJmiRL3M3eb3lv7u+pZuP
   O9x/GIzusoR6vPtzD7OGEdGbNOffqckA0Xz1HCP2syxJgQvbZGDN3dOYi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="392552341"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="392552341"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 05:22:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="787028438"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="787028438"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2023 05:22:40 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEUC0-000DFV-0J;
        Wed, 28 Jun 2023 12:22:40 +0000
Date:   Wed, 28 Jun 2023 20:22:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230627] BUILD SUCCESS WITH
 WARNING 2ebb702f25c4764fb36ab29f4f40728e12b0e42b
Message-ID: <202306282018.A5SDYtCO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230627
branch HEAD: 2ebb702f25c4764fb36ab29f4f40728e12b0e42b  scsi: aacraid: Replace one-element array with flexible-array member in struct user_sgmap

Warning: (recently discovered and may have been fixed)

arch/loongarch/include/asm/atomic.h:174:9: warning: array subscript 1 is outside array bounds of 'struct cpumask[1]' [-Warray-bounds]
arch/mips/include/asm/io.h:272:23: warning: array subscript -1 is outside array bounds of 'char[]' [-Warray-bounds]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c:427:17: warning: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c:535:17: warning: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c:472:25: warning: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]
drivers/media/dvb-frontends/cxd2880/cxd2880_devio_spi.c:95:17: warning: 'memcpy' writing 255 bytes into a region of size 129 [-Wstringop-overflow=]
fs/crypto/fname.c:506:33: warning: array subscript 'struct fscrypt_nokey_name[0]' is partly outside array bounds of 'unsigned char[189]' [-Warray-bounds]
include/net/xfrm.h:1363:19: warning: array subscript 'xfrm_address_t[0]' is partly outside array bounds of '__be32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-randconfig-r046-20230627
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_training_dpia.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_training_fixed_vs_pe_retimer.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
|   `-- fs-crypto-fname.c:warning:array-subscript-struct-fscrypt_nokey_name-is-partly-outside-array-bounds-of-unsigned-char
|-- loongarch-allmodconfig
|   `-- arch-loongarch-include-asm-atomic.h:warning:array-subscript-is-outside-array-bounds-of-struct-cpumask
|-- microblaze-randconfig-r004-20230627
|   |-- drivers-media-dvb-frontends-cxd2880-cxd2880_devio_spi.c:warning:memcpy-writing-bytes-into-a-region-of-size
|   `-- include-net-xfrm.h:warning:array-subscript-xfrm_address_t-is-partly-outside-array-bounds-of-__be32-aka-unsigned-int
|-- mips-randconfig-r011-20230627
|   `-- arch-mips-include-asm-io.h:warning:array-subscript-is-outside-array-bounds-of-char
`-- x86_64-buildonly-randconfig-r001-20230627
    |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_training_dpia.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size
    `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_training_fixed_vs_pe_retimer.c:warning:dp_decide_lane_settings-accessing-bytes-in-a-region-of-size

elapsed time: 723m

configs tested: 123
configs skipped: 7

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230627   gcc  
alpha                randconfig-r022-20230627   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230627   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r021-20230627   gcc  
arm                  randconfig-r031-20230627   clang
arm                  randconfig-r035-20230627   clang
arm                  randconfig-r046-20230627   gcc  
arm                        spear3xx_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230627   clang
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r002-20230627   clang
hexagon              randconfig-r041-20230627   clang
hexagon              randconfig-r045-20230627   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230627   gcc  
i386         buildonly-randconfig-r005-20230627   gcc  
i386         buildonly-randconfig-r006-20230627   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230627   gcc  
i386                 randconfig-i002-20230627   gcc  
i386                 randconfig-i003-20230627   gcc  
i386                 randconfig-i004-20230627   gcc  
i386                 randconfig-i005-20230627   gcc  
i386                 randconfig-i006-20230627   gcc  
i386                 randconfig-i011-20230627   clang
i386                 randconfig-i012-20230627   clang
i386                 randconfig-i013-20230627   clang
i386                 randconfig-i014-20230627   clang
i386                 randconfig-i015-20230627   clang
i386                 randconfig-i016-20230627   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r032-20230627   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r015-20230627   gcc  
m68k                           virt_defconfig   gcc  
microblaze           randconfig-r003-20230627   gcc  
microblaze           randconfig-r004-20230627   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                           mtx1_defconfig   clang
mips                 randconfig-r011-20230627   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r025-20230627   gcc  
openrisc                         alldefconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                      katmai_defconfig   clang
powerpc                      mgcoge_defconfig   gcc  
powerpc                   microwatt_defconfig   clang
powerpc              randconfig-r024-20230627   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230627   clang
riscv                randconfig-r026-20230627   clang
riscv                randconfig-r042-20230627   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230627   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r006-20230627   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r023-20230627   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r001-20230627   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230627   gcc  
x86_64       buildonly-randconfig-r002-20230627   gcc  
x86_64       buildonly-randconfig-r003-20230627   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230627   clang
x86_64               randconfig-x002-20230627   clang
x86_64               randconfig-x003-20230627   clang
x86_64               randconfig-x004-20230627   clang
x86_64               randconfig-x005-20230627   clang
x86_64               randconfig-x006-20230627   clang
x86_64               randconfig-x011-20230627   gcc  
x86_64               randconfig-x012-20230627   gcc  
x86_64               randconfig-x013-20230627   gcc  
x86_64               randconfig-x014-20230627   gcc  
x86_64               randconfig-x015-20230627   gcc  
x86_64               randconfig-x016-20230627   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
