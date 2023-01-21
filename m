Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115776761F2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjAUAPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjAUAPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:15:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FAB677A0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674260140; x=1705796140;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FH1f+g6FWH26Ox9x+EmAyoEpRxm1/VDa0KXQ2U7V8Xk=;
  b=bTtI9uVrcD+mlYDSkLKzwjqDdCMg6FsthruuGbuPtuD8mtyR/WlOQgY6
   UEFUmJKbc03qns/dUaCyCbhh/VeM+Mn6PWEtuxXPB6hjXpioYwUcsg1z7
   cfGl350clpM7tyEOnP7IXd5dQOX6jiga+JHT1pYlHaGHpixzsyNHY4qAA
   HuWtmd0b2S6prqeCZztVf2JZFF+aspoWiQYj/TERLBhxa2lA7ALVGstd5
   DAscUyiknRZzYzGSp/bQioaSBa4BYrI7Usb9fjIXYj9tWYUs8dTLXZ02Y
   1IZ2P97vbIOHxaW7D/kTbB+D/HcIvHUTqG+whJvvDQHzAMdgzpxv0Sqnr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="323421101"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="323421101"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 16:15:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="749540565"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="749540565"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jan 2023 16:15:35 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJ1Xi-00038g-1C;
        Sat, 21 Jan 2023 00:15:34 +0000
Date:   Sat, 21 Jan 2023 08:15:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 71439cf2e33836df937c8d7c6c64816e2c7f2595
Message-ID: <63cb2e86.D2xWWTYYSGFki2Vq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 71439cf2e33836df937c8d7c6c64816e2c7f2595  locking/csd_lock: Remove per-CPU data indirection from CSD lock debugging

elapsed time: 720m

configs tested: 92
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                              defconfig
sh                               allmodconfig
alpha                               defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
s390                                defconfig
x86_64                         rhel-8.3-kunit
arm                                 defconfig
mips                             allyesconfig
s390                             allyesconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
x86_64                           rhel-8.3-bpf
arm                  randconfig-r046-20230119
arc                  randconfig-r043-20230119
m68k                             allyesconfig
arm                              allyesconfig
m68k                             allmodconfig
arm64                            allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                                defconfig
i386                          randconfig-a014
ia64                             allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a004
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a002
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                             allyesconfig
sh                           se7724_defconfig
powerpc                      ppc6xx_defconfig
loongarch                        alldefconfig
sh                   sh7770_generic_defconfig
nios2                               defconfig
powerpc                   currituck_defconfig
sparc                       sparc32_defconfig
arm                           stm32_defconfig
arm64                            alldefconfig
arm                          exynos_defconfig
sh                        sh7757lcr_defconfig
m68k                        m5407c3_defconfig
arc                              alldefconfig
powerpc                       eiger_defconfig
sh                             espt_defconfig
i386                          randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64                          rhel-8.3-rust
riscv                randconfig-r042-20230119
hexagon              randconfig-r041-20230119
hexagon              randconfig-r045-20230119
s390                 randconfig-r044-20230119
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a015
x86_64                        randconfig-a003
x86_64                        randconfig-a014
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
mips                       lemote2f_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     ksi8560_defconfig
powerpc                     tqm8540_defconfig
powerpc                    ge_imp3a_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
