Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6CF606F29
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJUFJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJUFJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:09:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68301274E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 22:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666328972; x=1697864972;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uy7QxQw2UT4tMHGmX1B88elZY0l7qgXe4PtBXfTVSuQ=;
  b=b1DD7Y96colol0oBnA+NRMdQnOCvGA0/D8pJTyCgyje6aUmUn9QtCll0
   MRcAD0SJySMOYVXmJvhKjKRFk2JxsnVeO+Fd3rTX+vCkRgqnXFCFVhgya
   LzwxqzGTTHIgUAkIvHlZNR/Ay6sIY6H3+slQPz/Zjg2AL7n22ZzAD55sa
   HqQ7U+GEYKf1f2DubvnfhVlC3oveNKxap3rYpbFDjn8bLMdQFJ53rIyRE
   bOVmBa0rcsKX6h88q3kJavQ7QykfEzATHwc5TVXF02M4TVnlr5Vg52LTG
   Ixe3zEjQQD5ImB+Ajeyc1dCvqkFcfES25ihhFOsrWqdj0R0AZ+NTFvC0P
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="306903748"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="306903748"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 22:09:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="630281126"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="630281126"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 20 Oct 2022 22:09:22 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1olkHa-0002Ae-0z;
        Fri, 21 Oct 2022 05:09:22 +0000
Date:   Fri, 21 Oct 2022 13:09:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 dbf53a29b28b277fa952a000245b558536c6bdd7
Message-ID: <6352297a.ACQnPbTXDp2tTU0n%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: dbf53a29b28b277fa952a000245b558536c6bdd7  x86/paravirt: Fix a !PARAVIRT build warning

elapsed time: 883m

configs tested: 131
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                                defconfig
arc                                 defconfig
x86_64                              defconfig
s390                             allmodconfig
powerpc                           allnoconfig
alpha                               defconfig
arc                  randconfig-r043-20221020
x86_64                               rhel-8.3
x86_64                        randconfig-a013
m68k                             allmodconfig
s390                                defconfig
x86_64                        randconfig-a011
arc                              allyesconfig
x86_64                           rhel-8.3-syz
alpha                            allyesconfig
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a002
x86_64                        randconfig-a015
m68k                             allyesconfig
x86_64                           allyesconfig
mips                             allyesconfig
i386                             allyesconfig
s390                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
s390                 randconfig-r044-20221020
riscv                randconfig-r042-20221020
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a004
i386                          randconfig-a016
i386                          randconfig-a001
arm                                 defconfig
i386                          randconfig-a003
i386                          randconfig-a005
arm64                            allyesconfig
arm                              allyesconfig
openrisc                         alldefconfig
powerpc                       holly_defconfig
m68k                            q40_defconfig
powerpc                     tqm8541_defconfig
arm                           stm32_defconfig
powerpc                      chrp32_defconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
m68k                       m5475evb_defconfig
xtensa                              defconfig
sparc                            alldefconfig
arm                          badge4_defconfig
arc                  randconfig-r043-20221019
i386                          randconfig-c001
sh                           se7750_defconfig
sh                           se7343_defconfig
nios2                         10m50_defconfig
um                               alldefconfig
powerpc                  iss476-smp_defconfig
sh                         apsh4a3a_defconfig
m68k                         apollo_defconfig
arc                        vdk_hs38_defconfig
sh                           se7712_defconfig
arm                        oxnas_v6_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                 randconfig-c004-20221020
x86_64                        randconfig-c001
arm                  randconfig-c002-20221019
mips                           ci20_defconfig
m68k                        mvme147_defconfig
openrisc                            defconfig
mips                       bmips_be_defconfig
sh                ecovec24-romimage_defconfig
arm                      footbridge_defconfig
sh                     magicpanelr2_defconfig
arm                          gemini_defconfig
mips                  maltasmvp_eva_defconfig

clang tested configs:
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221020
x86_64                        randconfig-a012
hexagon              randconfig-r045-20221020
x86_64                        randconfig-a001
x86_64                        randconfig-a014
i386                          randconfig-a013
x86_64                        randconfig-a003
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
powerpc                     tqm8560_defconfig
powerpc                     kmeter1_defconfig
s390                 randconfig-r044-20221019
hexagon              randconfig-r045-20221019
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221019
mips                          ath79_defconfig
arm                         shannon_defconfig
mips                     cu1830-neo_defconfig
arm                           omap1_defconfig
mips                      malta_kvm_defconfig
arm                                 defconfig
x86_64                        randconfig-c007
mips                 randconfig-c004-20221019
i386                          randconfig-c001
s390                 randconfig-c005-20221019
arm                  randconfig-c002-20221019
riscv                randconfig-c006-20221019
powerpc              randconfig-c003-20221019
mips                       lemote2f_defconfig
powerpc                    socrates_defconfig
arm                         orion5x_defconfig
arm                          ep93xx_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                    gamecube_defconfig
x86_64                        randconfig-k001
arm                        magician_defconfig
arm                       mainstone_defconfig
arm                  colibri_pxa300_defconfig
hexagon              randconfig-r045-20221018
hexagon              randconfig-r041-20221018

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
