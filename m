Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CC465717B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 01:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiL1Atu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 19:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiL1Atp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 19:49:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF96E001
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 16:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672188584; x=1703724584;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+sQUZeOMeWIbNhlha4Vs4lgVmyHx45CRXv9cOMUkdJY=;
  b=HvB97v2DZaS/3IqZUFKJAHxuDkrvvAjgBw1Dhx9fz4pI+9l0kY0VvSWV
   oyOlgY+HjzfsLOdMeIO+nGWVZ1POJ1SQUiIAiPI/p+iHaDPHCHkksmDGY
   /UMmb1Ixd1knAxMJXNdsrIWN+BrDJUuhuvFbNkQbXopeRvksFDfY4767y
   roK+zeUk4WdOf82qJ2vhysID9rtQ1szkJqxCulsi7zfeiseWYiTYoNF59
   KWYIccd+PgbAdyP+zzL5+aj8PJ7HXz+4RQiaMp5UOAWAfXJscpmwuHh6p
   lDR4zgEKm6GvFnQGlcstTZEEtDMKDa/mc738JXDni/B+7q9lNDbAIJzNU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="385205414"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="385205414"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 16:49:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="646577755"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="646577755"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Dec 2022 16:49:42 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pAKdZ-000FI7-2z;
        Wed, 28 Dec 2022 00:49:41 +0000
Date:   Wed, 28 Dec 2022 08:49:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 03c4c7f88709fac0e20b6a48357c73d6fc50e544
Message-ID: <63ab9284.TEGxC1SDi70XplqS%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 03c4c7f88709fac0e20b6a48357c73d6fc50e544  perf/x86/lbr: Simplify the exposure check for the LBR_INFO registers

elapsed time: 729m

configs tested: 46
configs skipped: 81

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
i386                 randconfig-a016-20221226
i386                                defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                 randconfig-a013-20221226
i386                 randconfig-a014-20221226
i386                 randconfig-a012-20221226
i386                 randconfig-a011-20221226
x86_64               randconfig-a014-20221226
i386                 randconfig-a015-20221226
x86_64               randconfig-a013-20221226
x86_64               randconfig-a011-20221226
x86_64               randconfig-a012-20221226
x86_64               randconfig-a015-20221226
i386                             allyesconfig
x86_64               randconfig-a016-20221226
x86_64                            allnoconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20221225
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64                          rhel-8.3-rust
i386                 randconfig-a004-20221226
i386                 randconfig-a001-20221226
i386                 randconfig-a003-20221226
i386                 randconfig-a002-20221226
i386                 randconfig-a006-20221226
i386                 randconfig-a005-20221226
x86_64               randconfig-a002-20221226
x86_64               randconfig-a003-20221226
x86_64               randconfig-a001-20221226
x86_64               randconfig-a004-20221226
x86_64               randconfig-a006-20221226
x86_64               randconfig-a005-20221226
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
