Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC4C62EB9A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 03:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbiKRCFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 21:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiKRCF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:05:29 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A07F7A35E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668737128; x=1700273128;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JyJauzkQODxGtfljjlMpNx1r98raawwNidDBzEU6WJw=;
  b=LNSn61ZzvxHdMY8F1UwdjhdSdxAnYxOnqzQQsWLOk7y95koFZzIGKoeK
   OncUgoa4el1sa+/00TCblGhele5DHhK5NUjr2ZLhBVtyl8Sd2VEdQMB+P
   lT1nu1iUW/E4Ph7MVhUE48TQvh2q7cSJeJLy+75VbiqWZy52yW5cqjlKp
   RMtdp+yyKRQSaKMFFTCKMP7DspeqDCm/4Mr6k+13PvcmVqHnw6yaLo+3t
   Mq/R13fzHJKxEmS9aX9rCvBbw0CvNxGO2n1UwTfmrvj37a9I6uuXSmJLJ
   pr519gMpTi4PDz4NizQ0DGt0ruikUO7FpywGTevEEyb2tHLqnvSy6kJe9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="292732151"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="292732151"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 18:05:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="814746175"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="814746175"
Received: from lkp-server01.sh.intel.com (HELO 55744f5052f8) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2022 18:05:26 -0800
Received: from kbuild by 55744f5052f8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovqkw-0000v1-0S;
        Fri, 18 Nov 2022 02:05:26 +0000
Date:   Fri, 18 Nov 2022 10:05:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 72ff63e2d3f19963a4ef401e5f8c1bd16646b587
Message-ID: <6376e857.iDCD6vFdPdJIrQVR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 72ff63e2d3f19963a4ef401e5f8c1bd16646b587  clocksource: Print clocksource name when clocksource is tested unstable

elapsed time: 1760m

configs tested: 84
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                        randconfig-a002
m68k                             allmodconfig
arc                              allyesconfig
x86_64                            allnoconfig
arc                                 defconfig
ia64                             allmodconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a004
sh                          sdk7786_defconfig
arm                            zeus_defconfig
openrisc                            defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
alpha                               defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                              defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                        randconfig-a013
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
x86_64                               rhel-8.3
s390                             allmodconfig
x86_64                        randconfig-a011
s390                                defconfig
s390                             allyesconfig
x86_64                        randconfig-a006
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a015
um                               alldefconfig
sh                           se7722_defconfig
sh                         ap325rxa_defconfig
arc                  randconfig-r043-20221117
riscv                randconfig-r042-20221117
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-c001
i386                          randconfig-a016
s390                 randconfig-r044-20221117
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                       omap2plus_defconfig
arm                           stm32_defconfig
sh                           se7705_defconfig
powerpc                       maple_defconfig
sh                        edosk7705_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
x86_64                        randconfig-a001
powerpc                          g5_defconfig
x86_64                        randconfig-a005
hexagon              randconfig-r041-20221117
hexagon              randconfig-r045-20221117
x86_64                        randconfig-a016
x86_64                        randconfig-a003
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
