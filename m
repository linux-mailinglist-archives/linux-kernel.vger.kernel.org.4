Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C166D29FF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjCaVaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjCaVaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:30:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C358A21AB4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680298202; x=1711834202;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3qrKgVUmJpVCvUu/6DRX3eOmlNHKcXEUsVxCcM+HZ0k=;
  b=cwTWycV9i9/pA+9I3b41G6ujbcJPTd9W/msXgKvMhV/+p7MdYSPsdfeQ
   uUmP77pjbEnoG5yvcSV05A4F2Ic9rtAzxlFW5hN6SJ6IwBM37//dioYyc
   rRXbJROSfusYCMQhnLxLdEeiWcDousFvh2BjbxpOxyVZ/xz1EznEiTJt6
   ybgylhMCBiargTTg3TMNOM6X1o/ZJ5x42ili0/7pjk5aN9/U9zg7D0Cwo
   SrPoBmvvMpuOrHj+RhxzbwZzHAiG4KL5228IATfnRUAw3mV9TS/HMrXp1
   947nxGBirEfJ67q2zYg4N45TmhKvTIU9kIf2SYApzcpG1NHcfUyGTUapM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="341579586"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="341579586"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 14:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="931325270"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="931325270"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 Mar 2023 14:29:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piMJp-000MBW-1u;
        Fri, 31 Mar 2023 21:29:57 +0000
Date:   Sat, 01 Apr 2023 05:29:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5874c82edd018a497093a683de46fa8700f40a18
Message-ID: <642750c3.OTZcR2054bebov05%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 5874c82edd018a497093a683de46fa8700f40a18  Merge branch into tip/master: 'x86/tdx'

elapsed time: 724m

configs tested: 113
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230329   gcc  
alpha                randconfig-r006-20230329   gcc  
alpha                randconfig-r016-20230329   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r033-20230329   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                  randconfig-r001-20230329   clang
arm                  randconfig-r002-20230329   clang
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230329   gcc  
hexagon              randconfig-r041-20230329   clang
hexagon              randconfig-r041-20230330   clang
hexagon              randconfig-r045-20230329   clang
hexagon              randconfig-r045-20230330   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a004   clang
i386                          randconfig-a006   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a014   gcc  
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                      gensparse_defconfig   gcc  
ia64                 randconfig-r012-20230329   gcc  
ia64                 randconfig-r036-20230329   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r015-20230329   gcc  
loongarch            randconfig-r016-20230331   gcc  
loongarch            randconfig-r021-20230329   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230329   gcc  
m68k                 randconfig-r035-20230329   gcc  
m68k                           sun3_defconfig   gcc  
microblaze   buildonly-randconfig-r005-20230329   gcc  
microblaze   buildonly-randconfig-r006-20230329   gcc  
microblaze           randconfig-r011-20230331   gcc  
microblaze           randconfig-r016-20230329   gcc  
microblaze           randconfig-r023-20230329   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                        vocore2_defconfig   gcc  
nios2                               defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r015-20230329   gcc  
parisc               randconfig-r022-20230329   gcc  
parisc               randconfig-r025-20230329   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc              randconfig-r032-20230329   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r022-20230329   clang
riscv                randconfig-r032-20230329   gcc  
riscv                randconfig-r035-20230329   gcc  
riscv                randconfig-r042-20230329   clang
riscv                randconfig-r042-20230330   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230329   clang
s390                                defconfig   gcc  
s390                 randconfig-r002-20230329   gcc  
s390                 randconfig-r003-20230329   gcc  
s390                 randconfig-r013-20230331   gcc  
s390                 randconfig-r023-20230329   clang
s390                 randconfig-r044-20230329   clang
s390                 randconfig-r044-20230330   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r014-20230329   gcc  
sh                   randconfig-r024-20230329   gcc  
sh                           sh2007_defconfig   gcc  
sparc        buildonly-randconfig-r001-20230329   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r031-20230329   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r031-20230329   gcc  
xtensa               randconfig-r033-20230329   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
