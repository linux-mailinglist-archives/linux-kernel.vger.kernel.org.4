Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9C56DAA75
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbjDGIwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbjDGIwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:52:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAA64EED
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 01:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680857558; x=1712393558;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=brzm7nw9KA0VmZA36CFS9sRkrobUJQ2XtHtermUU4n4=;
  b=SPvCBwQosbcOkGk26mT8pt+8ibcRCQbvzK2UHsEwLyGJvZ1+D92KQpvp
   faYx26BjzOPfrFFjOFtncHX9H1s6lFSYgN3vFZqLqb6E9yxrTm1P6swBd
   KhjxJ0RQycsf2BoOfrkg3HdyOo+6NHJgzMakn1enoH3dcqYKS1y+Nj3dS
   Uy6oip6XU8FCAEo8iEa0QOWugUgJuYG3MbBy+vuCZR2Oo/RMPuy1sKi7s
   yo7QRK8tOZs6mxU5Zhu2IxV4iJJejQbh8kIXn7ToPPrYQXhaO3PXwL3Q/
   /2KjeRFMAOBu1NqjST7i/snP6157NLFnnv75zRcaOEnVdIUrGYfS8nzZ8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="331598698"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="331598698"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 01:52:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="756656708"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="756656708"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Apr 2023 01:52:36 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkhpk-000SHi-02;
        Fri, 07 Apr 2023 08:52:36 +0000
Date:   Fri, 07 Apr 2023 16:52:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 5462ade6871e96646502cc95e7e05f0ab4fc84de
Message-ID: <642fd9bd.6dvX79Js+AuaL04I%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 5462ade6871e96646502cc95e7e05f0ab4fc84de  x86/boot: Centralize __pa()/__va() definitions

elapsed time: 3563m

