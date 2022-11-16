Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912F762CD55
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbiKPWFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiKPWFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:05:24 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F1625E2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668636322; x=1700172322;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vVjWvQeVMXWFPwVn1M6N2vlioWd46Pb8XXsTear1hmY=;
  b=hRAVqhw2ydGZTjGjn3mvg7hu0/vTZ6ZpLDju2zwFXrsIgcWG8jmN/okq
   ZRWCuA1CVNv8JdpQoUjlgK8iAQ/7frTvhLtEssAjah3OFyH9lK4kGEMwS
   U/0ZczNAI5FKYGGHs8aZZscyIAkIjezKSD416aRzMFHdK7+NRUQjjy25d
   kxy1NWDBcAR55Z4mpWww/Q9EFRKFivNNZI4Eb9yjCZFMpjnVLB9M44i+f
   ACG3dGbj5lRgJupB/ToT2jlY9cbVYeJN0yz/IdWZV4/nRMaxDN2oDrNe1
   qnLXevQqZbZyG/YxJSVljU2slVV75/VRM+3CxgG7NDLNqy1dsW17hyoT+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="300212169"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="300212169"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 14:05:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="814250592"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="814250592"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Nov 2022 14:05:20 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovQX2-0002mT-0D;
        Wed, 16 Nov 2022 22:05:20 +0000
Date:   Thu, 17 Nov 2022 06:04:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/urgent] BUILD SUCCESS
 2d77de1581bb5b470486edaf17a7d70151131afd
Message-ID: <63755e7e.Cr61tiCFnQYUf38x%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/urgent
branch HEAD: 2d77de1581bb5b470486edaf17a7d70151131afd  scripts/faddr2line: Fix regression in name resolution on ppc64le

elapsed time: 722m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                              defconfig
i386                                defconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arc                  randconfig-r043-20221116
ia64                             allmodconfig
m68k                             allyesconfig
powerpc                           allnoconfig
m68k                             allmodconfig
x86_64                          rhel-8.3-func
powerpc                          allmodconfig
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
alpha                            allyesconfig
mips                             allyesconfig
i386                          randconfig-a001
x86_64                               rhel-8.3
arc                              allyesconfig
i386                          randconfig-a003
i386                          randconfig-a016
x86_64                            allnoconfig
sh                               allmodconfig
i386                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
powerpc                      ppc40x_defconfig
sh                         apsh4a3a_defconfig
arm                         s3c6400_defconfig
sparc64                             defconfig
arm                       multi_v4t_defconfig
powerpc                     asp8347_defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                        shmobile_defconfig
sh                   sh7770_generic_defconfig
loongarch                 loongson3_defconfig
mips                           gcw0_defconfig
alpha                            alldefconfig
powerpc                     tqm8555_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
m68k                          sun3x_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
m68k                           virt_defconfig
i386                          randconfig-c001
um                                  defconfig
sh                ecovec24-romimage_defconfig
arm                           sunxi_defconfig
powerpc                      makalu_defconfig
openrisc                       virt_defconfig
sh                          r7780mp_defconfig
sh                           se7751_defconfig
sh                          r7785rp_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                        realview_defconfig
powerpc                   currituck_defconfig
xtensa                    xip_kc705_defconfig
arm                             ezx_defconfig
arm                        oxnas_v6_defconfig
openrisc                 simple_smp_defconfig
openrisc                            defconfig
sh                            titan_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                            ar7_defconfig
arm                            zeus_defconfig
powerpc                    amigaone_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7705_defconfig
arm                            qcom_defconfig
microblaze                          defconfig
sh                          rsk7203_defconfig
sparc64                          alldefconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
hexagon              randconfig-r045-20221116
riscv                randconfig-r042-20221116
hexagon              randconfig-r041-20221116
x86_64                        randconfig-a016
s390                 randconfig-r044-20221116
i386                          randconfig-a002
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                     pseries_defconfig
hexagon              randconfig-r041-20221117
hexagon              randconfig-r045-20221117
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
