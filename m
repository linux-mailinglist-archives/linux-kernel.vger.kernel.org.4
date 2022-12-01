Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7963FBD4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiLAXRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiLAXRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:17:51 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E066444
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669936669; x=1701472669;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RY9aaLj+Qa+bji5tEbVewZXKW2D/TGq5pRHWrJyqu6E=;
  b=QdWol2rx3WuMu602WmzF9E8xcdHVuTW127Qumyfd4NjXuooVi/ECevUy
   hyCVjbAu5zLm9ON8WUX4ANwFMLv9GDZRt77EL5OdGcgwL5iP+kwauRYon
   BGcPhsAdDCdOpdD58cigyCir7mztWNwpxCIx28mO8cSsQwo8158npWGbV
   PdmzTHARbLxwU99xT2beGDGlLyFnu69WjvEJAJGCzVA3ye2kvdno0LLNl
   Yb99mpxETVPytbT96ML5r2IDxkUeQ6DAZQAbmnKeiU2jman2uuVFVE/BK
   vKEv+GWuYyRHPKJE4zWJFbhT50P6Jzh/k2h/vYvAcEJxzIJRcJhpSLWWA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="377979001"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="377979001"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 15:17:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="787071533"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="787071533"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Dec 2022 15:17:46 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0soM-000D0s-0K;
        Thu, 01 Dec 2022 23:17:46 +0000
Date:   Fri, 02 Dec 2022 07:17:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 d9f15a9de44affe733e34f93bc184945ba277e6d
Message-ID: <638935ff.PYIJrA+BmeF12iN7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: d9f15a9de44affe733e34f93bc184945ba277e6d  Revert "clocksource/drivers/riscv: Events are stopped during CPU suspend"

elapsed time: 727m

configs tested: 47
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
sh                               allmodconfig
s390                             allyesconfig
mips                             allyesconfig
m68k                             allyesconfig
powerpc                          allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
ia64                             allmodconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20221201
s390                 randconfig-r044-20221201
riscv                randconfig-r042-20221201
x86_64                            allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016

clang tested configs:
hexagon              randconfig-r041-20221201
hexagon              randconfig-r045-20221201
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
