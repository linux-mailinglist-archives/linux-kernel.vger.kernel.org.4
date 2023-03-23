Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7A36C6D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjCWQ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCWQ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:29:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2633233F5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679588936; x=1711124936;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IPi13B32QRBDthTFsj02TwBFbFsdaxQIRrKpXLUfBiw=;
  b=FtMHB3hPPrdEI6Yamy6YLqqzFjsigyljOcS9XU4mBXoMMrCogPLntt59
   YT302DsmyUYR7FRmU95Ks64LiAddI8HS5Cdz0JFfF1Ns2KN3k5qX1eoB5
   scRLY20QoNqECCsQqsbBIwb4G5Vtcrlk/y8tyK1tr7nF78YkS71KAO9Ra
   IbmRmw50aBSvFgIqXI20RaiDRDaexwcj6zafPQnwzqnXbXqxK0F+e3fvw
   H68NzX9GjsDAXeSgShei1dVV0YeC5hJi+86YweOT1lQNxTF1ypjuByMdu
   liLAZJ+Ip45tc+fXsuAIHRgTlubP3zniHEg+EZgwv0r8XTLG1AwWttGaQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="337051399"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="337051399"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 09:25:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="856561652"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="856561652"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2023 09:25:39 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfNkr-000EWW-20;
        Thu, 23 Mar 2023 16:25:33 +0000
Date:   Fri, 24 Mar 2023 00:25:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fsfa3] BUILD REGRESSION
 0866a2ea45cdf26bbee3f4b1bd9a840c74de54e3
Message-ID: <641c7d68.M3lyM5dCQc0IUoZe%lkp@intel.com>
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
branch HEAD: 0866a2ea45cdf26bbee3f4b1bd9a840c74de54e3  Makefile: Enable -Wstringop-overflow and -Warray-bounds and -fstrict-flex-arrays=3

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303231323.YNz4H0a3-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303231428.zEj8YhJa-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

aarch64-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
alpha-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
arc-elf-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
arceb-elf-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
arm-linux-gnueabi-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
csky-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
gcc-11: error: unrecognized command-line option '-fstrict-flex-arrays=3'
hppa-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
hppa64-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
ia64-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
loongarch64-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
m68k-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
mips-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
nios2-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
powerpc-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
riscv32-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
riscv64-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
s390-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
sh4-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
sparc-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
sparc64-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
xtensa-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- alpha-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- alpha-defconfig
|   `-- alpha-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arc-allyesconfig
|   `-- arceb-elf-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arc-defconfig
|   `-- arc-elf-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arc-randconfig-r043-20230322
|   `-- arceb-elf-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arm-allyesconfig
|   `-- arm-linux-gnueabi-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- arm64-allyesconfig
|   `-- aarch64-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- csky-defconfig
|   `-- csky-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- i386-randconfig-a001
|   `-- gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- i386-randconfig-a014
|   `-- gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- ia64-allmodconfig
|   `-- ia64-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- ia64-defconfig
|   `-- ia64-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- ia64-randconfig-r013-20230322
|   `-- ia64-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- loongarch-allmodconfig
|   `-- loongarch64-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- loongarch-allnoconfig
|   `-- loongarch64-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- loongarch-allyesconfig
|   `-- loongarch64-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- loongarch-defconfig
|   `-- loongarch64-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- loongarch-randconfig-r021-20230322
|   `-- loongarch64-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- m68k-allyesconfig
|   `-- m68k-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- mips-allmodconfig
|   `-- mips-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- mips-allyesconfig
|   `-- mips-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- nios2-defconfig
|   `-- nios2-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- parisc-allyesconfig
|   `-- hppa-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- parisc-defconfig
|   `-- hppa-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
|-- parisc64-defconfig
|   `-- hppa64-linux-gcc:error:unrecognized-command-line-option-fstrict-flex-arrays
clang_recent_errors
`-- i386-randconfig-a002
    `-- clang:error:unknown-argument:fstrict-flex-arrays

elapsed time: 725m

configs tested: 70
configs skipped: 6

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230322   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r025-20230322   clang
arm                  randconfig-r046-20230322   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r014-20230322   clang
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
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r011-20230322   gcc  
ia64                 randconfig-r013-20230322   gcc  
ia64                 randconfig-r016-20230322   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r021-20230322   gcc  
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
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r026-20230322   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230322   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r022-20230322   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
