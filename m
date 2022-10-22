Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E91608CB6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJVLdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJVLdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:33:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A68961777
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666437218; x=1697973218;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=E3UdXHkLke1SBbqBTfdiYIuAu4z4rEiF8vP3hLoYVNg=;
  b=URiPOPbfYBtfkUvm9Tetnq7RdlTTu8026ch0BhefGQZl2bpXB1bC1C5x
   7LtQy/IslaWdmJuhCkNHN278NOfLReOYFRfjqho/L4jmC2s7pII4AV5E0
   FDNwN47Z7uxBf1dBR14GNeb2X5YmTPG8f7AaFWQFK3KD2rKs2mfV1CLwX
   khF2gfVMToSw1gfW4hPY0KWGbKe7l2ecjlyJax973qjB3FctZV251fErr
   2l9dRE0kOulJe+EY2Orsf8dsaFOvYkJlbXLwCzM1g+TrTeszTY2K87Y1a
   frkhyGXwQLyLAZ+PIIqSjY0eySqKduwm4Ty8owjcjyA9fTy944/50NB8X
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="307169658"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="307169658"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 04:13:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="581885576"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="581885576"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 22 Oct 2022 04:13:36 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1omCRb-0003aa-34;
        Sat, 22 Oct 2022 11:13:35 +0000
Date:   Sat, 22 Oct 2022 19:12:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.10.20a] BUILD SUCCESS
 0787663d34936ae88dd58fa22cc5d60fbff5a4be
Message-ID: <6353d02c.DXWI0cqjTTVhejCB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.10.20a
branch HEAD: 0787663d34936ae88dd58fa22cc5d60fbff5a4be  selftests/nolibc: Add 7 tests for memcmp()

elapsed time: 725m

configs tested: 85
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
alpha                               defconfig
x86_64                    rhel-8.3-kselftests
i386                                defconfig
x86_64                              defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm                                 defconfig
powerpc                           allnoconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
x86_64                        randconfig-a015
m68k                             allyesconfig
i386                          randconfig-a003
mips                             allyesconfig
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
m68k                             allmodconfig
i386                          randconfig-a005
arc                  randconfig-r043-20221020
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
i386                          randconfig-a012
arc                              allyesconfig
i386                          randconfig-a016
sh                               allmodconfig
s390                 randconfig-r044-20221020
arm64                            allyesconfig
i386                          randconfig-a014
alpha                            allyesconfig
arc                  randconfig-r043-20221018
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                randconfig-r042-20221020
arm                              allyesconfig
riscv                randconfig-r042-20221018
x86_64                        randconfig-a006
s390                 randconfig-r044-20221018
i386                             allyesconfig
arc                  randconfig-r043-20221019
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
x86_64                        randconfig-a016
x86_64                        randconfig-a012
hexagon              randconfig-r041-20221020
i386                          randconfig-a013
hexagon              randconfig-r045-20221020
i386                          randconfig-a002
x86_64                        randconfig-a014
i386                          randconfig-a011
hexagon              randconfig-r041-20221018
i386                          randconfig-a006
hexagon              randconfig-r045-20221018
i386                          randconfig-a004
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
