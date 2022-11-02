Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018636161DB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKBLkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKBLj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:39:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBF563F9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 04:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667389195; x=1698925195;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=j5quP0J+6I4e3yoi2xA+3ANFPu07lIFcjaOR8KQ7qgc=;
  b=jcJsyn7/ZM5XZX0mE5U0hmxb1Dxs5YmEmFSAJviCcjt9YerS+17Y/ZEs
   uT722CHyFoYpbfJhtfyYf9XLU7connfZuvhHt8mqE/PxrxDbseAfJIRNv
   oWufZMnMeN/15/qmmNa5i4iD4G2Wit2yPEb9Rk0xeTZ90FU0SWqNDwNqY
   7aZkWzd3g9eY+UvvLVcrpKlefB2RStIbrM7Cow7qo8SJbs3uJwR8/Nzxn
   ++OGnF2SkLtn96E61fguRKXitg5CDscP+rj0AHXw0GxXt4jp4MDVvSfKB
   vatowH04cBJJGGVOUvYfY4nF8RsDA/3VYr00OtUKANYneFrZy6lTfyKwP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="308104232"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="308104232"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 04:39:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="697776793"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="697776793"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 02 Nov 2022 04:39:54 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqC65-000EiH-1b;
        Wed, 02 Nov 2022 11:39:53 +0000
Date:   Wed, 02 Nov 2022 19:39:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 373e715e31bf4e0f129befe87613a278fac228d3
Message-ID: <636256dd.eqvham6J+zgmbJtg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 373e715e31bf4e0f129befe87613a278fac228d3  x86/tdx: Panic on bad configs that #VE on "private" memory access

elapsed time: 721m

configs tested: 82
configs skipped: 76

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a002
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                 randconfig-a014-20221031
i386                 randconfig-a011-20221031
i386                 randconfig-a012-20221031
i386                                defconfig
i386                 randconfig-a013-20221031
i386                 randconfig-a015-20221031
i386                 randconfig-a016-20221031
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                             allyesconfig
x86_64                        randconfig-a015
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
ia64                             allmodconfig
x86_64               randconfig-k001-20221031
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
sparc                             allnoconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                       common_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm                        keystone_defconfig
powerpc                     stx_gp3_defconfig
arm                         cm_x300_defconfig
mips                           xway_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
i386                 randconfig-c001-20221031
powerpc                      arches_defconfig
powerpc                    klondike_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
i386                 randconfig-a003-20221031
i386                 randconfig-a002-20221031
i386                 randconfig-a004-20221031
i386                 randconfig-a001-20221031
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a006-20221031
i386                 randconfig-a005-20221031
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
arm                        vexpress_defconfig
powerpc                       ebony_defconfig
powerpc                      obs600_defconfig
hexagon              randconfig-r041-20221102
hexagon              randconfig-r045-20221102
riscv                randconfig-r042-20221101
hexagon              randconfig-r041-20221101
hexagon              randconfig-r045-20221101
s390                 randconfig-r044-20221101

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
