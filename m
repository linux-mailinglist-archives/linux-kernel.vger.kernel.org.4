Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC61668B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjAMFML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjAMFME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:12:04 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A292160871
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 21:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673586722; x=1705122722;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BpDFs2rbSfnN09+1oZoHCZFkyZHWKrlnWA7JREweLKI=;
  b=mZHKeKmhOY6d+ZVYZyrqNNDcS8DkVC171gbCTNyx73wMYztX/boTLO7V
   4XPL0pIcqbKj7YG+heFU7gF/h+N3BAGCVvYWl0KUvUMcZ107yIEeX/2XV
   8eQrYpC3urSto3a5lBPuUdQMl2dTr55Nh3EboJbQ6O4P6D6N+cp6LtTHQ
   eDvnD98QLOuzv6WRj3pbEH4mn4CFWwS2TgPwMCXHuVmCEuZkNX1sxbNw1
   PE1h++inwjjpYEVMdxPxMfdbRO7ttCWtOlLRP/WhXyV98p/dOlP2XeGBL
   vQjGSHh4KalTyTdnvVqJUjFEfWznSH1PvY0MtLyuNTBgG3IcWHZFJEYjc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="322616567"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="322616567"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 21:12:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="746812107"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="746812107"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jan 2023 21:12:01 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGCMC-000AjA-1L;
        Fri, 13 Jan 2023 05:12:00 +0000
Date:   Fri, 13 Jan 2023 13:11:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 28c8e088427ad30b4260953f3b6f908972b77c2d
Message-ID: <63c0e7f3.oTp5oI2n5vr9bFQS%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 28c8e088427ad30b4260953f3b6f908972b77c2d  rseq: Increase AT_VECTOR_SIZE_BASE to match rseq auxvec entries

elapsed time: 736m

configs tested: 59
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
x86_64                            allnoconfig
sh                               allmodconfig
x86_64                              defconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
i386                          randconfig-a001
x86_64                        randconfig-a004
i386                          randconfig-a003
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                           allyesconfig
i386                          randconfig-a005
i386                                defconfig
s390                 randconfig-r044-20230112
arc                  randconfig-r043-20230112
x86_64                           rhel-8.3-syz
riscv                randconfig-r042-20230112
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
arm                                 defconfig
m68k                             allyesconfig
m68k                             allmodconfig
i386                             allyesconfig
arc                              allyesconfig
x86_64                        randconfig-a013
alpha                            allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func

clang tested configs:
i386                          randconfig-a002
x86_64                        randconfig-a001
i386                          randconfig-a004
x86_64                        randconfig-a003
arm                  randconfig-r046-20230112
x86_64                        randconfig-a005
hexagon              randconfig-r041-20230112
hexagon              randconfig-r045-20230112
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
