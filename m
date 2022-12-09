Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BBF647CD0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 05:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLIEFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 23:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLIEFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 23:05:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E472EF74
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 20:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670558704; x=1702094704;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BDkI8whAeZGqrwwGv9GRdxHU/f7CM+7+/e00pffDKs8=;
  b=a+LGhAsFMfZg/+GrnTohYuGStUKQQJW962hvB2VxGLhOZ3GpQovKvU1c
   utW98AW+oI/2j5X0v17RYWbjcfNvh4+hfg04kM8FelbZor8gKqTFRydwt
   6E2aNl2cDygr9wyCd/VLxdRnU4RIFB1l9zp8KxVMHPWaiv0aw+EMBcYtC
   LvBUxgF7cPU7neP1QZESzWenTxJeqoWVaE9i+PZ0nS1BJy+Tjxz53DhIS
   fvBJT0xb1AahVqV0fSN5NKr5o51H/qTDpBnezAqTTn/QXE5VgbKXOulsZ
   jzJqnq7Nq2HSYKQDR3eYePTT99NGO81hToHDyky4JLXtuh8CH1evb4lML
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="344407547"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="344407547"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 20:05:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="624979641"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="624979641"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Dec 2022 20:05:02 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3UdB-0001bP-2J;
        Fri, 09 Dec 2022 04:05:01 +0000
Date:   Fri, 09 Dec 2022 12:05:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 a5dadcb601b4954c60494d797b4dd1e03a4b1ebe
Message-ID: <6392b3ec.tOSkmf/QOi8iVqV4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: a5dadcb601b4954c60494d797b4dd1e03a4b1ebe  Merge branch into tip/master: 'irq/core'

elapsed time: 730m

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
s390                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
m68k                             allyesconfig
powerpc                          allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                              defconfig
arc                  randconfig-r043-20221207
riscv                randconfig-r042-20221207
s390                 randconfig-r044-20221207
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                                defconfig
arm                                 defconfig
i386                          randconfig-a001
i386                          randconfig-a003
arm                              allyesconfig
i386                          randconfig-a005
arm64                            allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a004
x86_64                        randconfig-a002
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a014
x86_64                        randconfig-a006
x86_64                        randconfig-a015
i386                          randconfig-a012
x86_64                           rhel-8.3-syz
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                  randconfig-r046-20221207
hexagon              randconfig-r041-20221207
hexagon              randconfig-r045-20221207
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a001
i386                          randconfig-a013
x86_64                        randconfig-a003
x86_64                        randconfig-a016
x86_64                        randconfig-a005
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
