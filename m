Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6AF666721
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 00:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbjAKX0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 18:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbjAKX0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 18:26:07 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9015619033
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 15:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673479564; x=1705015564;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=iEefiBHpBl0RDM4gMl1sLCj6rNSDzjWX/nLdj1DCBAQ=;
  b=Lr2W1o40vKJdDtceiw47TiqgSqtfl1V/TQSXdHBEGR2WYR7QD8Y0OGpi
   fI2ABBZizwwEmpdHGQr3u0oBPbGRQjLlMF+Dnb6jEMnIUVgIlswoBr84E
   eCEwVMF0B20zyKI9JIqFwSaO1QdDGBG7TZo1zh103huPJqRp9jhe1GeRx
   fdxEkrkTCquStH7yN3nLtMCwW1EJKdgUvn5UU6Q/kqcXpi80TYpetvHTh
   k1K7NkctJ5fuNwD3LFd5Yt6pit+UEu8mEVkl0AT6nvaQwwfoWlxgcKUsm
   MKccVDFW0h+ZpePezswlJd6qV5/cVGlMYjSfXAO7xsqgrtymzz8jKV3md
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="307085759"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="307085759"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 15:26:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="689928929"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="689928929"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Jan 2023 15:25:33 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFkTH-0009cM-1M;
        Wed, 11 Jan 2023 23:25:27 +0000
Date:   Thu, 12 Jan 2023 07:24:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 cd9f5c3d3096e26fa128ae747f66383002001398
Message-ID: <63bf454a.rUhEDlgkeizLetWO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: cd9f5c3d3096e26fa128ae747f66383002001398  sched/cputime: Fix IA64 build error of missing arch_vtime_task_switch() prototype

elapsed time: 822m

configs tested: 73
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a004
x86_64                        randconfig-a011
x86_64                        randconfig-a002
i386                                defconfig
x86_64                        randconfig-a015
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a006
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
x86_64                          rhel-8.3-func
alpha                               defconfig
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
mips                             allyesconfig
s390                                defconfig
arm                                 defconfig
x86_64                               rhel-8.3
powerpc                          allmodconfig
i386                          randconfig-a001
i386                             allyesconfig
m68k                             allyesconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20230110
arc                              allyesconfig
alpha                            allyesconfig
s390                             allyesconfig
i386                          randconfig-a003
s390                 randconfig-r044-20230110
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a005
riscv                randconfig-r042-20230110
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
ia64                             allmodconfig
arm                          gemini_defconfig
powerpc                     tqm8548_defconfig
microblaze                      mmu_defconfig
arm                           tegra_defconfig
loongarch                 loongson3_defconfig
parisc                           allyesconfig
powerpc                      pasemi_defconfig
mips                       bmips_be_defconfig
arc                        vdk_hs38_defconfig
sh                   sh7770_generic_defconfig
loongarch                           defconfig
m68k                             allmodconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a014
x86_64                        randconfig-a003
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230110
arm                  randconfig-r046-20230110
i386                          randconfig-a002
hexagon              randconfig-r045-20230110
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
