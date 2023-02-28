Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF9E6A5400
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjB1H76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjB1H7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:59:43 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08552244A6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677571168; x=1709107168;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=os9+1q5LxIyf7cVBqW2kcXAcRBTS4qgjo6E8t2++Z8c=;
  b=NTHNXsFRJ3vdHjJ+VcN8QirUS8S9agbsvPAXy8xmJfnWfFMVZ/ApRxxh
   P5TBOa6oXoSoaIpO6kLxqoM0u+O2MFCndqH5w8DkGFD9SkBW3Yu//4QpS
   PQiT9WDJsUiOlJKVWct8kEXiHTNNEo6dgZd6Y6g11rZcnjsMQCDmKZjKN
   O+PhB1LQumAInxieP/g6FnshCWxMwhHYvqF40Rx3D/HloC7fvaIDd/FZF
   alaifSGCHJaNAtAi0hu37ds+28pMko2zxkr8kYZ0ag2QGtk5dokcVuqPF
   x2Hr8ijnIl1PTF94uBeBx1YmsXZM39+518Z90+ZRGumK6GtPGbMtNXWpA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="335562821"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="335562821"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 23:59:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="623930903"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="623930903"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Feb 2023 23:59:23 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWutO-0005Cz-1q;
        Tue, 28 Feb 2023 07:59:22 +0000
Date:   Tue, 28 Feb 2023 15:59:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 e02b50ca442e88122e1302d4dbc1b71a4808c13f
Message-ID: <63fdb454.qFCZu6IRfyU5mvId%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: e02b50ca442e88122e1302d4dbc1b71a4808c13f  Documentation/hw-vuln: Document the interaction between IBRS and STIBP

elapsed time: 723m

configs tested: 128
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230227   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230226   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230226   gcc  
arc                  randconfig-r011-20230226   gcc  
arc                  randconfig-r016-20230227   gcc  
arc                  randconfig-r022-20230226   gcc  
arc                  randconfig-r043-20230226   gcc  
arc                  randconfig-r043-20230227   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230226   gcc  
arm                  randconfig-r046-20230227   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r006-20230226   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230226   gcc  
arm64                randconfig-r005-20230226   gcc  
arm64                randconfig-r013-20230227   gcc  
arm64                randconfig-r014-20230226   clang
csky                                defconfig   gcc  
csky                 randconfig-r021-20230226   gcc  
csky                 randconfig-r021-20230227   gcc  
hexagon              randconfig-r026-20230226   clang
hexagon              randconfig-r041-20230226   clang
hexagon              randconfig-r041-20230227   clang
hexagon              randconfig-r045-20230226   clang
hexagon              randconfig-r045-20230227   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230227   gcc  
i386                 randconfig-a012-20230227   gcc  
i386                 randconfig-a013-20230227   gcc  
i386                 randconfig-a014-20230227   gcc  
i386                 randconfig-a015-20230227   gcc  
i386                 randconfig-a016-20230227   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230227   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r006-20230226   gcc  
ia64                 randconfig-r023-20230226   gcc  
ia64                 randconfig-r024-20230226   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230227   gcc  
loongarch            randconfig-r035-20230228   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r004-20230227   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r012-20230227   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r005-20230226   clang
mips                 randconfig-r033-20230228   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r013-20230226   gcc  
openrisc             randconfig-r014-20230227   gcc  
parisc       buildonly-randconfig-r004-20230226   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230227   gcc  
parisc               randconfig-r034-20230228   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230227   gcc  
powerpc      buildonly-randconfig-r003-20230227   gcc  
powerpc              randconfig-r025-20230227   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230227   clang
riscv                randconfig-r005-20230227   clang
riscv                randconfig-r031-20230228   gcc  
riscv                randconfig-r036-20230228   gcc  
riscv                randconfig-r042-20230226   clang
riscv                randconfig-r042-20230227   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230227   clang
s390                 randconfig-r032-20230228   gcc  
s390                 randconfig-r044-20230226   clang
s390                 randconfig-r044-20230227   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r025-20230226   gcc  
sh                   randconfig-r026-20230227   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230227   gcc  
sparc                randconfig-r004-20230226   gcc  
sparc                randconfig-r015-20230227   gcc  
sparc                randconfig-r016-20230226   gcc  
sparc                randconfig-r022-20230227   gcc  
sparc                randconfig-r024-20230227   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230227   clang
x86_64               randconfig-a002-20230227   clang
x86_64               randconfig-a003-20230227   clang
x86_64               randconfig-a004-20230227   clang
x86_64               randconfig-a005-20230227   clang
x86_64               randconfig-a006-20230227   clang
x86_64               randconfig-a011-20230227   gcc  
x86_64               randconfig-a012-20230227   gcc  
x86_64               randconfig-a013-20230227   gcc  
x86_64               randconfig-a014-20230227   gcc  
x86_64               randconfig-a015-20230227   gcc  
x86_64               randconfig-a016-20230227   gcc  
x86_64               randconfig-r023-20230227   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230227   gcc  
xtensa               randconfig-r015-20230226   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
