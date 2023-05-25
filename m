Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1619B7117DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241180AbjEYUJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241490AbjEYUJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:09:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E5419A
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685045337; x=1716581337;
  h=date:from:to:cc:subject:message-id;
  bh=+0/znEnpTU7ppBio87huH7O5TjnzGIP0isC+eb3jjUk=;
  b=NhAzylgnLRz2TxmzAiKvkPqazHraK7g4eYvlOjl5i9m7Bfjs+yau1DTa
   LYudSwo5Lj8u44g7LEv9D9dzWPrOVUpDzGjeEyoyDrxa09mkMG9B4IMB5
   +EpdLq2CEhgsJtjys2eFecyXTvZPc2ktLuiXpT50YTU8Vr60n08YpyUJf
   8D8RtglbLkinT70U+i6p26v2kxTDEUKS9Rh9QgKSgmokkyt1RjdwZSfwA
   EV1eZZEIzOrGGsCdbJdN+DaXI4dQ667vnNrV3+4lNvLcHKEIhxQMkNb14
   58WvWgSixb5MAlrNtBiLaRxXNyxHwlSl2EhzYt3kNS4JoUUGPol1rPWgx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="417494491"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="417494491"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 13:08:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="794791312"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="794791312"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 May 2023 13:08:55 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2HGY-000Fyt-21;
        Thu, 25 May 2023 20:08:54 +0000
Date:   Fri, 26 May 2023 04:08:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b03fa665901b50468624fb8177d9067698ba8310
Message-ID: <20230525200847.r-NN1%lkp@intel.com>
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
branch HEAD: b03fa665901b50468624fb8177d9067698ba8310  Merge branch into tip/master: 'x86/tdx'

elapsed time: 726m

configs tested: 139
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230524   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230524   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r032-20230524   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230524   clang
arm                  randconfig-r005-20230524   clang
arm                  randconfig-r015-20230524   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230524   gcc  
i386                 randconfig-i002-20230524   gcc  
i386                 randconfig-i003-20230524   gcc  
i386                 randconfig-i004-20230524   gcc  
i386                 randconfig-i005-20230524   gcc  
i386                 randconfig-i006-20230524   gcc  
i386                 randconfig-i011-20230524   clang
i386                 randconfig-i012-20230524   clang
i386                 randconfig-i013-20230524   clang
i386                 randconfig-i014-20230524   clang
i386                 randconfig-i015-20230524   clang
i386                 randconfig-i016-20230524   clang
i386                 randconfig-i051-20230524   gcc  
i386                 randconfig-i052-20230524   gcc  
i386                 randconfig-i053-20230524   gcc  
i386                 randconfig-i054-20230524   gcc  
i386                 randconfig-i061-20230524   gcc  
i386                 randconfig-i062-20230524   gcc  
i386                 randconfig-i063-20230524   gcc  
i386                 randconfig-i064-20230524   gcc  
i386                 randconfig-i065-20230524   gcc  
i386                 randconfig-i066-20230524   gcc  
i386                 randconfig-i071-20230524   clang
i386                 randconfig-i071-20230525   gcc  
i386                 randconfig-i072-20230524   clang
i386                 randconfig-i072-20230525   gcc  
i386                 randconfig-i073-20230524   clang
i386                 randconfig-i073-20230525   gcc  
i386                 randconfig-i074-20230524   clang
i386                 randconfig-i074-20230525   gcc  
i386                 randconfig-i075-20230525   gcc  
i386                 randconfig-i076-20230525   gcc  
i386                 randconfig-i081-20230524   clang
i386                 randconfig-i081-20230525   gcc  
i386                 randconfig-i082-20230524   clang
i386                 randconfig-i082-20230525   gcc  
i386                 randconfig-i083-20230524   clang
i386                 randconfig-i083-20230525   gcc  
i386                 randconfig-i084-20230525   gcc  
i386                 randconfig-i085-20230525   gcc  
i386                 randconfig-i086-20230525   gcc  
i386                 randconfig-i091-20230524   gcc  
i386                 randconfig-i092-20230524   gcc  
i386                 randconfig-i093-20230524   gcc  
i386                 randconfig-i094-20230524   gcc  
ia64         buildonly-randconfig-r005-20230524   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230524   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r014-20230524   gcc  
m68k                 randconfig-r036-20230525   gcc  
microblaze           randconfig-r031-20230525   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r016-20230524   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230524   gcc  
openrisc             randconfig-r036-20230524   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230524   gcc  
parisc               randconfig-r031-20230524   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230524   clang
powerpc              randconfig-r001-20230524   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r025-20230524   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r023-20230524   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230524   gcc  
sparc64      buildonly-randconfig-r003-20230524   gcc  
sparc64              randconfig-r035-20230525   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230524   gcc  
x86_64               randconfig-a002-20230524   gcc  
x86_64               randconfig-a003-20230524   gcc  
x86_64               randconfig-a004-20230524   gcc  
x86_64               randconfig-a005-20230524   gcc  
x86_64               randconfig-a006-20230524   gcc  
x86_64               randconfig-a011-20230525   gcc  
x86_64               randconfig-a012-20230525   gcc  
x86_64               randconfig-a013-20230525   gcc  
x86_64               randconfig-r013-20230524   clang
x86_64               randconfig-x051-20230525   gcc  
x86_64               randconfig-x052-20230525   gcc  
x86_64               randconfig-x053-20230525   gcc  
x86_64               randconfig-x054-20230525   gcc  
x86_64               randconfig-x055-20230525   gcc  
x86_64               randconfig-x056-20230525   gcc  
x86_64               randconfig-x061-20230524   clang
x86_64               randconfig-x062-20230524   clang
x86_64               randconfig-x063-20230524   clang
x86_64               randconfig-x064-20230524   clang
x86_64               randconfig-x065-20230524   clang
x86_64               randconfig-x066-20230524   clang
x86_64               randconfig-x086-20230525   clang
x86_64               randconfig-x091-20230525   gcc  
x86_64               randconfig-x092-20230525   gcc  
x86_64               randconfig-x093-20230525   gcc  
x86_64               randconfig-x094-20230525   gcc  
x86_64               randconfig-x095-20230525   gcc  
x86_64               randconfig-x096-20230525   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230524   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
