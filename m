Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803115F12E9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiI3Tm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiI3TmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:42:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7921710C3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664566940; x=1696102940;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+WW0xD5CX15Pni0Fdj0A8XL7ERBwrltJ94jfZXN77kw=;
  b=XeTwsYTjc5VXja57HX3Rj0YlM1s53mkRCTCtPmorUPi9j2j0sFqCKgUi
   jbaRZ+vR4P2H7JlC4BUgh0QSfvF9JW/sStNuUBTnKytOXlyHST5knxyW5
   LoaZuM93ktU+SHhbP6nK91btwUJ2vzYIiIqxT297AS+iN0RUfyrVPuRbP
   MidTVGJyi0Csz1c9pmfsEUdsTbuOah1rEoRFCHJ8bFjKqN91FzK1TGJKl
   iQZhVq17Kr9YPS9cdNWz/I3dT2QnY8asW1b9GCTZxrANsiYq4S9EqkVGk
   EJKpr9+I3f8DDKvySBNh54umJ/r2KygFIrrPltYrTzxjOU3H2qBiTgEwl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="366325302"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="366325302"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 12:42:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="573971998"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="573971998"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Sep 2022 12:41:56 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oeLtR-0001Tv-2v;
        Fri, 30 Sep 2022 19:41:53 +0000
Date:   Sat, 01 Oct 2022 03:40:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 334b2cea811944df99ae2172bcc0effcdfdbe862
Message-ID: <63374649.CW8OdLPJBit2G1Ga%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 334b2cea811944df99ae2172bcc0effcdfdbe862  x86/mm: Add prot_sethuge() helper to abstract out _PAGE_PSE handling

elapsed time: 1597m

configs tested: 158
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
x86_64                              defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
x86_64                               rhel-8.3
s390                                defconfig
alpha                            allyesconfig
s390                             allmodconfig
arc                              allyesconfig
x86_64                           allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
s390                             allyesconfig
mips                             allyesconfig
x86_64                           rhel-8.3-syz
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
i386                                defconfig
arc                  randconfig-r043-20220925
riscv                randconfig-r042-20220925
arc                  randconfig-r043-20220926
s390                 randconfig-r044-20220925
x86_64                        randconfig-a002
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a006
sh                             sh03_defconfig
sh                               j2_defconfig
m68k                       m5249evb_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
mips                     decstation_defconfig
sh                         apsh4a3a_defconfig
m68k                        mvme147_defconfig
sh                             shx3_defconfig
sh                     magicpanelr2_defconfig
mips                      fuloong2e_defconfig
i386                          randconfig-c001
i386                 randconfig-a003-20220926
i386                 randconfig-a001-20220926
i386                 randconfig-a006-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a005-20220926
i386                 randconfig-a002-20220926
arm                          pxa3xx_defconfig
sh                          landisk_defconfig
nios2                            allyesconfig
sh                            hp6xx_defconfig
powerpc                      cm5200_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                           se7722_defconfig
powerpc                 mpc837x_mds_defconfig
sh                            migor_defconfig
xtensa                          iss_defconfig
sh                        edosk7760_defconfig
mips                         rt305x_defconfig
sh                 kfr2r09-romimage_defconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm                         assabet_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220925
sparc                             allnoconfig
powerpc                    sam440ep_defconfig
arm                         at91_dt_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
x86_64                           alldefconfig
m68k                        m5307c3_defconfig
x86_64               randconfig-a002-20220926
x86_64               randconfig-a001-20220926
x86_64               randconfig-a004-20220926
x86_64               randconfig-a006-20220926
x86_64               randconfig-a005-20220926
x86_64               randconfig-a003-20220926
powerpc                        cell_defconfig
m68k                                defconfig
arm                          gemini_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
powerpc                      ppc6xx_defconfig
sh                          rsk7269_defconfig
arm                            xcep_defconfig
arm64                               defconfig
arm                              allmodconfig
ia64                                defconfig
mips                             allmodconfig
arm                       omap2plus_defconfig
powerpc                     ep8248e_defconfig
arm                             ezx_defconfig
powerpc                       maple_defconfig
mips                       bmips_be_defconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20220928
hexagon              randconfig-r045-20220928
riscv                randconfig-r042-20220928
s390                 randconfig-r044-20220928
x86_64                        randconfig-a005
arm                         hackkit_defconfig
powerpc                      walnut_defconfig
mips                        maltaup_defconfig
x86_64               randconfig-a016-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a014-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a015-20220926
x86_64                        randconfig-k001
i386                 randconfig-a011-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a016-20220926
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                   microwatt_defconfig
mips                      malta_kvm_defconfig
powerpc                  mpc885_ads_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
