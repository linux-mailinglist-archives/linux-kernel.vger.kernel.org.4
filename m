Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022A26DAA4E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbjDGIlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjDGIlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:41:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DB159ED
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 01:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680856903; x=1712392903;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UNEa1dT9y48mEHG9ymPJCX0NFlv5/xY5QKjvozKcDUo=;
  b=G9PIMHPur0Eci9DpTHH1V5pUqAoPuU6jgMDdC8N2BPp1ifvgTx5U0mD8
   mgRBViW0eeUhPCivZ3/kCpnr3RALLBZNlMS10dAnk2xACeXxvg0v3Dvsn
   qQPNVSYVjgnMQPD0vh9kcCqOv1Lqh/HJt2F6W+q3CAQyKQP4bVXbQExT2
   LJsgOwL/3NkaoQ92Txb1I/SBaAetgeXuXkkk/94WIJoQxrd7naYp+4l58
   fCrp32qiXt9KwxyPVasuygxb62NPTfm2i1OgiYo8hnwLMl947lLTPu2y1
   hVrJEWVdmks/u/DbWhrfQFUWM7nUtTKnikpmZI9+/qaJigP1aEzCbklqn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="341704087"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="341704087"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 01:41:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="933535404"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="933535404"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Apr 2023 01:41:41 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkhf5-000SHM-28;
        Fri, 07 Apr 2023 08:41:35 +0000
Date:   Fri, 07 Apr 2023 16:41:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fsfa3-next-20230406] BUILD SUCCESS WITH
 WARNING e9c955e0508a6086051a93cab74d062fb0400746
Message-ID: <642fd729.L2llolbJaCHWTKNs%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fsfa3-next-20230406
branch HEAD: e9c955e0508a6086051a93cab74d062fb0400746  Makefile: Enable -Wstringop-overflow and -Warray-bounds

Warning: (recently discovered and may have been fixed)

arch/ia64/kernel/mca.c:530:16: warning: array subscript -1 is outside array bounds of 'struct mca_table_entry[1152921504606846975]' [-Warray-bounds]
arch/ia64/kernel/unwind.c:2091:44: warning: array subscript -1 is outside array bounds of 'char[]' [-Warray-bounds]
drivers/gpu/drm/nouveau/nvif/outp.c:140:9: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
drivers/infiniband/hw/bnxt_re/qplib_sp.c:229:29: warning: array subscript 0 is outside array bounds of 'struct bnxt_qplib_sgid_tbl[230584300921369395]' [-Warray-bounds]
drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c:167:31: warning: array subscript 4 is above array bounds of 'const struct sparx5_psfp_gce[4]' [-Warray-bounds]
drivers/platform/chrome/cros_ec_vbc.c:36:15: warning: array subscript 'struct ec_params_vbnvcontext[1]' is partly outside array bounds of 'unsigned char[36]' [-Warray-bounds]
drivers/staging/rtl8712/rtl871x_xmit.c:949:40: warning: array subscript 4 is outside array bounds of 'void[256]' [-Warray-bounds]
drivers/staging/rtl8712/rtl871x_xmit.c:949:40: warning: array subscript 4 is outside array bounds of 'void[448]' [-Warray-bounds]
include/linux/fortify-string.h:59:33: warning: '__builtin_memset' specified bound 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Wstringop-overflow=]
include/net/xfrm.h:1362:19: warning: array subscript 'xfrm_address_t[0]' is partly outside array bounds of '__be32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]

Unverified Warning (likely false positive, please contact us if interested):

