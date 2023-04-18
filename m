Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3C96E6DC3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjDRU5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDRU5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:57:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DC5E53
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681851430; x=1713387430;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6o2vi1uZ+AQ31rMsv8XiqCfgK8Yjqe2N0xhHfnlSPak=;
  b=CVQDwpPhPIiK6VMhiVQLsnQhV1+LEMUJWMsVtnYxwgnjAIxdTeGiymRJ
   99wsFihP531Xp6XuxqWFo+7ZS1G9lBNleLxlsFVyhMendtiKIFi1TA2yQ
   1fWlbwFXLohgQTkfVOj+ZJWpOs2HlkNo1X8RGMdTM4UWhqin/B/fzJuVj
   B6OcIjGoFzcebQHL86PwITPcbjHr4cs+O00eKIs+kCOqB/i6ZFfSaeKJ1
   DJupUEtAQyPeBsgGLnG1igwg0OJwsshQA/NKBEwD/8PwHlP8OcFr4W7Qu
   0oM/UUMCngGZPqX9IwNI3mRfkeWNhU37uISA28pfC2Hgoaaw8E7OBrzcM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="324903005"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="324903005"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 13:57:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="755831890"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="755831890"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 Apr 2023 13:57:09 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1posNw-000e2T-0v;
        Tue, 18 Apr 2023 20:57:08 +0000
Date:   Wed, 19 Apr 2023 04:56:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/entry] BUILD SUCCESS
 8c8fa605f7b8b6df3e6fb280a74cff8d7374a7b7
Message-ID: <643f03fb.zbvhtaKCl64yL+Yy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
branch HEAD: 8c8fa605f7b8b6df3e6fb280a74cff8d7374a7b7  selftest, ptrace: Add selftest for syscall user dispatch config api

elapsed time: 720m

configs tested: 89
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230417   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r005-20230416   clang
arm                                 defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230418   gcc  
csky                                defconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230417   gcc  
ia64         buildonly-randconfig-r005-20230418   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230416   gcc  
ia64                 randconfig-r005-20230418   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r006-20230416   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230418   gcc  
microblaze   buildonly-randconfig-r004-20230418   gcc  
microblaze   buildonly-randconfig-r006-20230418   gcc  
microblaze           randconfig-r001-20230416   gcc  
microblaze           randconfig-r014-20230418   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2        buildonly-randconfig-r001-20230416   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230418   gcc  
openrisc             randconfig-r006-20230416   gcc  
parisc       buildonly-randconfig-r003-20230416   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230418   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230417   clang
powerpc      buildonly-randconfig-r004-20230417   clang
powerpc              randconfig-r002-20230418   clang
powerpc              randconfig-r012-20230418   gcc  
powerpc              randconfig-r013-20230418   gcc  
powerpc              randconfig-r015-20230418   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230418   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230417   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r004-20230416   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230418   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230416   gcc  
sh           buildonly-randconfig-r005-20230417   gcc  
sh                   randconfig-r001-20230418   gcc  
sparc                               defconfig   gcc  
sparc64      buildonly-randconfig-r002-20230417   gcc  
sparc64      buildonly-randconfig-r003-20230418   gcc  
sparc64              randconfig-r004-20230417   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
