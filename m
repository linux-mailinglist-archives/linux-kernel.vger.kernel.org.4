Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4044E666B52
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 07:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjALG67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 01:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbjALG6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 01:58:49 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91064BD50
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 22:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673506727; x=1705042727;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vt29QpmloR83+mhULh0sgirTO8EtzuU82gOAfWQq+F8=;
  b=NZb6GvacGLuwztwL0LxRISKKnwrW85KVGVpLHZHMUA6crvYx04OP/X+q
   0BSRWI3JbrO5zaOtQwSpkz7RVcuBQGYGnVvcMoETflSkDdzL7onNdxqZN
   BQaC0R864HIveX/CwCj3IXTKFcF5Cftl8bmCPkSqF2ABeoF7H2JLiphns
   0vNMPQmeMHb3u6iilOBAh2M9b6enVLd4TcpODfPv0ZPkJ6KWdOwBYz/CQ
   qBekYw4fmwIzuPC+UNR/mCEU5elv6P0I7LjbTs2VjYApNYK6J56o59WUQ
   vN98sFhJNUkR0NS6b5juNZbywo5+WPWmEbwQsQjoO9y4guvEsSuRoXhOF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324865147"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="324865147"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 22:58:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="657691442"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="657691442"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 11 Jan 2023 22:58:45 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFrXw-0009u0-1k;
        Thu, 12 Jan 2023 06:58:44 +0000
Date:   Thu, 12 Jan 2023 14:58:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 9f76d59173d9d146e96c66886b671c1915a5c5e5
Message-ID: <63bfaf8c.oQhtLhiqCl+Y8EUm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 9f76d59173d9d146e96c66886b671c1915a5c5e5  timers: Prevent union confusion from unexpected restart_syscall()

elapsed time: 735m

configs tested: 78
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
sh                               allmodconfig
s390                             allyesconfig
i386                          randconfig-a001
x86_64                        randconfig-a013
i386                          randconfig-a003
x86_64                        randconfig-a011
mips                             allyesconfig
i386                          randconfig-a005
arm                                 defconfig
um                             i386_defconfig
x86_64                              defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a015
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                               rhel-8.3
arc                  randconfig-r043-20230110
i386                                defconfig
x86_64                        randconfig-a006
powerpc                          allmodconfig
arm64                            allyesconfig
s390                 randconfig-r044-20230110
x86_64                           rhel-8.3-syz
arm                              allyesconfig
riscv                randconfig-r042-20230110
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
x86_64                           rhel-8.3-bpf
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
ia64                             allmodconfig
alpha                            allyesconfig
i386                             allyesconfig
i386                          randconfig-a014
arm                          gemini_defconfig
powerpc                     tqm8548_defconfig
i386                          randconfig-a012
i386                          randconfig-a016
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
m68k                         amcore_defconfig
arm                        multi_v7_defconfig
sh                              ul2_defconfig
m68k                             alldefconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    klondike_defconfig

clang tested configs:
i386                          randconfig-a002
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a004
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a016
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
arm                  randconfig-r046-20230110
hexagon              randconfig-r045-20230110
x86_64                        randconfig-a005
hexagon              randconfig-r041-20230110
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
arm                         s5pv210_defconfig
hexagon                          alldefconfig
powerpc                     ksi8560_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
