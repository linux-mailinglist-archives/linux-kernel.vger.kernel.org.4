Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68DE69A5FB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjBQHQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBQHQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:16:23 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5D04CCBA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676618182; x=1708154182;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OU/xN2FFpuZPk1yD7UcV1hhjmNqNkFrlhhwhX/s19ww=;
  b=EtKd4a+eQW+eWovQAfkolC6/j8IDtMbfvjt++pTTHbXwGfK7XTtIXYDZ
   b2AgByeKF7HXSNsLRMyxe5hxAEfvGNKS+lBQvHC+QDTtelafad2QTV0gv
   bRVfG32xhy3EUY0xbkfxupr/JiDyOPQHiOrimcpOheUIPyWBtrO1kE8Zx
   1sr1OM1uyYPxnTCS8tii1Sm2wE31caGA5+RhL2yL9v6SlP+ZD2a+xD36G
   LNsYR5WIkOLI5CNFM9xfjiPGcTec13CMZTLKGV2uRMmJnMExNrcfLl61d
   SO6AYJtk1nnQN5yorpf1s05Hd6rwbDN9br5nyTKP0anJket7rQop7VgEN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="312296934"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="312296934"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 23:12:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="672507035"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="672507035"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 16 Feb 2023 23:12:02 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSuuX-000BC9-2h;
        Fri, 17 Feb 2023 07:12:01 +0000
Date:   Fri, 17 Feb 2023 15:11:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.02.06b] BUILD REGRESSION
 5632ab73470796810edb2ee9cf387ad88ffa0dcf
Message-ID: <63ef288c.jDBPbrVL1xUx2pCP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LONGWORDS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.02.06b
branch HEAD: 5632ab73470796810edb2ee9cf387ad88ffa0dcf  kcsan: select CONFIG_CONSTRUCTORS

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202302021723.ucm8d559-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

net/netfilter/ipvs/ip_vs_est.c:552:17: error: 'kfree_rcu' undeclared (first use in this function); did you mean 'kfree_skb'?
net/netfilter/ipvs/ip_vs_est.c:552:29: error: macro "kfree_rcu" requires 2 arguments, but only 1 given

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- sparc-allyesconfig
    |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
    `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given

elapsed time: 1915m

configs tested: 48
configs skipped: 3

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                              allyesconfig
arc                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
mips                             allmodconfig
mips                             allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
sh                               allmodconfig
sparc                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64               randconfig-a011-20230213
x86_64               randconfig-a012-20230213
x86_64               randconfig-a013-20230213
x86_64               randconfig-a014-20230213
x86_64               randconfig-a015-20230213
x86_64               randconfig-a016-20230213
x86_64                               rhel-8.3

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
