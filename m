Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B12C608CB5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJVLda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJVLdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:33:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E338660EA0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666437217; x=1697973217;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=N/lj34MVd9FUcYHSIMRB4FOiHjHkYUMTvVoryrhPM0E=;
  b=XgkF3mrXlM3fyQKNz+1J5M9oO98L699MRbIAhaXGykrVNyWPqwlH4Dnd
   oZkOm7mnybGXfuXxhvZoSxx8vaFq805GHWPI1ZQZnR66jzt28Vg+IO87P
   C6oDhQ7ceuPO/N6f6IOwKKlFjevvOcJ4egJs6QjCRseYXx92yHdihlbtX
   Yryy3606UG85nHVbbs0NqHKJ/txo3YSUEVNmy+eX7mkTX3a528Gy+ZFAC
   JkTbU8SfCcMpPNK0CaWMHKnR3GJjnedj2wqP7lGClwrm0vt+gMtn85Ziw
   5hBpNLRuDRkFzSKC8ab/vOySyIZL1zyJR2LKycz3BZl6R2CnU02OFALVa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="308273643"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="308273643"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 04:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="608679903"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="608679903"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 22 Oct 2022 04:13:36 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1omCRb-0003aY-32;
        Sat, 22 Oct 2022 11:13:35 +0000
Date:   Sat, 22 Oct 2022 19:12:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 ba38687626adeb7afce6527608adb74d7e8ed351
Message-ID: <6353d029.TiOGmviQv3lbljbs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: ba38687626adeb7afce6527608adb74d7e8ed351  selftests/nolibc: Add 7 tests for memcmp()

elapsed time: 947m

configs tested: 85
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
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
x86_64                              defconfig
arc                  randconfig-r043-20221019
arc                  randconfig-r043-20221020
s390                 randconfig-r044-20221020
riscv                randconfig-r042-20221020
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
i386                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
arm                                 defconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           allyesconfig
i386                          randconfig-a005
arm64                            allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sh                         microdev_defconfig
arm                            qcom_defconfig
arc                              alldefconfig
m68k                          atari_defconfig
powerpc                     tqm8548_defconfig
arm                          lpd270_defconfig
arm                       omap2plus_defconfig
arm                        clps711x_defconfig
powerpc                 linkstation_defconfig
arc                            hsdk_defconfig
openrisc                 simple_smp_defconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
riscv                randconfig-r042-20221019
i386                 randconfig-a011-20221017
i386                 randconfig-a013-20221017
i386                 randconfig-a012-20221017
i386                 randconfig-a014-20221017
x86_64                        randconfig-a005
x86_64                        randconfig-a016
i386                 randconfig-a016-20221017
x86_64                        randconfig-a001
i386                 randconfig-a015-20221017
hexagon              randconfig-r045-20221019
x86_64                        randconfig-a012
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221019
s390                 randconfig-r044-20221019
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
