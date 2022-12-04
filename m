Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D76641A35
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 02:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiLDBCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 20:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLDBB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 20:01:59 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00F31AF08
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 17:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670115718; x=1701651718;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mWhbW290ZMjkRD8pMRZHtjuzwghQeYv+F/ZMXAZ3l9I=;
  b=I5Ad2K4l5UY1cL/5fQvTwbIfzy2OZyXFORsTxCfRvQhXh1/wIlFSTNkX
   qtH7hz0OdIYJHGJCFyMQ5GtVSq/dbKKxXa2l84vNLUS11fqMgTCkQW+bG
   xW8Jm/HgdXbf4HBBkgoqsujhvutzMAQFIBvgyepZ4T7SWnQhtA3p8kHfN
   pvwXrzeVDVQTaV/h/lmEvmJmhuVWYEUmvOEHVLea0SychX4xAbphgPqAX
   IC0zQ+WczTvwRlRv7X4nYRiVzz4u7We1dHVmyhvHy9w6lwbop0VhqZSH3
   HXBHRKrS38jrh+OGTNZDbFSyxVfCfda0gJoNJMTnlssqBHzqcPBav7tNX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="378308822"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="378308822"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 17:01:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="819809713"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="819809713"
Received: from lkp-server01.sh.intel.com (HELO 4d912534d779) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 Dec 2022 17:01:56 -0800
Received: from kbuild by 4d912534d779 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1dOG-0000S1-0A;
        Sun, 04 Dec 2022 01:01:56 +0000
Date:   Sun, 04 Dec 2022 09:01:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 c20479857031c1ab009a00d377a12bd87a5d2251
Message-ID: <638bf168.e4jRPtPJvmx6FBqO%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: c20479857031c1ab009a00d377a12bd87a5d2251  Merge x86/microcode into tip/master

elapsed time: 723m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           rhel-8.3-kvm
s390                                defconfig
powerpc                           allnoconfig
i386                          randconfig-a005
arm                                 defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
s390                             allyesconfig
x86_64                              defconfig
x86_64                        randconfig-a015
arm                              allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a014
arm64                            allyesconfig
ia64                             allmodconfig
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                               rhel-8.3
arc                  randconfig-r043-20221201
x86_64                        randconfig-a004
i386                                defconfig
s390                 randconfig-r044-20221201
x86_64                        randconfig-a002
x86_64                        randconfig-a006
sh                               allmodconfig
x86_64                           allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
riscv                randconfig-r042-20221201
mips                             allyesconfig
m68k                             allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
arc                  randconfig-r043-20221204

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20221201
hexagon              randconfig-r041-20221201
hexagon              randconfig-r041-20221204
hexagon              randconfig-r045-20221204
s390                 randconfig-r044-20221204
riscv                randconfig-r042-20221204

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
