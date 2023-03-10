Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCB96B37A2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCJHpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCJHpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:45:00 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F87F6C6B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 23:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678434217; x=1709970217;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=EYsUT3LB5xbwY4fZEYgwByeXNeQyE0pH3kno5ArjuuQ=;
  b=BWKQuES3diejDihFsydOpIJpeMpRvBoSFnicEkxvZYCSXYDZShKrZZXq
   n3hI/QlcJfgKGmaD20ZmmSvQvB2x9Hp2rGuuQWtf8nXq2sOGJXHOneA/T
   BM9N53nbg+Q/oVJp+XX8pMtFi5UHtpiLGU5bIcn5TL2ZjMbw1LrpcDRpR
   BnAqORc/j26/PsVIQuOmDhBpe57UlwAFJpulHd3EqMb4VJyAmnw9y/26g
   NZ5HjKXi0GtX4c0ophjJ1Elr/O8fvwWvk+RzHGvNu3M2XtWmvBWIEvWMv
   XCIwcRrlpjQXVW1lfisl3dvbjhZXVDgsxIq7aURXtSCM1Su8VqDevQonr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="316323713"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="316323713"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 23:43:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="710183217"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="710183217"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Mar 2023 23:43:08 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paXP9-0003ct-2G;
        Fri, 10 Mar 2023 07:43:07 +0000
Date:   Fri, 10 Mar 2023 15:42:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fsfa3] BUILD SUCCESS
 b708fd61b656d15a508359a92dd02ddfa8442a89
Message-ID: <640adf81.ygyTtwE/yumm/pyP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fsfa3
branch HEAD: b708fd61b656d15a508359a92dd02ddfa8442a89  wifi: carl9170: Replace fake flex-arrays with flexible-arrays

elapsed time: 860m

configs tested: 54
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                          tiger_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                 randconfig-r023-20230308   gcc  
mips                 randconfig-r026-20230308   gcc  
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230308   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r021-20230308   gcc  
sh                          rsk7201_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230308   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r025-20230308   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
