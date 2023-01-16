Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C290266C305
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjAPO7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjAPO6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:58:35 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CA7234F6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673880517; x=1705416517;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tmR4OFItN8ekaYiG7pqbsY+vnj+im0Eg/vw53oLAjaM=;
  b=fXhp2wahDEGGSdBDbFa8V81NEiez+sFdDg6LPDBOZQ/XsthEqj82JPkE
   QbKFZUozEJKc8a9RGztjFEjfZWTmWb2jN8rWSZBvFsHMS0RKfgXzXcan0
   X6WIQnNNizoTudTjS/p2zbA91kz8uEDtVeFSAFmvW2b46iRVLgoP+zMdM
   tGmL8XT1UYDSyRPOIRrQSvA5wtkr/GE8EBjpODeWnDAhHqYbTG1a6cA0s
   cpiiF8jmjYyVTq7tDOU4pCSGDp4JA8q2eBIIRNBW7Cw+3uN7GyIxoyJzK
   sJkAdJYmaptWpYq8TurV/VXtCGbYRX5Mnge9wXfsb90ssy8PVOLy19GgR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="386817523"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="386817523"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 06:48:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="747752358"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="747752358"
Received: from lkp-server02.sh.intel.com (HELO f57cd993bc73) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jan 2023 06:48:33 -0800
Received: from kbuild by f57cd993bc73 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pHQmn-0000WN-06;
        Mon, 16 Jan 2023 14:48:33 +0000
Date:   Mon, 16 Jan 2023 22:48:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 5d8a515b71f0cce1376dfcf52fc20c4eda69b53c
Message-ID: <63c563a2.LE3XFNXBhpmVl/an%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 5d8a515b71f0cce1376dfcf52fc20c4eda69b53c  rcutorture: Add SRCU deadlock scenarios

elapsed time: 727m

configs tested: 112
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
um                           x86_64_defconfig
um                             i386_defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
x86_64                            allnoconfig
sh                               allmodconfig
i386                 randconfig-a014-20230116
arm                                 defconfig
i386                 randconfig-a013-20230116
x86_64               randconfig-a011-20230116
mips                             allyesconfig
s390                             allyesconfig
x86_64               randconfig-a013-20230116
powerpc                          allmodconfig
x86_64               randconfig-a012-20230116
arm                        mini2440_defconfig
powerpc                   motionpro_defconfig
i386                 randconfig-a012-20230116
m68k                             allyesconfig
i386                 randconfig-a015-20230116
x86_64               randconfig-a015-20230116
arc                  randconfig-r043-20230115
x86_64               randconfig-a014-20230116
m68k                             allmodconfig
x86_64               randconfig-a016-20230116
arc                              allyesconfig
i386                 randconfig-a011-20230116
riscv                randconfig-r042-20230116
arm                              allyesconfig
i386                 randconfig-a016-20230116
arm64                            allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20230116
arm                  randconfig-r046-20230115
s390                 randconfig-r044-20230116
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
ia64                             allmodconfig
x86_64               randconfig-k001-20230116
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
i386                                defconfig
i386                 randconfig-c001-20230116
arm                         axm55xx_defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
sh                           se7722_defconfig
powerpc                       maple_defconfig
powerpc                    klondike_defconfig
sh                           se7206_defconfig
sh                        dreamcast_defconfig
openrisc                       virt_defconfig
powerpc                      ppc6xx_defconfig
m68k                       m5275evb_defconfig
arm                            mps2_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
nios2                         10m50_defconfig
arc                               allnoconfig
powerpc                      makalu_defconfig
arm                               allnoconfig
sh                      rts7751r2d1_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
m68k                                defconfig
loongarch                 loongson3_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
i386                 randconfig-a002-20230116
powerpc                   bluestone_defconfig
mips                     cu1000-neo_defconfig
i386                 randconfig-a004-20230116
i386                 randconfig-a003-20230116
hexagon              randconfig-r041-20230116
i386                 randconfig-a005-20230116
i386                 randconfig-a001-20230116
i386                 randconfig-a006-20230116
hexagon              randconfig-r045-20230115
riscv                randconfig-r042-20230115
arm                  randconfig-r046-20230116
s390                 randconfig-r044-20230115
hexagon              randconfig-r045-20230116
hexagon              randconfig-r041-20230115
powerpc                      pmac32_defconfig
powerpc                     kilauea_defconfig
arm                          collie_defconfig
x86_64               randconfig-a003-20230116
x86_64               randconfig-a004-20230116
x86_64               randconfig-a006-20230116
x86_64               randconfig-a005-20230116
x86_64               randconfig-a001-20230116
x86_64               randconfig-a002-20230116
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust
arm                       netwinder_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
