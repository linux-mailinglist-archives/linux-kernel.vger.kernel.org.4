Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6B45F208D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 01:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJAXKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 19:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJAXKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 19:10:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA38A24975
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 16:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664665801; x=1696201801;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Y797qqRgo0VROOaPHRRtz+ojF0zVRxhaDxV0aldhXQQ=;
  b=jNdEuBKRIym9DDVgurCdZwURhk3gQlavZ6UfSDyukhtXGl0ZpChc1q4n
   55Z+dzkpzf2vDdWV6enw2nT63nQWa9clH2wszS65HbDIbCu8YsfjnIh7g
   b2vqWetG3KLp0qv9xCO2FuUaFfkVJY49gxmNGDTEvRQ/J+ItGNXxeiYBQ
   t59ZMT6eUXEzB7HRcv/lJiGwkyMqJnIi1Ot+K7yU177NgVcxWodJWyMwM
   V95Bq0wNxBnjadXT2QQjKxIvpVRgkpiBSO039ZouusWZ7FKu2gsEyelyQ
   lC4lWyKL3NTWQxrUTZMG043RoQFCdikNMUN0IM4VD9cNWdOv3ZlhRClPB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="301144126"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="301144126"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 16:10:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="685696459"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="685696459"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Oct 2022 16:10:00 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oelcO-0002rA-00;
        Sat, 01 Oct 2022 23:10:00 +0000
Date:   Sun, 02 Oct 2022 07:09:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.09.28a] BUILD SUCCESS
 55df35755efa2e44d901d107ccc3b0aa0aa85008
Message-ID: <6338c8b1.tXOWESo8rosfkJT0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.09.28a
branch HEAD: 55df35755efa2e44d901d107ccc3b0aa0aa85008  rcu-tasks: Make grace-period-age message human-readable

elapsed time: 3072m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
m68k                             allyesconfig
x86_64                          rhel-8.3-func
m68k                             allmodconfig
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           allyesconfig
i386                             allyesconfig
arm                                 defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
arm64                            allyesconfig
arm                              allyesconfig
arc                  randconfig-r043-20220928
i386                 randconfig-a001-20220926
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a006-20220926
i386                 randconfig-a005-20220926
arc                  randconfig-r043-20221002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
ia64                             allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                 randconfig-a011-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a014-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a016-20220926
riscv                randconfig-r042-20220928
hexagon              randconfig-r045-20220928
hexagon              randconfig-r041-20220928
i386                 randconfig-a016-20220926
i386                 randconfig-a015-20220926
s390                 randconfig-r044-20220928
i386                 randconfig-a014-20220926
hexagon              randconfig-r041-20221002
hexagon              randconfig-r045-20221002
s390                 randconfig-r044-20221002
riscv                randconfig-r042-20221002
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
