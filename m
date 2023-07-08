Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525D974BB25
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 03:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjGHBvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 21:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHBvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 21:51:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D88D2105
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 18:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688781079; x=1720317079;
  h=date:from:to:cc:subject:message-id;
  bh=Gb63cS3qqRcMPnhlP6nrs7YI2tBjuIz8lk8kVOoS5j0=;
  b=URZnslXGH5++80JW6dQ6uiaFxX8AExUwJcB3HB9XLXsnnVLzR6GC5GH7
   AX28uAx6IvkakdxFobYuaP5WX93i++57wdX7raI0/cOijblkwuKHB4TlD
   9Q8k3NdQetxQPD3s0dBLZuU58FIqkfFbn65wqUYX9LnD1VQakfDtIegwf
   x9kjekHJvsPr8vQVd9+mGhjtjui2V+WgE69nzTygytomw+LQgIXfkcLKB
   n+VJLpElWJZkI5zH7fZdF52ycu2QO6+Zda02pWNPEzfNJMRjvTU7dA0pH
   oCPYkeLQd8rU6H78KuleHEk5dD+r9WuqjZaRyQyuuG0mkIMt639pX5QmJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="430083563"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="430083563"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 18:51:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="755383592"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="755383592"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Jul 2023 18:51:17 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHx6T-0002Tu-07;
        Sat, 08 Jul 2023 01:51:17 +0000
Date:   Sat, 08 Jul 2023 09:50:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 b1472a60a584694875a05cf8bcba8bdf0dc1cd3a
Message-ID: <202307080923.tmRVqowl-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: b1472a60a584694875a05cf8bcba8bdf0dc1cd3a  x86/smp: Don't send INIT to boot CPU

elapsed time: 724m

configs tested: 66
configs skipped: 93

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arm                     am200epdkit_defconfig   clang
arm                         axm55xx_defconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                       multi_v4t_defconfig   gcc  
arm                       netwinder_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                            qcom_defconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230707   gcc  
i386         buildonly-randconfig-r005-20230707   gcc  
i386         buildonly-randconfig-r006-20230707   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230707   gcc  
i386                 randconfig-i002-20230707   gcc  
i386                 randconfig-i003-20230707   gcc  
i386                 randconfig-i004-20230707   gcc  
i386                 randconfig-i005-20230707   gcc  
i386                 randconfig-i006-20230707   gcc  
i386                 randconfig-i011-20230707   clang
i386                 randconfig-i012-20230707   clang
i386                 randconfig-i013-20230707   clang
i386                 randconfig-i014-20230707   clang
i386                 randconfig-i015-20230707   clang
i386                 randconfig-i016-20230707   clang
m68k                             alldefconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                        maltaup_defconfig   clang
openrisc                 simple_smp_defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                      cm5200_defconfig   gcc  
powerpc                    mvme5100_defconfig   clang
powerpc                       ppc64_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc                    socrates_defconfig   clang
powerpc                     tqm8540_defconfig   clang
powerpc                     tqm8541_defconfig   gcc  
powerpc                     tqm8560_defconfig   clang
sh                             shx3_defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230707   gcc  
x86_64       buildonly-randconfig-r002-20230707   gcc  
x86_64       buildonly-randconfig-r003-20230707   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r012-20230707   clang
x86_64               randconfig-r021-20230707   clang
x86_64               randconfig-x001-20230707   clang
x86_64               randconfig-x002-20230707   clang
x86_64               randconfig-x003-20230707   clang
x86_64               randconfig-x004-20230707   clang
x86_64               randconfig-x005-20230707   clang
x86_64               randconfig-x006-20230707   clang
x86_64               randconfig-x011-20230707   gcc  
x86_64               randconfig-x012-20230707   gcc  
x86_64               randconfig-x013-20230707   gcc  
x86_64               randconfig-x014-20230707   gcc  
x86_64               randconfig-x015-20230707   gcc  
x86_64               randconfig-x016-20230707   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
