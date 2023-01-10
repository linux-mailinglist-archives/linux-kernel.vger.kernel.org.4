Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB5A66396F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbjAJGjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbjAJGjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:39:22 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F3049179
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 22:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673332742; x=1704868742;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Mgc/n+nT7sjIG3y7slEXDV7YxWPnkpN7RVad1TgVSWo=;
  b=UbUYo8iDzSYCRwS97kL31vTMO0vkOz3iCIG4U1EGuc2ADmLmsBL4LC6p
   N7r2f89nLI8bfOzvz6KYhz9jkSQLX8Cd649LY9ngcKRBAUdRwpUE2uig0
   f0jowJbEBcBa2PVMLEwkoeVR5/xkiJwQYxBCscIIW12Dwt+IXrucXqz3N
   BxYYDEN+MFtqPsqYSS/3ndv54h3Zl8X5NJjky4tJ5C9VbtgIOlq/XYwD3
   AgGaVhhnWq0PaAQhN35dc/ysILdtw69NCT8CASiRFm9Ocjp8aZJae3KZV
   yMnwPq2lK7lPcICEBqV7LdFJJdYOU6zHMFRV51NGZ92/MrhrBdPrh684x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="310875112"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="310875112"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 22:39:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="745657848"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="745657848"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jan 2023 22:39:00 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pF8Hj-0007gq-1R;
        Tue, 10 Jan 2023 06:38:59 +0000
Date:   Tue, 10 Jan 2023 14:38:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 0ecc518e5c1a83fbfc6262d20d0df289eafc2207
Message-ID: <63bd07e5.Vrdiywswol3MxAev%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 0ecc518e5c1a83fbfc6262d20d0df289eafc2207  perf/core: Save calculated sample data size

elapsed time: 810m

configs tested: 92
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
x86_64                            allnoconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                                 defconfig
arm64                            allyesconfig
x86_64                              defconfig
arm                              allyesconfig
x86_64                          rhel-8.3-func
x86_64               randconfig-a013-20230109
ia64                             allmodconfig
i386                 randconfig-a011-20230109
x86_64               randconfig-a012-20230109
i386                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
x86_64               randconfig-a014-20230109
i386                 randconfig-a016-20230109
alpha                            allyesconfig
x86_64               randconfig-a011-20230109
i386                 randconfig-a015-20230109
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a013-20230109
x86_64               randconfig-a016-20230109
x86_64                        randconfig-a004
i386                 randconfig-a012-20230109
x86_64                        randconfig-a002
x86_64                           rhel-8.3-bpf
x86_64               randconfig-a015-20230109
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
i386                 randconfig-a014-20230109
x86_64                        randconfig-a006
sh                               allmodconfig
riscv                randconfig-r042-20230109
s390                 randconfig-r044-20230109
arm                  randconfig-r046-20230108
arc                  randconfig-r043-20230108
arc                  randconfig-r043-20230109
m68k                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                        trizeps4_defconfig
arm                         s3c6400_defconfig
sh                               alldefconfig
ia64                                defconfig
m68k                           sun3_defconfig
parisc                generic-32bit_defconfig
sh                     sh7710voipgw_defconfig
mips                            gpr_defconfig

clang tested configs:
i386                 randconfig-a004-20230109
i386                 randconfig-a002-20230109
i386                 randconfig-a003-20230109
i386                 randconfig-a001-20230109
i386                 randconfig-a005-20230109
i386                 randconfig-a006-20230109
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r045-20230109
arm                  randconfig-r046-20230109
riscv                randconfig-r042-20230108
hexagon              randconfig-r041-20230108
hexagon              randconfig-r041-20230109
x86_64                        randconfig-a005
hexagon              randconfig-r045-20230108
s390                 randconfig-r044-20230108
x86_64                        randconfig-k001
x86_64               randconfig-a001-20230109
x86_64               randconfig-a002-20230109
x86_64               randconfig-a004-20230109
x86_64               randconfig-a003-20230109
x86_64               randconfig-a006-20230109
x86_64               randconfig-a005-20230109
arm                          pcm027_defconfig
powerpc                       ebony_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
