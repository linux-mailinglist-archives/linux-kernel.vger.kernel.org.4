Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BB565717A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 01:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiL1Atq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 19:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiL1Atp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 19:49:45 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF040D93
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 16:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672188584; x=1703724584;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yyO4+TuwzGJ/D/HZm70jItupSLFC4W57Ubpmn95ndE0=;
  b=aK3h300L34LK3QPQJ8HDgLdzd7RAruO7dqHiHYdyzaPK88zQoI85x47P
   xSXJy4A4sZvYil9ZlvT+jOHD9v5Mg33gvRPTe390a/NbuHSSM6VF5yKHI
   /jD2tN6dmoJmTGlVgnfu652MNfG4iDlhu4YV/YbflNab1FCkaR9S0Tkk+
   7wOLJ78qHvRQ5QKBBOIo3POZnNCRf4Uw7J5AJGocu18ibqZtsIYGHFhMg
   KNubHV6FR7O/Vq9k0nDOLnRX/faPztHFv9XWpwZACpO97bnf7v50F8KUS
   YCzmjbIEJ0eMu1Ek03B42oGXbmw02M4goDdOwhU6eWEx+F22yODrffUxs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="407046282"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="407046282"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 16:49:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="741876713"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="741876713"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Dec 2022 16:49:42 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pAKdZ-000FI5-2v;
        Wed, 28 Dec 2022 00:49:41 +0000
Date:   Wed, 28 Dec 2022 08:49:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 c89970202a1153b2fc230e89f90c180bd5bcbcef
Message-ID: <63ab9289.fnn/h6e6SjhJVTHn%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: c89970202a1153b2fc230e89f90c180bd5bcbcef  cputime: remove cputime_to_nsecs fallback

elapsed time: 723m

configs tested: 83
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
m68k                             allmodconfig
alpha                            allyesconfig
m68k                             allyesconfig
arc                              allyesconfig
x86_64                           rhel-8.3-kvm
s390                             allyesconfig
x86_64                           rhel-8.3-bpf
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
ia64                             allmodconfig
i386                 randconfig-a012-20221226
x86_64                              defconfig
i386                 randconfig-a011-20221226
x86_64                               rhel-8.3
i386                 randconfig-a013-20221226
i386                 randconfig-a014-20221226
i386                 randconfig-a016-20221226
i386                                defconfig
i386                 randconfig-a015-20221226
arm                                 defconfig
x86_64                           allyesconfig
i386                             allyesconfig
sh                               allmodconfig
arm64                            allyesconfig
x86_64               randconfig-a012-20221226
arm                              allyesconfig
x86_64               randconfig-a014-20221226
x86_64               randconfig-a013-20221226
x86_64               randconfig-a011-20221226
x86_64               randconfig-a015-20221226
mips                             allyesconfig
x86_64               randconfig-a016-20221226
powerpc                          allmodconfig
arm                  randconfig-r046-20221225
arc                  randconfig-r043-20221225
arc                  randconfig-r043-20221227
arm                  randconfig-r046-20221227
arc                  randconfig-r043-20221226
riscv                randconfig-r042-20221226
s390                 randconfig-r044-20221226
x86_64                            allnoconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20221225
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a002-20221226
x86_64               randconfig-a003-20221226
x86_64               randconfig-a006-20221226
x86_64               randconfig-a001-20221226
x86_64               randconfig-a004-20221226
x86_64               randconfig-a005-20221226
i386                 randconfig-a003-20221226
i386                 randconfig-a001-20221226
i386                 randconfig-a005-20221226
i386                 randconfig-a004-20221226
i386                 randconfig-a006-20221226
i386                 randconfig-a002-20221226
hexagon              randconfig-r045-20221225
riscv                randconfig-r042-20221227
hexagon              randconfig-r041-20221225
hexagon              randconfig-r041-20221227
hexagon              randconfig-r041-20221226
arm                  randconfig-r046-20221226
s390                 randconfig-r044-20221225
hexagon              randconfig-r045-20221226
riscv                randconfig-r042-20221225
hexagon              randconfig-r045-20221227
s390                 randconfig-r044-20221227
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
