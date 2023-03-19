Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996E66C0365
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 18:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCSRNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 13:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCSRNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 13:13:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E0918A9D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 10:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679245994; x=1710781994;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=M5CDA3U+iKhhW5pGbZ5M3BN+lgk0ifNkn4lC5S3nV+E=;
  b=f5LmfguXIpnpa/dM3D7OoL+DSlhTjjLl+gGZR7LRxvrRa9va6ldon9py
   odakA2CQsZCxTb3gvFqeVzXEeYAWniJa2nWqcXE3N5B32mfgEnN4lFddp
   /niXCBAd5LX3QYN/zFjluFpt0RC9aMafpiQxO4oC0TxuPXQwRPotlSoGk
   u2DRXAD2ZFM31VkT/eFWuiQdBmYLMxsREFbXmild4QiwSxUoeAlcJQkYC
   PCdiwSVBi6wa2gJkacjIZ+FgzhGQiJrwiQmpMMk5xMIHd8Szi7P7AgUoF
   07HNC5zk8eq3PY9Dasjg8Yux/6JrLvruYVq4fxBZu4ruZIcwtRL8Z1QNB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326895379"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326895379"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 10:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="658117926"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="658117926"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Mar 2023 10:13:12 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdwal-000Ab2-2v;
        Sun, 19 Mar 2023 17:13:11 +0000
Date:   Mon, 20 Mar 2023 01:12:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.03.11a] BUILD SUCCESS
 daaaf357ff854004a665cfb9e73844228c108e8e
Message-ID: <64174289.1rTzTdia4iV59WHO%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.03.11a
branch HEAD: daaaf357ff854004a665cfb9e73844228c108e8e  srcu: Begin offloading srcu_struct fields to srcu_update

elapsed time: 723m

configs tested: 126
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230319   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230319   gcc  
alpha                randconfig-r021-20230319   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230319   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230319   gcc  
arc                  randconfig-r025-20230319   gcc  
arc                  randconfig-r043-20230319   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r005-20230319   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r012-20230319   gcc  
arm                  randconfig-r024-20230319   gcc  
arm                  randconfig-r036-20230319   clang
arm                  randconfig-r046-20230319   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230319   gcc  
csky                 randconfig-r005-20230319   gcc  
csky                 randconfig-r034-20230319   gcc  
hexagon      buildonly-randconfig-r001-20230319   clang
hexagon              randconfig-r001-20230319   clang
hexagon              randconfig-r041-20230319   clang
hexagon              randconfig-r045-20230319   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230319   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r003-20230319   gcc  
ia64                 randconfig-r004-20230319   gcc  
ia64                 randconfig-r015-20230319   gcc  
ia64                 randconfig-r033-20230319   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r015-20230319   gcc  
loongarch            randconfig-r022-20230319   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r014-20230319   gcc  
microblaze   buildonly-randconfig-r001-20230319   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r026-20230319   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230319   gcc  
nios2                randconfig-r013-20230319   gcc  
nios2                randconfig-r035-20230319   gcc  
nios2                randconfig-r036-20230319   gcc  
openrisc             randconfig-r006-20230319   gcc  
openrisc             randconfig-r021-20230319   gcc  
openrisc             randconfig-r024-20230319   gcc  
openrisc             randconfig-r025-20230319   gcc  
openrisc             randconfig-r035-20230319   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230319   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230319   clang
powerpc              randconfig-r033-20230319   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r031-20230319   gcc  
riscv                randconfig-r042-20230319   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230319   clang
s390                                defconfig   gcc  
s390                 randconfig-r012-20230319   clang
s390                 randconfig-r044-20230319   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230319   gcc  
sh                   randconfig-r016-20230319   gcc  
sh                   randconfig-r032-20230319   gcc  
sparc        buildonly-randconfig-r006-20230319   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230319   gcc  
sparc                randconfig-r031-20230319   gcc  
sparc64              randconfig-r011-20230319   gcc  
sparc64              randconfig-r032-20230319   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230319   gcc  
xtensa               randconfig-r003-20230319   gcc  
xtensa               randconfig-r013-20230319   gcc  
xtensa               randconfig-r023-20230319   gcc  
xtensa               randconfig-r026-20230319   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
