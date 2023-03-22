Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2706C58C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCVV1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVV07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:26:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D7728E64
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679520418; x=1711056418;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8TqOqL3M6yHFU0rdkrV0IjVyNJ+BE7coyCax/t4OTr4=;
  b=IWVpzF1lsOT5jlKauu2EpiCEnroNbCl625vCt47eJ2q+JNqCyO/RmuT6
   nFzR1ReZCSjcKGuIJCiRhThpR2fxJcYKTO5SvCAsrPL/v+wry9IkM8+aM
   d1O1cXUjC+W8VLGe3jwZGRbG5ITV5iJa2+1aNOeJF9JQRyo294sVKZLw2
   6ywXboDX/Lo32I6yhKbX62tnbS6jn5i7e4pgvARHzNGdpRzadSbPFFc7p
   amf6KkCTzieJhGFoAWxXIq0cNH17mG0/FCsTVMafJfwKdJ3I7Lj8Bu1j5
   Tm/J6JNCwdl+pXP65HcBvTNIPxsCAYM8mA+6+KaIgmicMx26qIACe1waY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="367073091"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="367073091"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 14:26:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="927984905"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="927984905"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Mar 2023 14:26:55 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pf5yx-000Dfi-04;
        Wed, 22 Mar 2023 21:26:55 +0000
Date:   Thu, 23 Mar 2023 05:26:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 872d28001be56b205bd9b3f97cea1571a1bde317
Message-ID: <641b7277.Dtv0nH9xnqTpZSXQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 872d28001be56b205bd9b3f97cea1571a1bde317  perf/x86/cstate: Add Granite Rapids support

elapsed time: 722m

configs tested: 77
configs skipped: 139

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
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
ia64                 randconfig-r031-20230322   gcc  
ia64                 randconfig-r032-20230322   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
mips                 randconfig-r034-20230322   gcc  
mips                   sb1250_swarm_defconfig   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r033-20230322   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r036-20230322   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r035-20230322   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
