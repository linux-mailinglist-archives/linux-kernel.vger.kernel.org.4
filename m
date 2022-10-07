Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4EE5F7E0D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiJGTfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJGTfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:35:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDA142D74
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665171301; x=1696707301;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=A1JVSJumD15xJOvO47sg+6LNAU7gON9Nkn4nIzM3pMU=;
  b=K+vNvFGgIX7oRZr0r6uU25HD3R3/5nYvQFg5NY/m0tvk13/VvTbsX3TT
   6CcKZdYA7OfQhg2fP06N+j9HZyIsr3rz+wzO78vcq8wiYO/h6kfOhMLlO
   wPw8mlTjL2pYiNyZIRMz3MYGygsQQo97qDY9LjSC7FEITII0zGAy+4TbG
   P+w522nT2JnAL6wG0iag9oU3bqZnZ9JPUHnBSp8rIPE/3N4xjrKfVQxtU
   26uHm4nMRy8w9dLPqf/D/MtlsZep6NXHu7tjEmz3uNjttw9ia1VI1CNs+
   6oZrDRI1x59aa5SXYHx2XfB3JCunOlZBhqLP5s9dH7s3FduGjMpl5cAKZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="284188678"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="284188678"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 12:34:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="656176587"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="656176587"
Received: from lkp-server01.sh.intel.com (HELO 3c15167049b7) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Oct 2022 12:34:58 -0700
Received: from kbuild by 3c15167049b7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogt7Z-0001SN-1A;
        Fri, 07 Oct 2022 19:34:57 +0000
Date:   Sat, 08 Oct 2022 03:34:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 8e0b84a8b7f8a448f5439eed087f68eec5e775ac
Message-ID: <63407f58.irN3GWl1u48UCgM/%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 8e0b84a8b7f8a448f5439eed087f68eec5e775ac  Merge branch into tip/master: 'x86/mm'

elapsed time: 728m

configs tested: 138
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
i386                                defconfig
x86_64                           rhel-8.3-syz
arm                                 defconfig
powerpc                           allnoconfig
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
s390                                defconfig
riscv                randconfig-r042-20221007
s390                             allmodconfig
mips                             allyesconfig
arc                  randconfig-r043-20221007
powerpc                          allmodconfig
sh                               allmodconfig
arc                  randconfig-r043-20221006
x86_64                           allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
s390                             allyesconfig
s390                 randconfig-r044-20221007
alpha                            allyesconfig
arm64                            allyesconfig
x86_64               randconfig-a011-20221003
i386                             allyesconfig
arm                              allyesconfig
i386                 randconfig-a011-20221003
x86_64               randconfig-a015-20221003
i386                 randconfig-a012-20221003
x86_64               randconfig-a014-20221003
i386                 randconfig-a013-20221003
x86_64               randconfig-a012-20221003
i386                 randconfig-a015-20221003
x86_64               randconfig-a013-20221003
i386                 randconfig-a016-20221003
powerpc                 mpc85xx_cds_defconfig
sh                            migor_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm8555_defconfig
nios2                            alldefconfig
x86_64               randconfig-a016-20221003
i386                 randconfig-a014-20221003
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                        warp_defconfig
powerpc                      makalu_defconfig
csky                             alldefconfig
arc                      axs103_smp_defconfig
mips                            gpr_defconfig
i386                          randconfig-c001
ia64                             allmodconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
arc                  randconfig-r043-20221002
s390                 randconfig-r044-20221003
powerpc                  storcenter_defconfig
powerpc                     mpc83xx_defconfig
mips                  maltasmvp_eva_defconfig
arm                         s3c6400_defconfig
mips                     loongson1b_defconfig
powerpc                     asp8347_defconfig
m68k                          hp300_defconfig
arm                        keystone_defconfig
sh                           se7751_defconfig
sh                         ap325rxa_defconfig
arm                  randconfig-c002-20221002
x86_64                        randconfig-c001
mips                        bcm47xx_defconfig
sparc64                             defconfig
mips                      loongson3_defconfig
microblaze                          defconfig
arm64                            alldefconfig
openrisc                    or1ksim_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc                           allyesconfig
xtensa                         virt_defconfig
powerpc                    adder875_defconfig
powerpc                      pcm030_defconfig
riscv                            allmodconfig
mips                       bmips_be_defconfig
powerpc                     ep8248e_defconfig
sh                  sh7785lcr_32bit_defconfig
sparc64                          alldefconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
um                               alldefconfig
powerpc                     sequoia_defconfig
sh                          kfr2r09_defconfig

clang tested configs:
hexagon              randconfig-r045-20221006
s390                 randconfig-r044-20221006
hexagon              randconfig-r041-20221006
riscv                randconfig-r042-20221006
hexagon              randconfig-r045-20221007
hexagon              randconfig-r041-20221007
i386                 randconfig-a003-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a006-20221003
i386                 randconfig-a002-20221003
x86_64               randconfig-a003-20221003
i386                 randconfig-a001-20221003
x86_64               randconfig-a005-20221003
i386                 randconfig-a006-20221003
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
powerpc                   microwatt_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      obs600_defconfig
arm                       cns3420vb_defconfig
x86_64                        randconfig-k001
powerpc                   bluestone_defconfig
powerpc                          g5_defconfig
powerpc                      pmac32_defconfig
arm                                 defconfig
powerpc                      ppc44x_defconfig
arm                     am200epdkit_defconfig
powerpc                    gamecube_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                 mpc832x_mds_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
