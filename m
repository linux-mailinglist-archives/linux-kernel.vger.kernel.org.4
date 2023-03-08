Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7780A6B0D45
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCHPrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjCHPr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:47:29 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF335506C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678290410; x=1709826410;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FTXnH1sCTC6pPYlc8+nCiU04l6s5QWNfToPHt8rPfWg=;
  b=fTS2RT4BcYE//4PS57R2ojpExZEIIFI3CdU/mcRzDt4DB5MJt4yzBa4r
   oBlY33sPxgh2Vf38y/+i7XjlHppFl5ZQwt4IJGtqntw9m1vOQiTk0RTDt
   p54gH8NSqN3Zxc2zS8Wr/TM9GZwEa6QJQ7vpZTdPGUVlG9rkdemfSe9GS
   ACQLALtzhqXKtBASDclJ3OSZCQ4ASYRDtUdEkbeebetFsS/yyCm3yBwQB
   bhM5R0PcgVPYiAE5JZcbIyo1f0z40oyyHXC6S7YRamF571nlSv/rvbEhd
   cuv3HbQRWTFUsaUWzL2VJMrJ8srg0udbthdXpUU5dPYBqM+rL7F2un90t
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="363825653"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="363825653"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:46:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="707229784"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="707229784"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Mar 2023 07:46:49 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZw08-0002EN-24;
        Wed, 08 Mar 2023 15:46:48 +0000
Date:   Wed, 08 Mar 2023 23:46:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 e4beed6287ce8ebd0baa96f87824e883b2cfacec
Message-ID: <6408add1.IziDijSDAUoNT97D%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: e4beed6287ce8ebd0baa96f87824e883b2cfacec  Revert "rcu/kvfree: Eliminate k[v]free_rcu() single argument macro"

elapsed time: 882m

configs tested: 158
configs skipped: 23

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230305   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r033-20230308   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230306   gcc  
arc                  randconfig-r043-20230305   gcc  
arc                  randconfig-r043-20230306   gcc  
arc                  randconfig-r043-20230308   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r015-20230305   clang
arm                  randconfig-r033-20230306   clang
arm                  randconfig-r046-20230305   clang
arm                  randconfig-r046-20230306   gcc  
arm                  randconfig-r046-20230308   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230305   clang
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230308   clang
arm64                randconfig-r026-20230306   clang
csky                                defconfig   gcc  
csky                 randconfig-r001-20230305   gcc  
csky                 randconfig-r002-20230305   gcc  
csky                 randconfig-r025-20230306   gcc  
csky                 randconfig-r034-20230305   gcc  
hexagon              randconfig-r002-20230306   clang
hexagon              randconfig-r013-20230305   clang
hexagon              randconfig-r014-20230306   clang
hexagon              randconfig-r041-20230305   clang
hexagon              randconfig-r041-20230306   clang
hexagon              randconfig-r041-20230308   clang
hexagon              randconfig-r045-20230305   clang
hexagon              randconfig-r045-20230306   clang
hexagon              randconfig-r045-20230308   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230306   gcc  
i386                 randconfig-a002-20230306   gcc  
i386                 randconfig-a003-20230306   gcc  
i386                 randconfig-a004-20230306   gcc  
i386                 randconfig-a005-20230306   gcc  
i386                 randconfig-a006-20230306   gcc  
i386                 randconfig-a011-20230306   clang
i386                 randconfig-a012-20230306   clang
i386                 randconfig-a013-20230306   clang
i386                 randconfig-a014-20230306   clang
i386                 randconfig-a015-20230306   clang
i386                 randconfig-a016-20230306   clang
i386                 randconfig-r002-20230306   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230306   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230305   gcc  
ia64                 randconfig-r024-20230305   gcc  
ia64                 randconfig-r031-20230308   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230306   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230305   gcc  
loongarch            randconfig-r006-20230305   gcc  
loongarch            randconfig-r013-20230306   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r022-20230306   gcc  
microblaze   buildonly-randconfig-r005-20230305   gcc  
microblaze   buildonly-randconfig-r006-20230306   gcc  
microblaze           randconfig-r005-20230305   gcc  
microblaze           randconfig-r022-20230305   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r005-20230308   clang
mips                 randconfig-r025-20230305   clang
mips                 randconfig-r035-20230308   clang
nios2        buildonly-randconfig-r003-20230305   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230306   gcc  
nios2                randconfig-r036-20230308   gcc  
openrisc             randconfig-r011-20230308   gcc  
openrisc             randconfig-r014-20230305   gcc  
parisc       buildonly-randconfig-r006-20230305   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230305   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230306   clang
powerpc              randconfig-r006-20230306   gcc  
powerpc              randconfig-r016-20230305   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230306   gcc  
riscv                randconfig-r012-20230308   clang
riscv                randconfig-r033-20230305   clang
riscv                randconfig-r035-20230305   clang
riscv                randconfig-r042-20230305   gcc  
riscv                randconfig-r042-20230306   clang
riscv                randconfig-r042-20230308   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230305   clang
s390                 randconfig-r023-20230305   gcc  
s390                 randconfig-r031-20230306   gcc  
s390                 randconfig-r032-20230305   clang
s390                 randconfig-r032-20230306   gcc  
s390                 randconfig-r036-20230306   gcc  
s390                 randconfig-r044-20230305   gcc  
s390                 randconfig-r044-20230306   clang
s390                 randconfig-r044-20230308   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r012-20230306   gcc  
sparc        buildonly-randconfig-r004-20230306   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230306   gcc  
sparc64              randconfig-r003-20230305   gcc  
sparc64              randconfig-r004-20230305   gcc  
sparc64              randconfig-r021-20230305   gcc  
sparc64              randconfig-r026-20230305   gcc  
sparc64              randconfig-r031-20230305   gcc  
sparc64              randconfig-r034-20230306   gcc  
sparc64              randconfig-r034-20230308   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230306   gcc  
x86_64               randconfig-a002-20230306   gcc  
x86_64               randconfig-a003-20230306   gcc  
x86_64               randconfig-a004-20230306   gcc  
x86_64               randconfig-a005-20230306   gcc  
x86_64               randconfig-a006-20230306   gcc  
x86_64               randconfig-a011-20230306   clang
x86_64                        randconfig-a011   gcc  
x86_64               randconfig-a012-20230306   clang
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230306   clang
x86_64                        randconfig-a013   gcc  
x86_64               randconfig-a014-20230306   clang
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230306   clang
x86_64                        randconfig-a015   gcc  
x86_64               randconfig-a016-20230306   clang
x86_64               randconfig-r001-20230306   gcc  
x86_64               randconfig-r006-20230306   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230305   gcc  
xtensa               randconfig-r003-20230306   gcc  
xtensa               randconfig-r023-20230306   gcc  
xtensa               randconfig-r024-20230306   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
