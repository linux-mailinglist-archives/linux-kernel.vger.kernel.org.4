Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D5A610454
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbiJ0VZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbiJ0VZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:25:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C37C5B79D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666905953; x=1698441953;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sHzPL3wcEhTGZrCvQS4IYwsxIqnVWjC8KbAD9ul/+8s=;
  b=WmVCvl+e00joK+Ylee6lfEEOIgXS+LEk24yYvCp14hJZdMpfxs76U7F8
   E+jAPXY6zAEe3HRJkXvetKAiYNTBj0O+eZdD/ca8mpO3HhDSj6tm9XELK
   vHiPluWSc/tu/gP6jwbc2Zgv0R8Pijn0sAB0J+MwwVxoqGRzGUSvTlD/q
   EqGA3TaDhVX1xHsZCyd0BrHzAucAC5r9HJ+OR7V4+LdxJ5rdFYolQDbKS
   W0IqPFqeq6pzhjr+33d5LpS4htUNGbAmPmUdP2fhdHShqr/2ieIMzis+7
   JwHlLDV42Xv7gQ5bMl2QA+059W3g38ZwmVCSn6dj0uiBmnntTTcxLZCwt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="308336184"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="308336184"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 14:25:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="583703360"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="583703360"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 27 Oct 2022 14:25:51 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooANq-0009Bv-37;
        Thu, 27 Oct 2022 21:25:50 +0000
Date:   Fri, 28 Oct 2022 05:25:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 c36eae5a86d15a694968be35d7ff056854997a72
Message-ID: <635af73a.UdCJ41pHOAHto+FC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: c36eae5a86d15a694968be35d7ff056854997a72  sched/psi: Fix possible missing or delayed pending event

elapsed time: 728m

configs tested: 92
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                              defconfig
s390                             allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a004
ia64                             allmodconfig
i386                                defconfig
x86_64                        randconfig-a002
riscv                randconfig-r042-20221026
arc                  randconfig-r043-20221026
x86_64                        randconfig-a006
s390                 randconfig-r044-20221026
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
i386                          randconfig-a001
sh                               allmodconfig
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                           allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                    amigaone_defconfig
sh                           se7724_defconfig
sh                          rsk7201_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sparc                               defconfig
m68k                       m5249evb_defconfig
parisc                generic-32bit_defconfig
arm                          pxa910_defconfig
arc                              alldefconfig
arm                            pleb_defconfig
mips                      maltasmvp_defconfig
mips                            ar7_defconfig
arc                            hsdk_defconfig
arm                             ezx_defconfig
sh                            migor_defconfig
nios2                         3c120_defconfig
i386                          randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sparc                             allnoconfig
m68k                        m5272c3_defconfig
xtensa                    smp_lx200_defconfig
m68k                       m5208evb_defconfig
riscv                               defconfig
sh                        dreamcast_defconfig
powerpc                 canyonlands_defconfig
m68k                         amcore_defconfig
m68k                           sun3_defconfig
microblaze                      mmu_defconfig
mips                         bigsur_defconfig
sh                             shx3_defconfig
openrisc                  or1klitex_defconfig

clang tested configs:
hexagon              randconfig-r045-20221026
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221026
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
s390                 randconfig-r044-20221027
hexagon              randconfig-r041-20221027
riscv                randconfig-r042-20221027
hexagon              randconfig-r045-20221027
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
