Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D08B5B7D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiIMWcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIMWb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:31:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995DA69F5A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663108315; x=1694644315;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qWut/6tCN+zCbmeAh/BcCfj2aeRAUk1w9Z1/6G3H42E=;
  b=THtc9cpPkZgmmLP6rPd0fG66HpxtPHElb+HnDiIBEyHJdffQ9X0GZcn4
   hw31IzIKDtOEnlWUZhmUWilykO7NeDQjEFDLRTKucJvCGJ51tRgY48K3w
   1IYh+yx0TMGfWbP3ZZDiVE4QX1lksM7QMPHOswnF0mEa0amKmqAUVT3/u
   uLJF+xebHxmPCYMJIc0lby96o+KSOTVpFDONOtmGyonqy+LoWKTYJvbT8
   UsebDh9aSvw3J2Fby51HY+8j+RUXSXp9m/ex3xbQiB0Qo23Q8gnJcayDd
   j6fk0LR/StId/ZQ8gpUHgcSsNfiW2a1HEZtRBeCVr4TkM7YOfD4uRdMok
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="278665324"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="278665324"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 15:31:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="649842699"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Sep 2022 15:31:53 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYERd-00044n-07;
        Tue, 13 Sep 2022 22:31:53 +0000
Date:   Wed, 14 Sep 2022 06:31:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 82eedfedea446ae448f0975f1db7d1631cd24330
Message-ID: <632104aa.YWHaOKLypq4xJ/as%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 82eedfedea446ae448f0975f1db7d1631cd24330  Merge branch into tip/master: 'x86/timers'

elapsed time: 725m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-a001-20220912
i386                 randconfig-a002-20220912
i386                 randconfig-a003-20220912
i386                 randconfig-a006-20220912
i386                 randconfig-a005-20220912
i386                 randconfig-a004-20220912
arm                                 defconfig
i386                                defconfig
x86_64                              defconfig
arm                              allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
riscv                randconfig-r042-20220911
arm64                            allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
x86_64                         rhel-8.3-kunit
arc                  randconfig-r043-20220912
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
m68k                             allmodconfig
x86_64                    rhel-8.3-kselftests
arc                              allyesconfig
x86_64               randconfig-a001-20220912
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20220911
ia64                             allmodconfig
x86_64               randconfig-a004-20220912
m68k                             allyesconfig
x86_64               randconfig-a002-20220912
s390                 randconfig-r044-20220911
x86_64               randconfig-a005-20220912
x86_64               randconfig-a003-20220912
x86_64               randconfig-a006-20220912
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig

clang tested configs:
i386                 randconfig-a014-20220912
i386                 randconfig-a015-20220912
i386                 randconfig-a013-20220912
i386                 randconfig-a011-20220912
i386                 randconfig-a012-20220912
x86_64               randconfig-a014-20220912
i386                 randconfig-a016-20220912
x86_64               randconfig-a011-20220912
riscv                randconfig-r042-20220912
x86_64               randconfig-a012-20220912
hexagon              randconfig-r041-20220912
x86_64               randconfig-a015-20220912
hexagon              randconfig-r045-20220911
x86_64               randconfig-a016-20220912
x86_64               randconfig-a013-20220912
hexagon              randconfig-r041-20220911
hexagon              randconfig-r045-20220912
s390                 randconfig-r044-20220912

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
