Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD56C5EBB77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiI0H2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiI0H2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:28:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4185AA0E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664263710; x=1695799710;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=x4YGRSIkkMpt6dJX7MqUWsWvX7MB3+Vaq3OcfrbqsqA=;
  b=O4HsLFGozHpjy5u3H8jxSfwJ5xR3WOt0mNHsSRMYNaMz+pMPIumVznnQ
   4sDzcZ9bITDDPtxOI/OPIhOPb82YUjG3LWjmFQuwLd/gOm1jjIWwJoIqc
   /TGuqv5BccNRqt4/xczmRdZbr9IbkpLKUfHJXhW/kOVOLdr2vjhRW4xKb
   KmGXb3B+3u2LoRvOLfJwp6dw7LmkCgjZFhK+IHDTyVH9T9pIcMjRhlAP8
   xRhqIQpHmacIyGAWGQ/Iraa8vV0C9SGFY5Sx42nsESLKZwYwv4SCLKQ4s
   XPQ0PnwE0B2vkuMFdUQFDx9oAeaIFjOJLaUTnsvCeTJnU7paMlz22tDe0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="365288790"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="365288790"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="621421585"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="621421585"
Received: from lkp-server02.sh.intel.com (HELO dfa2c9fcd321) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 27 Sep 2022 00:28:29 -0700
Received: from kbuild by dfa2c9fcd321 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1od512-0000lc-1G;
        Tue, 27 Sep 2022 07:28:28 +0000
Date:   Tue, 27 Sep 2022 15:27:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.09.20a] BUILD SUCCESS
 ca0f880efc3515d5fadeb1a0188facb2d23bc5c0
Message-ID: <6332a5f6.cNhmAMkFTjQ0EQXM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.09.20a
branch HEAD: ca0f880efc3515d5fadeb1a0188facb2d23bc5c0  slab: Explain why SLAB_DESTROY_BY_RCU reference before locking

elapsed time: 723m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
arc                                 defconfig
x86_64                         rhel-8.3-kunit
alpha                               defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allmodconfig
x86_64                              defconfig
powerpc                           allnoconfig
s390                                defconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
x86_64                               rhel-8.3
i386                                defconfig
i386                 randconfig-a001-20220926
m68k                             allmodconfig
s390                             allyesconfig
i386                 randconfig-a002-20220926
arc                              allyesconfig
i386                 randconfig-a003-20220926
alpha                            allyesconfig
x86_64                           allyesconfig
i386                 randconfig-a004-20220926
x86_64               randconfig-a002-20220926
i386                 randconfig-a005-20220926
arm                                 defconfig
i386                 randconfig-a006-20220926
x86_64               randconfig-a001-20220926
x86_64               randconfig-a003-20220926
x86_64               randconfig-a005-20220926
x86_64               randconfig-a004-20220926
m68k                             allyesconfig
x86_64               randconfig-a006-20220926
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
arc                  randconfig-r043-20220925
riscv                randconfig-r042-20220925
arc                  randconfig-r043-20220926
s390                 randconfig-r044-20220925
ia64                             allmodconfig

clang tested configs:
i386                 randconfig-a011-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a016-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a015-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a014-20220926
hexagon              randconfig-r045-20220925
x86_64               randconfig-a013-20220926
hexagon              randconfig-r041-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a016-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
