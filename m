Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C29471010B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbjEXWgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237763AbjEXWgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:36:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459B91B4
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684967791; x=1716503791;
  h=date:from:to:cc:subject:message-id;
  bh=8Q7P0hpP9ZPzOudqJgzW32QAEujLsjP7P2A5fBXPbEA=;
  b=OxccnFGT45O3Ww0sTYP7C016T5Icr6kzjUegXv4thKf0DC1Mu52lPmwh
   8Z/1QUlp+QEqcrMldToPTfURZnzPqZCXul7n0VFxHcekC5CfjE1JTPeBY
   tejMatdoy2Q1sMqEbMKNEseMmQ342R4+Gx3ndje2ScOKpOUbOSGsgeF27
   1F9hC1EtOINzmYJLa5AhlZDj3ucsH1qRFVmV9GUAXT3cW2jBok27JUxES
   Fi4qs1UCoWJikHP3uziy7ozrHINSPXaFmDXXqCBlArQSPyAXrry0Gnktg
   7B0XRB4UKU9NXYHpsln64IlS2x5xlM++oWlRpmeCjeeuESJoVNxi2xtd0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="381956965"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="381956965"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 15:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="794369744"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="794369744"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 May 2023 15:36:23 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1x5i-000FCz-23;
        Wed, 24 May 2023 22:36:22 +0000
Date:   Thu, 25 May 2023 06:35:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 4c8a49244c6abc5fb829d81abaaf2435ad2a44bf
Message-ID: <20230524223538.2wq4O%lkp@intel.com>
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

tree/branch: INFO setup_repo_specs: /db/releases/20230524230549/lkp-src/repo/*/tip
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 4c8a49244c6abc5fb829d81abaaf2435ad2a44bf  bcache: Convert to lock_cmp_fn

elapsed time: 725m

configs tested: 153
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230524   gcc  
alpha                randconfig-r005-20230524   gcc  
alpha                randconfig-r016-20230524   gcc  
alpha                randconfig-r034-20230524   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r012-20230524   gcc  
arc                  randconfig-r043-20230524   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r031-20230524   clang
arm                  randconfig-r046-20230524   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230524   gcc  
arm64                randconfig-r032-20230524   gcc  
csky         buildonly-randconfig-r003-20230524   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230524   gcc  
hexagon              randconfig-r024-20230524   clang
hexagon              randconfig-r041-20230524   clang
hexagon              randconfig-r045-20230524   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r001-20230524   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i051-20230524   gcc  
i386                 randconfig-i052-20230524   gcc  
i386                 randconfig-i053-20230524   gcc  
i386                 randconfig-i054-20230524   gcc  
i386                 randconfig-i055-20230524   gcc  
i386                 randconfig-i056-20230524   gcc  
i386                 randconfig-i061-20230525   clang
i386                 randconfig-i062-20230525   clang
i386                 randconfig-i063-20230525   clang
i386                 randconfig-i064-20230525   clang
i386                 randconfig-i065-20230525   clang
i386                 randconfig-i066-20230525   clang
i386                 randconfig-i071-20230524   clang
i386                 randconfig-i072-20230524   clang
i386                 randconfig-i073-20230524   clang
i386                 randconfig-i074-20230524   clang
i386                 randconfig-i075-20230524   clang
i386                 randconfig-i076-20230524   clang
i386                 randconfig-i081-20230524   clang
i386                 randconfig-i082-20230524   clang
i386                 randconfig-i083-20230524   clang
i386                 randconfig-i084-20230524   clang
i386                 randconfig-i085-20230524   clang
i386                 randconfig-i086-20230524   clang
i386                 randconfig-i091-20230524   gcc  
i386                 randconfig-i092-20230524   gcc  
i386                 randconfig-i093-20230524   gcc  
i386                 randconfig-i094-20230524   gcc  
i386                 randconfig-i095-20230524   gcc  
i386                 randconfig-i096-20230524   gcc  
i386                 randconfig-r011-20230524   clang
i386                 randconfig-r015-20230524   clang
i386                 randconfig-r026-20230524   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230524   gcc  
ia64                 randconfig-r002-20230524   gcc  
ia64                 randconfig-r035-20230524   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r006-20230524   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230524   gcc  
loongarch            randconfig-r036-20230524   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r014-20230524   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r025-20230524   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r033-20230524   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230524   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230524   clang
s390                                defconfig   gcc  
s390                 randconfig-r044-20230524   clang
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r004-20230524   gcc  
sparc64              randconfig-r006-20230524   gcc  
sparc64              randconfig-r013-20230524   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r002-20230524   gcc  
x86_64       buildonly-randconfig-r004-20230524   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230524   gcc  
x86_64               randconfig-a002-20230524   gcc  
x86_64               randconfig-a003-20230524   gcc  
x86_64               randconfig-a004-20230524   gcc  
x86_64               randconfig-a005-20230524   gcc  
x86_64               randconfig-a006-20230524   gcc  
x86_64               randconfig-a011-20230524   clang
x86_64               randconfig-a012-20230524   clang
x86_64               randconfig-a013-20230524   clang
x86_64               randconfig-a014-20230524   clang
x86_64               randconfig-a015-20230524   clang
x86_64               randconfig-a016-20230524   clang
x86_64               randconfig-x051-20230524   clang
x86_64               randconfig-x052-20230524   clang
x86_64               randconfig-x053-20230524   clang
x86_64               randconfig-x054-20230524   clang
x86_64               randconfig-x055-20230524   clang
x86_64               randconfig-x056-20230524   clang
x86_64               randconfig-x061-20230524   clang
x86_64               randconfig-x062-20230524   clang
x86_64               randconfig-x063-20230524   clang
x86_64               randconfig-x064-20230524   clang
x86_64               randconfig-x065-20230524   clang
x86_64               randconfig-x066-20230524   clang
x86_64               randconfig-x071-20230524   gcc  
x86_64               randconfig-x072-20230524   gcc  
x86_64               randconfig-x073-20230524   gcc  
x86_64               randconfig-x074-20230524   gcc  
x86_64               randconfig-x075-20230524   gcc  
x86_64               randconfig-x076-20230524   gcc  
x86_64               randconfig-x081-20230524   gcc  
x86_64               randconfig-x082-20230524   gcc  
x86_64               randconfig-x083-20230524   gcc  
x86_64               randconfig-x084-20230524   gcc  
x86_64               randconfig-x085-20230524   gcc  
x86_64               randconfig-x086-20230524   gcc  
x86_64               randconfig-x091-20230524   clang
x86_64               randconfig-x092-20230524   clang
x86_64               randconfig-x093-20230524   clang
x86_64               randconfig-x094-20230524   clang
x86_64               randconfig-x095-20230524   clang
x86_64               randconfig-x096-20230524   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r021-20230524   gcc  
xtensa               randconfig-r022-20230524   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
