Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734C067A524
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbjAXVn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjAXVnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:43:24 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE3C47082
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674596604; x=1706132604;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OyMFGGntUnPYhGVxQeOHDXLc1V17I6tBaQNDlHnBZEQ=;
  b=bP9yX15wBpym9z7pS+6lS62/wc75ne0WOw6iFZqrajsc3OX/UAnGzJ9y
   2ePh1bl+nD6UlXR2lFGkfl8EH4BP3Ckt8z6Uwa0Oncb4w0TMtKETXtGtQ
   TVgdAKnbR6GU64BW7/crhPEqjwW8sFZaKbjlNcjD3EG5WNefaI9Z00kDQ
   oDJK2zxRzGKYJB5BK1KdjsgHIFx/dz7h+bE6t+XLWaSsVnRvwqK34kXar
   KdCi42WNXJuCyNmBFvNnChq3Z3UTw9Rwvvh+6ZVpHD62Z2XJpQ4OdUOa3
   H3tffOsy1bE4/Jf3iJ20PLhFWFru+vh2STqtqrAp8mI2DfWoeyIdKLUCH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="412646362"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="412646362"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 13:43:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="750964786"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="750964786"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jan 2023 13:43:22 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKR4c-0006ns-0U;
        Tue, 24 Jan 2023 21:43:22 +0000
Date:   Wed, 25 Jan 2023 05:43:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 8272720be0448ed9da201afb1ba4f65e31d8fc0a
Message-ID: <63d050e6.Ltx7CP1++ek5Hsdo%lkp@intel.com>
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
branch HEAD: 8272720be0448ed9da201afb1ba4f65e31d8fc0a  Merge x86/cache into tip/master

elapsed time: 726m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
powerpc                           allnoconfig
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                                 defconfig
sh                               allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20230123
arm                  randconfig-r046-20230123
alpha                            allyesconfig
m68k                             allyesconfig
arc                                 defconfig
mips                             allyesconfig
i386                 randconfig-a004-20230123
i386                 randconfig-a003-20230123
s390                             allmodconfig
m68k                             allmodconfig
alpha                               defconfig
arc                              allyesconfig
x86_64                           allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a002-20230123
x86_64               randconfig-a002-20230123
arm64                            allyesconfig
x86_64               randconfig-a001-20230123
i386                 randconfig-a001-20230123
s390                                defconfig
ia64                             allmodconfig
arm                              allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
i386                 randconfig-a005-20230123
x86_64               randconfig-a004-20230123
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64               randconfig-a003-20230123
x86_64                           rhel-8.3-kvm
i386                 randconfig-a006-20230123
x86_64                           rhel-8.3-bpf
x86_64               randconfig-a005-20230123
x86_64               randconfig-a006-20230123
s390                             allyesconfig
i386                             allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
i386                 randconfig-a012-20230123
riscv                randconfig-r042-20230123
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a015-20230123
i386                 randconfig-a011-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a015-20230123
i386                 randconfig-a014-20230123
x86_64               randconfig-a014-20230123
i386                 randconfig-a016-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
