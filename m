Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667C965715A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 01:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiL1AAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 19:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiL1AAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 19:00:45 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04312184
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 16:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672185644; x=1703721644;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=joQG7uRBMM+Pd0YIgfHRlmT6MwdBMUPJE0e1+aypsys=;
  b=nFahaOprpgSQvkyJgvsqMZh4HJuZqlepka9DeitQUVJPgROzqn2nlMW1
   /hw3+YsMaL5k5AObccBGcjIJblxkqeeMqHgIdO/BITpeoDkh8dC0g2ljh
   87WHC8D440JWJ4r7EOF7o1Vxp33F/ObbzL5vrBC5L0LFVVip/ohRMhEiw
   ozWYf4WHA3h+c5H0J9X+x0zkFEI7ejNpQVtjAjCuA6i0kPNRlhTiEORsZ
   ijPwgDN6L5k+yw3bk4Aq82r5tD1l7ztK8avRjpAX9zRYnbkIBHs3KYhil
   I2nx2begx2SEmhLwD0M0YO48TzgBn01H2svFm5YrevnrK9MA6sbnVDOlO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="347977443"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="347977443"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 16:00:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="685549681"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="685549681"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Dec 2022 16:00:41 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pAJs8-000FGb-31;
        Wed, 28 Dec 2022 00:00:40 +0000
Date:   Wed, 28 Dec 2022 08:00:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 0a041ebca4956292cadfb14a63ace3a9c1dcb0a3
Message-ID: <63ab8717.sbE+W8pmiAG2XxT8%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/urgent
branch HEAD: 0a041ebca4956292cadfb14a63ace3a9c1dcb0a3  perf/core: Call LSM hook after copying perf_event_attr

elapsed time: 726m

configs tested: 108
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
alpha                            allyesconfig
arm                                 defconfig
m68k                             allmodconfig
sh                               allmodconfig
um                             i386_defconfig
arc                              allyesconfig
m68k                             allyesconfig
mips                             allyesconfig
um                           x86_64_defconfig
arm64                            allyesconfig
arm                              allyesconfig
arc                                 defconfig
alpha                               defconfig
x86_64               randconfig-a014-20221226
x86_64               randconfig-a013-20221226
s390                             allmodconfig
x86_64               randconfig-a011-20221226
x86_64                              defconfig
x86_64               randconfig-a012-20221226
x86_64                           rhel-8.3-bpf
x86_64                               rhel-8.3
powerpc                          allmodconfig
x86_64               randconfig-a016-20221226
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
x86_64                           allyesconfig
s390                                defconfig
i386                 randconfig-a011-20221226
x86_64               randconfig-a015-20221226
x86_64                           rhel-8.3-kvm
i386                 randconfig-a016-20221226
i386                 randconfig-a013-20221226
i386                 randconfig-a014-20221226
i386                 randconfig-a012-20221226
i386                 randconfig-a015-20221226
s390                             allyesconfig
i386                                defconfig
x86_64                            allnoconfig
arm                  randconfig-r046-20221225
arc                  randconfig-r043-20221225
arc                  randconfig-r043-20221227
arm                  randconfig-r046-20221227
arc                  randconfig-r043-20221226
riscv                randconfig-r042-20221226
s390                 randconfig-r044-20221226
i386                             allyesconfig
sh                        apsh4ad0a_defconfig
powerpc                  storcenter_defconfig
i386                          randconfig-c001
s390                       zfcpdump_defconfig
arm                           stm32_defconfig
arm                        spear6xx_defconfig
powerpc                mpc7448_hpc2_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                      ppc40x_defconfig
arc                            hsdk_defconfig
sh                            migor_defconfig
sh                           se7722_defconfig
powerpc                 mpc8540_ads_defconfig
riscv             nommu_k210_sdcard_defconfig
sparc                       sparc32_defconfig
arm                        keystone_defconfig
sh                          rsk7264_defconfig
riscv                            allyesconfig
arm                            mps2_defconfig
arm                             pxa_defconfig
arm                      integrator_defconfig
mips                            ar7_defconfig

clang tested configs:
x86_64               randconfig-a002-20221226
x86_64               randconfig-a003-20221226
x86_64               randconfig-a001-20221226
x86_64               randconfig-a004-20221226
x86_64               randconfig-a005-20221226
x86_64               randconfig-a006-20221226
i386                 randconfig-a004-20221226
i386                 randconfig-a001-20221226
i386                 randconfig-a003-20221226
i386                 randconfig-a002-20221226
i386                 randconfig-a006-20221226
i386                 randconfig-a005-20221226
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20221225
riscv                randconfig-r042-20221227
hexagon              randconfig-r041-20221225
s390                 randconfig-r044-20221227
hexagon              randconfig-r041-20221227
hexagon              randconfig-r041-20221226
arm                  randconfig-r046-20221226
s390                 randconfig-r044-20221225
hexagon              randconfig-r045-20221226
x86_64                        randconfig-k001
riscv                randconfig-r042-20221225
hexagon              randconfig-r045-20221227
arm                         socfpga_defconfig
arm                     am200epdkit_defconfig
powerpc                     akebono_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
