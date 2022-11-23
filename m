Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48AE636A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbiKWTzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239178AbiKWTzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:55:12 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDEBCFEA2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669233220; x=1700769220;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xlZgdPpxTpeiegHRuFoPfFvJUVSCfBUyy0Zd9xGhEUk=;
  b=NY7olaISq3JFueykdqaK0lmWOlerbd9zPCv/DfPIPsvofjzuaT7qtTFM
   PnoW2YpUF0mv5s1VQovFr5r5XCRJ72wOKuFVpV2m8oODUPCHB8ll0ToqZ
   rr4STJ759LSICLWqKadpnxYe/xYW1eCId/piYrTBqbuc7MbsNhEvI77M4
   J6aCi/TUpR3o+ITAnSYC/nP98aXG5sVL0kcxToNViDWOzXJaIElSRMQlo
   S+4ioOM64X5KxmtDkJFDFnYc32VOs66b9LAU2pKrYCpFdbVZHxXJH9JHa
   BpdUWSBHS4TB7wss3PRLW7Cy27q6heOvE51YoKwRJx3qPc6wGiLbUAx5V
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="312847174"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="312847174"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 11:53:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="674837994"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="674837994"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Nov 2022 11:53:34 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxvoL-00033a-1n;
        Wed, 23 Nov 2022 19:53:33 +0000
Date:   Thu, 24 Nov 2022 03:53:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 39035b41bccb8576146915c9566ea6f85ae51389
Message-ID: <637e7a31.DaF2hlSWilt2wSjD%lkp@intel.com>
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
branch HEAD: 39035b41bccb8576146915c9566ea6f85ae51389  tools/memory-model: Use "grep -E" instead of "egrep"

elapsed time: 2449m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
arc                                 defconfig
x86_64                           rhel-8.3-syz
alpha                               defconfig
sh                               allmodconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64               randconfig-a012-20221121
x86_64               randconfig-a011-20221121
x86_64               randconfig-a013-20221121
ia64                             allmodconfig
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
x86_64               randconfig-a014-20221121
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
i386                                defconfig
arc                  randconfig-r043-20221122
i386                             allyesconfig
x86_64                        randconfig-a006
arm                                 defconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                 randconfig-a001-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
hexagon              randconfig-r041-20221122
hexagon              randconfig-r045-20221122
s390                 randconfig-r044-20221122
riscv                randconfig-r042-20221122
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
