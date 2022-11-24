Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C2A63809F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 22:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKXV0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 16:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXV0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 16:26:52 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F17112A83
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 13:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669325212; x=1700861212;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wSzl18jZmy2kTfMUnK1/pP4EHKtYFXZLhyIIQSy7NWc=;
  b=lZ4rYi3NyiTOUr+JusupL+iMw/a6dlwy45GarSR/J6PvhXuA0GLxITIX
   1p5bI+wfvBTGJp9JMUn2uBZzfL6qqYb/mil3Du7T752W429c+P12W8VO3
   4v3GYQ9tosExJaL6/gv5FJwy5c6vsvBEbAmHi9oGPxWjx+bmgFvlG6lRt
   NjdJWzNf3vH6xEdGN0uPtuVNIZii74A0sg8Lg9F0yYYG/leBoNoUO0jdS
   3ptuwrmdkoCWVRAPG9Vx6s2HB9Mp13D43m0Mb/NogSj7eXeQ+DA6NgUio
   d3u6rEs1eXC73wXsOhQ+cWITjqBQagO7HKUzj/2eRhdffig511tka2hw6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="312004173"
X-IronPort-AV: E=Sophos;i="5.96,191,1665471600"; 
   d="scan'208";a="312004173"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 13:26:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="748363128"
X-IronPort-AV: E=Sophos;i="5.96,191,1665471600"; 
   d="scan'208";a="748363128"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Nov 2022 13:26:38 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oyJjx-0004Gz-21;
        Thu, 24 Nov 2022 21:26:37 +0000
Date:   Fri, 25 Nov 2022 05:26:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 030a976efae83f7b6593afb11a8254d42f9290fe
Message-ID: <637fe185.MMBaqfQrA30EXIQJ%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/urgent
branch HEAD: 030a976efae83f7b6593afb11a8254d42f9290fe  perf: Consider OS filter fail

elapsed time: 729m

configs tested: 57
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
sh                               allmodconfig
s390                                defconfig
powerpc                           allnoconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
ia64                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                            allnoconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
arc                  randconfig-r043-20221124
powerpc                       maple_defconfig
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sh                           se7206_defconfig
sh                        dreamcast_defconfig
arm                        shmobile_defconfig
powerpc                     tqm8548_defconfig
powerpc                    klondike_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                      ep88xc_defconfig
ia64                        generic_defconfig
arm                       multi_v4t_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-c001

clang tested configs:
s390                 randconfig-r044-20221124
hexagon              randconfig-r041-20221124
riscv                randconfig-r042-20221124
hexagon              randconfig-r045-20221124
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
