Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97D45F83E1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 08:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJHGqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 02:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJHGqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 02:46:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DE8A3F44
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 23:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665211592; x=1696747592;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zjNvzvgY/cZwAvbfdgymUVlA0IAlagC/PeDAs05ZyPA=;
  b=LGi7Hz+7fycOMD8S4GY4pYiC+5shiVbur8wrDlsOLz8UIajO7gURPiAm
   NwxXM5Ci96nLtwz9rV49z3zZldPgSvfa7tFM7wWhulOe6+P+m59/vfWlK
   Ge0dsascwTCNg0wLGLx70koUERNNkVctCwkdCwFfAqMTpYlAaQFu9I8jM
   r3EGXguUmu7bZSxLlfWyNttTfrldxFOXxtH+lQincRWt+eXYsVNB670lz
   bc0M4Sv7lBTXVE8IV95AVLpGgrR7/5h+uAamI+ttDpgZ07o/itl8hREwS
   eNgY6sIyCBq4M7VfAs+hSrR/N7Ey0HQSGXySM/ivKl7Xx5TxQ1RjBG7zm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="291182401"
X-IronPort-AV: E=Sophos;i="5.95,169,1661842800"; 
   d="scan'208";a="291182401"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 23:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="658590234"
X-IronPort-AV: E=Sophos;i="5.95,169,1661842800"; 
   d="scan'208";a="658590234"
Received: from lkp-server01.sh.intel.com (HELO 3c15167049b7) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Oct 2022 23:46:31 -0700
Received: from kbuild by 3c15167049b7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oh3bS-0001uh-1j;
        Sat, 08 Oct 2022 06:46:30 +0000
Date:   Sat, 08 Oct 2022 14:45:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:lazy.2022.10.07a] BUILD SUCCESS
 2373c5a1033a43f83bb287ac2bac29dc8865a555
Message-ID: <63411c90.fyz2OYWA054Q/65a%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lazy.2022.10.07a
branch HEAD: 2373c5a1033a43f83bb287ac2bac29dc8865a555  workqueue: Make queue_rcu_work() use call_rcu_flush()

elapsed time: 725m

configs tested: 83
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
alpha                            allyesconfig
arc                                 defconfig
s390                             allmodconfig
powerpc                           allnoconfig
m68k                             allyesconfig
alpha                               defconfig
i386                 randconfig-a014-20221003
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
s390                             allyesconfig
m68k                             allmodconfig
s390                                defconfig
i386                 randconfig-a011-20221003
mips                             allyesconfig
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
sh                               allmodconfig
arc                              allyesconfig
x86_64                           allyesconfig
x86_64               randconfig-a011-20221003
riscv                randconfig-r042-20221007
arm                                 defconfig
i386                 randconfig-a012-20221003
arc                  randconfig-r043-20221007
x86_64               randconfig-a015-20221003
i386                 randconfig-a013-20221003
x86_64               randconfig-a014-20221003
riscv                randconfig-r042-20221003
i386                             allyesconfig
arm                              allyesconfig
arc                  randconfig-r043-20221003
i386                 randconfig-a015-20221003
i386                 randconfig-a016-20221003
x86_64               randconfig-a012-20221003
x86_64               randconfig-a013-20221003
arm64                            allyesconfig
x86_64               randconfig-a016-20221003
s390                 randconfig-r044-20221007
s390                 randconfig-r044-20221003
ia64                             allmodconfig
arc                               allnoconfig
arc                  randconfig-r043-20221002
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
powerpc                     taishan_defconfig
arm                       imx_v6_v7_defconfig
sh                          landisk_defconfig
powerpc                         wii_defconfig
m68k                        m5272c3_defconfig
csky                                defconfig
sh                           se7750_defconfig
xtensa                  cadence_csp_defconfig

clang tested configs:
i386                 randconfig-a004-20221003
hexagon              randconfig-r041-20221003
x86_64               randconfig-a003-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
i386                 randconfig-a003-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a006-20221003
x86_64               randconfig-a005-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a006-20221003
i386                 randconfig-a005-20221003
hexagon              randconfig-r045-20221007
hexagon              randconfig-r041-20221007
hexagon              randconfig-r045-20221003
hexagon              randconfig-r041-20221002
hexagon              randconfig-r045-20221002
riscv                randconfig-r042-20221002
s390                 randconfig-r044-20221002
powerpc                 mpc8315_rdb_defconfig
powerpc                     pseries_defconfig
mips                          ath25_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
