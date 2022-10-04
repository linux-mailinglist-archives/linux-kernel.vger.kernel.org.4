Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28965F3C4A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 06:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJDEzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 00:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJDEzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 00:55:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5118CEE0B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 21:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664859325; x=1696395325;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WEb7uQBPO/P3ViFY0tWsJ2vc2471D9GDR+dNY2H0c4A=;
  b=nd+Gp8euFarVjLOdvAM/E69jefmNn4MJ8l+94djdxeSgKKhDt3bAc2XC
   D/j3dnZdaTsa26HMycRsrzgYQRguY03BLS/Jb7/KqdrDNfU9a7o6ZLtpO
   PAuj16slZZeJupq0JMUkkTpl9Mit31t2lFlt3V3ccdtXXsXLLkhTmRRNt
   +3bXqblGjdgmomrWYkgxoVcHQ2qBCzUJZ6eUHyLSPJUGLfOb2mmbd6Oa8
   3y66I0a9v8SrT7a/VEzIx+BdcYUAOD3nckXLExmdZx7v0Yzj4U+I1O+lD
   YTsEMtbSYiX20vFB6BwebzwZpTJ2jBnNuikonzyp9q/M5VTEJl7m/p0B4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="329231053"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="329231053"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 21:55:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="749254028"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="749254028"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Oct 2022 21:55:23 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ofZxi-0005Jz-2l;
        Tue, 04 Oct 2022 04:55:22 +0000
Date:   Tue, 04 Oct 2022 12:54:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.09.30a] BUILD SUCCESS
 94119b8bb10199044ed75d455dd08efd14ea620f
Message-ID: <633bbc90.3uJh9G6unX8Qcmwb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.09.30a
branch HEAD: 94119b8bb10199044ed75d455dd08efd14ea620f  rcu-tasks: Make grace-period-age message human-readable

elapsed time: 4579m

configs tested: 140
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                               defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
m68k                             allmodconfig
i386                 randconfig-a001-20220926
arc                              allyesconfig
i386                 randconfig-a002-20220926
alpha                            allyesconfig
i386                 randconfig-a003-20220926
m68k                             allyesconfig
i386                 randconfig-a004-20220926
i386                 randconfig-a005-20220926
i386                 randconfig-a006-20220926
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                        randconfig-a011
arc                  randconfig-r043-20220925
x86_64                        randconfig-a013
x86_64                        randconfig-a015
riscv                randconfig-r042-20220925
arc                  randconfig-r043-20220926
s390                 randconfig-r044-20220925
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                                defconfig
arm                                 defconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
x86_64                           alldefconfig
arc                           tb10x_defconfig
sh                          rsk7203_defconfig
arm                             rpc_defconfig
sh                           se7712_defconfig
powerpc                     rainier_defconfig
sparc                       sparc64_defconfig
nios2                            allyesconfig
x86_64               randconfig-a011-20221003
x86_64               randconfig-a015-20221003
x86_64               randconfig-a014-20221003
x86_64               randconfig-a012-20221003
i386                 randconfig-a011-20221003
i386                 randconfig-a012-20221003
i386                 randconfig-a013-20221003
i386                 randconfig-a015-20221003
x86_64               randconfig-a013-20221003
i386                 randconfig-a016-20221003
sh                           se7724_defconfig
powerpc                         ps3_defconfig
powerpc                     tqm8548_defconfig
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
arc                  randconfig-r043-20221002
s390                 randconfig-r044-20221003
powerpc                     redwood_defconfig
m68k                       bvme6000_defconfig
arc                    vdk_hs38_smp_defconfig
arm                             ezx_defconfig
i386                 randconfig-a014-20221003
x86_64               randconfig-a016-20221003
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                  randconfig-c002-20221002
x86_64                        randconfig-c001
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
i386                 randconfig-a011-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
x86_64                        randconfig-a012
i386                 randconfig-a016-20220926
i386                 randconfig-a015-20220926
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220925
x86_64                        randconfig-a014
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
arm                          ep93xx_defconfig
arm                         hackkit_defconfig
arm                                 defconfig
powerpc                 mpc836x_mds_defconfig
i386                 randconfig-a001-20221003
i386                 randconfig-a006-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a003-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a004-20221003
x86_64                        randconfig-k001
x86_64               randconfig-a003-20221003
x86_64               randconfig-a005-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a006-20221003
hexagon              randconfig-r041-20221002
hexagon              randconfig-r045-20221002
hexagon              randconfig-r045-20221003
hexagon              randconfig-r041-20221003
riscv                randconfig-r042-20221002
s390                 randconfig-r044-20221002
mips                        bcm63xx_defconfig
mips                          ath79_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
