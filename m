Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4797272AF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjFGXF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjFGXE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:04:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003581FEA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686179097; x=1717715097;
  h=date:from:to:cc:subject:message-id;
  bh=yYlnBSGOpSnq7CTyiDgIzQMSFfkXsgY10/watWVddzI=;
  b=UXAYQPiFOKbfddRzYAooTIu36hz83E5L4keYMIwx/furp0wGrxj6067+
   3Xn92EkMHY4sYpzpYTlJ69xNbzupN6r7aaHmEHkSqcGngAlnP+oh25TsL
   1/+Lh9xARklHicHEF6xbWoT7ttlNzyVeQQkqqHwsBeBRibRqXL0YrfG6q
   1dnGz8JIPeuXgT4o3lsjap71EEuaCWpi40p6wZMJMKhpp9iy0g/VY0Rep
   3iQuT6G2IxffNN8LFe2eLlMYSn/srATPT5g/InRdrbYTf9PKkJJ/Wyg5m
   uUY17lnJ1CqVsQUGfY/yy3lWZnV3081StzhqfWBTuXqtzrIr5l9YlhrR/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="422979944"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="422979944"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 16:04:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="742877385"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="742877385"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2023 16:04:56 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q72D1-0006zO-2x;
        Wed, 07 Jun 2023 23:04:55 +0000
Date:   Thu, 08 Jun 2023 07:04:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5320c4f88009a3cb2b0174988bf9c337db9bb8fc
Message-ID: <20230607230446.znozd%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 5320c4f88009a3cb2b0174988bf9c337db9bb8fc  Merge x86/cleanups into tip/master

elapsed time: 724m

configs tested: 79
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230607   gcc  
alpha                randconfig-r011-20230607   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230607   clang
csky                                defconfig   gcc  
csky                 randconfig-r003-20230607   gcc  
hexagon      buildonly-randconfig-r001-20230607   clang
hexagon      buildonly-randconfig-r006-20230607   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i011-20230607   gcc  
i386                 randconfig-i012-20230607   gcc  
i386                 randconfig-i013-20230607   gcc  
i386                 randconfig-i014-20230607   gcc  
i386                 randconfig-i015-20230607   gcc  
i386                 randconfig-i016-20230607   gcc  
i386                 randconfig-i051-20230607   clang
i386                 randconfig-i052-20230607   clang
i386                 randconfig-i053-20230607   clang
i386                 randconfig-i054-20230607   clang
i386                 randconfig-i055-20230607   clang
i386                 randconfig-i056-20230607   clang
i386                 randconfig-i061-20230607   clang
i386                 randconfig-i062-20230607   clang
i386                 randconfig-i063-20230607   clang
i386                 randconfig-i064-20230607   clang
i386                 randconfig-i065-20230607   clang
i386                 randconfig-i066-20230607   clang
i386                 randconfig-r014-20230607   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230607   gcc  
loongarch            randconfig-r024-20230607   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230607   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r021-20230607   gcc  
microblaze           randconfig-r023-20230607   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230607   gcc  
nios2                randconfig-r025-20230607   gcc  
openrisc             randconfig-r013-20230607   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r012-20230607   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230607   clang
s390                 randconfig-r022-20230607   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r026-20230607   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r005-20230607   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r005-20230607   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
