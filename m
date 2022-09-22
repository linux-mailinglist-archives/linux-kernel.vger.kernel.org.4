Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74895E5C68
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiIVH3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiIVH3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:29:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8BFD12F1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663831748; x=1695367748;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=k9qs39PELS4GoHGgV0/R5Yu65JN0uqBWFmDRJIFGfms=;
  b=lAWLOwpvRlUt0cDkZpyim0cBZiiqpSxvHzS2YQVAmStDxV9WkmLDl6i+
   Wp4xd8amFntw+smohk/+mVA05vXLojbGSbeQgt3Gb65ySPy+yLix/6MwE
   5ici7DK4O45wMNLDRvRv+MWh9n9CCICH2gU6/JdL9a4Di3oRD9riMimwz
   GDgocSqQ30wtqKD7KFjM5+xuIOskM6vQkjCWHm0R4d0ER8Lmf2wnGbl/i
   F+x7PJ+4IC9Rk8UVDY7uNxI+C2oOrYRgfybTgdAs2ptvicYUivsDqOVXj
   uZEKlgQkQm4JlDysxX9ud9/OcDQ3Y5gMbklEGG6RC88XZVOd6tGYvCOOQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="280594316"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="280594316"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 00:29:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="688190601"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Sep 2022 00:29:06 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obGdt-0004R0-2d;
        Thu, 22 Sep 2022 07:29:05 +0000
Date:   Thu, 22 Sep 2022 15:28:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 467e9e2ff121ec538f78065cba2608da32774f7f
Message-ID: <632c0ea9.ycJ+i5dRPOMhMFL8%lkp@intel.com>
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
branch HEAD: 467e9e2ff121ec538f78065cba2608da32774f7f  rcu: Fix late wakeup when flush of bypass cblist happens (v6)

elapsed time: 931m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                             allyesconfig
s390                                defconfig
um                           x86_64_defconfig
um                             i386_defconfig
arc                  randconfig-r043-20220921
riscv                randconfig-r042-20220921
alpha                            allyesconfig
arc                              allyesconfig
s390                 randconfig-r044-20220921
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                                defconfig
x86_64                        randconfig-a006
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                              defconfig
i386                          randconfig-a014
x86_64                               rhel-8.3
i386                          randconfig-a012
arm                                 defconfig
i386                          randconfig-a016
x86_64                           allyesconfig
i386                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
