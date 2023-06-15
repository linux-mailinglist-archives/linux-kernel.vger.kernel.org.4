Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F29730E67
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 06:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242822AbjFOEub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 00:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238310AbjFOEuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:50:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7192684
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 21:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686804619; x=1718340619;
  h=date:from:to:cc:subject:message-id;
  bh=G/QN5w2IFYqQOKnVxfMAPNV5WcBGeTazLU5Tly08aK4=;
  b=FvLGe1JlNCHditaGnEtUQGCLE041huknpZKiuSUQUA5fBalmCLkOEDRB
   daUogeS9nAxWv0aSqQLRweFxApMe8A0MVycAKQTrXlQyOy0Swe8gz3dXc
   QCKmhLCkzxk3MHfVfau4SDw0ns9kxT4yDErGikHjiBVvV8K1XE38C+vIc
   iAYrkharxPiSNKkE4460/68wLjWDjTMgkMTFsxd51GNChjPnnkA7DOS/f
   lU3Iz34dXJISIfN5V4ZREwTDThv7Okv9zKFlQ9e0QL4inRtt2AP6DF9PN
   G9fW63EhygVDNPce0anzW0KIy1ZK/TcGnctvl8mI96r5tXBoWKhuY1pVE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="361290135"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="361290135"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 21:50:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="689647145"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="689647145"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Jun 2023 21:50:17 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9ew5-0001SV-02;
        Thu, 15 Jun 2023 04:50:17 +0000
Date:   Thu, 15 Jun 2023 12:49:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.06.09b] BUILD SUCCESS
 9f16f9ce86f44a485791469eca26c4b89996d0dd
Message-ID: <202306151248.1pGaMN5Z-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.06.09b
branch HEAD: 9f16f9ce86f44a485791469eca26c4b89996d0dd  torture: Add RCU Tasks individual-flavor build tests

elapsed time: 729m

configs tested: 101
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230612   gcc  
alpha                randconfig-r022-20230612   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230612   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230612   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r036-20230612   clang
csky                                defconfig   gcc  
csky                 randconfig-r012-20230614   gcc  
csky                 randconfig-r034-20230612   gcc  
hexagon              randconfig-r031-20230612   clang
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r045-20230612   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230614   clang
i386                 randconfig-i002-20230614   clang
i386                 randconfig-i003-20230614   clang
i386                 randconfig-i004-20230614   clang
i386                 randconfig-i005-20230614   clang
i386                 randconfig-i006-20230614   clang
i386                 randconfig-i011-20230614   gcc  
i386                 randconfig-i012-20230614   gcc  
i386                 randconfig-i013-20230614   gcc  
i386                 randconfig-i014-20230614   gcc  
i386                 randconfig-i015-20230614   gcc  
i386                 randconfig-i016-20230614   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230612   gcc  
loongarch            randconfig-r005-20230612   gcc  
loongarch            randconfig-r014-20230614   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r002-20230614   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r016-20230614   clang
mips                 randconfig-r021-20230612   clang
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230612   gcc  
nios2                randconfig-r032-20230612   gcc  
openrisc     buildonly-randconfig-r006-20230614   gcc  
openrisc             randconfig-r024-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r004-20230614   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r035-20230612   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230614   gcc  
powerpc      buildonly-randconfig-r005-20230614   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230614   gcc  
riscv                randconfig-r033-20230612   clang
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230612   clang
s390                 randconfig-r011-20230614   gcc  
s390                 randconfig-r025-20230612   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230612   clang
x86_64               randconfig-a002-20230612   clang
x86_64               randconfig-a003-20230612   clang
x86_64               randconfig-a004-20230612   clang
x86_64               randconfig-a005-20230612   clang
x86_64               randconfig-a006-20230612   clang
x86_64               randconfig-a011-20230612   gcc  
x86_64               randconfig-a012-20230612   gcc  
x86_64               randconfig-a013-20230612   gcc  
x86_64               randconfig-a014-20230612   gcc  
x86_64               randconfig-a015-20230612   gcc  
x86_64               randconfig-a016-20230612   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
