Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336A76057BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJTG5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJTG4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:56:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D434120EFB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666249013; x=1697785013;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Gn+mnJuwRYj1DkGTXdoQqBn+zHia9ikLXJmm6niCJh0=;
  b=ZAROVMTCin4wL5zCfult/kDYIt3GlCejeAJnXS485rkBMgmsTZz97RHb
   n1evGmM7z8Y9nZq3v0VgqWJVqUQuGy+UbqEt7H/l3j/sstBRaiOEWfRbj
   TfK6tIpossvkbmF10Brb6foFAOhTTFKS8QeT+MON1qjmLa6DsZaIssc1V
   s4EhWWOyL/5ktAtlAUvVTIi5mm14GvKyrieZaBc91avN0cQIkodOJLXjF
   IE8cl7JckWtM1XwNs6O3qRvLRq9Z5lTz/WcHJE2Rz453OFviYCmCwfh0W
   7ZdJ0NEcafd6FRvokDobFqj76ZNRkSYyxM+DwgTvtdaDfDQuntHqNhLzK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="289935455"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="289935455"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 23:56:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="580731092"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="580731092"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 19 Oct 2022 23:56:51 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1olPU2-0000yM-3D;
        Thu, 20 Oct 2022 06:56:51 +0000
Date:   Thu, 20 Oct 2022 14:56:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 01c97c7303580682751b5aaae043b639bdcbacb3
Message-ID: <6350f119.GeroT9zMTiUbp6LD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 01c97c7303580682751b5aaae043b639bdcbacb3  x86/mtrr: Add comment for set_mtrr_state() serialization

elapsed time: 721m

configs tested: 102
configs skipped: 81

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a002
x86_64                          rhel-8.3-func
x86_64                        randconfig-a004
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a006
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                        randconfig-a013
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                        randconfig-a011
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a015
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arm                          pxa3xx_defconfig
m68k                          sun3x_defconfig
openrisc                       virt_defconfig
m68k                           virt_defconfig
xtensa                          iss_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sh                        sh7763rdp_defconfig
mips                           gcw0_defconfig
openrisc                            defconfig
arm                           stm32_defconfig
powerpc                 mpc834x_itx_defconfig
openrisc                  or1klitex_defconfig
sh                            titan_defconfig
arm                       aspeed_g5_defconfig
m68k                          amiga_defconfig
arc                               allnoconfig
i386                          randconfig-c001
sparc64                          alldefconfig
m68k                       bvme6000_defconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                          rsk7269_defconfig
s390                          debug_defconfig
sh                     sh7710voipgw_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221020
arm                        keystone_defconfig
ia64                                defconfig
arm                  randconfig-c002-20221019

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
s390                 randconfig-r044-20221019
hexagon              randconfig-r045-20221019
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221019
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
x86_64                        randconfig-k001
hexagon              randconfig-r041-20221020
hexagon              randconfig-r045-20221020
x86_64                        randconfig-c007
mips                 randconfig-c004-20221019
i386                          randconfig-c001
s390                 randconfig-c005-20221019
arm                  randconfig-c002-20221019
riscv                randconfig-c006-20221019
powerpc              randconfig-c003-20221019

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