configs tested: 454
configs skipped: 190

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230403   gcc  
alpha        buildonly-randconfig-r001-20230405   gcc  
alpha        buildonly-randconfig-r003-20230405   gcc  
alpha        buildonly-randconfig-r004-20230405   gcc  
alpha        buildonly-randconfig-r005-20230403   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230403   gcc  
alpha                randconfig-r003-20230405   gcc  
alpha                randconfig-r005-20230403   gcc  
alpha                randconfig-r016-20230403   gcc  
alpha                randconfig-r021-20230403   gcc  
alpha                randconfig-r023-20230403   gcc  
alpha                randconfig-r024-20230403   gcc  
alpha                randconfig-r025-20230403   gcc  
alpha                randconfig-r026-20230403   gcc  
alpha                randconfig-r033-20230406   gcc  
alpha                randconfig-r034-20230403   gcc  
alpha                randconfig-r036-20230403   gcc  
alpha                randconfig-r036-20230404   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230403   gcc  
arc          buildonly-randconfig-r004-20230403   gcc  
arc          buildonly-randconfig-r005-20230405   gcc  
arc          buildonly-randconfig-r006-20230403   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r001-20230405   gcc  
arc                  randconfig-r002-20230403   gcc  
arc                  randconfig-r004-20230403   gcc  
arc                  randconfig-r006-20230403   gcc  
arc                  randconfig-r021-20230403   gcc  
arc                  randconfig-r022-20230403   gcc  
arc                  randconfig-r023-20230406   gcc  
arc                  randconfig-r026-20230406   gcc  
arc                  randconfig-r031-20230403   gcc  
arc                  randconfig-r032-20230403   gcc  
arc                  randconfig-r032-20230404   gcc  
arc                  randconfig-r033-20230403   gcc  
arc                  randconfig-r034-20230403   gcc  
arc                  randconfig-r034-20230404   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                         at91_dt_defconfig   gcc  
arm          buildonly-randconfig-r003-20230403   clang
arm                        clps711x_defconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                          gemini_defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                             pxa_defconfig   gcc  
arm                  randconfig-r002-20230405   gcc  
arm                  randconfig-r005-20230405   gcc  
arm                  randconfig-r021-20230403   clang
arm                  randconfig-r025-20230405   clang
arm                  randconfig-r031-20230403   gcc  
arm                  randconfig-r032-20230405   gcc  
arm                  randconfig-r033-20230403   gcc  
arm                  randconfig-r034-20230403   gcc  
arm                  randconfig-r035-20230403   gcc  
arm                  randconfig-r046-20230403   clang
arm                        realview_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230403   clang
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230403   clang
arm64                randconfig-r004-20230403   clang
arm64                randconfig-r012-20230403   gcc  
arm64                randconfig-r013-20230403   gcc  
arm64                randconfig-r021-20230403   gcc  
arm64                randconfig-r024-20230403   gcc  
arm64                randconfig-r026-20230403   gcc  
arm64                randconfig-r026-20230405   gcc  
arm64                randconfig-r032-20230403   clang
arm64                randconfig-r035-20230403   clang
csky         buildonly-randconfig-r001-20230403   gcc  
csky         buildonly-randconfig-r002-20230403   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230403   gcc  
csky                 randconfig-r002-20230405   gcc  
csky                 randconfig-r004-20230403   gcc  
csky                 randconfig-r006-20230403   gcc  
csky                 randconfig-r011-20230403   gcc  
csky                 randconfig-r012-20230403   gcc  
csky                 randconfig-r013-20230403   gcc  
csky                 randconfig-r015-20230403   gcc  
csky                 randconfig-r021-20230403   gcc  
csky                 randconfig-r033-20230403   gcc  
csky                 randconfig-r034-20230403   gcc  
csky                 randconfig-r035-20230403   gcc  
csky                 randconfig-r036-20230405   gcc  
hexagon      buildonly-randconfig-r001-20230403   clang
hexagon      buildonly-randconfig-r003-20230403   clang
hexagon      buildonly-randconfig-r006-20230403   clang
hexagon      buildonly-randconfig-r006-20230404   clang
hexagon              randconfig-r001-20230403   clang
hexagon              randconfig-r004-20230403   clang
hexagon              randconfig-r005-20230403   clang
hexagon              randconfig-r012-20230403   clang
hexagon              randconfig-r024-20230403   clang
hexagon              randconfig-r024-20230405   clang
hexagon              randconfig-r025-20230405   clang
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r041-20230406   clang
hexagon              randconfig-r045-20230403   clang
hexagon              randconfig-r045-20230406   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                 randconfig-a012-20230403   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                          randconfig-a016   gcc  
i386                 randconfig-r014-20230403   gcc  
i386                 randconfig-r015-20230403   gcc  
i386                 randconfig-r016-20230403   gcc  
i386                 randconfig-r021-20230403   gcc  
i386                 randconfig-r022-20230403   gcc  
i386                 randconfig-r023-20230403   gcc  
i386                 randconfig-r026-20230403   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230405   gcc  
ia64         buildonly-randconfig-r002-20230403   gcc  
ia64         buildonly-randconfig-r004-20230403   gcc  
ia64         buildonly-randconfig-r006-20230403   gcc  
ia64                                defconfig   gcc  
ia64                        generic_defconfig   gcc  
ia64                 randconfig-r001-20230405   gcc  
ia64                 randconfig-r002-20230403   gcc  
ia64                 randconfig-r006-20230406   gcc  
ia64                 randconfig-r014-20230403   gcc  
ia64                 randconfig-r024-20230403   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch            randconfig-r001-20230405   gcc  
loongarch            randconfig-r006-20230403   gcc  
loongarch            randconfig-r013-20230403   gcc  
loongarch            randconfig-r023-20230405   gcc  
loongarch            randconfig-r026-20230403   gcc  
loongarch            randconfig-r031-20230403   gcc  
loongarch            randconfig-r032-20230403   gcc  
loongarch            randconfig-r032-20230406   gcc  
loongarch            randconfig-r034-20230406   gcc  
loongarch            randconfig-r035-20230403   gcc  
loongarch            randconfig-r035-20230404   gcc  
loongarch            randconfig-r036-20230403   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k         buildonly-randconfig-r001-20230403   gcc  
m68k         buildonly-randconfig-r005-20230403   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r001-20230403   gcc  
m68k                 randconfig-r003-20230406   gcc  
m68k                 randconfig-r005-20230403   gcc  
m68k                 randconfig-r012-20230403   gcc  
m68k                 randconfig-r014-20230403   gcc  
m68k                 randconfig-r021-20230405   gcc  
m68k                 randconfig-r023-20230403   gcc  
m68k                 randconfig-r024-20230403   gcc  
m68k                 randconfig-r033-20230404   gcc  
m68k                 randconfig-r034-20230404   gcc  
m68k                 randconfig-r035-20230403   gcc  
m68k                 randconfig-r036-20230406   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze   buildonly-randconfig-r006-20230403   gcc  
microblaze           randconfig-r005-20230403   gcc  
microblaze           randconfig-r011-20230403   gcc  
microblaze           randconfig-r015-20230403   gcc  
microblaze           randconfig-r016-20230403   gcc  
microblaze           randconfig-r023-20230403   gcc  
microblaze           randconfig-r024-20230403   gcc  
microblaze           randconfig-r031-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips         buildonly-randconfig-r002-20230404   clang
mips         buildonly-randconfig-r004-20230403   gcc  
mips         buildonly-randconfig-r006-20230405   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                 randconfig-r002-20230405   gcc  
mips                 randconfig-r004-20230403   gcc  
mips                 randconfig-r015-20230403   clang
mips                 randconfig-r021-20230403   clang
mips                 randconfig-r022-20230405   clang
mips                 randconfig-r024-20230403   clang
mips                 randconfig-r024-20230406   gcc  
mips                 randconfig-r026-20230403   clang
mips                 randconfig-r033-20230403   gcc  
mips                 randconfig-r034-20230403   gcc  
mips                          rb532_defconfig   gcc  
mips                           rs90_defconfig   clang
nios2                            allyesconfig   gcc  
nios2        buildonly-randconfig-r003-20230403   gcc  
nios2        buildonly-randconfig-r006-20230403   gcc  
nios2        buildonly-randconfig-r006-20230405   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230403   gcc  
nios2                randconfig-r001-20230406   gcc  
nios2                randconfig-r014-20230403   gcc  
nios2                randconfig-r022-20230403   gcc  
nios2                randconfig-r023-20230403   gcc  
nios2                randconfig-r024-20230403   gcc  
nios2                randconfig-r032-20230403   gcc  
nios2                randconfig-r033-20230404   gcc  
nios2                randconfig-r035-20230403   gcc  
openrisc     buildonly-randconfig-r001-20230403   gcc  
openrisc     buildonly-randconfig-r002-20230405   gcc  
openrisc     buildonly-randconfig-r003-20230403   gcc  
openrisc     buildonly-randconfig-r006-20230403   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r006-20230403   gcc  
openrisc             randconfig-r006-20230405   gcc  
openrisc             randconfig-r011-20230403   gcc  
openrisc             randconfig-r013-20230403   gcc  
openrisc             randconfig-r016-20230403   gcc  
openrisc             randconfig-r022-20230403   gcc  
openrisc             randconfig-r025-20230403   gcc  
openrisc             randconfig-r026-20230403   gcc  
openrisc             randconfig-r034-20230403   gcc  
openrisc             randconfig-r035-20230403   gcc  
openrisc                 simple_smp_defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc       buildonly-randconfig-r003-20230403   gcc  
parisc       buildonly-randconfig-r005-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230403   gcc  
parisc               randconfig-r003-20230405   gcc  
parisc               randconfig-r006-20230405   gcc  
parisc               randconfig-r011-20230403   gcc  
parisc               randconfig-r013-20230403   gcc  
parisc               randconfig-r014-20230403   gcc  
parisc               randconfig-r034-20230403   gcc  
parisc               randconfig-r035-20230403   gcc  
parisc               randconfig-r036-20230403   gcc  
parisc               randconfig-r036-20230406   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc      buildonly-randconfig-r003-20230403   gcc  
powerpc      buildonly-randconfig-r003-20230404   clang
powerpc      buildonly-randconfig-r004-20230403   gcc  
powerpc      buildonly-randconfig-r005-20230403   gcc  
powerpc      buildonly-randconfig-r006-20230403   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                    ge_imp3a_defconfig   clang
powerpc                       holly_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc                     pq2fads_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc              randconfig-r012-20230403   gcc  
powerpc              randconfig-r014-20230403   gcc  
powerpc              randconfig-r015-20230403   gcc  
powerpc              randconfig-r025-20230403   gcc  
powerpc              randconfig-r036-20230403   clang
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230404   clang
riscv        buildonly-randconfig-r002-20230403   gcc  
riscv        buildonly-randconfig-r002-20230405   gcc  
riscv        buildonly-randconfig-r004-20230405   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230403   clang
riscv                randconfig-r012-20230403   gcc  
riscv                randconfig-r013-20230403   gcc  
riscv                randconfig-r014-20230403   gcc  
riscv                randconfig-r015-20230403   gcc  
riscv                randconfig-r016-20230403   gcc  
riscv                randconfig-r021-20230403   gcc  
riscv                randconfig-r031-20230406   gcc  
riscv                randconfig-r032-20230404   gcc  
riscv                randconfig-r032-20230406   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                randconfig-r042-20230406   clang
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230403   gcc  
s390         buildonly-randconfig-r003-20230403   gcc  
s390         buildonly-randconfig-r005-20230403   gcc  
s390         buildonly-randconfig-r006-20230405   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230403   clang
s390                 randconfig-r004-20230403   clang
s390                 randconfig-r005-20230406   gcc  
s390                 randconfig-r012-20230403   gcc  
s390                 randconfig-r031-20230404   gcc  
s390                 randconfig-r044-20230403   gcc  
s390                 randconfig-r044-20230406   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230403   gcc  
sh           buildonly-randconfig-r003-20230403   gcc  
sh           buildonly-randconfig-r005-20230403   gcc  
sh                        edosk7760_defconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r001-20230403   gcc  
sh                   randconfig-r002-20230406   gcc  
sh                   randconfig-r003-20230403   gcc  
sh                   randconfig-r005-20230405   gcc  
sh                   randconfig-r011-20230403   gcc  
sh                   randconfig-r021-20230406   gcc  
sh                   randconfig-r025-20230405   gcc  
sh                   randconfig-r026-20230403   gcc  
sh                   randconfig-r031-20230403   gcc  
sh                   randconfig-r034-20230403   gcc  
sh                   randconfig-r036-20230403   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc        buildonly-randconfig-r001-20230403   gcc  
sparc        buildonly-randconfig-r002-20230403   gcc  
sparc        buildonly-randconfig-r003-20230403   gcc  
sparc        buildonly-randconfig-r004-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230403   gcc  
sparc                randconfig-r021-20230403   gcc  
sparc                randconfig-r024-20230403   gcc  
sparc                randconfig-r025-20230403   gcc  
sparc                randconfig-r031-20230403   gcc  
sparc                randconfig-r032-20230403   gcc  
sparc                randconfig-r033-20230406   gcc  
sparc                randconfig-r034-20230403   gcc  
sparc                randconfig-r035-20230404   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64      buildonly-randconfig-r001-20230405   gcc  
sparc64      buildonly-randconfig-r002-20230403   gcc  
sparc64      buildonly-randconfig-r006-20230403   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r004-20230405   gcc  
sparc64              randconfig-r004-20230406   gcc  
sparc64              randconfig-r005-20230403   gcc  
sparc64              randconfig-r014-20230403   gcc  
sparc64              randconfig-r022-20230403   gcc  
sparc64              randconfig-r024-20230403   gcc  
sparc64              randconfig-r026-20230403   gcc  
sparc64              randconfig-r031-20230403   gcc  
sparc64              randconfig-r033-20230403   gcc  
sparc64              randconfig-r034-20230404   gcc  
sparc64              randconfig-r034-20230406   gcc  
sparc64              randconfig-r035-20230406   gcc  
sparc64              randconfig-r036-20230403   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64               randconfig-a006-20230403   clang
x86_64               randconfig-a011-20230403   gcc  
x86_64                        randconfig-a011   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230403   gcc  
x86_64                        randconfig-a013   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230403   gcc  
x86_64                        randconfig-a015   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-k001-20230403   gcc  
x86_64               randconfig-r001-20230403   clang
x86_64               randconfig-r005-20230403   clang
x86_64               randconfig-r012-20230403   gcc  
x86_64               randconfig-r013-20230403   gcc  
x86_64               randconfig-r016-20230403   gcc  
x86_64               randconfig-r023-20230403   gcc  
x86_64               randconfig-r026-20230403   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230403   gcc  
xtensa       buildonly-randconfig-r005-20230403   gcc  
xtensa               randconfig-r001-20230403   gcc  
xtensa               randconfig-r005-20230405   gcc  
xtensa               randconfig-r012-20230403   gcc  
xtensa               randconfig-r021-20230403   gcc  
xtensa               randconfig-r022-20230403   gcc  
xtensa               randconfig-r025-20230406   gcc  
xtensa               randconfig-r026-20230403   gcc  
xtensa               randconfig-r031-20230406   gcc  
xtensa               randconfig-r033-20230403   gcc  
xtensa               randconfig-r035-20230404   gcc  
xtensa               randconfig-r035-20230406   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
