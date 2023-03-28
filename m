Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDE16CCBA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjC1UuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjC1UuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:50:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117151FC3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680036623; x=1711572623;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1yQN01MMu8nDYyPk/YfO0TF9J2sVXs9I/bhDuxlyddc=;
  b=VUQ/Gg4vU+++SWV7LVDZ2q3LQFW0tQYihQyKudbUq+EaDNea6BkXYp6r
   W6sZJ14k1roMPVL7oxH4N4cT1ZL8hkgRajJyQAu8LZe6wKP8KGbPJcPzB
   U3IL77WlZ3n2OH0IggoowU1ZDnsZGN9DfOCOr6SXUqCeqOttrj2jW8QxQ
   UauU/gQWp3ItQ9m/eCJP99swGtZ7eP2Wa4TfBYADKmmkWP0wokuaBmusA
   pyn80AHKq5rgUMjdnNJNEjM3HP86QBzhmn/0zAGMLRvXDH9Vke8bAH0ZC
   LyU+vysRvMwVnTMiIxebXQve+ZMP1675LkaQRxqusChxcDkDbGY2odDoW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="340709556"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="340709556"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 13:50:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="753310928"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="753310928"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Mar 2023 13:50:21 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phGGr-000Itb-0G;
        Tue, 28 Mar 2023 20:50:21 +0000
Date:   Wed, 29 Mar 2023 04:49:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/rcuref] BUILD SUCCESS
 ee1ee6db07795d9637bc5e8993a8ddcf886541ef
Message-ID: <642352e1.qJgsZCZY1TcYgIUX%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/rcuref
branch HEAD: ee1ee6db07795d9637bc5e8993a8ddcf886541ef  atomics: Provide rcuref - scalable reference counting

elapsed time: 725m

configs tested: 132
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230327   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230328   gcc  
alpha                randconfig-r021-20230327   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230328   gcc  
arc                  randconfig-r012-20230326   gcc  
arc                  randconfig-r022-20230326   gcc  
arc                  randconfig-r034-20230327   gcc  
arc                  randconfig-r043-20230326   gcc  
arc                  randconfig-r043-20230327   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r024-20230326   clang
arm                  randconfig-r031-20230327   clang
arm                  randconfig-r046-20230326   clang
arm                  randconfig-r046-20230327   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230327   clang
arm64                randconfig-r026-20230326   gcc  
csky         buildonly-randconfig-r001-20230327   gcc  
csky         buildonly-randconfig-r003-20230326   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r026-20230326   gcc  
csky                 randconfig-r034-20230326   gcc  
hexagon      buildonly-randconfig-r002-20230327   clang
hexagon      buildonly-randconfig-r004-20230326   clang
hexagon              randconfig-r013-20230327   clang
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
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r022-20230327   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230327   gcc  
loongarch            randconfig-r023-20230327   gcc  
loongarch            randconfig-r026-20230327   gcc  
loongarch            randconfig-r032-20230326   gcc  
loongarch            randconfig-r033-20230327   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r022-20230326   gcc  
m68k                 randconfig-r031-20230326   gcc  
microblaze           randconfig-r002-20230328   gcc  
microblaze           randconfig-r016-20230327   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r021-20230326   clang
mips                 randconfig-r022-20230327   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r015-20230327   gcc  
nios2                randconfig-r023-20230326   gcc  
openrisc             randconfig-r006-20230328   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230326   gcc  
parisc               randconfig-r024-20230327   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r036-20230327   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230326   gcc  
riscv                randconfig-r042-20230327   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230326   gcc  
s390         buildonly-randconfig-r006-20230327   clang
s390                                defconfig   gcc  
s390                 randconfig-r015-20230326   gcc  
s390                 randconfig-r024-20230327   clang
s390                 randconfig-r044-20230326   gcc  
s390                 randconfig-r044-20230327   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230326   gcc  
sh                   randconfig-r011-20230327   gcc  
sh                   randconfig-r025-20230327   gcc  
sparc        buildonly-randconfig-r003-20230327   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230326   gcc  
sparc64              randconfig-r001-20230328   gcc  
sparc64              randconfig-r004-20230328   gcc  
sparc64              randconfig-r025-20230326   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r005-20230327   gcc  
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
x86_64               randconfig-r014-20230327   clang
x86_64               randconfig-r035-20230327   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
