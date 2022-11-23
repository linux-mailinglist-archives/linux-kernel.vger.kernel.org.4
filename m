Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDA8634E10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiKWCyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbiKWCxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:53:55 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD83DE675D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 18:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669172026; x=1700708026;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TevMJJBXc/rr8P5n4npofRQ0ZTNvf93uzPN/X7fxxRA=;
  b=K3nzpC73pE+hoEAfQXGHVK4LwqXLjW2EkhixZ7HbW7c2DbjiuDJlItx8
   5rT0KPCio/Eow6FhWwEowwjJ/3pW0MTQwLSSQF3slxLCchm/IOTDD2bm3
   D+CYcmsBq3YmnjC9mQbQjrt/YlPsuVTEKqM03899Dq7h4KCgRvVJXkW0Y
   +e/GJ7lvv3a5FyX9Fii1SmC/ATbcksmXeIxjW/YMsUc8wMJD8447wOgHH
   6bfhtFiyB342xghnVcnO9Il856CyYUfQQNMrmE1UnLB9r9B33Mfu6037i
   XV12GhIj4jRYw1bI4ELWjJ7iL9le5Kf7xwZABRKCMUA26KNKQTkHjgnK4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="301523517"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="301523517"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 18:53:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="816324862"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="816324862"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Nov 2022 18:53:45 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxftQ-00028n-1r;
        Wed, 23 Nov 2022 02:53:44 +0000
Date:   Wed, 23 Nov 2022 10:53:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/alternatives] BUILD SUCCESS
 be84d8ed3f04e9154a3a55e29a27dcd416f05b31
Message-ID: <637d8b0e.VILUhHEdSORyfpqb%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/alternatives
branch HEAD: be84d8ed3f04e9154a3a55e29a27dcd416f05b31  x86/alternative: Consistently patch SMP locks in vmlinux and modules

elapsed time: 728m

configs tested: 97
configs skipped: 94

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                            allnoconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
i386                             allyesconfig
arm                        trizeps4_defconfig
m68k                       m5275evb_defconfig
arc                          axs103_defconfig
x86_64                           allyesconfig
i386                                defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                 randconfig-r044-20221121
arc                  randconfig-r043-20221121
ia64                             allmodconfig
arc                              allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                 randconfig-a014-20221121
i386                 randconfig-a016-20221121
x86_64                              defconfig
x86_64                               rhel-8.3
arm                          simpad_defconfig
powerpc                  iss476-smp_defconfig
sh                             espt_defconfig
x86_64               randconfig-a014-20221121
x86_64               randconfig-a012-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a015-20221121
m68k                       m5208evb_defconfig
arm                          gemini_defconfig
arm                            pleb_defconfig
parisc                generic-64bit_defconfig
sh                     sh7710voipgw_defconfig
x86_64               randconfig-a011-20221121
x86_64               randconfig-a016-20221121
i386                          randconfig-c001
arm                                 defconfig
riscv                randconfig-r042-20221121
arc                  randconfig-r043-20221120
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                      pcm030_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                         haps_hs_defconfig
arc                      axs103_smp_defconfig
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a012-20221121
riscv                    nommu_virt_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                 randconfig-a015-20221121
um                           x86_64_defconfig
um                             i386_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
s390                             allyesconfig
mips                             allyesconfig
powerpc                      makalu_defconfig
ia64                      gensparse_defconfig
xtensa                          iss_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig

clang tested configs:
x86_64                        randconfig-k001
x86_64               randconfig-a002-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a003-20221121
i386                 randconfig-a001-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
powerpc                   bluestone_defconfig
arm                          moxart_defconfig
hexagon                             defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                    gamecube_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     cu1000-neo_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
