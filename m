Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CF9643FDF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbiLFJbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbiLFJbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:31:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69201D0C6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670319059; x=1701855059;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yeV+4mLkKps1OdTOWtRx5035MPwqqZix4UkFQ2vcdKQ=;
  b=fKrfqcjtd1iwjISaNRE16Pc8E8tOKlY35tQYPlfc38xfD6hGD0uKfTzg
   xk/cbDdZVQO6KXCJAyyxC2Du+XWR1NubGvIzRijUXKcbQlqbeE4hUNjBE
   IzlpI/bOAHlmfjtfxnVXRKqNn3pOXGt9kbPYCgrgjxCmmmzZ2qZoGa4Vi
   b9fjClkRDpl/pnaDRKGLWpA/1xNexKAcxKwj+TjxCZN69QrH8q2FAPSp1
   PGkaF4upIa2WcHU9xBF9gYvloasDvpePiM5y/On8UUHHrM7pb9E/A4vn2
   WPgLW08I4chjjH/P5vuhO3sqm/Six+weaCAtoL8+AD2LNtY8hKfPBDTv7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="402854363"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="402854363"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 01:30:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="676911914"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="676911914"
Received: from lkp-server01.sh.intel.com (HELO b3c45e08cbc1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Dec 2022 01:30:57 -0800
Received: from kbuild by b3c45e08cbc1 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p2UHx-0000oN-0J;
        Tue, 06 Dec 2022 09:30:57 +0000
Date:   Tue, 06 Dec 2022 17:30:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 be1b670f61443aa5d0d01782e9b8ea0ee825d018
Message-ID: <638f0bb6.brFvxip0tzTDWrxr%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: be1b670f61443aa5d0d01782e9b8ea0ee825d018  x86/microcode/intel: Do not retry microcode reloading on the APs

elapsed time: 729m

configs tested: 67
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
um                             i386_defconfig
s390                             allyesconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
x86_64                           allyesconfig
ia64                             allmodconfig
i386                                defconfig
alpha                            allyesconfig
powerpc                          allmodconfig
arc                              allyesconfig
i386                 randconfig-a013-20221205
i386                 randconfig-a012-20221205
i386                 randconfig-a011-20221205
i386                 randconfig-a014-20221205
x86_64               randconfig-a011-20221205
x86_64               randconfig-a012-20221205
x86_64               randconfig-a014-20221205
i386                 randconfig-a016-20221205
i386                 randconfig-a015-20221205
x86_64               randconfig-a013-20221205
x86_64               randconfig-a015-20221205
x86_64               randconfig-a016-20221205
sh                               allmodconfig
i386                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                  randconfig-r043-20221205
arm                                 defconfig
s390                 randconfig-r044-20221205
riscv                randconfig-r042-20221205
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
x86_64               randconfig-a003-20221205
x86_64               randconfig-a004-20221205
x86_64               randconfig-a005-20221205
x86_64               randconfig-a001-20221205
x86_64               randconfig-a002-20221205
x86_64               randconfig-a006-20221205
hexagon              randconfig-r045-20221205
arm                  randconfig-r046-20221205
hexagon              randconfig-r041-20221205
hexagon              randconfig-r041-20221206
riscv                randconfig-r042-20221206
hexagon              randconfig-r045-20221206
s390                 randconfig-r044-20221206
i386                 randconfig-a001-20221205
i386                 randconfig-a002-20221205
i386                 randconfig-a005-20221205
i386                 randconfig-a004-20221205
i386                 randconfig-a006-20221205
i386                 randconfig-a003-20221205
hexagon              randconfig-r041-20221204
riscv                randconfig-r042-20221204
hexagon              randconfig-r045-20221204
s390                 randconfig-r044-20221204

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
