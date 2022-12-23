Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C40D654C88
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 07:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiLWGrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 01:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLWGrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 01:47:07 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048391D65B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671778025; x=1703314025;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zy+8d0eYcT+6Nqf0Y0NbRjGEkesD9uxHj5Ruw34Spi0=;
  b=MeQjvoQjNILVhG2JG9+fnM4/UTJAXADaRdRRML/ea+1QCwYs7FoCAVNW
   uOlYvTlOovieiQo+e6l9G9pPjtqh/ral56E0TBMt9+dC4YrrwYhbzjDqY
   IiFKU/GI3Kt5dTAkKBPNFiJslG+KQxNTgm+aNB1IvJrsc8xk2AqXmR6nv
   BwZzF51oatf7V7Wqv63A2ZnZ2LEL0o6ZzYWWVIceFeCOystnV/oBmIg4F
   ZknYHf2sQBa3aiXDpDCTAKQb3rOCa+Qz08Qpy60fVGtuD0bspgKoVCMuB
   jj2ulPivcPu+okAJ/JeWdc8NdxcFREWrIC+hp4PQdU8SYv4fiztCpoHtz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="347439548"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="347439548"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 22:47:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="759265088"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="759265088"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 22 Dec 2022 22:47:04 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p8bpf-000CUm-34;
        Fri, 23 Dec 2022 06:47:03 +0000
Date:   Fri, 23 Dec 2022 14:46:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:haltnmi3.2022.12.21a] BUILD SUCCESS
 79237a508a57aaec52d98013b232f04148bdb55f
Message-ID: <63a54ed0.x6ZfU2ckA2ZU/Y8C%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git haltnmi3.2022.12.21a
branch HEAD: 79237a508a57aaec52d98013b232f04148bdb55f  x86/nmi: Test commit for exc_nmi handler deep-losing NMIs

elapsed time: 724m

configs tested: 109
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
sh                               allmodconfig
i386                                defconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
mips                             allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20221222
riscv                randconfig-r042-20221222
s390                 randconfig-r044-20221222
ia64                             allmodconfig
x86_64               randconfig-a002-20221219
x86_64               randconfig-a003-20221219
x86_64               randconfig-a001-20221219
i386                             allyesconfig
x86_64               randconfig-a004-20221219
x86_64               randconfig-a005-20221219
i386                 randconfig-a004-20221219
i386                 randconfig-a001-20221219
arm                                 defconfig
i386                 randconfig-a003-20221219
x86_64               randconfig-a006-20221219
i386                 randconfig-a002-20221219
i386                 randconfig-a006-20221219
i386                 randconfig-a005-20221219
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
x86_64                            allnoconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-c001
xtensa                  cadence_csp_defconfig
openrisc                         alldefconfig
sh                        sh7785lcr_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                        trizeps4_defconfig
sh                            shmin_defconfig
um                               alldefconfig
powerpc                      makalu_defconfig
m68k                        mvme147_defconfig
powerpc                    amigaone_defconfig
m68k                         amcore_defconfig
m68k                        m5272c3_defconfig
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
x86_64                          rhel-8.3-rust
arm                  randconfig-r046-20221222
hexagon              randconfig-r041-20221222
hexagon              randconfig-r045-20221222
i386                 randconfig-a014-20221219
i386                 randconfig-a012-20221219
i386                 randconfig-a013-20221219
i386                 randconfig-a011-20221219
i386                 randconfig-a015-20221219
x86_64               randconfig-a011-20221219
x86_64               randconfig-a012-20221219
x86_64               randconfig-a014-20221219
i386                 randconfig-a016-20221219
x86_64               randconfig-a015-20221219
x86_64               randconfig-a016-20221219
x86_64               randconfig-a013-20221219
x86_64               randconfig-k001-20221219
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
