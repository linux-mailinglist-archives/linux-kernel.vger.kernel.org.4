Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EEC5BD974
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiITBjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiITBjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:39:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331FC140E6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663637989; x=1695173989;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=weDHyRhpHZspD3mwgIOc1XTKMAsxwi/Mu7niNwqWd9o=;
  b=BYobpsybpJnpkNEycAzXW3/FG4hW8gx3P/m6Kb0DiISWe4Dvg2Okj18W
   Zh18u+V88/JZQe94tFFU/AuY7DLpksXf9JZ7meTQCpfjuhyGSfTRWCWdZ
   NY5SgDEyIH3awBY9r7nPfF4NyxbcucI7Zcrba2kh7YPrXqADTAHeFwmIU
   l3VXNxQ7O9K+mk3WL8MvAz60/kV3xPoWQYBVYKSiFtYRi+pYqn4QAWNx6
   FEVkvw3jYt6uL5uF8bwGGmUG9cCFmqvHs425k3KuC7Rt++ZnF5RRQbxUK
   s+K4mo3+mI4CyUQWMVqdJDo10sOfKyIw0pmONmkGEfRXfUMF5wrOxRI8G
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="361304595"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="361304595"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 18:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="707783088"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Sep 2022 18:39:45 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaSEj-0002N1-0F;
        Tue, 20 Sep 2022 01:39:45 +0000
Date:   Tue, 20 Sep 2022 09:39:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 94ec234a16cf3acdb319f05917b1efec9642222e
Message-ID: <632919dd.RW2JLQyQHrc9d/hJ%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 94ec234a16cf3acdb319f05917b1efec9642222e  bcma: gpio: Use generic_handle_irq_safe()

elapsed time: 724m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
i386                 randconfig-a013-20220919
riscv                randconfig-r042-20220919
x86_64                              defconfig
i386                                defconfig
m68k                             allmodconfig
i386                 randconfig-a012-20220919
arc                  randconfig-r043-20220919
arc                              allyesconfig
arm                                 defconfig
i386                 randconfig-a011-20220919
i386                 randconfig-a016-20220919
s390                 randconfig-r044-20220919
x86_64                               rhel-8.3
x86_64               randconfig-a012-20220919
powerpc                           allnoconfig
x86_64               randconfig-a016-20220919
i386                 randconfig-a015-20220919
x86_64               randconfig-a011-20220919
i386                 randconfig-a014-20220919
x86_64                          rhel-8.3-func
x86_64               randconfig-a014-20220919
mips                             allyesconfig
x86_64                           allyesconfig
alpha                            allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20220919
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a013-20220919
m68k                             allyesconfig
i386                             allyesconfig
x86_64                           rhel-8.3-kvm
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
arm64                            allyesconfig
x86_64                           rhel-8.3-syz
arm                              allyesconfig
ia64                             allmodconfig
powerpc                     pq2fads_defconfig
powerpc                 linkstation_defconfig
sparc64                          alldefconfig
sh                        sh7757lcr_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc              randconfig-c003-20220919
i386                 randconfig-c001-20220919
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64               randconfig-c001-20220919
arm                  randconfig-c002-20220919
sh                          sdk7786_defconfig
powerpc                   motionpro_defconfig
sh                             shx3_defconfig
sh                          kfr2r09_defconfig
arm                          exynos_defconfig
powerpc                       holly_defconfig
arm                          gemini_defconfig
m68k                        mvme16x_defconfig
sh                            migor_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
x86_64               randconfig-k001-20220919
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
hexagon              randconfig-r041-20220919
hexagon              randconfig-r045-20220919
x86_64               randconfig-a003-20220919
x86_64               randconfig-a001-20220919
x86_64               randconfig-a002-20220919
i386                 randconfig-a001-20220919
i386                 randconfig-a006-20220919
x86_64               randconfig-a004-20220919
x86_64               randconfig-a006-20220919
i386                 randconfig-a002-20220919
i386                 randconfig-a003-20220919
x86_64               randconfig-a005-20220919
i386                 randconfig-a004-20220919
i386                 randconfig-a005-20220919
powerpc                          g5_defconfig
mips                        qi_lb60_defconfig
arm                         palmz72_defconfig
mips                     loongson1c_defconfig
hexagon                             defconfig
powerpc                     tqm5200_defconfig
mips                          rm200_defconfig
arm                           sama7_defconfig
powerpc                 mpc836x_mds_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
