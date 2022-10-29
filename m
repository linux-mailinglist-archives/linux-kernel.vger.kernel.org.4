Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A0E6122A3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 13:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJ2L4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 07:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJ2L4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 07:56:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8D86F577
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 04:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667044593; x=1698580593;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=YUZi3alwVnyYOc55ggcifsREzqM/m6XyDoAC4wzb9qQ=;
  b=DK691oUmILfHal9Q2gkJsPEglfUvBL7EQQ9hBp7+SBpTsCAa0B6ccZSX
   zUekSPoPBU4W5FFMvW39eeKEZM+YxIPsGzO3Tnm5JS7LD1GJib8Spulxw
   L8ZPb28Q/P3oFt8xPbqor+8ODmvQeTWzYJu5kMuFFdqZKFIt1vIySSvd+
   aKPkbL8hB5yVNBjFE1lXJJ1Oo0IQFIJwHzedq69+vMKVCWr9EW6A99IDT
   Ft+yIi6FEu5xfGZw5ZN4bNzqlIbcnkJn2oz6aIWoQ0olnd++1MNa+Vvkz
   NCeL2QKQqnDx3LDgIqNERA8UZcL/h1aArmUOKpmeim+YTHjaqKP+LGl0g
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="370732194"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="370732194"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 04:56:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="611023486"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="611023486"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 29 Oct 2022 04:56:30 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ookRy-000Azz-0x;
        Sat, 29 Oct 2022 11:56:30 +0000
Date:   Sat, 29 Oct 2022 19:56:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 ffb4efcd9d6187049fecba6be749bf17a74aee98
Message-ID: <635d14d3.fpjzac7QRQckLXxE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: ffb4efcd9d6187049fecba6be749bf17a74aee98  locking/memory-barriers.txt: Improve documentation for writel() example

elapsed time: 720m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
s390                             allmodconfig
i386                                defconfig
alpha                            allyesconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
arc                              allyesconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a001
i386                          randconfig-a014
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
m68k                             allyesconfig
s390                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a013
i386                          randconfig-a003
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a011
i386                          randconfig-a012
mips                             allyesconfig
i386                          randconfig-a005
i386                          randconfig-a016
arc                  randconfig-r043-20221029
sh                               allmodconfig
i386                             allyesconfig
x86_64                        randconfig-a015
x86_64                               rhel-8.3
x86_64                        randconfig-a002
x86_64                           allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arc                  randconfig-r043-20221028
s390                 randconfig-r044-20221028
riscv                randconfig-r042-20221028
arm                            hisi_defconfig
xtensa                  cadence_csp_defconfig
m68k                           virt_defconfig
powerpc                       holly_defconfig
arm                          pxa3xx_defconfig
sh                        dreamcast_defconfig
powerpc                      ep88xc_defconfig
powerpc                       ppc64_defconfig
powerpc                      makalu_defconfig
arm                           u8500_defconfig
arm                         lpc18xx_defconfig
arm                      jornada720_defconfig
i386                          randconfig-c001

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
riscv                randconfig-r042-20221029
i386                          randconfig-a002
hexagon              randconfig-r041-20221029
x86_64                        randconfig-a012
hexagon              randconfig-r045-20221029
i386                          randconfig-a015
i386                          randconfig-a006
i386                          randconfig-a004
s390                 randconfig-r044-20221029
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
