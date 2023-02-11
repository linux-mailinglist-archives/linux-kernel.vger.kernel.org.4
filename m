Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D006932A1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBKQ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKQ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:58:23 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546B6F4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 08:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676134702; x=1707670702;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=p4XXuymRwp+J/VTgiGMEzOPaHXhpVeP+ADlmhlHfwp0=;
  b=DFpSNPeDHlCzjZRzLDOItLIMcVAeETLeMYTII1OpD3G9TqaC+7STEyp9
   KX0Of55UcYEwAAfxKOxhOSdA6yTwZXwlrN/Hz7wKdvx6W6n0nZsySiCey
   760QVl50a9nbZ/p4rBLxhGpBGb5RLmv7ksPQ5K/mNeeJH8cVbD02FO9yC
   4RFAC8u/WngZGglSaU05h7LXA1wKXe+oaWveDr6fOiTJKiugo+QTeVl0k
   tNGsHCY1+YEZWN7btdCD75U7uO3K6OJo+kcdcRIPTnSIG8xkS3Ih4l2Dr
   uCKovsh+mdy2DtYMP179rP7+DzYYgi0XOwExI5oW62k4cY5uf+QK/Belb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="395237118"
X-IronPort-AV: E=Sophos;i="5.97,290,1669104000"; 
   d="scan'208";a="395237118"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2023 08:58:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="700783637"
X-IronPort-AV: E=Sophos;i="5.97,290,1669104000"; 
   d="scan'208";a="700783637"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Feb 2023 08:58:20 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQtCd-0006hF-1i;
        Sat, 11 Feb 2023 16:58:19 +0000
Date:   Sun, 12 Feb 2023 00:58:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:conflict-resolution.2023.02.10a] BUILD SUCCESS
 9adfa15b50c136ea02c94e0e98f861988bd88a35
Message-ID: <63e7c922.ZqCJCJ2w1sQ9V8f8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git conflict-resolution.2023.02.10a
branch HEAD: 9adfa15b50c136ea02c94e0e98f861988bd88a35  Merge commit '3a2dbc510c437ca392516b0105bad8e7970e6614' into HEAD

elapsed time: 1266m

configs tested: 105
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                               allnoconfig
arc                              allyesconfig
arc                                 defconfig
arc                 nsimosci_hs_smp_defconfig
arc                  randconfig-r043-20230210
arm                              allmodconfig
arm                              allyesconfig
arm                       aspeed_g5_defconfig
arm                                 defconfig
arm                          exynos_defconfig
arm                  randconfig-r046-20230210
arm                         vf610m4_defconfig
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                         debian-10.3-func
i386                   debian-10.3-kselftests
i386                        debian-10.3-kunit
i386                          debian-10.3-kvm
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-c001
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                          hp300_defconfig
m68k                          multi_defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                       bmips_be_defconfig
nios2                               defconfig
openrisc                       virt_defconfig
parisc                              defconfig
parisc                generic-64bit_defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                   motionpro_defconfig
powerpc                  storcenter_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv             nommu_k210_sdcard_defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
sh                               allmodconfig
sh                ecovec24-romimage_defconfig
sh                   rts7751r2dplus_defconfig
sparc                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                               rhel-8.3
x86_64                           rhel-8.3-bpf
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
xtensa                generic_kc705_defconfig

clang tested configs:
arm                       cns3420vb_defconfig
arm                         lpc32xx_defconfig
hexagon              randconfig-r041-20230210
hexagon              randconfig-r045-20230210
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
mips                           ip22_defconfig
powerpc                          allmodconfig
powerpc                 mpc8272_ads_defconfig
riscv                randconfig-r042-20230210
s390                 randconfig-r044-20230210
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
