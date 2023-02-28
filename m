Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA39B6A5A61
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjB1Nvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjB1Nvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:51:52 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780482DE62
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677592303; x=1709128303;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qdhyhSG2q4g8od+nQoD8vr632OZziZi6ddb2PgHXUVQ=;
  b=CxXTA/IAfCKbal226gj3xKrRhzxe/9HGBsSbIj+rVHolNjy3uqBOOwH8
   zu93Q+y0ujjfmRy1O7zmhIuzIENxVRlt0HWY/EcLMwat+9sje4rkdSRJW
   /7Y0EREYVeFwEuPv/Sdew0pcl6KEoW59UdY1wKQyj1fd/JFuaiHsGkXZl
   ni3xXDa0DZIkKY/2Qb9r9hqp6eT8gHkYZ/q1eYou8VVPhkEsSzRkYF/+/
   L/mMmVHd4BpHcg4J3U8pWnQtUBDnjKGdzmc4rx/4EzD9DmJ8ngFwv1+uh
   lnEhGZSobMFs7NtLihvhCa2mcihcM/06nW1XDbEZzJUZvg98kZkoSVeM7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="396704293"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="396704293"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 05:51:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="1003248801"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="1003248801"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Feb 2023 05:51:35 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pX0OE-0005Qp-33;
        Tue, 28 Feb 2023 13:51:34 +0000
Date:   Tue, 28 Feb 2023 21:50:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.02.24a] BUILD SUCCESS
 4494d173d8208b4e467c88f53f989dfaf995097d
Message-ID: <63fe06c3.RzZwAbHKcCDIVtR+%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.02.24a
branch HEAD: 4494d173d8208b4e467c88f53f989dfaf995097d  kernel/smp: Make csdlock_debug= resettable

elapsed time: 721m

