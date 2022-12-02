Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B8763FD36
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiLBAmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiLBAmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:42:52 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFEC1054A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669941770; x=1701477770;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1gyooS8NMgCA9iz2ZB9RZ7mYRyLhZr9DIgyBY+JnUUY=;
  b=ARX+WzGKNPGB8BwiVMrXlPTH4ieV7C+cSo/tS/KBeRT6hh9fPLuKIaiC
   vQ92lv1ufWVcQ6ewBzlTTv73Yd8jFK4xuOut4yxtaNw2iCea8C7rP/w/r
   7TAz25b56NgSBwL2UUkbXcLhDHvszXzxivxgiBO1G1wAbhUhWwb3MgVZI
   UYwBaGcZAw9dwMMv3gzIWsShByKYMvplW/lsZ0lqPDOL37No7bLP2uY8x
   Hq4+L+DIc7qJEgdOrrwElfif3roAYBOEeCTSayUqyjRT/R77pJDujWqcG
   DS7j2xbq+NUOJVzPdN8TwN1HbANCOR5M4tilyOrMTl1crsKrXpraE/6uE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="315861905"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="315861905"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 16:42:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="751043640"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="751043640"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 01 Dec 2022 16:42:48 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0u8d-000D48-3C;
        Fri, 02 Dec 2022 00:42:47 +0000
Date:   Fri, 02 Dec 2022 08:42:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 ebe11732838f39bd10bddafd4dfe2f97010fde62
Message-ID: <638949e6.78lArWQnIZBV2z/R%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: ebe11732838f39bd10bddafd4dfe2f97010fde62  clockevents: Repair kernel-doc for clockevent_delta2ns()

elapsed time: 722m

configs tested: 50
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allmodconfig
s390                                defconfig
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-kvm
sh                               allmodconfig
mips                             allyesconfig
s390                             allyesconfig
powerpc                          allmodconfig
x86_64                              defconfig
m68k                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                               rhel-8.3
ia64                             allmodconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20221201
x86_64                        randconfig-a013
s390                 randconfig-r044-20221201
x86_64                        randconfig-a011
x86_64                        randconfig-a015
riscv                randconfig-r042-20221201
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                            allnoconfig
i386                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016

clang tested configs:
hexagon              randconfig-r041-20221201
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
hexagon              randconfig-r045-20221201
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
