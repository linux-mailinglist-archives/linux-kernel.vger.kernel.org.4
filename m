Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C855BF7CE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiIUHgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiIUHgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:36:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313967F265
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663745772; x=1695281772;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=J9QuQdwoWeBnEMcNSWRRa6EYGcFsXwENI57SHdxsses=;
  b=kIYhpahD8AB1C4cFLn8wFXhU65ZXxuac4dQmuID1QBtXy0EmcwCI/Vr+
   /Nyf74BoBu2d6bWUmVlaMiKdmb5HPEUY+ZP2xdR68uAk4t4QrdQCqf+qD
   5m8A4OKNtyd9Wc9ukmo70PXxItEYHoI/v0S+yvyTCm0JtjcHBFR247uj+
   UNz3U4oyPZO8+k+X69WhSS6RNUS8xDVOvyD7gsb4pYkFSAa3HVoeZA4on
   ry2h1irTASS5f2xV5Cgo79IVsNCiMQTGYhy8LlknHY0PYkl9MlLBsrauR
   SwF/qj8xCAaDW2zi8Y7ACF5n6jFRUpAWJf9k/kcZ8VXQ78/lfHvybRu7b
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="280302846"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="280302846"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 00:36:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="570425412"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Sep 2022 00:36:09 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oauHA-0003Mt-0n;
        Wed, 21 Sep 2022 07:36:08 +0000
Date:   Wed, 21 Sep 2022 15:36:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.09.19a] BUILD SUCCESS
 2d20ef43284147922ea5eefd98057496f65300bb
Message-ID: <632abee3.yuEE1h1ffvaRLm/v%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.09.19a
branch HEAD: 2d20ef43284147922ea5eefd98057496f65300bb  srcu: Check for consistent per-CPU per-srcu_struct NMI safety

elapsed time: 1947m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
m68k                             allmodconfig
riscv                randconfig-r042-20220919
arc                              allyesconfig
arc                  randconfig-r043-20220919
alpha                            allyesconfig
s390                 randconfig-r044-20220919
m68k                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
arm                                 defconfig
x86_64                           allyesconfig
i386                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
arc                  randconfig-r043-20220921
riscv                randconfig-r042-20220921
s390                 randconfig-r044-20220921
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz

clang tested configs:
hexagon              randconfig-r045-20220919
hexagon              randconfig-r041-20220919
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
