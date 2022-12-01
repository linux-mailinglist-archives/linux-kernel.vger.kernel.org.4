Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF0563FA87
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiLAWZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiLAWZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:25:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12709201B8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669933549; x=1701469549;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yUStmfadKkmWpPAE/FwtbVkr1eh6voTlamZRfYyjeNc=;
  b=DIC1nE0yqVP7AgFoxMgdZnDT/xDr7vODIoHebzg48yIweGVLJkwRs/at
   lcsOK8U0oEZ4dF3DaaZ75+2rSg5yOHJQc9tt5jk8YSDUY+WXu6Up+5ont
   MtI5Ut0qyZOe1Ckm3b8yW1cLaasIgFhqBsEiCHFqJRny7k0QZuFACdFXu
   XtU+NG3gjFkb4mhOuCdZFWgTvtX2nPRe3w2hlqjF/Jy+dx+9DMdn61YWN
   C2MmDAffPMKc38RW8tiZCYQKAOo/eEM5cJ9Dzc/hzmJhNoA7uBN0mFyqN
   bdafzkJa6xTI+0we5B6WE/0/BgNewqEw87UylIDNeDlWKq1+Jhcb4ecrT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="342745673"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="342745673"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 14:25:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="787059762"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="787059762"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Dec 2022 14:25:45 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0s00-000CyQ-2B;
        Thu, 01 Dec 2022 22:25:44 +0000
Date:   Fri, 02 Dec 2022 06:25:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.11.23b] BUILD SUCCESS
 5abe1458d6716094f20316ba0373df01af2f0252
Message-ID: <638929d2.MQSX2rWI8JaPp/Zh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.11.23b
branch HEAD: 5abe1458d6716094f20316ba0373df01af2f0252  Documentation: Fixed a typo in atomic_t.txt

elapsed time: 1694m

configs tested: 56
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
alpha                            allyesconfig
s390                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arc                              allyesconfig
x86_64                           rhel-8.3-kvm
um                           x86_64_defconfig
powerpc                           allnoconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
x86_64                              defconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20221128
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
ia64                             allmodconfig
x86_64               randconfig-a002-20221128
x86_64               randconfig-a001-20221128
x86_64               randconfig-a003-20221128
x86_64               randconfig-a004-20221128
x86_64               randconfig-a005-20221128
x86_64               randconfig-a006-20221128
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig

clang tested configs:
hexagon              randconfig-r045-20221128
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
s390                 randconfig-r044-20221128
x86_64               randconfig-a013-20221128
x86_64               randconfig-a012-20221128
x86_64               randconfig-a014-20221128
x86_64               randconfig-a011-20221128
x86_64               randconfig-a015-20221128
x86_64               randconfig-a016-20221128
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
