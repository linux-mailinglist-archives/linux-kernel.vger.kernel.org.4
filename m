Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B0F66702E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjALKth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjALKsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:48:32 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D40C568BC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673520067; x=1705056067;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=n4mMvDBCUUkPNh9oZ0WvOrPiW6bxkVYRMSeaBL2O/dQ=;
  b=K+gk+3m1+wLuuCEuNLwXzeckiKOu2PoDPibbPuOIZ3lSGGLdIVJKM/Uz
   ejC7zCCev2dIg1lQ1K6pyIDns290b3CpxwrjH9fCMfVSCbhkuyUZqPFLY
   m+xUKo6Lwzvw/JDoXOEkD4aDiqp77Gb7kHQQzTFo6Su7DLA5f2QasWbpw
   LnqdMRl2Wfdf8vinME4OVEdKdG2Cb+gbPp1d6lpuqDCgtDgN9e7vYiQjA
   l0R8CxbGNLeknJeaCMYbScs3md8/gomgW+pONA3AatZhYzl2ALmaQsf+D
   FLYSFDg41vl8rfK9oqL3TR/13uy+2K+cNoLS+AxC/3v73Uo4SW2iGsoeM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324904430"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="324904430"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:40:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="903136440"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="903136440"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jan 2023 02:40:50 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFv0r-000A3G-1I;
        Thu, 12 Jan 2023 10:40:49 +0000
Date:   Thu, 12 Jan 2023 18:40:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 0e2213fe0ab4c04da0e2354e84ec3b90e59939a4
Message-ID: <63bfe389.rzPOoZLELoElvqYn%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 0e2213fe0ab4c04da0e2354e84ec3b90e59939a4  irqchip: Use irq_domain_alloc_irqs()

elapsed time: 793m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                            allnoconfig
i386                                defconfig
arc                  randconfig-r043-20230110
i386                          randconfig-a001
riscv                randconfig-r042-20230110
i386                          randconfig-a003
s390                 randconfig-r044-20230110
i386                          randconfig-a005
ia64                             allmodconfig
x86_64                              defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
x86_64                        randconfig-a015
i386                          randconfig-a012
x86_64                               rhel-8.3
i386                          randconfig-a016
arm                                 defconfig
x86_64                          rhel-8.3-func
arm64                            allyesconfig
x86_64                    rhel-8.3-kselftests
arm                              allyesconfig
i386                             allyesconfig
x86_64                           allyesconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allmodconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20230110
arm                  randconfig-r046-20230110
hexagon              randconfig-r045-20230110
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
