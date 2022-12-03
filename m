Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5656411FB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiLCA0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiLCA0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:26:37 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B09D8AAFA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027197; x=1701563197;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=L2GLJq+jvW1QGfZ6w6CBIoldGfPfUqL+JNtnox8R46s=;
  b=Bt27BY/zWnpDXSNaLGzfHLTsAtRIpBTQb6PTDUJV5jbST4YO3xauaIQu
   Dop0i1DYsAniGti5s8pwkPJCrlsZtsTjtmjFR9/Jd0ri7BWGuCzZ1owt/
   M9P0KGEoOiZpid4Oy1pIA1qs3MZxRCNLrbcFQi6yibuQVGrV7lcIBHT9+
   9NqkQkmhlrxdmzwrmA6j9vE0apmZOZ5JnaTBqdINa0OUFMdaxQfrHaILT
   pKw+nxZ+xzVrwJHl7mDeCXQb9p4B3cLzlMGr+DAPj8Dl4LGrRwaCZGR79
   PLxzMRYzV8iDPGjyhoiKdxCQp9KKpUlqDrLmaeUD6KTwpR3IIZ8h/fnnQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313709266"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313709266"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:26:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="647358266"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="647358266"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 02 Dec 2022 16:26:33 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1GMT-000E9D-13;
        Sat, 03 Dec 2022 00:26:33 +0000
Date:   Sat, 03 Dec 2022 08:25:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:smp/core] BUILD SUCCESS
 6f855b39e4602b6b42a8e5cbcfefb8a1b8b5f0be
Message-ID: <638a9782.ru7g2Fji382asI2s%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
branch HEAD: 6f855b39e4602b6b42a8e5cbcfefb8a1b8b5f0be  cpu/hotplug: Do not bail-out in DYING/STARTING sections

elapsed time: 731m

configs tested: 59
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a004
i386                          randconfig-a005
x86_64                        randconfig-a002
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                               rhel-8.3
arc                  randconfig-r043-20221201
x86_64                           allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a013
riscv                randconfig-r042-20221201
x86_64                        randconfig-a011
s390                 randconfig-r044-20221201
ia64                             allmodconfig
x86_64                        randconfig-a015
powerpc                           allnoconfig
m68k                             allyesconfig
powerpc                          allmodconfig
alpha                            allyesconfig
mips                             allyesconfig
m68k                             allmodconfig
i386                                defconfig
arc                              allyesconfig
sh                               allmodconfig
i386                             allyesconfig
arm                                 defconfig
x86_64                            allnoconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
x86_64                        randconfig-a001
i386                          randconfig-a011
i386                          randconfig-a006
x86_64                        randconfig-a003
i386                          randconfig-a015
hexagon              randconfig-r041-20221201
x86_64                        randconfig-a005
hexagon              randconfig-r045-20221201
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
