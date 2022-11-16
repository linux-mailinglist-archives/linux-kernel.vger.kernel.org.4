Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E96F62CD57
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbiKPWFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbiKPWFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:05:25 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D83657DB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668636322; x=1700172322;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sKrnKMb881XPHkRZm3uwqMkBKYSh5KgAMZ2DTt66W2w=;
  b=UPSqYcDBQmKfiDBQj1b4dGtBll6S9vaB5fJEclKCTFN7TtIuXuPUUiZ4
   Zsq8uWSdh4zJ69vwG137Jq9aZ8lvk2R3sqUpq+9Yopwl5Nk9WxwMsL5ZZ
   I3I9mJ8w5Mx2BUoEKZcS2m4xbtX8LtWY/8W7AsxB0ZXZpz0ghFZhfi4DW
   +Mnctp+k77Vtke4/JpA4p4zqPVbpa3pNbk5zxFMPhCwVDflP8lTE1Tanx
   GVjc7TeytomCkYLMz/THTNBQd7at/9ZmITwJdZpTaDbKxsUaDg173o7mO
   M5xvc4JBDhB7eYyfOeuBYtEr991ujUWnruA7Lm38eG8BUWvohiQKjOUCU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="314497124"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="314497124"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 14:05:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="745241370"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="745241370"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 16 Nov 2022 14:05:20 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovQX2-0002mR-0A;
        Wed, 16 Nov 2022 22:05:20 +0000
Date:   Thu, 17 Nov 2022 06:04:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 d6962c4fe8f96f7d384d6489b6b5ab5bf3e35991
Message-ID: <63755e80.5CC1dGcQW+ApHaFG%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: d6962c4fe8f96f7d384d6489b6b5ab5bf3e35991  sched: Clear ttwu_pending after enqueue_task()

elapsed time: 722m

configs tested: 83
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
s390                                defconfig
arc                                 defconfig
m68k                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                               defconfig
s390                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allmodconfig
s390                             allyesconfig
i386                                defconfig
x86_64                          rhel-8.3-func
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a001
powerpc                          allmodconfig
arm                                 defconfig
i386                             allyesconfig
i386                          randconfig-a003
ia64                             allmodconfig
sh                               allmodconfig
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                          randconfig-a005
x86_64                        randconfig-a002
arm                              allyesconfig
arm64                            allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a006
arc                  randconfig-r043-20221116
arm                         s3c6400_defconfig
sparc64                             defconfig
arm                       multi_v4t_defconfig
powerpc                     asp8347_defconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                            allnoconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a013
arm                        shmobile_defconfig
sh                   sh7770_generic_defconfig
loongarch                 loongson3_defconfig
mips                           gcw0_defconfig
alpha                            alldefconfig
powerpc                     tqm8555_defconfig
x86_64                        randconfig-a011
i386                          randconfig-c001
sh                          r7785rp_defconfig
sh                            titan_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                            ar7_defconfig
arm                            zeus_defconfig
arm                             ezx_defconfig
microblaze                          defconfig
sh                          rsk7203_defconfig
sparc64                          alldefconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a001
riscv                randconfig-r042-20221116
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221116
x86_64                        randconfig-a005
hexagon              randconfig-r045-20221116
s390                 randconfig-r044-20221116
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                     pseries_defconfig
hexagon              randconfig-r041-20221117
hexagon              randconfig-r045-20221117
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
