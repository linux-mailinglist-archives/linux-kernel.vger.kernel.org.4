Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB7961DF26
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 23:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiKEWjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 18:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKEWjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 18:39:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AF29FE6
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 15:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667687939; x=1699223939;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=y9CDc9xZ1YMldCutFBbHC131ijp5vj6wWVs5eeGhfWo=;
  b=KxFi6Z3T/YiOY5xxWDQ3IdPHIdUyxFeJ8GcPl/wQIGmsUoBG+2lCTV/s
   pfLZINkvbYv+VTyk11f+/3JGyKr9oVAgp4tZyGiqzOKp9nQ277Ytco0zJ
   9En7auIzdQwKrJivNntNQihNJLSEXoUmIO3LF3cAyNejQwOTiM7J74pLH
   hhtrxDt2sC2TMEqoP3fpEfNRuKzgp1XYkxaWgC6ioM+NjjQQHE8hw7xjR
   vYpnBMt6VuelgdUQ+1hBMgYZ2oVyNIhBG9wMS36sNhoL9JbmqJmjN5ski
   ahQAoMW+nVWquFdwJxkQYU84byrc9cstdLyhc9lNfMWay86MCv2yoTss4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="307835265"
X-IronPort-AV: E=Sophos;i="5.96,141,1665471600"; 
   d="scan'208";a="307835265"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2022 15:38:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="586560355"
X-IronPort-AV: E=Sophos;i="5.96,141,1665471600"; 
   d="scan'208";a="586560355"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 05 Nov 2022 15:38:57 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1orRoW-000IOR-2u;
        Sat, 05 Nov 2022 22:38:56 +0000
Date:   Sun, 06 Nov 2022 06:38:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 4fd5f70ce14da230c6a29648c3d51a48ee0b4bfd
Message-ID: <6366e5fd.pdJYrjWzF41Jo8jS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 4fd5f70ce14da230c6a29648c3d51a48ee0b4bfd  x86/Kconfig: Enable kernel IBT by default

elapsed time: 723m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                               rhel-8.3
arc                                 defconfig
s390                             allmodconfig
i386                          randconfig-a014
i386                          randconfig-a001
x86_64                              defconfig
i386                          randconfig-a003
x86_64                        randconfig-a004
alpha                               defconfig
x86_64                        randconfig-a002
s390                                defconfig
i386                          randconfig-a012
x86_64                          rhel-8.3-func
x86_64                        randconfig-a006
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a005
arm                                 defconfig
s390                             allyesconfig
m68k                             allyesconfig
i386                                defconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                        randconfig-a015
alpha                            allyesconfig
x86_64                        randconfig-a013
s390                 randconfig-r044-20221104
x86_64                        randconfig-a011
riscv                randconfig-r042-20221104
arm64                            allyesconfig
ia64                             allmodconfig
x86_64                           allyesconfig
arm                              allyesconfig
arc                  randconfig-r043-20221105
powerpc                           allnoconfig
i386                             allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20221104
mips                             allyesconfig
sh                               allmodconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a002
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a015
x86_64                        randconfig-a005
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
hexagon              randconfig-r045-20221105
x86_64                        randconfig-a012
hexagon              randconfig-r041-20221105
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221104
hexagon              randconfig-r045-20221104
s390                 randconfig-r044-20221105
riscv                randconfig-r042-20221105

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
