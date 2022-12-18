Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102DD64FEEB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 14:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiLRNEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 08:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLRNEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 08:04:22 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2B3B1D9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 05:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671368661; x=1702904661;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=I24sFTyp/UKXONvaAGMG4cg5BaMMBdT07RdIRFqVtP0=;
  b=A9N7booBjMWB2AlIqD8vAeidsUcuyIISbn7yBvWgQ2fOjIHfCzpVo8Ct
   eM1gmU8hfyignyjlrCBPGnlQweCqWLzlHW8pydpPkm4nOcMZRCsDog0ah
   FVBJSLVzctnGepZpqAYvhFl+SJu3K5O9f/tg6VfTMQ0PDu1ZbIdhkUQcM
   Esqr1QbogKCtLJTsKNS2B9NSq90Jeg6s8tglUBuNQRl0mwdtP6bZUu4eP
   ++jxv8sfF2HDKKxkkTC8x3rOIBYRYzyC0L3kxMY2RbdNQZ5sr6SgDyq89
   jCdFqOkDWURej/dmdwWHlerHMoRi4SnXPDrv71Fva9hPJ7FbjsXlooDeM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="317893755"
X-IronPort-AV: E=Sophos;i="5.96,254,1665471600"; 
   d="scan'208";a="317893755"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2022 05:04:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="682753443"
X-IronPort-AV: E=Sophos;i="5.96,254,1665471600"; 
   d="scan'208";a="682753443"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Dec 2022 05:04:19 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p6tL0-0008Ic-0j;
        Sun, 18 Dec 2022 13:04:18 +0000
Date:   Sun, 18 Dec 2022 21:03:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.12.15a] BUILD SUCCESS
 b99e4fd99dcc3da86988dcc930a2670387677788
Message-ID: <639f0fac.7KA/pBRgVwRYQsSD%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.12.15a
branch HEAD: b99e4fd99dcc3da86988dcc930a2670387677788  rcu: Make rcu_blocking_is_gp() stop early-boot might_sleep()

elapsed time: 2072m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
arc                                 defconfig
m68k                             allyesconfig
um                             i386_defconfig
alpha                               defconfig
m68k                             allmodconfig
um                           x86_64_defconfig
x86_64                               rhel-8.3
arc                              allyesconfig
alpha                            allyesconfig
x86_64                              defconfig
s390                             allmodconfig
x86_64                        randconfig-a002
x86_64                           allyesconfig
s390                                defconfig
x86_64                        randconfig-a006
i386                          randconfig-a014
x86_64                        randconfig-a004
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
s390                             allyesconfig
ia64                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a001
i386                          randconfig-a003
arc                  randconfig-r043-20221216
s390                 randconfig-r044-20221216
riscv                randconfig-r042-20221216
i386                          randconfig-a005
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                                defconfig
i386                             allyesconfig
arc                  randconfig-r043-20221218
s390                 randconfig-r044-20221218
riscv                randconfig-r042-20221218
x86_64                            allnoconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a013
x86_64                        randconfig-a003
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                  randconfig-r046-20221216
hexagon              randconfig-r041-20221216
hexagon              randconfig-r045-20221216
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                          rhel-8.3-rust
i386                          randconfig-a006
arm                  randconfig-r046-20221218
hexagon              randconfig-r041-20221218
hexagon              randconfig-r045-20221218

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
