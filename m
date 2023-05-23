Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC35070CFBD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjEWAqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbjEWAph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:45:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2230A170C
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684801920; x=1716337920;
  h=date:from:to:cc:subject:message-id;
  bh=hs2WTiuVlyp2QMGsNvv9p95UzCTl1Q48k4TU5C0N4lc=;
  b=L/c1wPyXdBqShvLSYCDMRnrlkKNcbbhciA782sXey7Fb1ecbKOTWRZ1K
   QsULVGlQlKLxnLLEAqj5g8Kr3Yim09e6v9lD28ev8t/3a9mZnGqEmyHde
   zhtMCTriojo/RLKujBilvrD8fWgbyqYl9ylpjx0zr2bQWiZc4UiDNoXrM
   ZAlnqhdB1OrMITciziPBZvVPVNUl80Ty6eGXKCYO7g27yfjofMYS2atmN
   O72JiuKkildPge6dUNtVhSKmUOmZq/TihJeOK8H18tGobEW2AnnuN4AkN
   VCZYLboSNGeGvD4vd7xNt+7hK9zwvx/6VJFyVc/Sp9MEMbb8ImVeShI/3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="332694935"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="332694935"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 17:31:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="734544809"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="734544809"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 May 2023 17:31:32 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1Fw4-000DM3-02;
        Tue, 23 May 2023 00:31:32 +0000
Date:   Tue, 23 May 2023 08:30:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:smp/core] BUILD SUCCESS
 6a4be6984595b164b6f281c5b242dbdf1c06d528
Message-ID: <20230523003057.oBSW6%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230522162832/lkp-src/repo/*/tip
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
branch HEAD: 6a4be6984595b164b6f281c5b242dbdf1c06d528  x86/apic: Fix use of X{,2}APIC_ENABLE in asm with older binutils

elapsed time: 728m

configs tested: 73
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
csky                                defconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230522   gcc  
i386                 randconfig-a002-20230522   gcc  
i386                 randconfig-a003-20230522   gcc  
i386                 randconfig-a004-20230522   gcc  
i386                 randconfig-a005-20230522   gcc  
i386                 randconfig-a006-20230522   gcc  
i386                 randconfig-a011-20230522   clang
i386                 randconfig-a012-20230522   clang
i386                 randconfig-a013-20230522   clang
i386                 randconfig-a014-20230522   clang
i386                 randconfig-a015-20230522   clang
i386                 randconfig-a016-20230522   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230522   gcc  
x86_64               randconfig-a002-20230522   gcc  
x86_64               randconfig-a003-20230522   gcc  
x86_64               randconfig-a004-20230522   gcc  
x86_64               randconfig-a005-20230522   gcc  
x86_64               randconfig-a006-20230522   gcc  
x86_64               randconfig-a011-20230522   clang
x86_64               randconfig-a012-20230522   clang
x86_64               randconfig-a013-20230522   clang
x86_64               randconfig-a014-20230522   clang
x86_64               randconfig-a015-20230522   clang
x86_64               randconfig-a016-20230522   clang
x86_64               randconfig-x051-20230522   clang
x86_64               randconfig-x052-20230522   clang
x86_64               randconfig-x053-20230522   clang
x86_64               randconfig-x054-20230522   clang
x86_64               randconfig-x055-20230522   clang
x86_64               randconfig-x056-20230522   clang
x86_64               randconfig-x061-20230522   clang
x86_64               randconfig-x062-20230522   clang
x86_64               randconfig-x063-20230522   clang
x86_64               randconfig-x064-20230522   clang
x86_64               randconfig-x065-20230522   clang
x86_64               randconfig-x066-20230522   clang
x86_64               randconfig-x071-20230522   gcc  
x86_64               randconfig-x072-20230522   gcc  
x86_64               randconfig-x073-20230522   gcc  
x86_64               randconfig-x074-20230522   gcc  
x86_64               randconfig-x075-20230522   gcc  
x86_64               randconfig-x076-20230522   gcc  
x86_64               randconfig-x081-20230522   gcc  
x86_64               randconfig-x082-20230522   gcc  
x86_64               randconfig-x083-20230522   gcc  
x86_64               randconfig-x084-20230522   gcc  
x86_64               randconfig-x085-20230522   gcc  
x86_64               randconfig-x086-20230522   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
