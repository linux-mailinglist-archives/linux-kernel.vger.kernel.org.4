Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8A76163EE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiKBNhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKBNhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:37:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DF52AC66
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 06:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667396236; x=1698932236;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Q91NMD6XfZ2xY8l4FsEk3jmPUcBruDrCV+ByTDntWMg=;
  b=HTGM/6uzUtNQsFrznRxNpeHYtea+hwmp9YkAuNPyKCpie2QgIoI92SZC
   HJx8S+8KbKSVOGI0j7sSVXLmFkjSYj9HWj7mOA9mKeVGt6T4XtPANyVag
   ks6966xvKz8Gat8oGvOHP5Gye+6gG0l6ExB9fO1B+0HzpvEC4OemFAdeO
   1mOb5RWtNi/5gkaNPD2X3zlksJIPJqV8S5tpye3vZwOfVT/EPKaWwZXUw
   akjsy4b1Ht/KrSnak+AM3Atv1NKoIEhSnRntoRCmA7R703z8Emsd/+ifz
   TLTR7fFt9+RW5eAs9xeijxWac5U6X9iwvhDeNAe8A4Gb+1mpsPV+A0+yw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="395714413"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="395714413"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 06:37:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="697810467"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="697810467"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 02 Nov 2022 06:36:59 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqDvN-000Em5-13;
        Wed, 02 Nov 2022 13:36:57 +0000
Date:   Wed, 02 Nov 2022 21:36:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 9399f613f2fe4ef95fd86c54b6efd98076dcfe12
Message-ID: <63627247.CloVBrstU+OzPqaV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 9399f613f2fe4ef95fd86c54b6efd98076dcfe12  locking/memory-barriers.txt: Improve documentation for writel() example

elapsed time: 1037m

configs tested: 113
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
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
s390                             allyesconfig
sh                               allmodconfig
ia64                             allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
sparc                             allnoconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                       common_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
m68k                        m5272c3_defconfig
sh                          r7780mp_defconfig
sh                          r7785rp_defconfig
sparc64                          alldefconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-a016-20221031
i386                 randconfig-a012-20221031
i386                 randconfig-a015-20221031
i386                 randconfig-a013-20221031
i386                 randconfig-a014-20221031
i386                 randconfig-a011-20221031
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm64                            alldefconfig
powerpc                 linkstation_defconfig
m68k                        stmark2_defconfig
arm                            mps2_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20221101
mips                         db1xxx_defconfig
mips                            ar7_defconfig
sh                     sh7710voipgw_defconfig
arm                             ezx_defconfig
arm                           sama5_defconfig
ia64                            zx1_defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
arm                       omap2plus_defconfig
arm                          iop32x_defconfig
riscv                    nommu_k210_defconfig
sh                        sh7757lcr_defconfig
openrisc                    or1ksim_defconfig
x86_64               randconfig-k001-20221031
arm                      footbridge_defconfig
powerpc                     taishan_defconfig
sh                  sh7785lcr_32bit_defconfig
alpha                             allnoconfig
i386                 randconfig-c001-20221031
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
powerpc                     stx_gp3_defconfig
ia64                        generic_defconfig
sh                          rsk7203_defconfig
sh                      rts7751r2d1_defconfig
i386                          randconfig-c001
sparc                       sparc64_defconfig
sh                          lboxre2_defconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                        vexpress_defconfig
powerpc                       ebony_defconfig
powerpc                      obs600_defconfig
riscv                randconfig-r042-20221101
hexagon              randconfig-r041-20221101
hexagon              randconfig-r045-20221101
s390                 randconfig-r044-20221101
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                        mvebu_v5_defconfig
powerpc                   microwatt_defconfig
arm                         bcm2835_defconfig
mips                           ip28_defconfig
arm                      pxa255-idp_defconfig
mips                      bmips_stb_defconfig
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
i386                 randconfig-a003-20221031
i386                 randconfig-a002-20221031
i386                 randconfig-a004-20221031
i386                 randconfig-a005-20221031
i386                 randconfig-a001-20221031
i386                 randconfig-a006-20221031

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
