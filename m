Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1822603B51
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJSIUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiJSIUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:20:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A71A7B783
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666167650; x=1697703650;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9Nyc/wsbItcBK3ax+RI3nxz8SnIZQzLNTEYYMyxBCus=;
  b=gExv/t3hV0JoUdWueEs9boD8O7G1WZx++8AoPJSHZbpYTip2wYGYMPHh
   jxuS/IywnyZAK+GRDSE71j2XInWYT/bKrunqfNKagGizJLlTyRX9R0FVS
   laXjPnOS3YRtnszrrN9VpVZ1BkIQgTXg91zoKC2/lzgp6SFy/Sz3IjP8P
   VRE0J1Wtk90k3hitPjrZazCpPWDCoeUGoNvRD91J8BO/i4pmnWRmQeWDj
   ILQnCXRJKmalzgijjrvjENarz3cu1IOzvsn6gJgt8bBN6H3+f7v+6Us6N
   bG6dSJ4qjiPAJNNR7F7+CF89TRDEyKrjwkRhA0NcDkRmYl7CzzNpqtLum
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="289659597"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="289659597"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 01:20:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="958220128"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="958220128"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Oct 2022 01:20:48 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ol4Jj-0002eW-25;
        Wed, 19 Oct 2022 08:20:47 +0000
Date:   Wed, 19 Oct 2022 16:20:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 996bf5c3ba7a605e563c2f3fc3cd967aec32d191
Message-ID: <634fb349.Mxf62v6pLr6ZnhaK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 996bf5c3ba7a605e563c2f3fc3cd967aec32d191  kcsan: Fix trivial typo in Kconfig help comments

elapsed time: 799m

configs tested: 139
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
i386                          randconfig-c001
arm                        spear6xx_defconfig
arm                         assabet_defconfig
mips                 decstation_r4k_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                        mvebu_v7_defconfig
nios2                               defconfig
m68k                          amiga_defconfig
openrisc                         alldefconfig
arm                      jornada720_defconfig
sh                          r7780mp_defconfig
arm                         axm55xx_defconfig
ia64                        generic_defconfig
arm                           tegra_defconfig
powerpc                      chrp32_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
mips                         db1xxx_defconfig
powerpc                  storcenter_defconfig
powerpc                 canyonlands_defconfig
sh                          urquell_defconfig
s390                       zfcpdump_defconfig
openrisc                            defconfig
powerpc                     tqm8548_defconfig
openrisc                  or1klitex_defconfig
i386                          randconfig-a001
x86_64                        randconfig-a002
i386                          randconfig-a003
xtensa                  audio_kc705_defconfig
arc                           tb10x_defconfig
openrisc                 simple_smp_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a005
arm                        trizeps4_defconfig
m68k                                defconfig
sh                 kfr2r09-romimage_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-c001
arm                  randconfig-c002-20221018
sh                            shmin_defconfig
sh                         apsh4a3a_defconfig
arm                        cerfcube_defconfig
sh                        sh7763rdp_defconfig
sh                          sdk7780_defconfig
powerpc                    klondike_defconfig
sh                             sh03_defconfig
sh                          r7785rp_defconfig
sh                             espt_defconfig
arm                          iop32x_defconfig
sh                            hp6xx_defconfig
sh                             shx3_defconfig
sh                          polaris_defconfig
mips                         cobalt_defconfig
sparc                             allnoconfig
arm                  randconfig-c002-20221019

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
hexagon              randconfig-r045-20221018
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
mips                        maltaup_defconfig
arm                                 defconfig
mips                           rs90_defconfig
hexagon              randconfig-r041-20221018
x86_64                        randconfig-c007
mips                 randconfig-c004-20221018
i386                          randconfig-c001
s390                 randconfig-c005-20221018
arm                  randconfig-c002-20221018
riscv                randconfig-c006-20221018
powerpc              randconfig-c003-20221018
powerpc                          g5_defconfig
powerpc                   lite5200b_defconfig
arm                         socfpga_defconfig
mips                 randconfig-c004-20221019
s390                 randconfig-c005-20221019
arm                  randconfig-c002-20221019
riscv                randconfig-c006-20221019
powerpc              randconfig-c003-20221019
x86_64                        randconfig-k001
hexagon                             defconfig
s390                 randconfig-r044-20221019
hexagon              randconfig-r045-20221019
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221019

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
