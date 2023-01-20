Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778C2675543
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjATNMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjATNME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:12:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A418710AB8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674220323; x=1705756323;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jClqtRk0D7ar+lDor9OnIysRgso8vrUuIXS0wAv4Rts=;
  b=ZI1BnnXVM5Pi8knhllrQBYl/YyvSKTMXrGkRE7SHneGYmMZTv67o8HY4
   CsyQzWYTigh6dsAyztuJN+G6RQBTzLjnfLLF3UqHt3UwBPBlbEcFgpom9
   30REQKjyQDUWV9P1z7Bzhqx7BLbyr0M5F4h03o7DV4WuJgrpz/vi13jZm
   Yw1zzAouKCX1Siq2+HczfGXUJX8yzdiaE8IufniEmzBFlJi/Zs3qbsalm
   02b0qngf4l7Rqk4au+2T7ZD5ejlYjyFGgIwXv7pc0N1RdzANYnKtyaiFg
   TQIB9arSDYg5Hki9oWtus1PDnGmxF1Ka1V8UW5xpRFwdmftgx8WY13Fnk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="309149705"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="309149705"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 05:12:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="784502766"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="784502766"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Jan 2023 05:12:02 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIrBY-0002Zq-2v;
        Fri, 20 Jan 2023 13:12:00 +0000
Date:   Fri, 20 Jan 2023 21:11:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:haltnmi3slow.2023.01.19a] BUILD SUCCESS
 b75213cc596d0f0d1a8fe531d52ebdd1fb6aeb0a
Message-ID: <63ca92f6.seABXNR7+acuJ96k%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git haltnmi3slow.2023.01.19a
branch HEAD: b75213cc596d0f0d1a8fe531d52ebdd1fb6aeb0a  x86/nmi: Test commit for delayed NMI handlers

elapsed time: 724m

configs tested: 77
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
powerpc                           allnoconfig
s390                                defconfig
s390                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                                defconfig
x86_64                        randconfig-a013
powerpc                  storcenter_defconfig
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a011
sh                           se7722_defconfig
i386                          randconfig-a005
m68k                             allmodconfig
powerpc                          allmodconfig
arc                              allyesconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a004
mips                             allyesconfig
alpha                            allyesconfig
arm                                 defconfig
x86_64                              defconfig
m68k                             allyesconfig
x86_64                        randconfig-a002
x86_64                           rhel-8.3-syz
ia64                             allmodconfig
x86_64                         rhel-8.3-kunit
riscv                               defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
i386                          randconfig-a014
x86_64                        randconfig-a006
x86_64                           rhel-8.3-bpf
i386                          randconfig-a012
i386                             allyesconfig
i386                          randconfig-a016
sparc64                          alldefconfig
arm64                            allyesconfig
arm                  randconfig-r046-20230119
sparc                       sparc32_defconfig
arc                  randconfig-r043-20230119
m68k                          hp300_defconfig
arm                              allyesconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20230120
s390                 randconfig-r044-20230120
riscv                randconfig-r042-20230120

clang tested configs:
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-k001
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a006
mips                      pic32mzda_defconfig
x86_64                        randconfig-a014
x86_64                        randconfig-a005
i386                          randconfig-a013
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20230119
arm                           omap1_defconfig
riscv                randconfig-r042-20230119
hexagon              randconfig-r041-20230119
s390                 randconfig-r044-20230119
hexagon              randconfig-r041-20230120
hexagon              randconfig-r045-20230120
arm                  randconfig-r046-20230120

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
