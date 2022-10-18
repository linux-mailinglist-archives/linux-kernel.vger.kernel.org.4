Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A4A6036C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 01:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJRXuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 19:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJRXuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 19:50:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57C92C134
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666137011; x=1697673011;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GtMrdMwCOcFC8fDs92mIk6Tv9+LaVjzoZHpIZlEDWAY=;
  b=UXhdYB6PN5uKHFzymPktLBShCoyyFpT/L73qO7ciEk4rdP+my7NfuzwE
   SOTWoeK0lhEDia/ikMK8sV/sPb3gF8q/hjhh4qHN5PTxgQl1ZGhr8Hxn/
   utV2PyrFOcixVzttWlk2LLzSOY8rJ8/2L+KydJvJlEspgZDHV46LwQTtm
   DXKIL/RAZC38cgIDEf9p1GwNr5F4ip63XPtv1YugZWW4Bp2FnRDJcKpm+
   K/cQY4cV+aXI6iJUAlLuNNIYgncSyOCh/+ndPYFe/w1PD83gUsD39ESs5
   Dug3Ko0nP8cwe8K0AV+elhsEf39IEz7RSqR/Rmrdx1MJ2s1iTjJBZ5Vjp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="392564700"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="392564700"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 16:50:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="580051832"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="580051832"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Oct 2022 16:50:09 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1okwLY-0002BO-1X;
        Tue, 18 Oct 2022 23:50:08 +0000
Date:   Wed, 19 Oct 2022 07:49:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 de1e44cd1509314b2f77d431754fd2f2b2b0a08a
Message-ID: <634f3b94.PzPPv8fiN/nLsO4R%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: de1e44cd1509314b2f77d431754fd2f2b2b0a08a  Merge branch into tip/master: 'x86/urgent'

elapsed time: 722m

configs tested: 139
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
arc                  randconfig-r043-20221018
alpha                               defconfig
i386                                defconfig
x86_64                        randconfig-a004
i386                          randconfig-a001
riscv                randconfig-r042-20221018
x86_64                        randconfig-a002
s390                 randconfig-r044-20221018
i386                          randconfig-a003
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a006
x86_64                          rhel-8.3-func
i386                          randconfig-a005
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
s390                             allmodconfig
mips                             allyesconfig
m68k                             allmodconfig
x86_64                              defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                             allyesconfig
x86_64                               rhel-8.3
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                           allyesconfig
s390                                defconfig
s390                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                        cerfcube_defconfig
sh                  sh7785lcr_32bit_defconfig
i386                          randconfig-a014
i386                          randconfig-a012
mips                           jazz_defconfig
arm                         lpc18xx_defconfig
powerpc                     asp8347_defconfig
mips                  maltasmvp_eva_defconfig
i386                          randconfig-a016
i386                          randconfig-c001
sh                   sh7724_generic_defconfig
ia64                          tiger_defconfig
microblaze                      mmu_defconfig
powerpc                      ppc6xx_defconfig
xtensa                  audio_kc705_defconfig
arc                           tb10x_defconfig
openrisc                 simple_smp_defconfig
sparc                             allnoconfig
powerpc                     tqm8541_defconfig
powerpc                     stx_gp3_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        trizeps4_defconfig
powerpc                 linkstation_defconfig
m68k                        mvme16x_defconfig
ia64                                defconfig
arm                        mvebu_v7_defconfig
nios2                               defconfig
m68k                          amiga_defconfig
openrisc                         alldefconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221018
arm                       imx_v6_v7_defconfig
sparc                       sparc64_defconfig
m68k                       m5475evb_defconfig
arm                          gemini_defconfig
powerpc                      ep88xc_defconfig
csky                              allnoconfig
arm                            mps2_defconfig
arc                  randconfig-r043-20221017
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                        spear6xx_defconfig
arm                         assabet_defconfig
mips                 decstation_r4k_defconfig
sh                          r7780mp_defconfig
arm                         axm55xx_defconfig
ia64                        generic_defconfig
arm                           tegra_defconfig
powerpc                      chrp32_defconfig
mips                         db1xxx_defconfig
powerpc                  storcenter_defconfig
powerpc                 canyonlands_defconfig
sh                          urquell_defconfig
m68k                                defconfig
sh                 kfr2r09-romimage_defconfig
s390                       zfcpdump_defconfig
openrisc                            defconfig
powerpc                     tqm8548_defconfig
openrisc                  or1klitex_defconfig

clang tested configs:
hexagon              randconfig-r041-20221018
hexagon              randconfig-r045-20221018
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a003
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
i386                          randconfig-a013
x86_64                        randconfig-k001
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-c007
mips                 randconfig-c004-20221018
i386                          randconfig-c001
s390                 randconfig-c005-20221018
arm                  randconfig-c002-20221018
riscv                randconfig-c006-20221018
powerpc              randconfig-c003-20221018
arm                      tct_hammer_defconfig
riscv                             allnoconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      ppc44x_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
