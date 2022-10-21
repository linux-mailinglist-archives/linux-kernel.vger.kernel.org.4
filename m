Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A510760759A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJULIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJULII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:08:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6162582FA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666350487; x=1697886487;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ea5GORsQef7R0ghK4gYeNNtaLLLbqldfJ+IL0nGcNd0=;
  b=FEXXjPyOTp5/lhtbTRkZ38idM4WQMHoRN3rx0UCuPr0dFTXTrNBRE6zi
   lP3D1S2f0BNewbK78tC7R1NRQoWmA1R4O6zfY6U0zCYbPX286qm3lxzom
   QeUtc/dWPm22oOJtGKvQ6vZ5fw9V3P7asEcJPBVSTdnwwMVznFQJtwheY
   kSNpH54nacQ7Ra9w4fgIhxBdoTWo89V2PvhYRHDohAk9SX6n4bktmHENU
   e6n1kAiFKkZhOp55nHL8JtUXQsHoinlljTL0uu1kUeBqzQpF1n3oHra81
   sW2iwTFl8/rPHWacIgEguESMVBUmK17VMvvyi37EKaPb1oRJVkfyRyxuG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="294373724"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="294373724"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 04:08:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="719664976"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="719664976"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Oct 2022 04:08:05 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1olpsj-0002Wm-0G;
        Fri, 21 Oct 2022 11:08:05 +0000
Date:   Fri, 21 Oct 2022 19:07:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:srcunmisafe.2022.10.20a] BUILD SUCCESS
 c4c1e1794feee19cf50f14200284e0037878da04
Message-ID: <63527d6f.nsd0eOu8mpX5QrR7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git srcunmisafe.2022.10.20a
branch HEAD: c4c1e1794feee19cf50f14200284e0037878da04  srcu: Explain the reason behind the read side critical section on GP start

elapsed time: 745m

configs tested: 117
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                        randconfig-a004
powerpc                           allnoconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                        randconfig-a002
x86_64                          rhel-8.3-func
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a006
arc                  randconfig-r043-20221020
x86_64                        randconfig-a013
s390                 randconfig-r044-20221020
x86_64                        randconfig-a011
riscv                randconfig-r042-20221020
m68k                             allmodconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a015
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a014
m68k                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
m68k                            q40_defconfig
powerpc                     tqm8541_defconfig
arm                           stm32_defconfig
powerpc                      chrp32_defconfig
i386                          randconfig-c001
openrisc                         alldefconfig
powerpc                       holly_defconfig
sh                ecovec24-romimage_defconfig
arm                      footbridge_defconfig
sh                     magicpanelr2_defconfig
arm                          gemini_defconfig
mips                  maltasmvp_eva_defconfig
m68k                         apollo_defconfig
arc                        vdk_hs38_defconfig
sh                           se7712_defconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
mips                      loongson3_defconfig
xtensa                generic_kc705_defconfig
nios2                            alldefconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                     eseries_pxa_defconfig
powerpc                  storcenter_defconfig
arc                  randconfig-r043-20221019
mips                           ci20_defconfig
m68k                        mvme147_defconfig
openrisc                            defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221020

clang tested configs:
hexagon              randconfig-r041-20221020
x86_64                        randconfig-a005
hexagon              randconfig-r045-20221020
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
mips                          ath79_defconfig
arm                         shannon_defconfig
mips                     cu1830-neo_defconfig
arm                       mainstone_defconfig
arm                  colibri_pxa300_defconfig
hexagon              randconfig-r045-20221018
hexagon              randconfig-r041-20221018
powerpc                     tqm8560_defconfig
powerpc                     kmeter1_defconfig
mips                       lemote2f_defconfig
powerpc                    socrates_defconfig
arm                         orion5x_defconfig
arm                        magician_defconfig
s390                 randconfig-r044-20221019
hexagon              randconfig-r045-20221019
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221019
powerpc                 mpc8560_ads_defconfig
mips                           rs90_defconfig
x86_64                        randconfig-k001
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
arm                          ep93xx_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                          ath25_defconfig
arm                           omap1_defconfig
mips                      malta_kvm_defconfig
arm                                 defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
