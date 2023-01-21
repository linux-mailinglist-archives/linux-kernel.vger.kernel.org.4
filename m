Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6886769BE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 23:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjAUWDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 17:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjAUWDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 17:03:50 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBED1B57C
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 14:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674338629; x=1705874629;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=s+ttVpt+jen/aFUp9SFUWf4YpdI5DYPBc+7F2etL9yE=;
  b=mHeX5keX3vISVrfD8qFOFg6tIWknrP/xhXp7n6IyCSbqQY3VmUZVfelv
   W4TtxMDpAK4rjjF6XvfPExFr11CiDhnfKKghkMsk8yttBP6csKxn6BWBo
   jhmWX+Qnsu0KBkOYiFmYGovwUF/zbp6d+fuix8vD0LLDzHH3QfAlaWhT7
   rIbh0Ie9B5Q+ARK1r2w1t8eQvjCfGAmIsV88RiWNS4G9X0+8iQ3NRkYy6
   RJTMVInZtnz6lIXqW2DPomNBOswNybcrZJaI78l7VCWXa3XiI4cvuDfoM
   k8Yj4G0LMSn/avca8L+CqojE1AHzslsZsMtOx4V21iqmuXivraZ545VpM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="313728585"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="313728585"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 14:03:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="906353715"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="906353715"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jan 2023 14:03:47 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJLxi-0004Vn-1C;
        Sat, 21 Jan 2023 22:03:46 +0000
Date:   Sun, 22 Jan 2023 06:02:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/core] BUILD SUCCESS
 03d7a1053cf72372be22b43faada5bca12ff183d
Message-ID: <63cc610d.MpmkhGXNvraiv/pJ%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
branch HEAD: 03d7a1053cf72372be22b43faada5bca12ff183d  objtool: Check that module init/exit function is an indirect call target

elapsed time: 724m

configs tested: 83
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
alpha                               defconfig
i386                                defconfig
x86_64                              defconfig
um                             i386_defconfig
s390                                defconfig
i386                          randconfig-a005
x86_64                          rhel-8.3-func
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arm64                            allyesconfig
arm                  randconfig-r046-20230119
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20230119
powerpc                           allnoconfig
s390                             allyesconfig
sh                               allmodconfig
mips                             allyesconfig
arm                              allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
m68k                             allmodconfig
x86_64                           rhel-8.3-bpf
arc                              allyesconfig
x86_64                        randconfig-a004
alpha                            allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a013
ia64                             allmodconfig
m68k                             allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a006
x86_64                        randconfig-a015
powerpc                          allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
sparc                       sparc32_defconfig
arm                           stm32_defconfig
arm64                            alldefconfig
arm                          exynos_defconfig
sh                        sh7757lcr_defconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                         ap325rxa_defconfig
alpha                            alldefconfig
sh                        sh7763rdp_defconfig
ia64                         bigsur_defconfig
xtensa                  cadence_csp_defconfig
powerpc                      arches_defconfig
sh                        dreamcast_defconfig
mips                             allmodconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                          rhel-8.3-rust
i386                          randconfig-a006
hexagon              randconfig-r045-20230119
hexagon              randconfig-r041-20230119
s390                 randconfig-r044-20230119
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a003
riscv                randconfig-r042-20230119
x86_64                        randconfig-a005
i386                          randconfig-a013
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
