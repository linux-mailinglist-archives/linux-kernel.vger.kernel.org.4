Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380CC73448B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 02:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjFRA0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 20:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjFRA0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 20:26:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6781733
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 17:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687047958; x=1718583958;
  h=date:from:to:cc:subject:message-id;
  bh=D34YLh36YCplnf7kHGOqzBYrjyvtcWXGw6qhQ3UuM5c=;
  b=O+hnOpgPXXXLAxZWamU98q8714YCkuHvTHl3wJIvV6o0nXVykDkLDQwK
   s1j/s5Ly+JdH9L8WSRe5ZkMyXkIkc2ThV7/gYxtB3GBNOKk3ZKTRH661q
   QLDB0z8CJAN55C6mmtFx+H7krMVv53uw8UpZ1jZ/JSGdGoHUGIaQsOQWJ
   DbcZJVhyoqO1JVOufhctlMgnnGsNUaIm9gpBU+AKDSvQfgIswhEb7Vykq
   rP3q2zLEftYHKLsVO2Etq4h0BeboG5TQJBtaVdOic1NvR6rctXPA1SIZ7
   eNo7MjDhwE4boksCA8zmmYVaDCpDJkbZTyqNu5h0ONaLuUc9/FU3OQKgH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10744"; a="339051125"
X-IronPort-AV: E=Sophos;i="6.00,251,1681196400"; 
   d="scan'208";a="339051125"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2023 17:25:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10744"; a="960030989"
X-IronPort-AV: E=Sophos;i="6.00,251,1681196400"; 
   d="scan'208";a="960030989"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2023 17:25:56 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qAgEu-0003FD-0D;
        Sun, 18 Jun 2023 00:25:56 +0000
Date:   Sun, 18 Jun 2023 08:25:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 b9c3332489136d8f6a67a606f6e3683eb8786960
Message-ID: <202306180836.OY63W3fA-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: b9c3332489136d8f6a67a606f6e3683eb8786960  Docs/RCU/rculist_nulls: Fix text discussing atomic_set_release()

Unverified Warning (likely false positive, please contact us if interested):

kernel/scftorture.c:441 scftorture_invoke_one() warn: possible memory leak of 'scfcp'

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- microblaze-randconfig-m031-20230614
    `-- kernel-scftorture.c-scftorture_invoke_one()-warn:possible-memory-leak-of-scfcp

elapsed time: 1445m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230616   gcc  
alpha                randconfig-r033-20230616   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r022-20230616   gcc  
arc                  randconfig-r043-20230616   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       netwinder_defconfig   clang
arm                  randconfig-r003-20230616   gcc  
arm                  randconfig-r013-20230616   clang
arm                  randconfig-r026-20230616   clang
arm                  randconfig-r046-20230616   clang
arm                        realview_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230616   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r021-20230616   gcc  
hexagon              randconfig-r035-20230616   clang
hexagon              randconfig-r041-20230616   clang
hexagon              randconfig-r045-20230616   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230617   gcc  
i386         buildonly-randconfig-r005-20230617   gcc  
i386         buildonly-randconfig-r006-20230617   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230616   clang
i386                 randconfig-i002-20230616   clang
i386                 randconfig-i003-20230616   clang
i386                 randconfig-i004-20230616   clang
i386                 randconfig-i005-20230616   clang
i386                 randconfig-i006-20230616   clang
i386                 randconfig-i011-20230617   clang
i386                 randconfig-i012-20230617   clang
i386                 randconfig-i013-20230617   clang
i386                 randconfig-i014-20230617   clang
i386                 randconfig-i015-20230617   clang
i386                 randconfig-i016-20230617   clang
i386                 randconfig-r005-20230616   clang
i386                 randconfig-r006-20230616   clang
i386                 randconfig-r036-20230616   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230616   gcc  
loongarch            randconfig-r031-20230616   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r024-20230616   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze           randconfig-r012-20230616   gcc  
microblaze           randconfig-r032-20230616   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                      pic32mzda_defconfig   clang
mips                 randconfig-r002-20230616   gcc  
mips                         rt305x_defconfig   gcc  
nios2                               defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        fsp2_defconfig   clang
powerpc                      ppc40x_defconfig   gcc  
powerpc                    socrates_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r042-20230616   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230616   gcc  
s390                 randconfig-r044-20230616   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r023-20230616   clang
um                   randconfig-r025-20230616   clang
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230617   gcc  
x86_64       buildonly-randconfig-r002-20230617   gcc  
x86_64       buildonly-randconfig-r003-20230617   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230617   gcc  
x86_64               randconfig-a002-20230617   gcc  
x86_64               randconfig-a003-20230617   gcc  
x86_64               randconfig-a004-20230617   gcc  
x86_64               randconfig-a005-20230617   gcc  
x86_64               randconfig-a006-20230617   gcc  
x86_64               randconfig-a011-20230617   clang
x86_64               randconfig-a012-20230617   clang
x86_64               randconfig-a013-20230617   clang
x86_64               randconfig-a014-20230617   clang
x86_64               randconfig-a015-20230617   clang
x86_64               randconfig-a016-20230617   clang
x86_64               randconfig-r011-20230616   gcc  
x86_64               randconfig-r034-20230616   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                              defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                    smp_lx200_defconfig   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
