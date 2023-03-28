Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101676CBDF9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjC1LkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjC1LkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:40:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F4D44BE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680003604; x=1711539604;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ieIMEGfwdXoqbtZ+dNdjTLdg/IXfu/W85BaihgbEHv8=;
  b=ORTZYRSOpL8heqYs4rHsL5DPDL3rcP1SlB4Yrddn5OtEAQjF4t+5lYiB
   jbL3n0PmerH0zQMTCpqtjaelDj4BgJSSMyI6/vcdzSXtwkYeCZQTU3sME
   OH7sFu1H4xA8LuD3SP0zmlqESmsB6PU/tU8QFyP5FtLI/t8UaScWdJMOI
   217dBcEJF0lZHb1fiu2i85c/lp8FzMGziRLeITqtj+y8MiZPILxQQJzSP
   PS61vIQ+RJ9XNybOy5KWuBpzFgW9/YqzcV3mUqDHbtW2TB7P0AMeKCLxD
   WOPj4EEu/IvlKnYd13V45qneH2w3+lVTWxJMLxq9fZs8Mee3IpxNNltpX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="324436483"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="324436483"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 04:40:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="661138651"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="661138651"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Mar 2023 04:40:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ph7gI-000IVM-0F;
        Tue, 28 Mar 2023 11:40:02 +0000
Date:   Tue, 28 Mar 2023 19:39:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:srcu-cf.2023.03.27b] BUILD SUCCESS
 8f5cabd81ba865b873bdeabe26ddebf5a966b102
Message-ID: <6422d1e2.TNUbdAI9QxZkS4iW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git srcu-cf.2023.03.27b
branch HEAD: 8f5cabd81ba865b873bdeabe26ddebf5a966b102  srcu: Fix long lines in srcu_funnel_gp_start()

elapsed time: 727m

configs tested: 134
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230327   gcc  
alpha                randconfig-r015-20230327   gcc  
alpha                randconfig-r034-20230326   gcc  
alpha                randconfig-r036-20230326   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230327   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r034-20230327   gcc  
arc                  randconfig-r043-20230326   gcc  
arc                  randconfig-r043-20230327   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r003-20230326   clang
arm                                 defconfig   gcc  
arm                  randconfig-r013-20230327   gcc  
arm                  randconfig-r031-20230327   clang
arm                  randconfig-r046-20230326   clang
arm                  randconfig-r046-20230327   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230326   clang
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230326   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230327   gcc  
csky                 randconfig-r015-20230326   gcc  
hexagon              randconfig-r041-20230326   clang
hexagon              randconfig-r041-20230327   clang
hexagon              randconfig-r045-20230326   clang
hexagon              randconfig-r045-20230327   clang
i386                             allyesconfig   gcc  
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
i386                          randconfig-c001   gcc  
i386                 randconfig-r012-20230327   clang
i386                 randconfig-r032-20230327   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r006-20230327   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r024-20230326   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230327   gcc  
m68k         buildonly-randconfig-r006-20230326   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230326   gcc  
m68k                 randconfig-r016-20230327   gcc  
microblaze           randconfig-r001-20230326   gcc  
microblaze           randconfig-r011-20230326   gcc  
microblaze           randconfig-r026-20230326   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230326   gcc  
mips         buildonly-randconfig-r006-20230327   clang
mips                 randconfig-r033-20230327   clang
nios2                               defconfig   gcc  
nios2                randconfig-r023-20230327   gcc  
openrisc     buildonly-randconfig-r005-20230327   gcc  
openrisc             randconfig-r011-20230327   gcc  
openrisc             randconfig-r013-20230326   gcc  
openrisc             randconfig-r016-20230326   gcc  
openrisc             randconfig-r033-20230326   gcc  
parisc       buildonly-randconfig-r002-20230327   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r021-20230326   gcc  
parisc               randconfig-r022-20230327   gcc  
parisc               randconfig-r025-20230326   gcc  
parisc               randconfig-r036-20230327   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r014-20230327   clang
powerpc              randconfig-r031-20230326   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230326   gcc  
riscv                randconfig-r042-20230327   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230326   clang
s390                 randconfig-r024-20230327   clang
s390                 randconfig-r044-20230326   gcc  
s390                 randconfig-r044-20230327   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r023-20230326   gcc  
sh                   randconfig-r035-20230326   gcc  
sparc        buildonly-randconfig-r001-20230327   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r021-20230327   gcc  
sparc                randconfig-r026-20230327   gcc  
sparc64      buildonly-randconfig-r004-20230326   gcc  
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
x86_64               randconfig-r005-20230327   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230327   gcc  
xtensa               randconfig-r003-20230326   gcc  
xtensa               randconfig-r004-20230326   gcc  
xtensa               randconfig-r032-20230326   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
