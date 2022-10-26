Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AE060DA4E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 06:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiJZE3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 00:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiJZE3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 00:29:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497921DA50
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 21:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666758579; x=1698294579;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=u9TceKqzHLlhB4IatNBntqkuLY4BzNLYIrl7QjpL5MM=;
  b=apG4FeZNyruS/HzvmL14TrNK+Pyfnduf2Shqp+Heli4Ggq02DYHurwwo
   P94OXR51diXF/OwAFTCSQDqVmhHexzmtvOxf7NP/EEwduTHN4Rd9w8K/I
   NHfHcvG2RmbXTb2PGTnk8Pv8EzAqdZsj+1cIiCDUZ4XfCx0/KRDsG2vfJ
   RG1+f1Tc+0LR4hKB8SrRZ+F8VBLoe/du9CnkLr2ubhWMU91Utb3JeFBMh
   I9BFYyW0cSCmOr/Lui96PM2yyDjUBmP+i61mJnTxXFphzOMx3BQg+E9MV
   dR55B58sdepZsSDDQpS2Zjc7OnYqOw/g+6xxLOThsRluyBwKxOzuwVNty
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="305470893"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="305470893"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 21:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="665155723"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="665155723"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Oct 2022 21:29:37 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onY2q-0006zq-3C;
        Wed, 26 Oct 2022 04:29:36 +0000
Date:   Wed, 26 Oct 2022 12:29:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5eb443db589a4526b2bef750a998ce7f0dc9c87b
Message-ID: <6358b796.Sh4DbMABTb2R+1RQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 5eb443db589a4526b2bef750a998ce7f0dc9c87b  Merge branch into tip/master: 'x86/cache'

elapsed time: 729m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
i386                                defconfig
arc                  randconfig-r043-20221024
x86_64                    rhel-8.3-kselftests
riscv                randconfig-r042-20221024
x86_64                          rhel-8.3-func
arc                  randconfig-r043-20221023
i386                 randconfig-a011-20221024
i386                 randconfig-a014-20221024
i386                             allyesconfig
x86_64                           rhel-8.3-syz
s390                 randconfig-r044-20221024
i386                 randconfig-a013-20221024
s390                                defconfig
i386                 randconfig-a012-20221024
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
s390                             allmodconfig
arm                                 defconfig
x86_64                           rhel-8.3-kvm
i386                 randconfig-a016-20221024
ia64                             allmodconfig
i386                 randconfig-a015-20221024
x86_64                           allyesconfig
x86_64               randconfig-a014-20221024
m68k                             allyesconfig
x86_64               randconfig-a013-20221024
s390                             allyesconfig
x86_64               randconfig-a012-20221024
alpha                            allyesconfig
x86_64               randconfig-a016-20221024
powerpc                           allnoconfig
x86_64               randconfig-a011-20221024
m68k                             allmodconfig
mips                             allyesconfig
arc                              allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20221024
sh                               allmodconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r045-20221023
hexagon              randconfig-r041-20221024
riscv                randconfig-r042-20221023
hexagon              randconfig-r045-20221024
s390                 randconfig-r044-20221023
hexagon              randconfig-r041-20221023
x86_64               randconfig-a001-20221024
x86_64               randconfig-a003-20221024
x86_64               randconfig-a004-20221024
x86_64               randconfig-a002-20221024
i386                 randconfig-a004-20221024
x86_64               randconfig-a005-20221024
i386                 randconfig-a001-20221024
i386                 randconfig-a002-20221024
x86_64               randconfig-a006-20221024
i386                 randconfig-a005-20221024
i386                 randconfig-a003-20221024
i386                 randconfig-a006-20221024

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
