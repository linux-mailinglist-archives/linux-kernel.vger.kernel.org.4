Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2811741C7D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 01:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjF1XbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 19:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjF1XbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:31:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DADE19BE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687995063; x=1719531063;
  h=date:from:to:cc:subject:message-id;
  bh=Me+7IXsSb1jmVjIbvQ8gYJJ+sscSI1L83xiUpPvO1Ec=;
  b=kuA+c+v4U8I9jYQpIg8rK9CcRju5pKBRXicWucp8i9QygW5G3ZoiYHqa
   4ND1xbZEHpkhLSfJM62aQrx7+9ZtL4u/oUYFx+/CNkHqSnhiFBnb8+ziG
   biWtbuTsErB0ZzwcwAL0lmcQPcT//gvcXz/uQbj875eFv97l8gulKMQxq
   VN8ba/IJOh/ZEc0U3EPkMpAML2W00eJGZlM0NVF/y9dZfeuEanPVYVmaM
   NG6Y6VQVhEo2O1jjx4kkTaC/Nc9p3f1s0/p+HLs6lA6eQ93iFSGg3rLr5
   TblDaCaokswWVF70mOsRdnMAq2X4S8Yyszu9ldFOVkoKk1Wovdi7baAIo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="342319385"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="342319385"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 16:31:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="963799609"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="963799609"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jun 2023 16:30:59 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEeck-000DaX-1Y;
        Wed, 28 Jun 2023 23:30:58 +0000
Date:   Thu, 29 Jun 2023 07:30:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/urgent] BUILD SUCCESS
 cc592643a3ea1b2231628fb414dee203633a11c0
Message-ID: <202306290724.XmFepRWK-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/urgent
branch HEAD: cc592643a3ea1b2231628fb414dee203633a11c0  objtool: Remove btrfs_assertfail() from the noreturn exceptions list

elapsed time: 726m

configs tested: 112
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230628   gcc  
alpha                randconfig-r036-20230628   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230628   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230628   gcc  
arm                  randconfig-r035-20230628   gcc  
arm                  randconfig-r046-20230628   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230628   gcc  
arm64                randconfig-r023-20230628   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230628   clang
hexagon              randconfig-r045-20230628   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230628   clang
i386         buildonly-randconfig-r005-20230628   clang
i386         buildonly-randconfig-r006-20230628   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230628   clang
i386                 randconfig-i002-20230628   clang
i386                 randconfig-i003-20230628   clang
i386                 randconfig-i004-20230628   clang
i386                 randconfig-i005-20230628   clang
i386                 randconfig-i006-20230628   clang
i386                 randconfig-i011-20230628   gcc  
i386                 randconfig-i012-20230628   gcc  
i386                 randconfig-i013-20230628   gcc  
i386                 randconfig-i014-20230628   gcc  
i386                 randconfig-i015-20230628   gcc  
i386                 randconfig-i016-20230628   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r021-20230628   gcc  
m68k                 randconfig-r034-20230628   gcc  
m68k                           sun3_defconfig   gcc  
m68k                           virt_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r024-20230628   clang
mips                   sb1250_swarm_defconfig   clang
mips                           xway_defconfig   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r026-20230628   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230628   gcc  
parisc               randconfig-r012-20230628   gcc  
parisc               randconfig-r016-20230628   gcc  
parisc               randconfig-r031-20230628   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230628   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230628   clang
s390                 randconfig-r015-20230628   gcc  
s390                 randconfig-r025-20230628   gcc  
s390                 randconfig-r044-20230628   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230628   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r006-20230628   gcc  
sparc                randconfig-r013-20230628   gcc  
sparc64              randconfig-r032-20230628   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230628   clang
x86_64       buildonly-randconfig-r002-20230628   clang
x86_64       buildonly-randconfig-r003-20230628   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r033-20230628   clang
x86_64               randconfig-x001-20230628   gcc  
x86_64               randconfig-x002-20230628   gcc  
x86_64               randconfig-x003-20230628   gcc  
x86_64               randconfig-x004-20230628   gcc  
x86_64               randconfig-x005-20230628   gcc  
x86_64               randconfig-x006-20230628   gcc  
x86_64               randconfig-x011-20230628   clang
x86_64               randconfig-x012-20230628   clang
x86_64               randconfig-x013-20230628   clang
x86_64               randconfig-x014-20230628   clang
x86_64               randconfig-x015-20230628   clang
x86_64               randconfig-x016-20230628   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
