Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E317361E4D8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 18:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKFRW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 12:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiKFRWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 12:22:39 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B90C39A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 09:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667755108; x=1699291108;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=l3iC7CmUcOXAxhDcYXOGQPCEkXZAISDUUMgzAGV88aQ=;
  b=EAW4KQZSOsaV455gAEGg7Vvo4gcZvf9j9zTsdadfMJ+/PuMuq22d40XM
   QRi8/z4EQHCVV1icJTuhAtMCeubJeEObY2txUB1JfCV7L14jyMdSTf78j
   3mW0FYfUkuV9PCw8a0OHZNnYYwlszpOPQbmnFEKrPIES4MFJlo22SkHcj
   7Zj5CeHMtAOM0y3bUQ2GeMUJD+EkuRokSGinqbGZwhgIO08TGhOzDD+gW
   dzJr14iuxH8FW92BaxmHzO4S3U/WbBcfrPUi//PHTv6A6ohlm944JPZp9
   m7PEfBIIakhDIyiXBHfgE7EL785R8UidPYOQX2Xqp6FRBL4Q/Nh+w6KrQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="374519873"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="scan'208";a="374519873"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 09:18:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="635649398"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="scan'208";a="635649398"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 06 Nov 2022 09:18:26 -0800
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1orjHt-000Ivn-37;
        Sun, 06 Nov 2022 17:18:25 +0000
Date:   Mon, 07 Nov 2022 01:17:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 5242bc5b7213c5ff120c018eabdfbcd6db3bacba
Message-ID: <6367ec36.W1Ua88kd6NgBB9i1%lkp@intel.com>
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
branch HEAD: 5242bc5b7213c5ff120c018eabdfbcd6db3bacba  rcu: Add RCU stall diagnosis information

elapsed time: 1168m

configs tested: 65
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                        randconfig-a004
um                             i386_defconfig
x86_64                        randconfig-a002
um                           x86_64_defconfig
arc                  randconfig-r043-20221106
i386                          randconfig-a001
i386                          randconfig-a003
s390                 randconfig-r044-20221106
i386                          randconfig-a005
riscv                randconfig-r042-20221106
x86_64                        randconfig-a013
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a015
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
i386                          randconfig-a012
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
sh                               allmodconfig
i386                          randconfig-a016
s390                                defconfig
i386                                defconfig
s390                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
i386                             allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
arc                        vdk_hs38_defconfig
arc                          axs101_defconfig
powerpc                        cell_defconfig
sh                            migor_defconfig
m68k                        mvme16x_defconfig
sh                     sh7710voipgw_defconfig

clang tested configs:
x86_64                        randconfig-a005
hexagon              randconfig-r041-20221106
hexagon              randconfig-r045-20221106
x86_64                        randconfig-a001
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a003
x86_64                        randconfig-a016
i386                          randconfig-a006
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