configs tested: 188
configs skipped: 20

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230227   gcc  
alpha        buildonly-randconfig-r006-20230227   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230226   gcc  
alpha                randconfig-r021-20230227   gcc  
alpha                randconfig-r034-20230226   gcc  
alpha                randconfig-r035-20230226   gcc  
alpha                randconfig-r035-20230227   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230226   gcc  
arc                  randconfig-r021-20230226   gcc  
arc                  randconfig-r036-20230227   gcc  
arc                  randconfig-r043-20230226   gcc  
arc                  randconfig-r043-20230227   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm          buildonly-randconfig-r001-20230228   gcc  
arm                                 defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                        oxnas_v6_defconfig   gcc  
arm                  randconfig-r015-20230227   clang
arm                  randconfig-r022-20230227   clang
arm                  randconfig-r046-20230226   gcc  
arm                  randconfig-r046-20230227   clang
arm                           stm32_defconfig   gcc  
arm                       versatile_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230227   gcc  
arm64                randconfig-r031-20230227   clang
arm64                randconfig-r034-20230227   clang
csky                                defconfig   gcc  
csky                 randconfig-r004-20230226   gcc  
csky                 randconfig-r011-20230227   gcc  
csky                 randconfig-r016-20230227   gcc  
csky                 randconfig-r023-20230227   gcc  
hexagon      buildonly-randconfig-r006-20230226   clang
hexagon              randconfig-r024-20230227   clang
hexagon              randconfig-r035-20230226   clang
hexagon              randconfig-r035-20230227   clang
hexagon              randconfig-r041-20230226   clang
hexagon              randconfig-r041-20230227   clang
hexagon              randconfig-r045-20230226   clang
hexagon              randconfig-r045-20230227   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r002-20230227   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230227   clang
i386                 randconfig-a002-20230227   clang
i386                 randconfig-a003-20230227   clang
i386                 randconfig-a004-20230227   clang
i386                 randconfig-a005-20230227   clang
i386                 randconfig-a006-20230227   clang
i386                 randconfig-a011-20230227   gcc  
i386                 randconfig-a012-20230227   gcc  
i386                 randconfig-a013-20230227   gcc  
i386                 randconfig-a014-20230227   gcc  
i386                 randconfig-a015-20230227   gcc  
i386                 randconfig-a016-20230227   gcc  
i386                          randconfig-c001   gcc  
i386                 randconfig-r002-20230227   clang
i386                 randconfig-r014-20230227   gcc  
i386                 randconfig-r025-20230227   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r022-20230227   gcc  
ia64                 randconfig-r032-20230227   gcc  
ia64                 randconfig-r036-20230226   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230226   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230226   gcc  
loongarch            randconfig-r014-20230226   gcc  
loongarch            randconfig-r031-20230226   gcc  
loongarch            randconfig-r034-20230226   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230226   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r012-20230226   gcc  
m68k                 randconfig-r014-20230227   gcc  
m68k                 randconfig-r025-20230227   gcc  
m68k                 randconfig-r033-20230226   gcc  
microblaze   buildonly-randconfig-r001-20230227   gcc  
microblaze   buildonly-randconfig-r006-20230228   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230226   clang
mips         buildonly-randconfig-r005-20230226   clang
mips                 randconfig-r033-20230226   clang
mips                 randconfig-r036-20230227   gcc  
mips                           xway_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r023-20230226   gcc  
nios2                randconfig-r024-20230227   gcc  
nios2                randconfig-r026-20230227   gcc  
openrisc     buildonly-randconfig-r003-20230226   gcc  
openrisc             randconfig-r002-20230226   gcc  
openrisc             randconfig-r011-20230226   gcc  
openrisc             randconfig-r016-20230226   gcc  
openrisc             randconfig-r026-20230226   gcc  
parisc       buildonly-randconfig-r003-20230227   gcc  
parisc       buildonly-randconfig-r004-20230226   gcc  
parisc       buildonly-randconfig-r006-20230227   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230227   gcc  
parisc               randconfig-r015-20230226   gcc  
parisc               randconfig-r025-20230226   gcc  
parisc               randconfig-r033-20230227   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230226   clang
powerpc      buildonly-randconfig-r003-20230228   clang
powerpc      buildonly-randconfig-r006-20230226   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                mpc7448_hpc2_defconfig   gcc  
powerpc                 mpc834x_mds_defconfig   gcc  
powerpc              randconfig-r022-20230226   clang
powerpc              randconfig-r036-20230226   gcc  
powerpc                    sam440ep_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230226   clang
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230226   gcc  
riscv                randconfig-r014-20230226   clang
riscv                randconfig-r015-20230226   clang
riscv                randconfig-r042-20230226   clang
riscv                randconfig-r042-20230227   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230227   gcc  
s390                 randconfig-r044-20230226   clang
s390                 randconfig-r044-20230227   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230228   gcc  
sh                               j2_defconfig   gcc  
sh                   randconfig-r001-20230226   gcc  
sh                   randconfig-r011-20230226   gcc  
sh                   randconfig-r012-20230227   gcc  
sh                   randconfig-r013-20230227   gcc  
sh                   randconfig-r033-20230227   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc        buildonly-randconfig-r005-20230227   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230227   gcc  
sparc                randconfig-r021-20230227   gcc  
sparc                randconfig-r032-20230226   gcc  
sparc64      buildonly-randconfig-r005-20230228   gcc  
sparc64              randconfig-r012-20230226   gcc  
um                               alldefconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230227   clang
x86_64               randconfig-a002-20230227   clang
x86_64               randconfig-a003-20230227   clang
x86_64               randconfig-a004-20230227   clang
x86_64               randconfig-a005-20230227   clang
x86_64               randconfig-a006-20230227   clang
x86_64               randconfig-a011-20230227   gcc  
x86_64               randconfig-a012-20230227   gcc  
x86_64               randconfig-a013-20230227   gcc  
x86_64               randconfig-a014-20230227   gcc  
x86_64               randconfig-a015-20230227   gcc  
x86_64               randconfig-a016-20230227   gcc  
x86_64               randconfig-r004-20230227   clang
x86_64               randconfig-r015-20230227   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230227   gcc  
xtensa               randconfig-r016-20230226   gcc  
xtensa               randconfig-r032-20230226   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