arch/m68k/include/asm/string.h:52:25: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-randconfig-s052-20230404
|   `-- include-net-xfrm.h:warning:array-subscript-xfrm_address_t-is-partly-outside-array-bounds-of-__be32-aka-unsigned-int
|-- ia64-allyesconfig
|   |-- arch-ia64-kernel-mca.c:warning:array-subscript-is-outside-array-bounds-of-struct-mca_table_entry
|   |-- arch-ia64-kernel-unwind.c:warning:array-subscript-is-outside-array-bounds-of-char
|   |-- drivers-gpu-drm-nouveau-nvif-outp.c:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|   |-- drivers-infiniband-hw-bnxt_re-qplib_sp.c:warning:array-subscript-is-outside-array-bounds-of-struct-bnxt_qplib_sgid_tbl
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   |-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|   `-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- loongarch-allmodconfig
|   |-- drivers-infiniband-hw-bnxt_re-qplib_sp.c:warning:array-subscript-is-outside-array-bounds-of-struct-bnxt_qplib_sgid_tbl
|   |-- drivers-net-ethernet-microchip-sparx5-sparx5_psfp.c:warning:array-subscript-is-above-array-bounds-of-const-struct-sparx5_psfp_gce
|   |-- drivers-platform-chrome-cros_ec_vbc.c:warning:array-subscript-struct-ec_params_vbnvcontext-is-partly-outside-array-bounds-of-unsigned-char
|   `-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- m68k-randconfig-s043-20230403
|   `-- arch-m68k-include-asm-string.h:warning:array-subscript-unsigned-char-is-partly-outside-array-bounds-of-u8-aka-unsigned-char
|-- s390-randconfig-c031-20230403
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-specified-bound-exceeds-maximum-object-size
`-- sparc64-randconfig-r005-20230403
    `-- include-net-xfrm.h:warning:array-subscript-xfrm_address_t-is-partly-outside-array-bounds-of-__be32-aka-unsigned-int

elapsed time: 905m

configs tested: 123
configs skipped: 4

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230403   gcc  
arc                  randconfig-r022-20230403   gcc  
arc                  randconfig-r023-20230406   gcc  
arc                  randconfig-r026-20230406   gcc  
arc                  randconfig-r043-20230404   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                  randconfig-r025-20230403   clang
arm                  randconfig-r046-20230404   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230403   clang
arm64                randconfig-r035-20230403   clang
csky                                defconfig   gcc  
hexagon              randconfig-r015-20230406   clang
hexagon              randconfig-r041-20230404   clang
hexagon              randconfig-r045-20230404   clang
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
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                 randconfig-r021-20230403   gcc  
i386                 randconfig-r023-20230403   gcc  
ia64                             allmodconfig   gcc  
ia64                             allyesconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r006-20230403   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r024-20230403   gcc  
microblaze   buildonly-randconfig-r005-20230403   gcc  
microblaze                      mmu_defconfig   gcc  
microblaze           randconfig-r012-20230406   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230403   gcc  
mips                 randconfig-r014-20230406   gcc  
mips                 randconfig-r024-20230406   gcc  
mips                          rm200_defconfig   clang
nios2        buildonly-randconfig-r004-20230403   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r013-20230406   gcc  
nios2                randconfig-r032-20230403   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r012-20230403   gcc  
parisc       buildonly-randconfig-r003-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230403   gcc  
parisc               randconfig-r013-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r036-20230403   clang
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230403   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r016-20230403   gcc  
riscv                randconfig-r042-20230404   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230404   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230403   gcc  
sh                   randconfig-r011-20230406   gcc  
sh                   randconfig-r015-20230403   gcc  
sh                   randconfig-r016-20230406   gcc  
sh                   randconfig-r021-20230406   gcc  
sh                   randconfig-r034-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230403   gcc  
sparc64      buildonly-randconfig-r006-20230403   gcc  
sparc64              randconfig-r005-20230403   gcc  
sparc64              randconfig-r031-20230403   gcc  
sparc64              randconfig-r033-20230403   gcc  
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
x86_64                        randconfig-a004   gcc  
x86_64               randconfig-a005-20230403   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230403   clang
x86_64                        randconfig-a006   gcc  
x86_64               randconfig-a011-20230403   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64               randconfig-r001-20230403   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r025-20230406   gcc  
xtensa               randconfig-r026-20230403   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
