Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5C5749105
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 00:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjGEWiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 18:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjGEWiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 18:38:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E4B1737
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 15:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688596689; x=1720132689;
  h=date:from:to:cc:subject:message-id;
  bh=CIsgsL0/hJjrrJ2Yua+MH3i9GBe5Xut3f1UNTXC9k4Y=;
  b=NRWiolfJNciYFjV6nJWuoG/BbujM5aOpmNmNMiVxpuzPLWRhFgrodPbo
   aK3SYkAMaITO3DJ/SEYopGXeyQsU7RLmdU5E9KbKMxbI8H87nR/6P5cxm
   oW7jAaT4DTX//ic4OGM51UB4cdBZrvHsNE0tl5UYwGE4EocVND3fu7mhN
   MqFcMKaHm4U4wPhhWimyayDq2j/5zMHYg1xAkizB2dpxWLtes0WiMbyDU
   F1cLYZRKBnZu8fnjwAHsPQpS8JdSTdbtKRC9akM1RIIkATKiuy+hHPXVQ
   9UNBz2RGYOUWciwIstouza/SFQyJB4xqfQ/IFk9YrC6iAPjLDbI4LCIR6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="427139641"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="427139641"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 15:38:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="863883437"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="863883437"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2023 15:38:07 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHB8Q-0000rO-2g;
        Wed, 05 Jul 2023 22:38:06 +0000
Date:   Thu, 06 Jul 2023 06:37:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 fe3e0a13e597c1c8617814bf9b42ab732db5c26e
Message-ID: <202307060626.FTV3vOGG-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: fe3e0a13e597c1c8617814bf9b42ab732db5c26e  x86/xen: Fix secondary processors' FPU initialization

elapsed time: 721m

configs tested: 65
configs skipped: 91

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                     nsimosci_hs_defconfig   gcc  
arm                              allyesconfig   gcc  
arm                          collie_defconfig   clang
arm                                 defconfig   clang
arm                       imx_v4_v5_defconfig   clang
arm                   milbeaut_m10v_defconfig   clang
arm                         mv78xx0_defconfig   clang
arm                         s5pv210_defconfig   clang
arm                           sama7_defconfig   clang
arm                         socfpga_defconfig   clang
arm                    vt8500_v6_v7_defconfig   clang
i386                             alldefconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230705   gcc  
i386         buildonly-randconfig-r005-20230705   gcc  
i386         buildonly-randconfig-r006-20230705   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230705   gcc  
i386                 randconfig-i002-20230705   gcc  
i386                 randconfig-i003-20230705   gcc  
i386                 randconfig-i004-20230705   gcc  
i386                 randconfig-i005-20230705   gcc  
i386                 randconfig-i006-20230705   gcc  
i386                 randconfig-i011-20230705   clang
i386                 randconfig-i012-20230705   clang
i386                 randconfig-i013-20230705   clang
i386                 randconfig-i014-20230705   clang
i386                 randconfig-i015-20230705   clang
i386                 randconfig-i016-20230705   clang
m68k                        m5272c3_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
mips                     cu1000-neo_defconfig   clang
mips                          malta_defconfig   clang
powerpc                          g5_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                      ppc44x_defconfig   clang
powerpc                      ppc64e_defconfig   clang
powerpc                 xes_mpc85xx_defconfig   clang
riscv                    nommu_virt_defconfig   clang
s390                             allmodconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230705   gcc  
x86_64       buildonly-randconfig-r002-20230705   gcc  
x86_64       buildonly-randconfig-r003-20230705   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r024-20230705   clang
x86_64               randconfig-x001-20230705   clang
x86_64               randconfig-x002-20230705   clang
x86_64               randconfig-x003-20230705   clang
x86_64               randconfig-x004-20230705   clang
x86_64               randconfig-x005-20230705   clang
x86_64               randconfig-x006-20230705   clang
x86_64               randconfig-x011-20230705   gcc  
x86_64               randconfig-x012-20230705   gcc  
x86_64               randconfig-x013-20230705   gcc  
x86_64               randconfig-x014-20230705   gcc  
x86_64               randconfig-x015-20230705   gcc  
x86_64               randconfig-x016-20230705   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
