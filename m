Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268A56601CC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjAFOKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjAFOKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:10:01 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D216C77AED
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 06:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673014200; x=1704550200;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fZw/jVqxu5hVEBJrCu7DLTQ/xktMM18Am4/dfWPrOVo=;
  b=SBCSDjYvpa3Ji02Z4HiEMRiFEgMGHwEGSY39ppeWHO0wfuQNZbPxuWBR
   4oJmCM1nfklZOTLWDjWgGUbQPdLM6qzsICgFPSaqZ+WDiQq+erIdPRItX
   +JRg0Wahu5bB5+bYttGXT8bs7ZUm/oWqr13j4pc+oxME5U6Qwccy/lKr9
   1q8bTz4gZ8+NldlXOx5sLhVCbp42eciQo27kC0pQLe8Ld4D3W5J0ozpNF
   LR5GsNghre3iJLGJQDxPbqg3wF685gcS6FZ/XtHA7HZnYSv8V4X8Z7O43
   Wf+9OYisGXtY+9L27fC5g8KPIt5I0iaOJKHiVcsmEa7I1J9ajH24MxD6r
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="384784262"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="384784262"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 06:10:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="633499808"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="633499808"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Jan 2023 06:09:45 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDnPk-0003Tq-2m;
        Fri, 06 Jan 2023 14:09:44 +0000
Date:   Fri, 06 Jan 2023 22:09:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 6f5aa91cf0f9a5ffc60a343bab6a74c9e047d399
Message-ID: <63b82b9f./oe5JZlOZSCsed1G%lkp@intel.com>
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
branch HEAD: 6f5aa91cf0f9a5ffc60a343bab6a74c9e047d399  rcu/trace: use strscpy() to instead of strncpy()

elapsed time: 723m

configs tested: 108
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
i386                          randconfig-a001
i386                          randconfig-a014
i386                          randconfig-a003
arc                  randconfig-r043-20230105
ia64                             allmodconfig
s390                 randconfig-r044-20230105
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
riscv                randconfig-r042-20230105
i386                          randconfig-a005
x86_64                        randconfig-a015
m68k                           sun3_defconfig
mips                            gpr_defconfig
ia64                         bigsur_defconfig
powerpc                           allnoconfig
arm                             rpc_defconfig
arm                          lpd270_defconfig
powerpc                     rainier_defconfig
arc                      axs103_smp_defconfig
parisc                generic-32bit_defconfig
csky                                defconfig
i386                          randconfig-c001
arc                                 defconfig
um                             i386_defconfig
i386                                defconfig
um                           x86_64_defconfig
alpha                               defconfig
arc                          axs101_defconfig
arm                                 defconfig
s390                             allmodconfig
x86_64                              defconfig
s390                                defconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
mips                             allyesconfig
powerpc                          allmodconfig
arm64                            allyesconfig
s390                             allyesconfig
x86_64                               rhel-8.3
arm                              allyesconfig
i386                             allyesconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                        m5407c3_defconfig
loongarch                           defconfig
sh                                  defconfig
x86_64                           alldefconfig
mips                         rt305x_defconfig
powerpc                      ppc40x_defconfig
sparc                       sparc32_defconfig
sh                             shx3_defconfig
m68k                           virt_defconfig
sh                           se7724_defconfig
sh                     magicpanelr2_defconfig
arm                       omap2plus_defconfig
powerpc                      makalu_defconfig
powerpc                  iss476-smp_defconfig
sh                ecovec24-romimage_defconfig
sh                        dreamcast_defconfig
sh                           se7619_defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a002
arm                  randconfig-r046-20230105
x86_64                        randconfig-a012
i386                          randconfig-a015
x86_64                        randconfig-a014
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r041-20230105
hexagon              randconfig-r045-20230105
x86_64                        randconfig-a016
mips                          ath25_defconfig
powerpc                     tqm8560_defconfig
powerpc                      pmac32_defconfig
mips                          malta_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                       cns3420vb_defconfig
powerpc                   bluestone_defconfig
arm                              alldefconfig
hexagon                             defconfig
mips                       rbtx49xx_defconfig
s390                 randconfig-r044-20230106
hexagon              randconfig-r041-20230106
hexagon              randconfig-r045-20230106
riscv                randconfig-r042-20230106
x86_64                          rhel-8.3-rust
mips                malta_qemu_32r6_defconfig
arm                           omap1_defconfig
arm                            dove_defconfig
x86_64                        randconfig-k001
mips                        maltaup_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
