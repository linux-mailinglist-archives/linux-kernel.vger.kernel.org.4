Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D54D655107
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiLWNbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbiLWNbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:31:15 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FAD3A8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671802274; x=1703338274;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ngykTVsE8CFbGilkwa2V+I8l0ISS6phUvTehAW/eK78=;
  b=NZqYty7027OwiLvDZq86uszP3Q0Ogt40irB/JiW3n/HWf1EO5UkNz2tK
   nx7zYeTyO6aPYx87+Xt4uxFIdF6w/SuNIx9Igh1eWQ+AQl43+/toYtre7
   8mIDyzq9FH3HRoxu2Qi5bxb0/W53IvJx686OLumI7jgBGlrMU4fj9TQey
   DEf7QWJGVshSpvAWNB+/sCTKMRqv50dayK+IhHVneVaSnKWfUIQ+QoSrW
   JtSIGd+qC9O3sQ+UrNI721A/KA3KA+i+kCiPJTf5+JWFFWGpCifLee9Rt
   1oG1rB9Colr76EN7HS2NpHYICr8S0ciPdf7gZ46plZr/QPxf3w92/ZVfJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10570"; a="347488633"
X-IronPort-AV: E=Sophos;i="5.96,268,1665471600"; 
   d="scan'208";a="347488633"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2022 05:31:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10570"; a="720646561"
X-IronPort-AV: E=Sophos;i="5.96,268,1665471600"; 
   d="scan'208";a="720646561"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Dec 2022 05:31:13 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p8i8m-000ChD-2f;
        Fri, 23 Dec 2022 13:31:12 +0000
Date:   Fri, 23 Dec 2022 21:30:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:waiman-clocksource.2022.12.22a] BUILD SUCCESS
 375e65d3055f9b379e5fbd449e69752cb69b4e19
Message-ID: <63a5ad7b.yt/JsYin2sOEc4f8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git waiman-clocksource.2022.12.22a
branch HEAD: 375e65d3055f9b379e5fbd449e69752cb69b4e19  clocksource: Limit the number of watchdogged clocksources

elapsed time: 768m

configs tested: 70
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
um                           x86_64_defconfig
um                             i386_defconfig
alpha                               defconfig
powerpc                           allnoconfig
riscv                randconfig-r042-20221218
x86_64               randconfig-a002-20221219
i386                 randconfig-a003-20221219
x86_64               randconfig-a001-20221219
i386                 randconfig-a002-20221219
x86_64               randconfig-a004-20221219
i386                 randconfig-a006-20221219
i386                 randconfig-a005-20221219
arc                  randconfig-r043-20221219
x86_64               randconfig-a006-20221219
i386                 randconfig-a004-20221219
arm                  randconfig-r046-20221219
ia64                             allmodconfig
i386                 randconfig-a001-20221219
x86_64               randconfig-a005-20221219
x86_64                              defconfig
i386                                defconfig
sh                               allmodconfig
arc                  randconfig-r043-20221218
s390                             allmodconfig
s390                 randconfig-r044-20221218
x86_64               randconfig-a003-20221219
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
m68k                             allyesconfig
x86_64                        randconfig-a013
m68k                             allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a011
arc                              allyesconfig
s390                                defconfig
alpha                            allyesconfig
arm                                 defconfig
x86_64                        randconfig-a015
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
s390                             allyesconfig
x86_64                          rhel-8.3-func
arm64                            allyesconfig
i386                             allyesconfig
arm                              allyesconfig
powerpc                          allmodconfig

clang tested configs:
arm                  randconfig-r046-20221218
hexagon              randconfig-r041-20221218
hexagon              randconfig-r045-20221219
s390                 randconfig-r044-20221219
hexagon              randconfig-r041-20221219
hexagon              randconfig-r045-20221218
i386                 randconfig-a011-20221219
i386                 randconfig-a014-20221219
i386                 randconfig-a012-20221219
riscv                randconfig-r042-20221219
i386                 randconfig-a013-20221219
i386                 randconfig-a015-20221219
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                 randconfig-a016-20221219
x86_64                        randconfig-a016
x86_64                          rhel-8.3-rust
x86_64               randconfig-a011-20221219
x86_64               randconfig-a012-20221219
x86_64               randconfig-a014-20221219

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
