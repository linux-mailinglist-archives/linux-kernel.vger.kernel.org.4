Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998F06CBFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjC1Myh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjC1MyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:54:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29874BB84
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680008021; x=1711544021;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ckAXpoYlAyhjjfNz0sv+GR+EoxAmhzRP36IVkFbijFA=;
  b=dUy4QX9rGXkhdnXDLkiqrUVSGz7KxnxPbwgH4rlZAwklaVHs98lkoErk
   HYRcnORUo+OHIJvsmqcZCB/fx0RgUh/4HKGcn9TdbwwGVs4TDP4M4E6Mo
   lxxbVPx1oGzT3f9ua/PVQFdBYUBPZmNXJ9gCzjsYqjYATxBHvh3m58eW0
   A/b3P16vFUd1mDtZuaLxdiEOnXqBM7d1WziWS8JitmG53DGYyx7ccmOWI
   axfRoK03SHWx9v0MhOJJcQCyLSgkZhm0P9W/qpERIrdHoS6LNapaiDm6D
   LsuwEWkTK/Wy1Gb7tc3G7PelWBrToo+XCjenqMEIjj1SWS2xJiPMwt6Eg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="405490085"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="405490085"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 05:52:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="683894889"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="683894889"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Mar 2023 05:52:04 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ph8nz-000IXT-36;
        Tue, 28 Mar 2023 12:52:03 +0000
Date:   Tue, 28 Mar 2023 20:51:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.03.24a] BUILD SUCCESS
 1a76974365d2187cb4efb3e9f2fab5b7373116ef
Message-ID: <6422e2d6.7oIvZzTeMHYnJ1Ke%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.03.24a
branch HEAD: 1a76974365d2187cb4efb3e9f2fab5b7373116ef  torture: Remove duplicated argument -enable-kvm for ppc64

elapsed time: 723m

configs tested: 127
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230327   gcc  
alpha                randconfig-r012-20230326   gcc  
alpha                randconfig-r033-20230327   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230326   gcc  
arc                  randconfig-r043-20230327   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230327   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r034-20230327   clang
arm                  randconfig-r046-20230326   clang
arm                  randconfig-r046-20230327   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230326   clang
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230326   gcc  
arm64                randconfig-r016-20230327   clang
arm64                randconfig-r026-20230326   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r005-20230326   gcc  
hexagon              randconfig-r002-20230326   clang
hexagon              randconfig-r012-20230327   clang
hexagon              randconfig-r041-20230326   clang
hexagon              randconfig-r041-20230327   clang
hexagon              randconfig-r045-20230326   clang
hexagon              randconfig-r045-20230327   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230327   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230327   gcc  
i386                 randconfig-a002-20230327   gcc  
i386                 randconfig-a003-20230327   gcc  
i386                 randconfig-a004-20230327   gcc  
i386                 randconfig-a005-20230327   gcc  
i386                 randconfig-a006-20230327   gcc  
i386                 randconfig-a011-20230327   clang
i386                 randconfig-a012-20230327   clang
i386                 randconfig-a013-20230327   clang
i386                 randconfig-a014-20230327   clang
i386                 randconfig-a015-20230327   clang
i386                 randconfig-a016-20230327   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r003-20230326   gcc  
ia64                 randconfig-r013-20230327   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230327   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r032-20230327   gcc  
loongarch            randconfig-r033-20230326   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230327   gcc  
m68k         buildonly-randconfig-r004-20230326   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r021-20230326   gcc  
microblaze   buildonly-randconfig-r004-20230327   gcc  
microblaze   buildonly-randconfig-r005-20230326   gcc  
microblaze           randconfig-r005-20230327   gcc  
microblaze           randconfig-r014-20230326   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r031-20230327   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r001-20230326   gcc  
openrisc             randconfig-r034-20230326   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r016-20230326   gcc  
parisc               randconfig-r026-20230327   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r006-20230326   clang
powerpc              randconfig-r014-20230327   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230326   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r036-20230327   gcc  
riscv                randconfig-r042-20230326   gcc  
riscv                randconfig-r042-20230327   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r035-20230326   clang
s390                 randconfig-r036-20230326   clang
s390                 randconfig-r044-20230326   gcc  
s390                 randconfig-r044-20230327   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r006-20230327   gcc  
sh                   randconfig-r022-20230326   gcc  
sh                   randconfig-r035-20230327   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r003-20230327   gcc  
sparc64              randconfig-r004-20230326   gcc  
sparc64              randconfig-r004-20230327   gcc  
sparc64              randconfig-r011-20230327   gcc  
sparc64              randconfig-r015-20230327   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230327   gcc  
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
x86_64               randconfig-r023-20230327   clang
x86_64               randconfig-r025-20230327   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230326   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
