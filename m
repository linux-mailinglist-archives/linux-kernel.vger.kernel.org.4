Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9ED6268D9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 11:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiKLKXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 05:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbiKLKXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 05:23:01 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D524D5F0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 02:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668248562; x=1699784562;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cB5N6u8rQhJUAfp3xjpynYyZ2ezjDoJfWbX223I+TgE=;
  b=iZOc45i0NXXUkp4LPiMnGuxMkJfafKPO9HNMHzOh/JJc/ptlBhURb+VE
   XhT/iFky1e5YdRGLqN7aXaKcXIrUHLz6s7c+ap4WTTtcbO7J1N5eAVwvu
   ob3DtXMpMHwhL8Gi6sW9q7lpHP9YjhFI9KOXce7dJU51l+JHqODckMl+c
   +7G2As+FTEOCPxz/Jq69W8xrtvTDDHmgkbJlLDZ+8xtG58QPW0t9A3Pa+
   XOlK05RN7kOwMSvExJZVp/Bq7DlRAHokNBy7JLjwoY8e969JQ2cYFkjcm
   B9p21qwgknFDsC25Ax1ftbnHCmlGhHNSs4wzuqepKVK3Q1VPx/2+CFyup
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="292119538"
X-IronPort-AV: E=Sophos;i="5.96,159,1665471600"; 
   d="scan'208";a="292119538"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 02:22:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="780398704"
X-IronPort-AV: E=Sophos;i="5.96,159,1665471600"; 
   d="scan'208";a="780398704"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 12 Nov 2022 02:22:41 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otneq-0004mm-1I;
        Sat, 12 Nov 2022 10:22:40 +0000
Date:   Sat, 12 Nov 2022 18:21:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 bf1269766228ef169145af26ae50ef9ef095b6fe
Message-ID: <636f73c0.1cI7NTIvLfZS6CyI%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: bf1269766228ef169145af26ae50ef9ef095b6fe  selftests/x86/lam: Add ARCH_FORCE_TAGGED_SVA test cases for linear-address masking

elapsed time: 724m

configs tested: 82
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a013
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a006
x86_64                        randconfig-a015
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20221112
s390                             allyesconfig
i386                                defconfig
mips                             allyesconfig
powerpc                           allnoconfig
arm                                 defconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
m68k                             allmodconfig
arc                              allyesconfig
i386                          randconfig-a001
alpha                            allyesconfig
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                              defconfig
m68k                             allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                           allyesconfig
ia64                             allmodconfig
x86_64                            allnoconfig
i386                          randconfig-c001
powerpc                      ppc40x_defconfig
arm                        mvebu_v7_defconfig
powerpc                     tqm8541_defconfig
sh                            hp6xx_defconfig
arc                          axs103_defconfig
powerpc                     asp8347_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a003
hexagon              randconfig-r045-20221112
hexagon              randconfig-r041-20221112
riscv                randconfig-r042-20221112
s390                 randconfig-r044-20221112
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r041-20221111
hexagon              randconfig-r045-20221111
x86_64                        randconfig-k001
arm                           omap1_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc8272_ads_defconfig
mips                           ip27_defconfig
riscv                            alldefconfig
powerpc                      ppc44x_defconfig
mips                           rs90_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
