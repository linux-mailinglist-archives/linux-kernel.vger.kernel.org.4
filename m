Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2326E6FC2B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjEIJZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjEIJZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:25:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BC097
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683624300; x=1715160300;
  h=date:from:to:cc:subject:message-id;
  bh=3o9mhW9pYQGr/a20Uumtltq/A9LwloIb6TbgYcmcoeo=;
  b=QhmQr4XBsiuIkRgDSpr3Gxrtd1Laz2oBM/rKc5lGbEiqWsg+iXLlu9FP
   sQfZFx0nBoHWwGp4vb/QlLBy8D5XVwqxHKWZ6N2btB5IAv46+3iryBeqi
   c2+11C5BQkiFBe9+nObU7GL5a2NGbUnrmfgr+dnr6O/SA0lZN2PeO++1y
   +VHaDcOlNsJJArADFo0p+zB/5Ol5jQ7oo7wr9JCzrKkt57fslwUpLd5sI
   3S3w5xRp5wOUFETUj8zDz9l/eiKY962mHC7bXnGXgTcxJl1uGgYQKh2W7
   1Hsh4H2t6hekurztaNNOZPQkZp4QFz2A/iGihwRJ7XezUtXF04J07eHy8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="352034909"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="352034909"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 02:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="729425630"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="729425630"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 May 2023 02:24:50 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwJaU-00020a-0w;
        Tue, 09 May 2023 09:24:50 +0000
Date:   Tue, 09 May 2023 17:24:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 f9d36cf445ffff0b913ba187a3eff78028f9b1fb
Message-ID: <20230509092434.Y625V%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: f9d36cf445ffff0b913ba187a3eff78028f9b1fb  tick/broadcast: Make broadcast device replacement work correctly

elapsed time: 720m

configs tested: 117
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230507   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230508   gcc  
arm                  randconfig-r023-20230508   clang
arm                  randconfig-r046-20230507   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230508   clang
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r005-20230508   clang
hexagon              randconfig-r031-20230507   clang
hexagon              randconfig-r036-20230508   clang
hexagon              randconfig-r041-20230507   clang
hexagon              randconfig-r045-20230507   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r002-20230508   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230508   gcc  
i386                 randconfig-a012-20230508   gcc  
i386                 randconfig-a013-20230508   gcc  
i386                 randconfig-a014-20230508   gcc  
i386                 randconfig-a015-20230508   gcc  
i386                 randconfig-a016-20230508   gcc  
i386                 randconfig-r035-20230508   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230508   gcc  
ia64         buildonly-randconfig-r004-20230508   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230507   gcc  
ia64                 randconfig-r024-20230508   gcc  
ia64                 randconfig-r026-20230507   gcc  
ia64                 randconfig-r026-20230508   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230507   gcc  
loongarch            randconfig-r022-20230508   gcc  
loongarch            randconfig-r034-20230508   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r024-20230507   gcc  
microblaze           randconfig-r001-20230507   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r034-20230507   clang
nios2                               defconfig   gcc  
nios2                randconfig-r022-20230507   gcc  
nios2                randconfig-r025-20230508   gcc  
nios2                randconfig-r031-20230508   gcc  
openrisc             randconfig-r015-20230507   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230507   gcc  
parisc               randconfig-r014-20230507   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r002-20230508   clang
powerpc              randconfig-r016-20230507   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230507   clang
riscv                randconfig-r021-20230508   gcc  
riscv                randconfig-r035-20230507   gcc  
riscv                randconfig-r042-20230507   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230508   clang
s390                 randconfig-r006-20230508   clang
s390                 randconfig-r032-20230507   gcc  
s390                 randconfig-r044-20230507   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r004-20230507   gcc  
sh                   randconfig-r013-20230507   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r032-20230508   gcc  
sparc                randconfig-r033-20230507   gcc  
sparc64              randconfig-r012-20230507   gcc  
sparc64              randconfig-r036-20230507   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230508   clang
x86_64               randconfig-a002-20230508   clang
x86_64               randconfig-a003-20230508   clang
x86_64               randconfig-a004-20230508   clang
x86_64               randconfig-a005-20230508   clang
x86_64               randconfig-a006-20230508   clang
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-r033-20230508   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r005-20230507   gcc  
xtensa               randconfig-r006-20230507   gcc  
xtensa               randconfig-r023-20230507   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
