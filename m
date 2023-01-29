Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6AF67FD95
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 09:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjA2IS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 03:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjA2IS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 03:18:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3426222D8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 00:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674980336; x=1706516336;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qHOaPVvJYqTMT+lPrxvUz3jpr+nf5MHJNc60+mWUsfc=;
  b=M1F8XkET4mSFX0Hu+uo3jYusoIqzagmPJ048zlsPkrJzXQqVc1hO0nLu
   5n4ZkxEEhmwCP7ERPqDVrRuLurRwOeNpntMufbYdasmUsM+3aCElwFl8y
   qoYbt0Mg+76A6Psi84EgihZ653Xs0iZNguSMVbnvAn1sAq5OKKhxZZD5v
   SuSSnD23zkqQY9LS4BzgOj5/2ntWc2y9vmWpm248fxpt6iqClVM/jbKgL
   GBB3pfDnPE7uYEyx4vdxxKc3O49WErMLn26haPGcsEkI7OuMCDjpmSVbz
   2zuux8MvSwyUBe2gUF/X5hOfanx6+tXkYopAot7JJFU5ry8fwu9dcPYLu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="413596119"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="413596119"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 00:18:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="909134497"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="909134497"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jan 2023 00:18:55 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pM2tq-0002c2-1h;
        Sun, 29 Jan 2023 08:18:54 +0000
Date:   Sun, 29 Jan 2023 16:18:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:peterz.2023.01.26a] BUILD SUCCESS
 f9588508f16615daf50ae4e3e16f40b6be874154
Message-ID: <63d62bde.+WBx6Nnpg70rNPyI%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git peterz.2023.01.26a
branch HEAD: f9588508f16615daf50ae4e3e16f40b6be874154  sched/clock: Make local_clock() noinstr

elapsed time: 725m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                            allyesconfig
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
x86_64                              defconfig
m68k                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
arc                              allyesconfig
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20230129
arm                  randconfig-r046-20230129
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
ia64                             allmodconfig
i386                          randconfig-a001
x86_64                        randconfig-a004
x86_64                        randconfig-a013
i386                          randconfig-a003
x86_64                        randconfig-a011
x86_64                        randconfig-a002
x86_64                        randconfig-a015
i386                          randconfig-a005
i386                                defconfig
s390                                defconfig
x86_64                        randconfig-a006
i386                             allyesconfig
s390                             allyesconfig
x86_64                         rhel-8.3-kunit
arm                                 defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm64                            allyesconfig
arm                              allyesconfig
arm                        realview_defconfig
arm                           tegra_defconfig
arm                        shmobile_defconfig
powerpc                     pq2fads_defconfig
xtensa                       common_defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20230129
hexagon              randconfig-r041-20230129
riscv                randconfig-r042-20230129
s390                 randconfig-r044-20230129
x86_64                        randconfig-a014
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a003
i386                          randconfig-a006
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
