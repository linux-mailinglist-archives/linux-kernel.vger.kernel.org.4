Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9400E6163ED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiKBNhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKBNhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:37:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD36829C8B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667396219; x=1698932219;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=azs9ElEO48Fqp6/mDDU9bb0uJRMp6Uje8pYo8MF9Z9k=;
  b=ePBzxQYSHXQUBcSUx0VCOr2G2spNOQVZ1UEJXkOKmnXLCnGjsrbsTXll
   T5M79WxWVnSyjrgNoJ5cxhripllkQk18I7Z1KowPEBSiKFSw8dxuHHZCT
   imHHN5r/aGh5WJpR/jDEOcNai2YP1jANi1xG7IzG4mASFfkyf4cjl6Rn2
   z2XPn/r4f5nwwmskhVujDOh7V2tlgLuzb5a4vQE4H2g+212SuHnmUiti0
   NNtknrrjb3qQUJDk1tBHPPndURpT8stFAHjyzfVJEEkbKXRCAJpn3lOEW
   TSdd0b1qkMDW3F3XgpokvzKWZHP0xSKVaHBK2uBorkP2ZmxW5y+z1scNt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="307020618"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="307020618"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 06:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="585397602"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="585397602"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Nov 2022 06:36:58 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqDvN-000Em8-1H;
        Wed, 02 Nov 2022 13:36:57 +0000
Date:   Wed, 02 Nov 2022 21:36:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.10.28a] BUILD SUCCESS
 eaee921daa7091f0eb731c9217ccc638ed5f8baf
Message-ID: <63627249.9QKg/LVGQttKT6ew%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.10.28a
branch HEAD: eaee921daa7091f0eb731c9217ccc638ed5f8baf  squash! clocksource: Exponential backoff for load-induced bogus watchdog reads

elapsed time: 722m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                  randconfig-r043-20221101
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
s390                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a013
x86_64                    rhel-8.3-kselftests
s390                                defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a006
x86_64                               rhel-8.3
i386                                defconfig
x86_64                        randconfig-a004
x86_64                              defconfig
s390                             allyesconfig
arc                              allyesconfig
i386                          randconfig-a014
alpha                            allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
arm                                 defconfig
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
sh                               allmodconfig
m68k                             allyesconfig
mips                             allyesconfig
m68k                             allmodconfig
powerpc                          allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20221101
hexagon              randconfig-r045-20221101
riscv                randconfig-r042-20221101
s390                 randconfig-r044-20221101
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a014
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
