Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265A766A7D5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 01:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjANA70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 19:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjANA7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:59:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E7B7A397
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 16:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673657962; x=1705193962;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eehD+Oq2sCZCUcSiHpgC4Zf1RklOmGarh8EqBH0N1mo=;
  b=ajw3g9e5hsGuj/7hVE9mySFXQ/VgyHA1tKx/jVhI4UIohYpV7JVcJ7L1
   CYOA3snJ0HYOsELTOEClup+zgjOLP3MD+JwYuLYcNuIGWaDshFKEB6eq+
   X4+ilNnREcZ+SFOunaxDCOEXUrWm8UVLP7Y8Rs+2Q2HNnY5lh0eMf57xM
   B3qbIzgu7kj4gcIrMWT+wMxp05aKQuGAHnm1IceNhQKeuPlHDqevBB8PS
   k+U+pp/SKfyUrJ30o8AcsWnilytwkHokGomdF2vWfpvRCPV/3V/o/l2t5
   O0L6iJqrfaaai3oZpHEZDM3yeCRqWibijWAJH+Qp3GLUH8lZqaGU1XSTu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="351376741"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="351376741"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 16:59:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="782332235"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="782332235"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Jan 2023 16:59:20 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGUtE-000BaA-07;
        Sat, 14 Jan 2023 00:59:20 +0000
Date:   Sat, 14 Jan 2023 08:58:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 0e26e1de0032779e43929174339429c16307a299
Message-ID: <63c1fe40.84FZcSmZYmLJ5zkZ%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 0e26e1de0032779e43929174339429c16307a299  context_tracking: Fix noinstr vs KASAN

elapsed time: 724m

configs tested: 71
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                                 defconfig
um                             i386_defconfig
alpha                               defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a006
s390                                defconfig
powerpc                           allnoconfig
s390                             allmodconfig
riscv                randconfig-r042-20230112
arm                  randconfig-r046-20230113
arc                  randconfig-r043-20230112
i386                          randconfig-a001
arc                  randconfig-r043-20230113
i386                          randconfig-a003
s390                 randconfig-r044-20230112
s390                             allyesconfig
i386                          randconfig-a005
i386                                defconfig
ia64                             allmodconfig
arm                                 defconfig
x86_64                        randconfig-a013
i386                             allyesconfig
x86_64                        randconfig-a011
sh                               allmodconfig
x86_64                        randconfig-a015
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
arc                              allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
alpha                            allyesconfig
x86_64                           rhel-8.3-bpf
i386                          randconfig-a014
arm64                            allyesconfig
mips                             allyesconfig
i386                          randconfig-a012
powerpc                          allmodconfig
i386                          randconfig-a016
arm                              allyesconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                          randconfig-c001
arm                            hisi_defconfig
arm                          pxa3xx_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20230113
arm                  randconfig-r046-20230112
hexagon              randconfig-r041-20230112
i386                          randconfig-a002
hexagon              randconfig-r045-20230113
hexagon              randconfig-r045-20230112
i386                          randconfig-a004
riscv                randconfig-r042-20230113
s390                 randconfig-r044-20230113
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
