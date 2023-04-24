Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4B06ED576
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjDXTnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjDXTnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:43:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32A55B8C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682365380; x=1713901380;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HUBHKBlJQGizF/NBsa9Lu2bpXVfpyy+WxnN2pepG0E8=;
  b=b1PY5FFIr8CebLKg04zxrbJZ20q7S4MAWLfEID22956BaD8fRkcI/gSr
   33f5lJJmrSsYinJqIwmrj2x7WHxqBK3P16QPs0dY5A6TRLi7LVdXW9ZGO
   51gd6UNpx4c464DDh8qt3559K7ccJBOD/sv6j/M5RqEGwkO94uzwPFexu
   HePrKm45WpYSrsDqJJrqt9VpUBUYk5kOfFY56aft2rcr/bpIrYvPkTIwK
   KHXJZMuRxF0R6f3IA66tku5PZ623ESZoWOo/YUoIJtY+J1DBg/pir7NxW
   CjY9Z5D4mRTQ/ghtx4eHr+KpKIianipBexFfKTidhOYjio9wcngs1PSSe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="345297733"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="345297733"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 12:43:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="782527126"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="782527126"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Apr 2023 12:42:59 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pr25S-000icv-2m;
        Mon, 24 Apr 2023 19:42:58 +0000
Date:   Tue, 25 Apr 2023 03:42:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 01cbd032298654fe4c85e153dd9a224e5bc10194
Message-ID: <6446db94.AfMzAx1nxUbnyZaE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 01cbd032298654fe4c85e153dd9a224e5bc10194  Merge branch into tip/master: 'x86/tdx'

elapsed time: 721m

configs tested: 131
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r016-20230424   gcc  
arc                  randconfig-r024-20230423   gcc  
arc                  randconfig-r043-20230423   gcc  
arc                  randconfig-r043-20230424   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230424   gcc  
arm                  randconfig-r015-20230424   clang
arm                  randconfig-r021-20230424   clang
arm                  randconfig-r025-20230424   clang
arm                  randconfig-r046-20230423   gcc  
arm                  randconfig-r046-20230424   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230423   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230423   clang
arm64                randconfig-r022-20230423   clang
arm64                randconfig-r031-20230423   gcc  
arm64                randconfig-r035-20230423   gcc  
csky         buildonly-randconfig-r003-20230424   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r033-20230423   gcc  
hexagon              randconfig-r011-20230423   clang
hexagon              randconfig-r025-20230423   clang
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
ia64                 randconfig-r003-20230424   gcc  
ia64                 randconfig-r005-20230424   gcc  
ia64                 randconfig-r012-20230424   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230423   gcc  
loongarch            randconfig-r006-20230424   gcc  
loongarch            randconfig-r014-20230423   gcc  
loongarch            randconfig-r014-20230424   gcc  
loongarch            randconfig-r034-20230423   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230423   gcc  
microblaze           randconfig-r013-20230424   gcc  
microblaze           randconfig-r022-20230424   gcc  
microblaze           randconfig-r026-20230423   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230423   clang
mips                 randconfig-r031-20230424   gcc  
nios2        buildonly-randconfig-r004-20230424   gcc  
nios2        buildonly-randconfig-r006-20230423   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r034-20230424   gcc  
openrisc     buildonly-randconfig-r001-20230424   gcc  
openrisc     buildonly-randconfig-r004-20230423   gcc  
openrisc             randconfig-r032-20230423   gcc  
openrisc             randconfig-r036-20230423   gcc  
openrisc             randconfig-r036-20230424   gcc  
parisc       buildonly-randconfig-r002-20230424   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230423   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230424   gcc  
riscv                randconfig-r042-20230423   clang
riscv                randconfig-r042-20230424   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230423   clang
s390                 randconfig-r044-20230424   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230424   gcc  
sh                   randconfig-r013-20230423   gcc  
sh                   randconfig-r024-20230424   gcc  
sh                   randconfig-r032-20230424   gcc  
sh                   randconfig-r033-20230424   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230423   gcc  
sparc64      buildonly-randconfig-r002-20230423   gcc  
sparc64              randconfig-r015-20230423   gcc  
sparc64              randconfig-r021-20230423   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r006-20230424   clang
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
xtensa       buildonly-randconfig-r005-20230423   gcc  
xtensa               randconfig-r002-20230424   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
