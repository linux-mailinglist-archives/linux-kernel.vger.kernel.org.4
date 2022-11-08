Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D59862049F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 01:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiKHAUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 19:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiKHAU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 19:20:29 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26ED10066
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 16:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667866828; x=1699402828;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qDSingf5/TzGRjV7lR1ytD2Flekl1mjAdItIAVSoHu0=;
  b=HkHxPTRBa9e/Qvvj49tIuER25kJ+OFGvDSjOgMVrIaPzoBa4jEmJ9pyZ
   dQHQqg1K3PLiXOH8Q6jpqLu60XlmT9Ht9xy1v0Rr4C0WbBa3Kte/N2JGn
   KEto9UAfH/62yPE7Z0U+HnM6hq11PxY6zGrxEXB24gIym6LmX8ienPbua
   GgO+d7Sh/ut1CbyY2Sg5wXSk9o3G5PwA/W6SYrxokUbyiEvhE3SUz0Pwp
   1Tn2BVy9Iu4gTGvX44ai3B8VZLhFqD9RT7NiSNssHTpLQWK8ikxaYWFMw
   xXpBSiirdLHtckVjapwfnUFc89VwqVYxHjr8RnHdkxuWdvFO+TZmwUytc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="312345151"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="312345151"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 16:20:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="669340367"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="669340367"
Received: from lkp-server01.sh.intel.com (HELO 462403710aa9) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Nov 2022 16:20:27 -0800
Received: from kbuild by 462403710aa9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1osCLq-0001LG-1D;
        Tue, 08 Nov 2022 00:20:26 +0000
Date:   Tue, 08 Nov 2022 08:19:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 75f97d8e607ceb54ed5fb2ffab09a35d1f5edcf0
Message-ID: <6369a0a8./qBU/waFxZKodJh4%lkp@intel.com>
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
branch HEAD: 75f97d8e607ceb54ed5fb2ffab09a35d1f5edcf0  rcu: Consolidate initialization and CPU-hotplug code

elapsed time: 1339m

configs tested: 71
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
riscv                randconfig-r042-20221106
arc                  randconfig-r043-20221106
s390                 randconfig-r044-20221106
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arc                  randconfig-r043-20221107
ia64                             allmodconfig
i386                 randconfig-a001-20221107
i386                 randconfig-a006-20221107
i386                 randconfig-a003-20221107
i386                 randconfig-a002-20221107
i386                 randconfig-a005-20221107
i386                 randconfig-a004-20221107
x86_64               randconfig-a004-20221107
x86_64               randconfig-a001-20221107
x86_64               randconfig-a003-20221107
x86_64               randconfig-a006-20221107
x86_64               randconfig-a005-20221107
x86_64               randconfig-a002-20221107
i386                             allyesconfig
i386                                defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a014-20221107
x86_64               randconfig-a011-20221107
x86_64               randconfig-a013-20221107
x86_64               randconfig-a012-20221107
x86_64               randconfig-a015-20221107
x86_64               randconfig-a016-20221107
hexagon              randconfig-r041-20221108
hexagon              randconfig-r045-20221108
i386                 randconfig-a013-20221107
i386                 randconfig-a011-20221107
i386                 randconfig-a012-20221107
i386                 randconfig-a014-20221107
i386                 randconfig-a015-20221107
i386                 randconfig-a016-20221107
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
