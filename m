Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801D86CBA22
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjC1JJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjC1JJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:09:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466DF193
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679994546; x=1711530546;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Q+6j6l/62DW+sfjurLtkkG6bdYbfwPi01frpfBdVtDA=;
  b=IH/CSL2RdyUcBWTE96C0gkVhOFUrZFup0nofJOYhtZ/L/5ZlyoN9uQT3
   WVw38zD9Nq9/JYxtyV9UFHvvxfTBBuW6c7bYNNPNqe55QnQAXcDWBBuYK
   4klsOhvvEpsptdYShTDnGg2Sta1U7hUq6J8PTNUbnFATBKmqTFtbs0cG4
   aPzaA1y+rSN5JCtgyT1def91/Ttz+v5UD9Vx43t+wWhujaLrq9dcmDcBS
   eiMtCwrLTHPTPY4yVVTZEB+yyqy6zBJ0lCaqpSP7LOkMvkIeQrWUhlxpz
   ZzToFOS12oXMez22CS5yzOSgZhhFPThITeCcLzmJIjeTjipB2cHoakxaY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="403124467"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="403124467"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 02:08:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="794730253"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="794730253"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2023 02:08:57 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ph5K5-000IQ0-10;
        Tue, 28 Mar 2023 09:08:57 +0000
Date:   Tue, 28 Mar 2023 17:08:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:srcu-cf.2023.03.27a] BUILD SUCCESS
 723cd88982b440dfc108c4d135278310f2ea5461
Message-ID: <6422ae74.EAVqn/GJ0lgSJVDL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git srcu-cf.2023.03.27a
branch HEAD: 723cd88982b440dfc108c4d135278310f2ea5461  srcu: Fix long lines in srcu_funnel_gp_start()

elapsed time: 725m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230326   gcc  
arc                  randconfig-r043-20230327   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r004-20230326   clang
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230327   gcc  
arm                        vexpress_defconfig   clang
arm                    vt8500_v6_v7_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r002-20230326   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r013-20230326   gcc  
hexagon      buildonly-randconfig-r003-20230326   clang
hexagon      buildonly-randconfig-r004-20230327   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a011-20230327   clang
i386                 randconfig-a012-20230327   clang
i386                 randconfig-a013-20230327   clang
i386                 randconfig-a014-20230327   clang
i386                 randconfig-a015-20230327   clang
i386                 randconfig-a016-20230327   clang
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230327   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230326   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230327   gcc  
m68k                 randconfig-r014-20230326   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2        buildonly-randconfig-r002-20230327   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230327   gcc  
nios2                randconfig-r016-20230327   gcc  
openrisc     buildonly-randconfig-r005-20230327   gcc  
openrisc             randconfig-r011-20230326   gcc  
openrisc             randconfig-r014-20230327   gcc  
openrisc             randconfig-r016-20230326   gcc  
parisc       buildonly-randconfig-r006-20230327   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-c003-20230326   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230327   clang
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230326   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230326   gcc  
sh                               allmodconfig   gcc  
sparc        buildonly-randconfig-r001-20230326   gcc  
sparc        buildonly-randconfig-r006-20230326   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230326   gcc  
sparc64              randconfig-r012-20230326   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230327   gcc  
x86_64               randconfig-a002-20230327   gcc  
x86_64               randconfig-a003-20230327   gcc  
x86_64               randconfig-a004-20230327   gcc  
x86_64               randconfig-a005-20230327   gcc  
x86_64               randconfig-a006-20230327   gcc  
x86_64               randconfig-a011-20230327   clang
x86_64               randconfig-a012-20230327   clang
x86_64               randconfig-a013-20230327   clang
x86_64               randconfig-a014-20230327   clang
x86_64               randconfig-a015-20230327   clang
x86_64               randconfig-a016-20230327   clang
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
