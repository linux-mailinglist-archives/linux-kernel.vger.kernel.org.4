Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D326CC0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjC1N1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjC1N1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:27:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326A6902C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680010027; x=1711546027;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=agBghESOe9lE3oj/bl+ukpCt/dGR6OVDPA0Kd2WbI00=;
  b=H8SMdnqeMuPRk3mVfMXDrsqJpaP02hKvlaKK2xkKrurpmBbzn0D1VZC2
   phFhkJoCmIkKLfCB03Kg8XQNZc84ib5n0s31rujiqrh4C5yZUyBs9/oCW
   aO6DergaIsZINC32LtQ9lCAjMDmf2kTzA8EBbatGfUiNNdlV/Ta3wZIaA
   rrpyZ3/h0vZy2aKr+PREqiOQNsMUcqy+yBGNOpTJQShRy50TurHxOWLh3
   Zi1mGAbN9MEMvlDYpdJd3QiURTY+h2py9LxqQWtGb+D4AAf2V5VtdqNmI
   Q3m7yOwsJ7rSmC50RMPn0cimlVmddLj47GP1Od7SQ4qgKplqSmozAL/M4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="342149178"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="342149178"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 06:27:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773149980"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="773149980"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Mar 2023 06:27:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ph9Ls-000IYN-1o;
        Tue, 28 Mar 2023 13:27:04 +0000
Date:   Tue, 28 Mar 2023 21:26:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/shstk] BUILD SUCCESS
 11c95c77eef6d56c1ef9f55d8afd83ceb6d99996
Message-ID: <6422eb1b.Ues2XPeNCzWESqep%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/shstk
branch HEAD: 11c95c77eef6d56c1ef9f55d8afd83ceb6d99996  x86/shstk: Enforce only whole copies for ssp_set()

elapsed time: 733m

configs tested: 125
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r003-20230326   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230327   gcc  
alpha                randconfig-r011-20230326   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230327   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r014-20230327   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                  randconfig-r025-20230326   clang
arm                  randconfig-r033-20230327   clang
arm                  randconfig-r036-20230327   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230326   gcc  
arm64                randconfig-r031-20230326   clang
csky         buildonly-randconfig-r004-20230327   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230326   gcc  
csky                 randconfig-r015-20230326   gcc  
hexagon              randconfig-r006-20230326   clang
hexagon              randconfig-r031-20230327   clang
hexagon              randconfig-r036-20230326   clang
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
i386                 randconfig-r006-20230327   gcc  
i386                 randconfig-r022-20230327   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r004-20230326   gcc  
ia64                 randconfig-r012-20230327   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230326   gcc  
loongarch    buildonly-randconfig-r006-20230326   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r004-20230326   gcc  
microblaze           randconfig-r005-20230327   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230326   gcc  
mips                 randconfig-r003-20230327   clang
mips                 randconfig-r033-20230326   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230327   gcc  
openrisc             randconfig-r012-20230326   gcc  
openrisc             randconfig-r015-20230327   gcc  
openrisc             randconfig-r016-20230326   gcc  
openrisc             randconfig-r016-20230327   gcc  
openrisc             randconfig-r035-20230326   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r026-20230326   gcc  
parisc               randconfig-r032-20230327   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc              randconfig-r011-20230327   clang
powerpc              randconfig-r024-20230326   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230326   clang
riscv                randconfig-r005-20230326   clang
riscv                randconfig-r024-20230327   clang
riscv                randconfig-r032-20230326   clang
riscv                randconfig-r034-20230327   gcc  
riscv                randconfig-r035-20230327   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r022-20230326   gcc  
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r021-20230326   gcc  
sparc                randconfig-r025-20230327   gcc  
sparc64      buildonly-randconfig-r002-20230327   gcc  
sparc64      buildonly-randconfig-r005-20230327   gcc  
sparc64              randconfig-r002-20230327   gcc  
sparc64              randconfig-r013-20230327   gcc  
sparc64              randconfig-r026-20230327   gcc  
sparc64              randconfig-r034-20230326   gcc  
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
x86_64               randconfig-r021-20230327   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r014-20230326   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
