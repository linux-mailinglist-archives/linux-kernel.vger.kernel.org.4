Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE47966D110
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 22:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjAPVqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 16:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjAPVqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:46:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F0C22A31
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 13:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673905568; x=1705441568;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SDEWNSuVj/9Q6o+101i5r6ft2tzeOm0Qdxkagh1pGbc=;
  b=WcY25snvk/l6bAVIp7n8K97KGsRWwkXZmsGyk4Aqrs8dSXIDf3muPGh/
   yQwcbDDGrtDikCTMj+Zz1FZrYIuVqLMfy0aBpEh5m+H6+qPis6eh8cufa
   DhKi82WOgYzG3wHhuyt3Udkg+jkyisIA4MA9VsIHKy8jcQ6PTD3Q1YR3c
   BLn8A7tx9q298aTZEq5+5gfo8AhE4BILt02eOe0PeZcqw4aQ7+Edxu7/R
   97yk4GmRml0m3L7m1lsMbqPxCU5EjOTVqH3IlPHGRHhxQbR6XtZJMSmW/
   mS2eqqpGzCpwqVuK5tq4YqfTn0VLz0F2AudsLii1Ev8PLzA92qoSlrzIT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="326624053"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="326624053"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 13:46:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="722444110"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="722444110"
Received: from lkp-server02.sh.intel.com (HELO f57cd993bc73) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2023 13:46:06 -0800
Received: from kbuild by f57cd993bc73 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pHXIr-0000jj-2I;
        Mon, 16 Jan 2023 21:46:05 +0000
Date:   Tue, 17 Jan 2023 05:45:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 5f5cc9ed992cbab6361f198966f0edba5fc52688
Message-ID: <63c5c567.FP3awRZSp9dLXfXg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LONGWORDS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 5f5cc9ed992cbab6361f198966f0edba5fc52688  x86/aperfmperf: Erase stale arch_freq_scale values when disabling frequency invariance readings

elapsed time: 722m

configs tested: 125
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
m68k                             allmodconfig
i386                 randconfig-a013-20230116
alpha                            allyesconfig
arm                                 defconfig
sh                               allmodconfig
m68k                             allyesconfig
i386                 randconfig-a012-20230116
arc                              allyesconfig
i386                 randconfig-a011-20230116
i386                 randconfig-a016-20230116
mips                             allyesconfig
arm64                            allyesconfig
i386                 randconfig-a014-20230116
i386                 randconfig-a015-20230116
arc                  randconfig-r043-20230116
arm                              allyesconfig
s390                 randconfig-r044-20230116
ia64                             allmodconfig
riscv                randconfig-r042-20230116
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
arc                                 defconfig
x86_64                           rhel-8.3-kvm
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64               randconfig-k001-20230116
powerpc                          allmodconfig
s390                             allyesconfig
x86_64               randconfig-a011-20230116
x86_64               randconfig-a016-20230116
x86_64               randconfig-a014-20230116
x86_64               randconfig-a013-20230116
x86_64               randconfig-a015-20230116
x86_64               randconfig-a012-20230116
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
nios2                         10m50_defconfig
arc                               allnoconfig
i386                             allyesconfig
i386                                defconfig
m68k                                defconfig
loongarch                 loongson3_defconfig
powerpc                      ppc6xx_defconfig
m68k                       m5275evb_defconfig
openrisc                       virt_defconfig
arm                            mps2_defconfig
arm                             rpc_defconfig
arm                           h3600_defconfig
powerpc                       maple_defconfig
sh                           se7619_defconfig
powerpc                      makalu_defconfig
arm                               allnoconfig
sh                      rts7751r2d1_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
mips                           jazz_defconfig
powerpc                      ep88xc_defconfig
powerpc                  storcenter_defconfig
arm                             ezx_defconfig
sh                        sh7785lcr_defconfig
mips                     decstation_defconfig
mips                         bigsur_defconfig
openrisc                            defconfig
mips                        bcm47xx_defconfig
powerpc                mpc7448_hpc2_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec

clang tested configs:
arm                  randconfig-r046-20230116
hexagon              randconfig-r045-20230116
hexagon              randconfig-r041-20230116
x86_64               randconfig-a001-20230116
x86_64               randconfig-a003-20230116
x86_64               randconfig-a002-20230116
x86_64               randconfig-a004-20230116
x86_64               randconfig-a005-20230116
x86_64               randconfig-a006-20230116
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                 randconfig-a002-20230116
i386                 randconfig-a004-20230116
i386                 randconfig-a001-20230116
i386                 randconfig-a003-20230116
i386                 randconfig-a005-20230116
i386                 randconfig-a006-20230116
arm                       netwinder_defconfig
powerpc                     kilauea_defconfig
x86_64                          rhel-8.3-rust
riscv                randconfig-r042-20230115
s390                 randconfig-r044-20230115
hexagon              randconfig-r041-20230115
hexagon              randconfig-r045-20230115
arm                        vexpress_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          pxa168_defconfig
arm                     am200epdkit_defconfig
mips                           mtx1_defconfig
powerpc                     pseries_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
