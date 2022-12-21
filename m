Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B5C652B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 03:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiLUCcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 21:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiLUCcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 21:32:09 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B839965EA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 18:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671589928; x=1703125928;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=k/DeT1Op7z3pQZizDwHne2TyikC8qOIXBJA4poIFzWc=;
  b=dXbj4GOToMSQDZKa+DLKtu1bZvStnb8eRp9v0mVaLOYyn03FLjRaTxO0
   odNdDSrtNRqqYR1P8UvFDonmV6KAvvZoIOGkpI7mmOEeCraZGRax9ph2e
   dpRtH1K7orbC1bzid8tJjvM3H9UvgDxITM2P/YjJRyhwlNlomsAyEdj8t
   3fNW3TRcXJtXU63qkwuaqTW2ML7ffxWf+hrubWtOQSSTRb5egO28QWfkn
   rg76cgZoVqWHWmi+XWsMDYutYHd7cVjN66vnkZOAON6ABdzcDwoFmgfuj
   EEjmmOtoBSTn8a6L9SyLN03qgRlypjX33UAQ4fh9AFj6Jk++os0JMOldk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="381994571"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="381994571"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 18:32:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="825480174"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="825480174"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Dec 2022 18:32:07 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p7otq-0009lj-1f;
        Wed, 21 Dec 2022 02:32:06 +0000
Date:   Wed, 21 Dec 2022 10:31:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 399454ca846957977053df897dcc3c85b2dba141
Message-ID: <63a27008.+JR96MG5Ba0oPw5r%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 399454ca846957977053df897dcc3c85b2dba141  Merge branch into tip/master: 'locking/urgent'

elapsed time: 812m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
m68k                             allyesconfig
s390                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                              defconfig
alpha                            allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
mips                             allyesconfig
ia64                             allmodconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
riscv                randconfig-r042-20221218
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20221219
x86_64                           rhel-8.3-kvm
arm                  randconfig-r046-20221219
x86_64                           rhel-8.3-bpf
arc                  randconfig-r043-20221218
x86_64                         rhel-8.3-kunit
s390                 randconfig-r044-20221218
x86_64               randconfig-a002-20221219
x86_64               randconfig-a003-20221219
x86_64               randconfig-a001-20221219
x86_64               randconfig-a004-20221219
x86_64               randconfig-a005-20221219
x86_64               randconfig-a006-20221219
i386                 randconfig-a004-20221219
i386                 randconfig-a001-20221219
i386                 randconfig-a003-20221219
i386                 randconfig-a002-20221219
i386                 randconfig-a006-20221219
arm                              allyesconfig
i386                 randconfig-a005-20221219
arm64                            allyesconfig
i386                                defconfig
i386                             allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
arm                  randconfig-r046-20221218
hexagon              randconfig-r041-20221218
hexagon              randconfig-r045-20221219
hexagon              randconfig-r041-20221219
hexagon              randconfig-r045-20221218
riscv                randconfig-r042-20221219
s390                 randconfig-r044-20221219
i386                 randconfig-a014-20221219
i386                 randconfig-a012-20221219
i386                 randconfig-a013-20221219
i386                 randconfig-a015-20221219
i386                 randconfig-a011-20221219
i386                 randconfig-a016-20221219
x86_64               randconfig-a012-20221219
x86_64               randconfig-a014-20221219
x86_64               randconfig-a015-20221219
x86_64               randconfig-a011-20221219
x86_64               randconfig-a013-20221219
x86_64               randconfig-a016-20221219

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
