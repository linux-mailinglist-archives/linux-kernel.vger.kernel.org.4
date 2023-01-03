Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC3F65B9F0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 05:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjACEPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 23:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACEPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 23:15:21 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD23463FE
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 20:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672719320; x=1704255320;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fKTIVX96XuNiVrTnedLaImq8tS1kc4xdPHXueA0S/6E=;
  b=DVI/vbHBMf/MqQakEWkySjy+0TgAC1cIoJ0/cJ1EANfg2LkXLTPwibAy
   FyIDrOl9nAIZJo7smfhg3nHQcBvaL2s2Gg0B4ZgnRMKdAa9GdA27F3+Fp
   J42/P0OUiiUOhZ5knp9Xqv8t405jrbEsN08VOxXQyZu27pBd9GV/IECYI
   WSmBG70U4SqrOLLVFeIA7OhjvRGXEn02E3lQ1gYj/K17egzHuEVE17Gqg
   lKlZeUUQYuw2aDDU0+pnuhqJze5Oo7WwrVLbuADHyJouwJCgEf3DdMZVf
   q0I7WUScpINna/pC3lGG1uCKLgZmLK5dZpsl4TanG5ZV2UrkAdTyF5kKd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="323571443"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="323571443"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 20:15:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="654651689"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="654651689"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Jan 2023 20:15:18 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pCYhp-000Rkx-1t;
        Tue, 03 Jan 2023 04:15:17 +0000
Date:   Tue, 03 Jan 2023 12:14:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 bbd0b031509b880b4e9a880bb27ca2a30ad081ab
Message-ID: <63b3abb2.7oq1s/8QXDjRgo1w%lkp@intel.com>
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
branch HEAD: bbd0b031509b880b4e9a880bb27ca2a30ad081ab  sched/rseq: Fix concurrency ID handling of usermodehelper kthreads

elapsed time: 723m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
um                             i386_defconfig
s390                             allmodconfig
um                           x86_64_defconfig
alpha                               defconfig
i386                                defconfig
s390                                defconfig
sh                               allmodconfig
x86_64                              defconfig
arm                                 defconfig
s390                             allyesconfig
i386                 randconfig-a004-20230102
i386                 randconfig-a003-20230102
i386                 randconfig-a002-20230102
i386                 randconfig-a001-20230102
x86_64                               rhel-8.3
ia64                             allmodconfig
i386                 randconfig-a005-20230102
i386                 randconfig-a006-20230102
m68k                             allyesconfig
m68k                             allmodconfig
mips                             allyesconfig
alpha                            allyesconfig
arm                              allyesconfig
powerpc                          allmodconfig
arc                              allyesconfig
arm64                            allyesconfig
x86_64               randconfig-a001-20230102
x86_64               randconfig-a004-20230102
x86_64               randconfig-a002-20230102
x86_64               randconfig-a003-20230102
x86_64               randconfig-a005-20230102
x86_64               randconfig-a006-20230102
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
riscv                randconfig-r042-20230101
arc                  randconfig-r043-20230102
arm                  randconfig-r046-20230102
arc                  randconfig-r043-20230101
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                 randconfig-r044-20230101
i386                             allyesconfig
x86_64                            allnoconfig

clang tested configs:
i386                 randconfig-a013-20230102
i386                 randconfig-a012-20230102
i386                 randconfig-a011-20230102
i386                 randconfig-a014-20230102
i386                 randconfig-a015-20230102
i386                 randconfig-a016-20230102
hexagon              randconfig-r041-20230102
hexagon              randconfig-r045-20230101
hexagon              randconfig-r045-20230102
arm                  randconfig-r046-20230101
riscv                randconfig-r042-20230102
hexagon              randconfig-r041-20230101
x86_64                          rhel-8.3-rust
s390                 randconfig-r044-20230102
x86_64               randconfig-a011-20230102
x86_64               randconfig-a014-20230102
x86_64               randconfig-a012-20230102
x86_64               randconfig-a013-20230102
x86_64               randconfig-a015-20230102
x86_64               randconfig-a016-20230102

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
