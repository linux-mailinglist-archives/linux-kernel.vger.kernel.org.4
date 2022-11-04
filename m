Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A91F61933B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiKDJPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiKDJPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:15:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5D2308
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667553309; x=1699089309;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uEACIUzSPfkFO9m4w1O8m7RrR7tn6rZ5SxVQXOJo6ZY=;
  b=MssLtDbzmANITVaZVRODhhLddDJdsPRMjqiFyOY6RjBuH1aYrPPq/SBK
   gyS+b9Dm+dWl59yf7M+mhegovty6a3IHbfAkQ2zEHWnchZmNi1r0ny/Vr
   PXpmAvXO93lZtM6bhvqGoCF8SnCfK06yIqA1SVIS+FHLX8mhjBzHBP0mA
   vDNOfZC3Vx3IaBhtj7TAs+61fskkLRtBRk3sGzugiAaGn48NWCGx/cshs
   pH9yMNaR/NOuu20zwMG2ZpCzrsvkCr0ki6CEt+ZdlOd8Xp5UC3N4B7Rt6
   zXQEAoVh7+yz5e/OxYQulGPB/sJo2EPbTXwZEasFT6mMmbHr8FBdgSDW0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="290312180"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="290312180"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 02:15:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809999783"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="809999783"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Nov 2022 02:15:07 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqsn5-000GpX-0V;
        Fri, 04 Nov 2022 09:15:07 +0000
Date:   Fri, 04 Nov 2022 17:14:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 3301badde43dee7c2a013fbd6479c258366519da
Message-ID: <6364d7e2.K636rCY8X7i+y27k%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 3301badde43dee7c2a013fbd6479c258366519da  mm: Convert __HAVE_ARCH_P..P_GET to the new style

elapsed time: 724m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                               rhel-8.3
i386                                defconfig
x86_64                              defconfig
m68k                             allmodconfig
arc                  randconfig-r043-20221102
arc                              allyesconfig
s390                 randconfig-r044-20221102
alpha                            allyesconfig
riscv                randconfig-r042-20221102
ia64                             allmodconfig
x86_64                           allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a015
x86_64                        randconfig-a013
i386                          randconfig-a005
x86_64                        randconfig-a011
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
riscv                randconfig-r042-20221104
arc                  randconfig-r043-20221104
s390                 randconfig-r044-20221104
powerpc                     taishan_defconfig
xtensa                  cadence_csp_defconfig
m68k                        m5307c3_defconfig
xtensa                         virt_defconfig
m68k                           sun3_defconfig
arm                        keystone_defconfig
arm                        spear6xx_defconfig
m68k                                defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20221102
hexagon              randconfig-r045-20221102
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
mips                       rbtx49xx_defconfig
arm                       cns3420vb_defconfig
arm                     am200epdkit_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
