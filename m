Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D373B732707
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242078AbjFPGF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241980AbjFPGFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:05:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ACF2D60
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686895516; x=1718431516;
  h=date:from:to:cc:subject:message-id;
  bh=1YpN1wt1IdJI/mKnyNCEsack0RE3rZvHAXzfUqmiBvY=;
  b=d+JPLcEfVDe37kuCn/92k+BSx8kkFee2XusELEDVQD4SGX/z1Yl2fEdG
   lF6A1jw/RSU32kBxlb8VZl3BJOr8N9P3xT3r8OS3Ko7eIaEQfUVwo2fuG
   FN7QW2nZlx95LCmvztcxNf4OOh2aro5Ux3qmp7zKjsICghL0atElObm2a
   pYjZjc7kJERh9H70bNywUKL9+DdlWSnOLt62cg3rHOdh6AaCCaisU/PPA
   mElAyAiqQFQlZdaDEYWCdyG323MhJu7BCuAFLlebIzlR1v66jq/sO21O8
   ggx/O1bZWAD1anbfqI3+eWbLW08BZ8E5ilq4U+kMHcDE0t3YM1X7CzErj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="387786582"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="387786582"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 22:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="742533024"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="742533024"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 15 Jun 2023 22:46:09 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qA2Hh-0000qr-0n;
        Fri, 16 Jun 2023 05:46:09 +0000
Date:   Fri, 16 Jun 2023 13:45:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 2d52a9ced37b1ad1da8dff184d635e30f1e01f4e
Message-ID: <202306161329.7XsoPVn9-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 2d52a9ced37b1ad1da8dff184d635e30f1e01f4e  docs/RCU: Add the missing rcu_read_unlock()

elapsed time: 724m

configs tested: 118
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230614   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r026-20230616   gcc  
arc                  randconfig-r043-20230615   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                             mxs_defconfig   clang
arm                  randconfig-r046-20230615   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230614   clang
arm64        buildonly-randconfig-r005-20230614   clang
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230615   clang
hexagon              randconfig-r045-20230615   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230614   clang
i386                 randconfig-i002-20230614   clang
i386                 randconfig-i003-20230614   clang
i386                 randconfig-i004-20230614   clang
i386                 randconfig-i005-20230614   clang
i386                 randconfig-i006-20230614   clang
i386                 randconfig-i011-20230615   clang
i386                 randconfig-i012-20230615   clang
i386                 randconfig-i013-20230615   clang
i386                 randconfig-i014-20230615   clang
i386                 randconfig-i015-20230615   clang
i386                 randconfig-i016-20230615   clang
i386                 randconfig-r022-20230616   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r014-20230614   gcc  
loongarch            randconfig-r035-20230615   gcc  
loongarch            randconfig-r036-20230615   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230614   gcc  
m68k                 randconfig-r013-20230614   gcc  
microblaze           randconfig-r013-20230614   gcc  
microblaze           randconfig-r034-20230615   gcc  
microblaze           randconfig-r036-20230615   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230614   gcc  
mips                  cavium_octeon_defconfig   clang
mips                           jazz_defconfig   gcc  
mips                        omega2p_defconfig   clang
mips                 randconfig-r025-20230616   clang
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230615   gcc  
nios2                randconfig-r021-20230616   gcc  
openrisc             randconfig-r016-20230614   gcc  
openrisc             randconfig-r031-20230615   gcc  
openrisc             randconfig-r032-20230615   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230615   gcc  
parisc               randconfig-r005-20230615   gcc  
parisc               randconfig-r015-20230614   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     kilauea_defconfig   clang
powerpc              randconfig-r011-20230614   gcc  
powerpc              randconfig-r033-20230615   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230614   gcc  
riscv                randconfig-r031-20230615   gcc  
riscv                randconfig-r042-20230615   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230614   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230615   clang
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r023-20230616   gcc  
sh                   randconfig-r035-20230615   gcc  
sh                           se7751_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230615   gcc  
sparc                randconfig-r033-20230615   gcc  
sparc64              randconfig-r032-20230615   gcc  
um                               alldefconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230615   gcc  
x86_64               randconfig-a002-20230615   gcc  
x86_64               randconfig-a003-20230615   gcc  
x86_64               randconfig-a004-20230615   gcc  
x86_64               randconfig-a005-20230615   gcc  
x86_64               randconfig-a006-20230615   gcc  
x86_64               randconfig-a011-20230615   clang
x86_64               randconfig-a012-20230615   clang
x86_64               randconfig-a013-20230615   clang
x86_64               randconfig-a014-20230615   clang
x86_64               randconfig-a015-20230615   clang
x86_64               randconfig-a016-20230615   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r034-20230615   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
