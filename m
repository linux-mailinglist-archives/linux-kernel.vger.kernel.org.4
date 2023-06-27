Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6CD73F03E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 03:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjF0BRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 21:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjF0BRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 21:17:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679C5173A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 18:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687828660; x=1719364660;
  h=date:from:to:cc:subject:message-id;
  bh=v3GTdvmwcsLVC3N6+L8X4g8hyaR0pYUvTpG/edSE+D8=;
  b=PynHW6zhX1B6bhGNhdKOtgXd+MjOMIImw0TcGHBo1zP7awBnSBbva3Ui
   kdYelWvkXPn2dVtIYlnqRFUt1/cEgAJG2oO80JuHcLZrCPiZ5d+X0KsqV
   jdK1NG4rnAWpbUcrOc1OfOn+jrip87JwIYcya2c2l6OBlr5G9eoMDtj8z
   pv4vb60RUI0AEbFuhF56h34EohJGVvZVjmi7xeKb6EvSSDz/5ZasFdrH7
   Tf5g1HbleuDeEkXVACD5kwfWEZCudo93+UUcu/Z5fi5+QmKiw8Anr6Y6P
   uufU0NNZwmgpkLWw5xjmxJrNQYBXDMfkyqi0coHQ4fJls3OMgdnHotbn5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="360301972"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="360301972"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="746027496"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="746027496"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2023 18:17:38 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDxKr-000BIo-2V;
        Tue, 27 Jun 2023 01:17:37 +0000
Date:   Tue, 27 Jun 2023 09:17:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230620] BUILD REGRESSION
 f88731de11436a7eaa371fd5179e5daf0446316f
Message-ID: <202306270908.MNgeCq9L-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230620
branch HEAD: f88731de11436a7eaa371fd5179e5daf0446316f  readdir: Replace one-element arrays with flexible-array members

Error/Warning: (recently discovered and may have been fixed)

arch/m68k/include/asm/io_no.h:17:11: warning: array subscript 0 is outside array bounds of 'volatile u8[0]' {aka 'volatile unsigned char[]'} [-Warray-bounds]
arch/sparc/mm/init_64.c:3057:31: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- m68k-randconfig-r034-20230620
|   `-- arch-m68k-include-asm-io_no.h:warning:array-subscript-is-outside-array-bounds-of-volatile-u8-aka-volatile-unsigned-char
`-- sparc-allyesconfig
    `-- arch-sparc-mm-init_64.c:error:array-subscript-is-outside-array-bounds-of-char

elapsed time: 9058m

configs tested: 106
configs skipped: 6

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230620   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                  randconfig-r024-20230620   gcc  
arc                  randconfig-r043-20230620   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          moxart_defconfig   clang
arm                  randconfig-r036-20230620   gcc  
arm                  randconfig-r046-20230620   clang
arm                         wpcm450_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r003-20230620   clang
hexagon              randconfig-r016-20230620   clang
hexagon              randconfig-r041-20230620   clang
hexagon              randconfig-r045-20230620   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230620   clang
i386         buildonly-randconfig-r005-20230620   clang
i386         buildonly-randconfig-r006-20230620   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230620   clang
i386                 randconfig-i002-20230620   clang
i386                 randconfig-i003-20230620   clang
i386                 randconfig-i004-20230620   clang
i386                 randconfig-i005-20230620   clang
i386                 randconfig-i006-20230620   clang
i386                 randconfig-i011-20230620   gcc  
i386                 randconfig-i012-20230620   gcc  
i386                 randconfig-i013-20230620   gcc  
i386                 randconfig-i014-20230620   gcc  
i386                 randconfig-i015-20230620   gcc  
i386                 randconfig-i016-20230620   gcc  
i386                 randconfig-r012-20230620   gcc  
i386                 randconfig-r033-20230620   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230620   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230620   gcc  
m68k                 randconfig-r034-20230620   gcc  
m68k                 randconfig-r035-20230620   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip22_defconfig   clang
mips                     loongson1c_defconfig   clang
mips                      loongson3_defconfig   gcc  
mips                 randconfig-r025-20230620   clang
mips                          rb532_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230620   gcc  
nios2                randconfig-r006-20230620   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   clang
powerpc              randconfig-r015-20230620   gcc  
powerpc              randconfig-r022-20230620   gcc  
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r032-20230620   clang
riscv                randconfig-r042-20230620   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230620   gcc  
sh                               allmodconfig   gcc  
sh                           se7751_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r013-20230620   gcc  
sparc64              randconfig-r021-20230620   gcc  
sparc64              randconfig-r026-20230620   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230620   clang
x86_64       buildonly-randconfig-r002-20230620   clang
x86_64       buildonly-randconfig-r003-20230620   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
