Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B841B6769BF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 23:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjAUWD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 17:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjAUWDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 17:03:50 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1394218B3B
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 14:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674338630; x=1705874630;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2TOL5UsVanpggqc6YR9raY2F/j0UbcvpBoClR1onr5A=;
  b=DXRZJv1LjfW7V/XNLsr8pCx5gtoxu3ayhvqKX6LhZDGafu9inM+eYmV9
   8WYiTtF4Y+x9hkBNBf2t/adXqCD92GLWOIMaRmEQ2E6XkGLgRemzYgIss
   b5DvZopq0KdBCNHR3UcYK7VPUc9WultXYV1ICndIa33T++//dygwOOQWD
   9bm+qtynohqg8evFNlb4yV0Bo9zeOiuKsZAlOq5itCfenaPmWco0Grcra
   QzSpNEMvnn1cjLZ6r2sUSXPXUBSOWj8IYzokBaY+mfiJcfVFNPAp6MkM+
   FE3Ue6r7i5dskuDfRv0l06KLKHmV/ZmbuQQvdOPWXmesHo2vqAlfHF3dL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="313728587"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="313728587"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 14:03:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="906353716"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="906353716"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jan 2023 14:03:47 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJLxi-0004Vk-18;
        Sat, 21 Jan 2023 22:03:46 +0000
Date:   Sun, 22 Jan 2023 06:02:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 5d515ee40cb57ea5331998f27df7946a69f14dc3
Message-ID: <63cc6108.ZSKSliAHeKMXngh3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 5d515ee40cb57ea5331998f27df7946a69f14dc3  perf/x86/uncore: Don't WARN_ON_ONCE() for a broken discovery table

elapsed time: 723m

configs tested: 63
configs skipped: 75

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                        randconfig-a002
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a016
i386                          randconfig-a005
x86_64                        randconfig-a015
i386                             allyesconfig
sparc                       sparc32_defconfig
arm                           stm32_defconfig
arm64                            alldefconfig
arm                          exynos_defconfig
sh                        sh7757lcr_defconfig
ia64                             allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sh                         ap325rxa_defconfig
alpha                            alldefconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                        sh7763rdp_defconfig
ia64                         bigsur_defconfig
xtensa                  cadence_csp_defconfig
powerpc                      arches_defconfig
sh                        dreamcast_defconfig
mips                             allmodconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a003
i386                          randconfig-a013
x86_64                        randconfig-a005
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a012
i386                          randconfig-a015
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a006
x86_64                        randconfig-k001
arm                        mvebu_v5_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
