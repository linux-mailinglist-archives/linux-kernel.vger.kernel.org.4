Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA24F685D8D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 03:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjBACwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 21:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjBACwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 21:52:42 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A699238B5A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 18:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675219961; x=1706755961;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=K9dWblYCafS8mpgET+MjzQvK6vI2nfHgMhhofIxSLm8=;
  b=GySovDWwcGNxT/uuevg3Til89FFxBk/LssZqecmK5hm1zVUyy3X7AmMc
   TvX6mXkWWm/Dy5p5WdZonhBNbKAP+cmunMwh4+Ju/uhH+Nd1BbpM82m33
   p+hhi91086GOaQrNnUPl2lkRsf/YfkxL0H/q0QzeYWp6b/S9j7rRMzMSS
   sJz2bpVAYw2lnN2hxIpZzSDph6NwJfc/LbrfYexERT77UlPh2K89kMXsX
   OgYIsEIj+qi/APdnzLNB8xCE7X8UfX3N2mM8ZhmnUaYSLSVzvVQVmp9AT
   eNck4Bvy5ZC/bYMvC/8+0wlfgAp/M4r3A8hbNSy7o+HDGJCw8AOJ/DKml
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="315993301"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="315993301"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 18:52:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="666749237"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="666749237"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 31 Jan 2023 18:52:38 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pN3Ek-0004xE-0q;
        Wed, 01 Feb 2023 02:52:38 +0000
Date:   Wed, 01 Feb 2023 10:51:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/alternatives] BUILD REGRESSION
 923510c88d2b7d947c4217835fd9ca6bd65cc56c
Message-ID: <63d9d3be.2FnzZHUx2CcJew/o%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/alternatives
branch HEAD: 923510c88d2b7d947c4217835fd9ca6bd65cc56c  x86/static_call: Add support for Jcc tail-calls

Error/Warning: (recently discovered and may have been fixed)

error: aborting due to previous error
error[E0588]: packed type cannot transitively contain a `#[repr(align)]` type

Error/Warning ids grouped by kconfigs:

clang_recent_errors
|-- x86_64-randconfig-a012-20230130
|   |-- error-E0588:packed-type-cannot-transitively-contain-a-repr(align)-type
|   `-- error:aborting-due-to-previous-error
`-- x86_64-rhel-8.3-rust
    |-- error-E0588:packed-type-cannot-transitively-contain-a-repr(align)-type
    `-- error:aborting-due-to-previous-error

elapsed time: 724m

configs tested: 68
configs skipped: 2

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
x86_64               randconfig-a001-20230130
m68k                             allmodconfig
x86_64               randconfig-a003-20230130
arc                              allyesconfig
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
alpha                            allyesconfig
x86_64               randconfig-a006-20230130
m68k                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                              defconfig
x86_64               randconfig-a005-20230130
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
mips                             allyesconfig
alpha                               defconfig
arc                  randconfig-r043-20230129
powerpc                          allmodconfig
i386                                defconfig
arm                  randconfig-r046-20230129
i386                 randconfig-a002-20230130
i386                 randconfig-a006-20230130
i386                             allyesconfig
i386                 randconfig-a001-20230130
s390                             allmodconfig
arm                  randconfig-r046-20230130
i386                 randconfig-a005-20230130
x86_64                           rhel-8.3-syz
i386                 randconfig-a004-20230130
arc                  randconfig-r043-20230130
i386                 randconfig-a003-20230130
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
s390                                defconfig
x86_64                           rhel-8.3-bpf
ia64                             allmodconfig
s390                             allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230129
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
s390                 randconfig-r044-20230129
s390                 randconfig-r044-20230130
riscv                randconfig-r042-20230129
x86_64               randconfig-a012-20230130
x86_64               randconfig-a013-20230130
riscv                randconfig-r042-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a014-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a016-20230130

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
