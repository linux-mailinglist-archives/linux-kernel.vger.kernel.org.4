Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F88568E2EF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjBGVZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBGVZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:25:03 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95A36EA1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 13:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675805070; x=1707341070;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vEpFlrFDAfViIhsuybh32LbGE8eseWOB9Qvys4oTXG0=;
  b=fJDsacysd/hIRbvUN0zFxkIguYL8jByJ1zx9VSIQKFMRERhqf/cBTFS/
   EwMI6bu5HOSyHjIhxytgplPBDLZ8H7ScQN0Y3z7Vttauz8Sr+YqWVQisw
   cC99/LMNG9Z4ltnQ5SwzF89uYNFxMg9hy2TRbdH2MJtJ5w67Sfccp/s8v
   U/z9R1zfUQr3+PrUIAi5r+YaR0xeL06UEaFR8ULQ8f8Fe/qIV164KgaSW
   9BfqGfTKZN4kJfQZZscLDdAXYcTnkjZdbJaMheo9cr3G0Bk2kw3NqgGaI
   /5puhp6ym3ZbSCOMvoQ1GxacSBTtDR59GH20awsDRIdTcSYkKVylb3P7t
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="317627681"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="317627681"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 13:23:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="668940611"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="668940611"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 07 Feb 2023 13:23:33 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPVR6-0003ts-33;
        Tue, 07 Feb 2023 21:23:32 +0000
Date:   Wed, 08 Feb 2023 05:23:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:clocksource.2023.02.06a] BUILD SUCCESS
 0051293c533017e2a860e0a0a33517bc40240fff
Message-ID: <63e2c13b.swSX0AoNAKZ27jGH%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git clocksource.2023.02.06a
branch HEAD: 0051293c533017e2a860e0a0a33517bc40240fff  clocksource: Enable TSC watchdog checking of HPET and PMTMR only when requested

elapsed time: 1236m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                           rhel-8.3-bpf
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
i386                 randconfig-a011-20230206
i386                 randconfig-a014-20230206
i386                 randconfig-a012-20230206
i386                 randconfig-a013-20230206
sh                               allmodconfig
i386                 randconfig-a016-20230206
i386                 randconfig-a015-20230206
mips                             allyesconfig
powerpc                          allmodconfig
arm                                 defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
arm                              allyesconfig
x86_64                           allyesconfig
riscv                randconfig-r042-20230204
arc                  randconfig-r043-20230204
arc                  randconfig-r043-20230206
i386                                defconfig
s390                 randconfig-r044-20230204
riscv                randconfig-r042-20230206
s390                 randconfig-r044-20230206
x86_64               randconfig-a014-20230206
x86_64               randconfig-a013-20230206
x86_64               randconfig-a011-20230206
x86_64               randconfig-a012-20230206
x86_64               randconfig-a015-20230206
x86_64               randconfig-a016-20230206
i386                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
m68k                         amcore_defconfig
m68k                          atari_defconfig
sh                         ap325rxa_defconfig
sh                           se7705_defconfig
m68k                        m5407c3_defconfig
sh                             shx3_defconfig
sh                           sh2007_defconfig
mips                     loongson1b_defconfig
sh                         microdev_defconfig

clang tested configs:
i386                 randconfig-a002-20230206
i386                 randconfig-a004-20230206
i386                 randconfig-a003-20230206
i386                 randconfig-a001-20230206
i386                 randconfig-a005-20230206
i386                 randconfig-a006-20230206
x86_64               randconfig-a001-20230206
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a005-20230206
x86_64               randconfig-a006-20230206
hexagon              randconfig-r041-20230206
hexagon              randconfig-r041-20230204
arm                  randconfig-r046-20230204
arm                  randconfig-r046-20230206
hexagon              randconfig-r045-20230204
hexagon              randconfig-r045-20230206
x86_64                          rhel-8.3-rust
x86_64                        randconfig-k001
mips                        maltaup_defconfig
powerpc                      ppc44x_defconfig
arm                       mainstone_defconfig
mips                           mtx1_defconfig

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
