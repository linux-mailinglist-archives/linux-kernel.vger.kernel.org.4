Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D5D5FCCD6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJLVOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJLVN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:13:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12635114DDF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665609237; x=1697145237;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zIZkigkFEYNmpEAppXnc5qI8LUejyj3srbQPoYUDQc8=;
  b=Hz3kJSLjHVy0qsUBMPIVWsHEaWTUfurciQB2BVKxi2UWZBhh2qQ3cT58
   VQIqo9+3yNv2hMu68Dyq5wqsKlij2WYv+yEDOq6Yv3Wi6eeiIL/PEBOUa
   u3arykT3X0uGJjIrq3fiRm8r2hmsbNS4S4uVCcURp1yo7nVvFI4fdQW9v
   1P4gV1LrbzK0SLXhwMS4VQ5OMPktD7LtlTTCb2irqrGWezqfg4ehIjycW
   R0QEQdAN68N/H6ZssLnPVYdsplE7+xpxQaLfxoH3X204aYZO0yqD8vYPm
   uwLHNN8Pk2uc4Mw0iNgjdFPnnj92U9IRhNTLyqD8HNdgz2VbPcSSso3yN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="305970559"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="305970559"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 14:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="660077273"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="660077273"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 Oct 2022 14:13:55 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oij34-0004CE-2A;
        Wed, 12 Oct 2022 21:13:54 +0000
Date:   Thu, 13 Oct 2022 05:13:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 b8d49bcd8fd19824888c766a217891855d8692ad
Message-ID: <63472e08.1v++AVopU9/DTlCg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LONGWORDS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: b8d49bcd8fd19824888c766a217891855d8692ad  Merge tag 'irqchip-fixes-6.1-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

elapsed time: 747m

configs tested: 115
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allyesconfig
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm                        keystone_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc834x_mds_defconfig
mips                       bmips_be_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arc                  randconfig-r043-20221012
s390                 randconfig-r044-20221012
riscv                randconfig-r042-20221012
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                        clps711x_defconfig
powerpc                      arches_defconfig
mips                     loongson1b_defconfig
mips                          rb532_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
powerpc                    amigaone_defconfig
mips                           ci20_defconfig
m68k                                defconfig
riscv                    nommu_k210_defconfig
xtensa                           allyesconfig
sh                           se7750_defconfig
powerpc                     rainier_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                          landisk_defconfig
sh                         ecovec24_defconfig
mips                         bigsur_defconfig
sh                           se7780_defconfig
arm                             ezx_defconfig
i386                          randconfig-c001
ia64                             allmodconfig
arm                        mini2440_defconfig
powerpc                     stx_gp3_defconfig
arm                         lpc18xx_defconfig
powerpc                  storcenter_defconfig
powerpc                 linkstation_defconfig
ia64                        generic_defconfig
powerpc                 mpc837x_mds_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                       omap2plus_defconfig
sparc                               defconfig
powerpc                     tqm8541_defconfig
arm                        spear6xx_defconfig
powerpc                      ppc40x_defconfig
sh                            shmin_defconfig
sh                        apsh4ad0a_defconfig
powerpc                       maple_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                      katmai_defconfig
mips                     cu1830-neo_defconfig
mips                      maltaaprp_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20221012
hexagon              randconfig-r041-20221012
powerpc                 mpc8560_ads_defconfig
powerpc                      obs600_defconfig
mips                           mtx1_defconfig
x86_64                        randconfig-k001
powerpc                        icon_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
