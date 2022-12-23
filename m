Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012A1654C87
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 07:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiLWGrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 01:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiLWGrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 01:47:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A8D1D675
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671778026; x=1703314026;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=r+b0HkHApJ6UifM+3W9cNkN8szA57pfsD/heJdmHNQE=;
  b=SY9c8LLX5JeiuUts3gCjvPdgWB09ra655DPhIeo2L6/8nlj1WMORHjDS
   CKYCIUjEuktUALYNkit5jswTmi2K+PtvgE87ainOe7pl6/C8vE92xDgNd
   Ee6g+1YLn1fCI285OIoxK5Vc58YQ36hlGnBtcs1Ut6Gldb9h8NCcXSeqn
   rStog0Q4O/d25LHGTg0Yie4m0tPF+/KhETHG0ZTAZDqkboKuNYsy8eR7h
   2KpLPkHHrzuClhbP2XaMw+BVJsZiKYokJZISieYbY2a7gJCXp6j6zXnVC
   40BHmlJfDOn8HOkDon7lTXV3obpBREbBpgu7R3Lb38iTeHQzSgxX2/icz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="318980177"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="318980177"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 22:47:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="684451762"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="684451762"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Dec 2022 22:47:04 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p8bpg-000CUq-05;
        Fri, 23 Dec 2022 06:47:04 +0000
Date:   Fri, 23 Dec 2022 14:46:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:haltnmi3glacial.2022.12.22a] BUILD SUCCESS
 c8b00fe7faea3ba4c5ba6ecf67637bab169256f6
Message-ID: <63a54ebd.tAE0Gsm/etTaFTqE%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git haltnmi3glacial.2022.12.22a
branch HEAD: c8b00fe7faea3ba4c5ba6ecf67637bab169256f6  x86/nmi: Test commit for severely delayed NMI handlers

elapsed time: 723m

configs tested: 136
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
sh                               allmodconfig
s390                                defconfig
mips                             allyesconfig
m68k                             allyesconfig
s390                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
powerpc                          allmodconfig
alpha                            allyesconfig
x86_64                              defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           allyesconfig
ia64                             allmodconfig
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
x86_64                           rhel-8.3-bpf
i386                          randconfig-a014
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                            allnoconfig
arm                                 defconfig
riscv                randconfig-r042-20221218
arc                  randconfig-r043-20221219
arm                  randconfig-r046-20221219
arc                  randconfig-r043-20221218
x86_64                        randconfig-a013
s390                 randconfig-r044-20221218
x86_64                        randconfig-a011
arm                              allyesconfig
arm64                            allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-c001
xtensa                  cadence_csp_defconfig
openrisc                         alldefconfig
sh                        sh7785lcr_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64               randconfig-a006-20221219
x86_64               randconfig-a002-20221219
x86_64               randconfig-a005-20221219
x86_64               randconfig-a003-20221219
x86_64               randconfig-a001-20221219
x86_64               randconfig-a004-20221219
i386                 randconfig-a005-20221219
i386                 randconfig-a002-20221219
i386                 randconfig-a003-20221219
i386                 randconfig-a006-20221219
i386                 randconfig-a001-20221219
i386                 randconfig-a004-20221219
arm                        trizeps4_defconfig
sh                            shmin_defconfig
um                               alldefconfig
powerpc                      makalu_defconfig
m68k                        mvme147_defconfig
powerpc                    amigaone_defconfig
m68k                         amcore_defconfig
m68k                        m5272c3_defconfig
s390                 randconfig-r044-20221222
arc                  randconfig-r043-20221222
riscv                randconfig-r042-20221222
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                             sh03_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                       maple_defconfig
sh                           se7724_defconfig
sh                          rsk7203_defconfig
arm                            xcep_defconfig
mips                           xway_defconfig
arm                        cerfcube_defconfig
arm                          iop32x_defconfig
xtensa                  nommu_kc705_defconfig
arm                               allnoconfig
m68k                          multi_defconfig
powerpc                 mpc8540_ads_defconfig
mips                            ar7_defconfig
openrisc                    or1ksim_defconfig
sh                          lboxre2_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
arc                        nsimosci_defconfig
mips                         bigsur_defconfig
m68k                          atari_defconfig
sh                        apsh4ad0a_defconfig
m68k                             alldefconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
arm                  randconfig-r046-20221218
hexagon              randconfig-r041-20221218
i386                          randconfig-a015
hexagon              randconfig-r045-20221219
s390                 randconfig-r044-20221219
hexagon              randconfig-r041-20221219
hexagon              randconfig-r045-20221218
riscv                randconfig-r042-20221219
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-k001-20221219
i386                 randconfig-a013-20221219
i386                 randconfig-a014-20221219
i386                 randconfig-a015-20221219
i386                 randconfig-a011-20221219
i386                 randconfig-a016-20221219
i386                 randconfig-a012-20221219
x86_64                        randconfig-k001
x86_64               randconfig-a015-20221219
x86_64               randconfig-a013-20221219
x86_64               randconfig-a012-20221219
x86_64               randconfig-a016-20221219
x86_64               randconfig-a014-20221219
x86_64               randconfig-a011-20221219

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
