Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0586DF185
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjDLKEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjDLKEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:04:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA0F7A98
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681293847; x=1712829847;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ieWfO7f4oLzk/CdBv1gNk/OWNX4qhiJGp7zB/jVoAYg=;
  b=mAdxYxO/aS6f5WZnvtb/ug/gPPL6tlVO4ZomISWFk8xLbQiG+ovEtggF
   nSld9RBt3VgXK1GAneewpYBY8m/hd2vYaZPMrsOXGbXdQDXIQOOvgQFs/
   0k7u7HhgiFXPbn1XxfqfdUSEFjvpajKCMpWefiDgYD8eVD+u7iki926XH
   oQBY10K/h94C6TJjhw/EoeqRXD/5I1AzmHJP3Mi6HMk38LiLaZ+eb83rS
   WbE96RqOVoqout4fkjd0nOgkZYR9D1Ab81qU5b6DprGzSG9cQf50mgf7W
   nzCam+KqKBCCpSFIaltutZORudoqBYYlNRtCGmPw49ZQNu3zCfMtL3i+c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="430138209"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="430138209"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 03:04:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="863243754"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="863243754"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Apr 2023 03:04:06 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmXKf-000Xbv-0i;
        Wed, 12 Apr 2023 10:04:05 +0000
Date:   Wed, 12 Apr 2023 18:03:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 ceff5af3c8ded94573d6b0b88c5c3100ee7e0845
Message-ID: <643681f4.xH2NP6TJWGFvxmlh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: ceff5af3c8ded94573d6b0b88c5c3100ee7e0845  Revert "rcu/kvfree: Eliminate k[v]free_rcu() single argument macro"

elapsed time: 728m

configs tested: 93
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230409   gcc  
alpha        buildonly-randconfig-r006-20230410   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230410   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r035-20230409   clang
csky                                defconfig   gcc  
hexagon              randconfig-r033-20230409   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-r036-20230410   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230409   gcc  
ia64                 randconfig-r024-20230410   gcc  
ia64                 randconfig-r025-20230409   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230409   gcc  
loongarch            randconfig-r021-20230410   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r002-20230409   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230410   gcc  
mips                 randconfig-r005-20230410   gcc  
nios2                               defconfig   gcc  
parisc       buildonly-randconfig-r003-20230409   gcc  
parisc       buildonly-randconfig-r004-20230409   gcc  
parisc       buildonly-randconfig-r004-20230410   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230410   gcc  
parisc               randconfig-r022-20230409   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230410   gcc  
powerpc              randconfig-r034-20230409   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230409   gcc  
riscv        buildonly-randconfig-r005-20230410   gcc  
riscv        buildonly-randconfig-r006-20230409   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r023-20230409   gcc  
s390                 randconfig-r033-20230410   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230409   gcc  
sh                   randconfig-r023-20230410   gcc  
sh                   randconfig-r026-20230409   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r003-20230409   gcc  
sparc64              randconfig-r021-20230409   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230410   clang
x86_64               randconfig-a002-20230410   clang
x86_64               randconfig-a003-20230410   clang
x86_64               randconfig-a004-20230410   clang
x86_64               randconfig-a005-20230410   clang
x86_64               randconfig-a006-20230410   clang
x86_64                        randconfig-k001   clang
x86_64               randconfig-r025-20230410   gcc  
x86_64               randconfig-r034-20230410   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
