Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA03872F297
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjFNCbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjFNCbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:31:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F93918C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686709908; x=1718245908;
  h=date:from:to:cc:subject:message-id;
  bh=/mCroygrd2CfruFO0929CR5tOL/PZMKehKnqlWlyvSU=;
  b=ebRyGcIAO5AAw/uxQx5tQAFdGojJu/wVMDEuFVt9NKR9npDFwprOl2uy
   +FBvqK8vwvNG/FstLjS+chAzTsoX7j6EMpm91HBBV1eHRcdkMBLxIXAln
   mc3SLBRmVRGnnsdoWuYifKvNjUVGNOT62tt4kjTh4JcKHf/yewxnZbQPg
   0sF3M1vw9tOa7BBHeuzmp6sgjBvsw2ashRtJDuWzKoxoB8uGshaA4+4RX
   s9GM5+azrTxbpDKw2FkhztYMPR+vfaFlg/zNnGPxSwzNCgziMAFdpG61f
   r5rrkNzH7tcd2GYivpa6scB5qzKf8AMQGd64RZEThQk3Em34V9I8G3NsD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="386905669"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="386905669"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 19:31:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="777060417"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="777060417"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jun 2023 19:31:47 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9GIU-00001I-0Z;
        Wed, 14 Jun 2023 02:31:46 +0000
Date:   Wed, 14 Jun 2023 10:27:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 a32b0f0db3f396f1c9be2fe621e77c09ec3d8e7d
Message-ID: <202306141043.eBbKe046-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: a32b0f0db3f396f1c9be2fe621e77c09ec3d8e7d  x86/microcode/AMD: Load late on both threads too

elapsed time: 722m

configs tested: 63
configs skipped: 93

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc          buildonly-randconfig-r004-20230612   gcc  
arc                                 defconfig   gcc  
arm                  randconfig-r036-20230612   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r031-20230612   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230612   clang
i386                 randconfig-i002-20230612   clang
i386                 randconfig-i003-20230612   clang
i386                 randconfig-i004-20230612   clang
i386                 randconfig-i005-20230612   clang
i386                 randconfig-i006-20230612   clang
i386                 randconfig-i011-20230612   gcc  
i386                 randconfig-i012-20230612   gcc  
i386                 randconfig-i013-20230612   gcc  
i386                 randconfig-i014-20230612   gcc  
i386                 randconfig-i015-20230612   gcc  
i386                 randconfig-i016-20230612   gcc  
i386                 randconfig-r025-20230612   gcc  
m68k                 randconfig-r033-20230612   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230612   gcc  
openrisc     buildonly-randconfig-r003-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230612   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
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
