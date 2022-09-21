Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71C45E544C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiIUUOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiIUUOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:14:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1250CE0E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663791281; x=1695327281;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rF1hDtIdeFiwWo2ylLrzJ2fRQ3nJIf7+Ff3h5Vv/WaY=;
  b=HI1hRGaT5gEBIPZI955qiVN77Zaj7L4bR3m41sbQCYWDRGBAfuCfheTm
   bRglNSFPLH9tey/tskhxXUr+1s5pA8H+YYJe3S6yWs+ZG3Z4jByv6NTQd
   jdFbG1XpnBhlj8mUhE/O5BVhPSJDpczhcFHSA4XnrPHiVDEW8YIzXWqC/
   +nAO0/pnyLOmLzcjYk3iCo6cEZrnyrGuY+N6biF14IxWHM74x4Q3qE6RV
   P+7WZMgZQ1nA81meGtnVVqC2wt/DDtYZXgbotGunv6Vb4jIGVaxiyJ9xY
   FdPjUHUGHRi5Qecb1lHcQr72hGriHwMQA83HrSAMfr7SEyEox+pTVIzVj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="279839041"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="279839041"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 13:14:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="761907376"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Sep 2022 13:14:40 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ob67D-0003up-1I;
        Wed, 21 Sep 2022 20:14:39 +0000
Date:   Thu, 22 Sep 2022 04:14:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 76e64c73db9542ff4bae8a60f4f32e38f3799b95
Message-ID: <632b7094.kvwl5zUkb1Saz9Gx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 76e64c73db9542ff4bae8a60f4f32e38f3799b95  locking/lockdep: Print more debug information - report name and key when look_up_lock_class() got confused

elapsed time: 725m

configs tested: 118
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
s390                                defconfig
x86_64                        randconfig-a006
powerpc                           allnoconfig
x86_64                              defconfig
s390                             allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
sh                               allmodconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20220921
riscv                randconfig-r042-20220921
mips                             allyesconfig
m68k                             allmodconfig
powerpc                          allmodconfig
s390                 randconfig-r044-20220921
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-c001
arm                  randconfig-c002-20220921
i386                          randconfig-c001
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm64                               defconfig
ia64                             allyesconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
sh                             sh03_defconfig
sh                              ul2_defconfig
powerpc                      ppc6xx_defconfig
i386                             alldefconfig
powerpc                      bamboo_defconfig
arm                           h5000_defconfig
m68k                        mvme147_defconfig
powerpc                        cell_defconfig
sparc64                          alldefconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                    mvme5100_defconfig
arm                        magician_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     ksi8560_defconfig
powerpc                     tqm8560_defconfig
mips                          ath79_defconfig
arm                       versatile_defconfig
arm                        multi_v5_defconfig
powerpc                      ppc64e_defconfig
mips                malta_qemu_32r6_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-c007
arm                  randconfig-c002-20220921
i386                          randconfig-c001
s390                 randconfig-c005-20220921
riscv                randconfig-c006-20220921
mips                 randconfig-c004-20220921
powerpc              randconfig-c003-20220921

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
