Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7DE5EB208
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiIZUYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIZUYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:24:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738B6A4851
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664223851; x=1695759851;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OlVYnHFXS/LEF96OUmHtue0noYUiQwyeq+L4FgYlLmM=;
  b=B5xHl2AmXQjEuLQvwcMSGNlMOoOTYMf5rl0KUBqDgjtWHBp0Crs+utJB
   QXcywtGcerd3BdsQF+vGvfBMV/xN705cKWoWgKSsVvPKwvROB8njwMi8P
   pQT3jNP+NCc9bDcjq6dq4sUEzCQ0j+i3KXLu5NStsP10DuPkoSe/ycUXY
   Kbgb6Iq0tFvvPWAUfAHoNPoBZGuIlTm/bD49aeZL6R4VO5XoH7vBxuJ9i
   +g3Dz5jD9Kg7kkbyfh3KVVfCTFrpIZVF7RVFycIPkC5vOtgudrOEhZpzj
   uCRfJ1cq3P5LxsqM+VRcuN4cyMJ8rWg7Eu4U6eijQsqRWtHF3/12KcONT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="301114975"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="301114975"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 13:24:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="654420107"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="654420107"
Received: from lkp-server02.sh.intel.com (HELO dfa2c9fcd321) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2022 13:24:10 -0700
Received: from kbuild by dfa2c9fcd321 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ocue9-0000DK-1D;
        Mon, 26 Sep 2022 20:24:09 +0000
Date:   Tue, 27 Sep 2022 04:23:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 51e1b05cbe8740a1ab1d6455a6523a152de972fe
Message-ID: <63320a45.yjck+czezNE2/sKQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 51e1b05cbe8740a1ab1d6455a6523a152de972fe  Merge branch into tip/master: 'x86/timers'

elapsed time: 722m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
x86_64               randconfig-a002-20220926
alpha                               defconfig
x86_64               randconfig-a001-20220926
x86_64               randconfig-a003-20220926
x86_64               randconfig-a004-20220926
x86_64               randconfig-a006-20220926
x86_64               randconfig-a005-20220926
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
arc                              allyesconfig
s390                                defconfig
x86_64                           rhel-8.3-syz
i386                                defconfig
alpha                            allyesconfig
s390                             allmodconfig
powerpc                           allnoconfig
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                  randconfig-r043-20220925
s390                             allyesconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
riscv                randconfig-r042-20220925
sh                               allmodconfig
arc                  randconfig-r043-20220926
s390                 randconfig-r044-20220925
x86_64                           allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
arm                                 defconfig
i386                 randconfig-a001-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
arm64                            allyesconfig
i386                 randconfig-a005-20220926
i386                             allyesconfig
arm                              allyesconfig
i386                 randconfig-a006-20220926

clang tested configs:
x86_64               randconfig-a012-20220926
x86_64               randconfig-a013-20220926
hexagon              randconfig-r045-20220925
x86_64               randconfig-a011-20220926
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a014-20220926
x86_64               randconfig-a016-20220926
i386                 randconfig-a011-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a016-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a015-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
