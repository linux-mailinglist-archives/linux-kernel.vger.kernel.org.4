Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789F26D6021
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjDDMUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbjDDMTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:19:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042763586
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680610705; x=1712146705;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7SUzOEUi6cvM/LRBmp2ursBIF9bJZuvanZilV3QtJWo=;
  b=U2ZcTEvregHZ4+6b2oQBMA7c5iCoUn0mtUwaff/ee9jLLIIUDmpSBNzK
   VwayPhCy1d62Tth/b0seQh5nWAqoO/m8Iscx3yJhBJOnGe1CD4kbgEB0C
   Qdu6Zkl7katz6WMEgAY20DLoa71F1AFeR9hqQ9uckFNH9+jnqWO/VjAhz
   9JZBOd8L61N02KHdiIRsqnLTyqoHKObLN0ZGGIv856KSqx0kMJb2oHa3x
   DDhTFvkzmCKGJZs1zL10R7qx/0lNT1SdIW/TY+Py2cG+hbT1So13whtCB
   SCr925vpecJx0v8lU3xVPJofdTFQKsk2xFwPbJOioPNW0HIZwgqf9ql5m
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="343861926"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="343861926"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 05:18:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="750895476"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="750895476"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Apr 2023 05:18:20 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjfcB-000PfE-2f;
        Tue, 04 Apr 2023 12:18:19 +0000
Date:   Tue, 04 Apr 2023 20:18:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.03.30a] BUILD SUCCESS
 e222f9a512539c3f4093a55d16624d9da614800b
Message-ID: <642c158b.VW7KIEJdx99u3tM5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.03.30a
branch HEAD: e222f9a512539c3f4093a55d16624d9da614800b  rcu: Avoid freeing new kfree_rcu() memory after old grace period

Unverified Warning (likely false positive, please contact us if interested):

kernel/rcu/tree.c:2149 rcu_do_batch() error: uninitialized symbol 'jlimit'.

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- openrisc-randconfig-m031-20230403
    `-- kernel-rcu-tree.c-rcu_do_batch()-error:uninitialized-symbol-jlimit-.

elapsed time: 725m

configs tested: 102
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230403   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r025-20230403   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230403   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r006-20230403   gcc  
arm                  randconfig-r026-20230403   clang
arm                  randconfig-r046-20230403   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230403   clang
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230403   gcc  
csky                 randconfig-r021-20230403   gcc  
csky                 randconfig-r035-20230403   gcc  
hexagon              randconfig-r005-20230403   clang
hexagon              randconfig-r016-20230403   clang
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r045-20230403   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                 randconfig-a012-20230403   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                 randconfig-r015-20230403   gcc  
i386                 randconfig-r031-20230403   clang
i386                 randconfig-r033-20230403   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230403   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230403   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r023-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r024-20230403   clang
nios2        buildonly-randconfig-r003-20230403   gcc  
nios2        buildonly-randconfig-r006-20230403   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r032-20230403   gcc  
nios2                randconfig-r036-20230403   gcc  
openrisc             randconfig-r013-20230403   gcc  
openrisc             randconfig-r034-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230403   gcc  
s390                 randconfig-r044-20230403   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r011-20230403   gcc  
sparc                               defconfig   gcc  
sparc64      buildonly-randconfig-r002-20230403   gcc  
sparc64              randconfig-r022-20230403   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64               randconfig-a006-20230403   clang
x86_64               randconfig-a011-20230403   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
