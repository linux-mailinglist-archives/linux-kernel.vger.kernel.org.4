Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38673601946
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJQUWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJQUWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:22:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C4811830
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666038161; x=1697574161;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kBnisBIm1Y+wEECqVvF1bNY6gnYP4pOnfH/Mij/o8Ow=;
  b=XiFN5YnMBH7O6u+/pjIz4kb0DtWJu+vrN0OFqUoJoOzO2E9azdSu5+0r
   Hxinr3lJvhjfHF9YzJw+cJAKs/FlN/sAPMx1yCY2ICgI6u3Wq93RrMe5U
   aes2rybFvMUeCo3ythBAaD3umkBpNnWNca5lHWN2pgswqKPTWsE2eb9ZA
   1E8D752yYS6sBU1nFRDIj3ZsIpHSpNnyuXvS+gzBzOzW5vnOtsGnzuYEY
   7FcsCoFBM5nB4zsyKNWXBLPpNaIbmF2505TTlpkR+K/m5/UbvbLkoxYSp
   IRjudi90x7ucHZdb9jNyFWZ6QYz33tSA2mntpoWvHMgOllvtDFGNQjBFO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="286301845"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="286301845"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 13:22:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="628434401"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="628434401"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 17 Oct 2022 13:22:40 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1okWdD-0000sW-2M;
        Mon, 17 Oct 2022 20:22:39 +0000
Date:   Tue, 18 Oct 2022 04:21:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 1d30800c0c0ae1d086ffad2bdf0ba4403370f132
Message-ID: <634db964.89atkmKXdyaFStyx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 1d30800c0c0ae1d086ffad2bdf0ba4403370f132  x86/bugs: Use sysfs_emit()

elapsed time: 728m

configs tested: 118
configs skipped: 60

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
i386                                defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arm                        spear6xx_defconfig
arc                  randconfig-r043-20221017
i386                 randconfig-a005-20221017
i386                 randconfig-a003-20221017
i386                 randconfig-a004-20221017
i386                 randconfig-a001-20221017
i386                 randconfig-a006-20221017
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64               randconfig-a004-20221017
x86_64               randconfig-a001-20221017
x86_64               randconfig-a002-20221017
x86_64               randconfig-a006-20221017
x86_64               randconfig-a005-20221017
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                        m5407c3_defconfig
powerpc                  iss476-smp_defconfig
sh                   rts7751r2dplus_defconfig
m68k                        mvme16x_defconfig
sh                   secureedge5410_defconfig
arc                        nsimosci_defconfig
m68k                          multi_defconfig
csky                             alldefconfig
arc                        nsim_700_defconfig
riscv                               defconfig
powerpc                 mpc837x_mds_defconfig
i386                 randconfig-c001-20221017
sh                           se7721_defconfig
arc                          axs103_defconfig
powerpc                     asp8347_defconfig
powerpc                 mpc8540_ads_defconfig
sh                          kfr2r09_defconfig
powerpc                 linkstation_defconfig
microblaze                          defconfig
arm                          gemini_defconfig
powerpc                 mpc834x_itx_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                    adder875_defconfig
sh                           se7751_defconfig
parisc                           alldefconfig
nios2                               defconfig
mips                        vocore2_defconfig
arm                        keystone_defconfig
powerpc                        cell_defconfig
parisc                generic-32bit_defconfig
riscv             nommu_k210_sdcard_defconfig
m68k                         amcore_defconfig
mips                           ci20_defconfig
powerpc                      makalu_defconfig
m68k                             alldefconfig
loongarch                           defconfig
loongarch                         allnoconfig
sh                             sh03_defconfig
ia64                            zx1_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      arches_defconfig
arm                          iop32x_defconfig
openrisc                  or1klitex_defconfig
powerpc                        warp_defconfig
sh                          polaris_defconfig
sh                          rsk7203_defconfig
arm                             ezx_defconfig
powerpc                     mpc83xx_defconfig
m68k                          hp300_defconfig

clang tested configs:
x86_64               randconfig-a014-20221017
x86_64               randconfig-a015-20221017
x86_64               randconfig-a012-20221017
x86_64               randconfig-a011-20221017
x86_64               randconfig-a013-20221017
x86_64               randconfig-a016-20221017
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
s390                 randconfig-r044-20221017
hexagon              randconfig-r045-20221017
riscv                randconfig-r042-20221017
hexagon              randconfig-r041-20221017
mips                 randconfig-c004-20221017
i386                 randconfig-c001-20221017
s390                 randconfig-c005-20221017
arm                  randconfig-c002-20221017
riscv                randconfig-c006-20221017
x86_64               randconfig-c007-20221017
powerpc              randconfig-c003-20221017
x86_64               randconfig-k001-20221017
arm                          collie_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
