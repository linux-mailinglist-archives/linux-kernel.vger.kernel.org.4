Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3328D66A880
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 03:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjANCCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 21:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjANCB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 21:01:57 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682FF88DF3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 18:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673661716; x=1705197716;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mpgSLZERDl3IgAgPOYsmnVG8z+c+BSVAmx+j8c4cM6o=;
  b=EHCZY1hPyodcPTcqcftxS/UfV1r2iE8l1/cBWbOZoPZ31OpA2jHjLUFU
   oPuo9V5ShruZcfqhxa8QegRiU8Vnbw/aYAfspwJoUNL64jQTJBeZjhGEL
   CoCRadqSSDitYqbpBH+Vc4Vltk2N8yR9l9NceBHXUyawp2qAuFwo+stpD
   DQyu5SE8uha3+3/2VdFBubtYBoLAlk7tDoEohEKs+luXmQIww0MITBzcW
   arXkt4EItc8nhy6BQlexglbJilJReyTXH/vpGB183518HhGytYKKypBmN
   mbK0vgNQ5r3aeeg8j39m9ubv95J0QJdqTFWUcdZfs0sIVLfEw/fJtvZJq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="303850202"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="303850202"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 18:01:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="747119761"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="747119761"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jan 2023 18:01:54 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGVrm-000BdS-18;
        Sat, 14 Jan 2023 02:01:54 +0000
Date:   Sat, 14 Jan 2023 10:01:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 e12ad468c22065a2826b2fc4c11d2113a7975301
Message-ID: <63c20cdf.GI4nRBEYLNhh9pL6%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: e12ad468c22065a2826b2fc4c11d2113a7975301  x86/gsseg: Add the new <asm/gsseg.h> header to <asm/asm-prototypes.h>

elapsed time: 786m

configs tested: 119
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
x86_64                            allnoconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
powerpc                           allnoconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arc                  randconfig-r043-20230112
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a004
riscv                randconfig-r042-20230112
x86_64                        randconfig-a002
s390                 randconfig-r044-20230112
arm                                 defconfig
x86_64                           rhel-8.3-bpf
i386                                defconfig
i386                          randconfig-a005
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
x86_64                        randconfig-a006
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
arc                              allyesconfig
arm64                            allyesconfig
alpha                            allyesconfig
x86_64                               rhel-8.3
arm                              allyesconfig
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
mips                             allyesconfig
ia64                             allmodconfig
powerpc                          allmodconfig
sparc                             allnoconfig
powerpc                    amigaone_defconfig
mips                           xway_defconfig
arm                         vf610m4_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                        m5307c3_defconfig
ia64                            zx1_defconfig
arc                     haps_hs_smp_defconfig
arm                             ezx_defconfig
mips                         rt305x_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arm                           corgi_defconfig
mips                        vocore2_defconfig
arm64                               defconfig
mips                 decstation_r4k_defconfig
powerpc                       maple_defconfig
sh                          urquell_defconfig
openrisc                         alldefconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                        cerfcube_defconfig
microblaze                          defconfig
powerpc                      mgcoge_defconfig
parisc                generic-64bit_defconfig
arc                         haps_hs_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
mips                     loongson1b_defconfig
arm                           viper_defconfig
arm                       imx_v6_v7_defconfig
um                                  defconfig
arc                          axs101_defconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                           imxrt_defconfig
sh                          rsk7269_defconfig
sh                        sh7785lcr_defconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
arm                  randconfig-r046-20230112
x86_64                        randconfig-a016
hexagon              randconfig-r041-20230112
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r045-20230112
x86_64                        randconfig-a001
i386                          randconfig-a006
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-k001
riscv                randconfig-r042-20230113
s390                 randconfig-r044-20230113
hexagon              randconfig-r041-20230113
hexagon              randconfig-r045-20230113

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
