Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010B36B1E64
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjCIIjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCIIij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:38:39 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D035E23119
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678351042; x=1709887042;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ewSu2KUf7OS3nApUnBsxMeXxYIQPTQSE29OMzU3yg9I=;
  b=fQL/d3zSyi1CBl+Kx4VMnwldWouV1oVaavYgGJz5jxleRnfq8/DfVOo3
   jqr6e8De/x0xlYIKved9toiIISZlz+CXRbiL7JX4OpXLUyjozSIPAzFeV
   aWGfpYrDIwM4QS6KuPJvPTQcrMhzVl3Ge7b6gq1q2cU0DT/7rvT4lA4oP
   GefVms3K4V4fTJQD4dPimxh5mb1UujJ9fnZgQI95GgD2yFHmCIh0c21Tl
   5GGZt4HPdwu8tEcAESl7jEX2cquN76+ZFgjRukG0HasbplDJ5T6u6RVNR
   qF9jMGEZLQSYToBwMVP55pxB5qJGZ4S02w6MbX+UZZgyhC8r8hK6nYplL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="316048384"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="316048384"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="741474188"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="741474188"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Mar 2023 00:37:17 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paBm0-0002o1-0R;
        Thu, 09 Mar 2023 08:37:16 +0000
Date:   Thu, 09 Mar 2023 16:36:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 3898e7642316732e23716ca902f9d122736f9805
Message-ID: <64099a90.1snG7cP6JXOk9HBB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 3898e7642316732e23716ca902f9d122736f9805  Revert "rcu/kvfree: Eliminate k[v]free_rcu() single argument macro"

elapsed time: 742m

configs tested: 101
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230308   gcc  
alpha        buildonly-randconfig-r005-20230308   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230308   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230308   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r012-20230308   gcc  
arm                  randconfig-r024-20230308   gcc  
arm                  randconfig-r046-20230308   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230308   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230309   clang
arm64                randconfig-r013-20230308   clang
arm64                randconfig-r035-20230308   gcc  
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r003-20230308   clang
hexagon              randconfig-r033-20230308   clang
hexagon              randconfig-r041-20230308   clang
hexagon              randconfig-r045-20230308   clang
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
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r022-20230308   gcc  
loongarch            randconfig-r036-20230308   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230309   gcc  
microblaze   buildonly-randconfig-r006-20230308   gcc  
microblaze           randconfig-r002-20230309   gcc  
microblaze           randconfig-r021-20230308   gcc  
microblaze           randconfig-r034-20230308   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r001-20230309   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230308   gcc  
nios2                randconfig-r016-20230308   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r026-20230308   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230308   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230308   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r031-20230308   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r025-20230308   gcc  
sparc                randconfig-r032-20230308   gcc  
sparc64              randconfig-r004-20230309   gcc  
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
xtensa       buildonly-randconfig-r001-20230308   gcc  
xtensa               randconfig-r015-20230308   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
