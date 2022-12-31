Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE4365A045
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 02:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbiLaBIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 20:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiLaBIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 20:08:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFE71573A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 17:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672448925; x=1703984925;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=K1jtPn7+jthkpSMD+6OfXRvwubiu7Ke+2saNndR5h6w=;
  b=BgFuMrCYhXhmaeb3uyin+dV4sg5NO9PsjxFeZ7XHkgqzo0X5Wo/7fnAW
   BAFmPcjr4sBgvgAQnrD/bntsTe1Ag2wTAAK5WXU1feK9JzNTSslr5BTpV
   KuJPzWMXShokF5/jxJ5lPzBYFklXYZYhej2WbqPiNS5EWZX3v6F2qLnvi
   eGq4r9rP3A2PrAT10/ml+a0EeGQgl6J+2sJewakYyFOBuFZ1K86s2E/5T
   LvI+cyYAsLeUDBf/zkA00sNSZyFduxzsHjBIuirBP9FbDyccQhwDieXGL
   L3LxT/9WCo7T81Pko/TcEbAINA3/T6zlFt0dYCeUQ4UqLLb9DCjbhQeI0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="309038698"
X-IronPort-AV: E=Sophos;i="5.96,288,1665471600"; 
   d="scan'208";a="309038698"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 17:08:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="899376524"
X-IronPort-AV: E=Sophos;i="5.96,288,1665471600"; 
   d="scan'208";a="899376524"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 Dec 2022 17:08:43 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pBQMc-000MjS-18;
        Sat, 31 Dec 2022 01:08:42 +0000
Date:   Sat, 31 Dec 2022 09:07:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 fdcbb2aa95b584bf189401bd3072b4bc0de4d52f
Message-ID: <63af8b69.9bh1fbKr7m4CPOrQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: fdcbb2aa95b584bf189401bd3072b4bc0de4d52f  Merge branch into tip/master: 'x86/microcode'

elapsed time: 723m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
sh                               allmodconfig
arc                                 defconfig
mips                             allyesconfig
alpha                               defconfig
powerpc                          allmodconfig
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                                defconfig
s390                             allmodconfig
s390                                defconfig
x86_64                           rhel-8.3-bpf
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a014-20221226
x86_64               randconfig-a013-20221226
x86_64               randconfig-a011-20221226
x86_64               randconfig-a012-20221226
s390                             allyesconfig
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a016-20221226
arm                                 defconfig
x86_64               randconfig-a015-20221226
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
arm64                            allyesconfig
i386                 randconfig-a013-20221226
arm                              allyesconfig
i386                 randconfig-a014-20221226
i386                 randconfig-a012-20221226
i386                 randconfig-a011-20221226
i386                             allyesconfig
i386                 randconfig-a015-20221226
i386                 randconfig-a016-20221226
arm                  randconfig-r046-20221225
arc                  randconfig-r043-20221225
arc                  randconfig-r043-20221227
arm                  randconfig-r046-20221227
arc                  randconfig-r043-20221226
riscv                randconfig-r042-20221226
s390                 randconfig-r044-20221226
x86_64                            allnoconfig
i386                          randconfig-c001

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a002-20221226
i386                 randconfig-a003-20221226
x86_64               randconfig-a003-20221226
x86_64               randconfig-a001-20221226
x86_64               randconfig-a004-20221226
i386                 randconfig-a001-20221226
x86_64               randconfig-a005-20221226
x86_64               randconfig-a006-20221226
i386                 randconfig-a005-20221226
i386                 randconfig-a004-20221226
i386                 randconfig-a006-20221226
i386                 randconfig-a002-20221226
hexagon              randconfig-r045-20221225
riscv                randconfig-r042-20221227
hexagon              randconfig-r041-20221225
s390                 randconfig-r044-20221227
hexagon              randconfig-r041-20221227
hexagon              randconfig-r041-20221226
arm                  randconfig-r046-20221226
s390                 randconfig-r044-20221225
hexagon              randconfig-r045-20221226
riscv                randconfig-r042-20221225
hexagon              randconfig-r045-20221227

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
