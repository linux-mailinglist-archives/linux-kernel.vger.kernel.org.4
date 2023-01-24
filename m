Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB191679AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjAXODr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbjAXODn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:03:43 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCA01ABF2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674569000; x=1706105000;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Xjin1MKwrS1nZTpuKEZpD395ChkPxx9UAHZP0HubY80=;
  b=ituRYNhKmLLY/7TdZbp7titb0zkIogZE9cPm6duin2dCBSE8cI7+pbCh
   WQGxby9X+AWP7SA2B1EsMI2Hzf0er02rzJH42/T6DLPPi+Wek6BYadlPP
   825S+nw50rORUD/EOuDNL4aY4V0W8R3/sbBgDbLXv2dYCQG0I1Ft5XZdP
   ZUt8Yks39YdXXUrWNyKc578jOX9BRbge1LbEYco7oupLOdOCrjam8Pe+9
   ReG+WkNvP3LmrFsLAFQoKj9PKnmOX80zIDJXO2y20DtN3nqkxMMekYTqg
   nzMEbdXdmwuOEexQLsYTAnVCvL4kF5g9Os+wOrY4+sUuoJ0e3HiEMXJZN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="324972621"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="324972621"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 06:01:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="907502697"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="907502697"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jan 2023 06:00:59 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKJr8-0006Wi-2r;
        Tue, 24 Jan 2023 14:00:58 +0000
Date:   Tue, 24 Jan 2023 22:00:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.01.19a] BUILD SUCCESS WITH WARNING
 e51eadce38349e7edb506a61e325cc562d49409f
Message-ID: <63cfe486.r3s5IrzSyo05CuCq%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.01.19a
branch HEAD: e51eadce38349e7edb506a61e325cc562d49409f  tools/nolibc: Add gitignore to avoid git complaints about sysroot

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202301241312.yvOSgMfx-lkp@intel.com

Warning: (recently discovered and may have been fixed)

kernel/rcu/rcutorture.c:3517:6: warning: variable 'cyclelenmax' set but not used [-Wunused-but-set-variable]
kernel/rcu/rcutorture.c:3542:6: warning: variable 'cyclelenmax' set but not used [-Wunused-but-set-variable]

Unverified Warning (likely false positive, please contact us if interested):

kernel/rcu/rcutorture.c:3548 rcu_torture_init_srcu_lockdep() warn: for statement not indented

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-m001-20230123
    `-- kernel-rcu-rcutorture.c-rcu_torture_init_srcu_lockdep()-warn:for-statement-not-indented
clang_recent_errors
|-- arm64-randconfig-r004-20230124
|   `-- kernel-rcu-rcutorture.c:warning:variable-cyclelenmax-set-but-not-used
|-- hexagon-randconfig-r035-20230123
|   `-- kernel-rcu-rcutorture.c:warning:variable-cyclelenmax-set-but-not-used
|-- powerpc-randconfig-r005-20230124
|   `-- kernel-rcu-rcutorture.c:warning:variable-cyclelenmax-set-but-not-used
`-- x86_64-randconfig-a013-20230123
    `-- kernel-rcu-rcutorture.c:warning:variable-cyclelenmax-set-but-not-used

elapsed time: 733m

configs tested: 62
configs skipped: 2

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
alpha                               defconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
s390                                defconfig
s390                             allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
arc                  randconfig-r043-20230123
arm                  randconfig-r046-20230123
i386                          randconfig-a005
x86_64                              defconfig
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a004
x86_64                           allyesconfig
x86_64                        randconfig-a002
arm64                            allyesconfig
i386                             allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a006
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
i386                          randconfig-a002
riscv                randconfig-r042-20230123
i386                          randconfig-a004
s390                 randconfig-r044-20230123
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
i386                          randconfig-a006
x86_64               randconfig-a014-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a015-20230123
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                 randconfig-a014-20230123
i386                 randconfig-a012-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a015-20230123
i386                 randconfig-a016-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
