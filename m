Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2C265717D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 01:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiL1AuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 19:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiL1Atp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 19:49:45 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0836EE003
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 16:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672188584; x=1703724584;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XvQDeXuRsAjQbXnf2tfggKMpZ76Dk0ReMOjPyChUJes=;
  b=gIZqjUJJ/JGX1/HUTzg6e0nhcXBa23RNyEzoABbTcM6b1LGLujAXcMtk
   7XJjkH9R2oFcgxdchaXfqknGWK0bQDbXFf8+gPd6riOx9mRXIcmLv7/IR
   dLY9O/3AzqENRhIjrDLxDGhAED2gCEN0GAibTmviay8NvLVUhjO331m+e
   LiaJh/DpFqRSPMIERV3jCv5hHKEUwhVq85UUOsZEdnPy+XHK1Gts4387R
   IMWdbLjU3iKHPKpUMq8s4DTag67nz+5Ozml0uWIEyHeLkB7ZlJkdB4lxS
   LaFWu9a1pARyHfwulcjo85I2GmInqp2aRj2rIQkpOux32RPwRau05ApNN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="407046285"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="407046285"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 16:49:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="741876714"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="741876714"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Dec 2022 16:49:42 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pAKdZ-000FID-3B;
        Wed, 28 Dec 2022 00:49:41 +0000
Date:   Wed, 28 Dec 2022 08:49:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 94cd8fa09f5f1ebdd4e90964b08b7f2cc4b36c43
Message-ID: <63ab927e.JaRmZHkf7MV6KtVB%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: 94cd8fa09f5f1ebdd4e90964b08b7f2cc4b36c43  futex: Fix futex_waitv() hrtimer debug object leak on kcalloc error

elapsed time: 730m

configs tested: 83
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
s390                             allmodconfig
ia64                             allmodconfig
s390                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
x86_64                           rhel-8.3-bpf
i386                 randconfig-a012-20221226
x86_64                           rhel-8.3-syz
i386                 randconfig-a011-20221226
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
i386                 randconfig-a013-20221226
x86_64                           rhel-8.3-kvm
i386                 randconfig-a014-20221226
arm64                            allyesconfig
x86_64                               rhel-8.3
i386                 randconfig-a016-20221226
i386                                defconfig
arm                              allyesconfig
i386                 randconfig-a015-20221226
x86_64                           allyesconfig
x86_64               randconfig-a014-20221226
i386                             allyesconfig
x86_64               randconfig-a013-20221226
x86_64               randconfig-a011-20221226
x86_64               randconfig-a012-20221226
x86_64               randconfig-a015-20221226
x86_64               randconfig-a016-20221226
arc                  randconfig-r043-20221227
arm                  randconfig-r046-20221227
arc                  randconfig-r043-20221226
riscv                randconfig-r042-20221226
s390                 randconfig-r044-20221226
arm                  randconfig-r046-20221225
arc                  randconfig-r043-20221225
x86_64                            allnoconfig
sh                               allmodconfig
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
x86_64               randconfig-a002-20221226
x86_64               randconfig-a003-20221226
x86_64               randconfig-a006-20221226
x86_64               randconfig-a001-20221226
x86_64               randconfig-a004-20221226
i386                 randconfig-a004-20221226
x86_64               randconfig-a005-20221226
i386                 randconfig-a001-20221226
i386                 randconfig-a003-20221226
i386                 randconfig-a002-20221226
i386                 randconfig-a006-20221226
i386                 randconfig-a005-20221226
hexagon              randconfig-r041-20221227
hexagon              randconfig-r041-20221226
arm                  randconfig-r046-20221226
hexagon              randconfig-r045-20221226
hexagon              randconfig-r045-20221227
riscv                randconfig-r042-20221227
s390                 randconfig-r044-20221227
hexagon              randconfig-r045-20221225
hexagon              randconfig-r041-20221225
s390                 randconfig-r044-20221225
riscv                randconfig-r042-20221225
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
