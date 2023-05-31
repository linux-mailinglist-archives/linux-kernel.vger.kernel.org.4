Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0894D717C59
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbjEaJrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjEaJrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:47:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11857D9
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685526436; x=1717062436;
  h=date:from:to:cc:subject:message-id;
  bh=k5dWzHm3JtGcVtvzGwiiffP2phvD2IawezXkFs4d5xA=;
  b=maS56pFZlLYGgNH5dBcsdfXaD2Zelx49yueCdsQqlJbOotXlJ9azCynf
   jQVa7ut/+QQJjt/+0BnUcN59D6UVD2jFRMVrSiPWxE35Hr0oAkblK5Dut
   AJ2M2pfaw+YrindP5BHhQCX3jExgeqVv+cmAqHz0e8ahM2vs7N5YseGF0
   5xEfCrAJiqV3NnS6S7vibIS8QtwK0eWi/R7Gc26MaUOUitMcpdfRM7c2g
   7fl1lEIeib2ZCXCPrNrPYy8xZxFZv0T9IfopeSty5NeOFwZ5R70gliwoI
   3lktGvsS47ZmSIMGbcue5Fc3k6wMMgy0/wFVK0xZxBjClO4OFu/bUhCXY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="357580135"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="357580135"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 02:47:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="710005264"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="710005264"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 31 May 2023 02:47:14 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4IQD-0001F5-35;
        Wed, 31 May 2023 09:47:13 +0000
Date:   Wed, 31 May 2023 17:47:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230530] BUILD SUCCESS WITH
 WARNING a2e8533878017f1874b21d78b6bf08a6c4095365
Message-ID: <20230531094710.KZUOA%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230530
branch HEAD: a2e8533878017f1874b21d78b6bf08a6c4095365  Makefile: Globally enable -Wstringop-overflow

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202305310834.1iGa1DB5-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202305310857.whO1DJq1-lkp@intel.com

Warning: (recently discovered and may have been fixed)

fs/smb/client/cifssmb.c:2987:31: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified bound between 2147483648 and 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
include/linux/fortify-string.h:57:33: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allyesconfig
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- i386-debian-10.3
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|-- i386-randconfig-i061-20230531
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|-- i386-randconfig-i063-20230531
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|-- i386-randconfig-i065-20230531
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|-- i386-randconfig-i066-20230531
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
|-- mips-randconfig-r014-20230531
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-specified-bound-between-and-exceeds-maximum-object-size
`-- x86_64-rhel-8.3
    `-- fs-smb-client-cifssmb.c:warning:writing-byte-into-a-region-of-size

elapsed time: 723m

configs tested: 82
configs skipped: 6

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230531   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230531   gcc  
arc                  randconfig-r043-20230531   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r034-20230531   clang
arm                  randconfig-r046-20230531   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230531   clang
arm64                randconfig-r031-20230531   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230531   gcc  
hexagon              randconfig-r024-20230531   clang
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i011-20230531   clang
i386                 randconfig-i012-20230531   clang
i386                 randconfig-i013-20230531   clang
i386                 randconfig-i014-20230531   clang
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i066-20230531   gcc  
i386                 randconfig-r021-20230531   clang
i386                 randconfig-r022-20230531   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230531   gcc  
loongarch            randconfig-r012-20230531   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230531   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230531   gcc  
m68k                 randconfig-r026-20230531   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r004-20230531   clang
mips                 randconfig-r014-20230531   gcc  
nios2        buildonly-randconfig-r002-20230531   gcc  
nios2        buildonly-randconfig-r003-20230531   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r035-20230531   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230531   gcc  
parisc               randconfig-r036-20230531   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
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
sh           buildonly-randconfig-r001-20230531   gcc  
sh                   randconfig-r001-20230531   gcc  
sparc        buildonly-randconfig-r006-20230531   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r003-20230531   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r032-20230531   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
