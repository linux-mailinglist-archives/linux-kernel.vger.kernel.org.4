Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7632733F1B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345821AbjFQHTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345712AbjFQHTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:19:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7F2211D
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686986363; x=1718522363;
  h=date:from:to:cc:subject:message-id;
  bh=oLS3Myx+XxcFjajE1DF2QIEEe+0LhQI5Eu7TxnLnRmY=;
  b=RpXwm6KJBUdGiaLt7IKHFcIPEkttl+ASiVwhG2aFF1zyRxvzM/1sHwpU
   HOWV21LdGbxRR0hQpIWLj9dZ7XKC9VuUvFO9Cn1hHnlFCszJcItM9X73B
   gPVER6D8G7bpZtVNe1J6jDXlcUjFlTUU0p4+v3DqJNDU9Xipu5b4PWw47
   Xj4QRB4JkgVyCun26ECc9BSZ1jeY6aMaGju1X7+uf/ofk8i75kKcasSzV
   IBeGsCjoGeJCQOvrSk4mznGueifBZp+J0iCibOiJ26T9TLvNLWpanpYXT
   mW2mm3U4eunewdAzqiG7jArYw5I+Q7BlmWW6xK9I3k25PQg0LEYqyAq62
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="445749521"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="445749521"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2023 00:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="1043333250"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="1043333250"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jun 2023 00:19:21 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qAQDQ-0002R2-1k;
        Sat, 17 Jun 2023 07:19:20 +0000
Date:   Sat, 17 Jun 2023 15:18:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230616] BUILD SUCCESS WITH
 WARNING fb66cc379b22acff289e4ece14b7b84b3cc9453c
Message-ID: <202306171538.bnQjyl5T-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230616
branch HEAD: fb66cc379b22acff289e4ece14b7b84b3cc9453c  wifi: wext-core: Fix -Wstringop-overflow warning in ioctl_standard_iw_point()

Warning: (recently discovered and may have been fixed)

arch/parisc/mm/init.c:285:46: warning: array subscript -1074790400 is outside array bounds of 'char[]' [-Warray-bounds]
drivers/gpu/drm/nouveau/dispnv04/dac.c:432:39: warning: array subscript -1 is below array bounds of 'uint32_t[4]' {aka 'unsigned int[4]'} [-Warray-bounds]
drivers/hwmon/pc87360.c:341:49: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
drivers/isdn/hardware/mISDN/hfcsusb.c:1218:47: warning: array subscript [0, 31] is outside array bounds of 'int[8]' [-Warray-bounds]
drivers/net/ethernet/mellanox/mlx4/alloc.c:761:37: warning: array subscript [0, 31] is outside array bounds of 'long unsigned int *[2]' [-Warray-bounds]
include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified bound between 2147483648 and 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|-- arm-allyesconfig
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|-- arm-randconfig-r003-20230616
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
`-- parisc64-allyesconfig
    |-- arch-parisc-mm-init.c:warning:array-subscript-is-outside-array-bounds-of-char
    |-- drivers-gpu-drm-nouveau-dispnv04-dac.c:warning:array-subscript-is-below-array-bounds-of-uint32_t-aka-unsigned-int
    |-- drivers-hwmon-pc87360.c:warning:writing-byte-into-a-region-of-size
    |-- drivers-isdn-hardware-mISDN-hfcsusb.c:warning:array-subscript-is-outside-array-bounds-of-int
    `-- drivers-net-ethernet-mellanox-mlx4-alloc.c:warning:array-subscript-is-outside-array-bounds-of-long-unsigned-int

elapsed time: 720m

configs tested: 102
configs skipped: 5

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230616   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                  randconfig-r043-20230617   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                        mvebu_v5_defconfig   clang
arm                  randconfig-r003-20230616   gcc  
arm                  randconfig-r034-20230616   gcc  
arm                  randconfig-r046-20230617   gcc  
arm                           sama7_defconfig   clang
arm                         wpcm450_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230616   gcc  
arm64                randconfig-r033-20230616   clang
csky                                defconfig   gcc  
csky                 randconfig-r014-20230616   gcc  
hexagon              randconfig-r012-20230616   clang
hexagon              randconfig-r036-20230616   clang
hexagon              randconfig-r041-20230617   clang
hexagon              randconfig-r045-20230617   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230616   clang
i386                 randconfig-i002-20230616   clang
i386                 randconfig-i003-20230616   clang
i386                 randconfig-i004-20230616   clang
i386                 randconfig-i005-20230616   clang
i386                 randconfig-i006-20230616   clang
i386                 randconfig-i011-20230616   gcc  
i386                 randconfig-i012-20230616   gcc  
i386                 randconfig-i013-20230616   gcc  
i386                 randconfig-i014-20230616   gcc  
i386                 randconfig-i015-20230616   gcc  
i386                 randconfig-i016-20230616   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230616   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r025-20230616   gcc  
openrisc             randconfig-r011-20230616   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230616   gcc  
parisc               randconfig-r031-20230616   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                 mpc836x_rdk_defconfig   clang
powerpc              randconfig-r002-20230616   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230617   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230616   clang
s390                 randconfig-r021-20230616   gcc  
s390                 randconfig-r022-20230616   gcc  
s390                 randconfig-r044-20230617   clang
sh                               allmodconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r035-20230616   gcc  
sh                             sh03_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r016-20230616   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r032-20230616   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a011-20230616   gcc  
x86_64               randconfig-a012-20230616   gcc  
x86_64               randconfig-a013-20230616   gcc  
x86_64               randconfig-a014-20230616   gcc  
x86_64               randconfig-a015-20230616   gcc  
x86_64               randconfig-a016-20230616   gcc  
x86_64               randconfig-r004-20230616   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
