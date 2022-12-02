Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E096B64088E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiLBOhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiLBOhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:37:05 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6D4F4E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 06:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669991824; x=1701527824;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bH6DQJCbDWOMJnSePwTP9d5C8M7uG/7GnKUlXVVPz60=;
  b=B4KfRhoKiDBaUHimm3+0Sh1yMXPqi492GJ3ipPH22EdGPPkzBOwp0Ip5
   HsHgCQDqDdKcsBKvRZWz4CFpnsobpks16cSVePWBjDtUQpQP8c4BCj1ea
   kJrR/ZF1JFMj43K2r6Fr5zRmX+EhuH0jDEoYeAW4KAN52JdT/WFPvRWT2
   qm98LTMlw1fuHSxAAqpfxo+G/KCvjbnumJPsmOQCJJi+xXdoUNUvgqREF
   +6CLqqchkX4gY5TizhO5kLntkTI/t2WjwbZdvMpz/f4k8JF9CTb04c7RW
   KqSKMHEFxtIqO4Don48VdFjtkwFMGdgUtzf3kKTBHclc6fE1GB2gUKRdS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="380253673"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="380253673"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 06:36:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="645043622"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="645043622"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2022 06:36:16 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p179E-000DkN-0S;
        Fri, 02 Dec 2022 14:36:16 +0000
Date:   Fri, 02 Dec 2022 22:35:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 1ab6c3f2e9237692f4d3d4a555d1ac31290ae0d1
Message-ID: <638a0d32.5ue94wgSe4r1Qecv%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 1ab6c3f2e9237692f4d3d4a555d1ac31290ae0d1  Merge branch 'nolibc.2022.10.28a' into HEAD

elapsed time: 784m

configs tested: 60
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a013
x86_64                              defconfig
x86_64                        randconfig-a011
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                        randconfig-a015
s390                             allyesconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
ia64                             allmodconfig
arc                  randconfig-r043-20221201
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
riscv                randconfig-r042-20221201
powerpc                           allnoconfig
s390                 randconfig-r044-20221201
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
sh                               allmodconfig
i386                          randconfig-a014
mips                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                                defconfig
x86_64                            allnoconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig

clang tested configs:
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
hexagon              randconfig-r041-20221201
hexagon              randconfig-r045-20221201
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
