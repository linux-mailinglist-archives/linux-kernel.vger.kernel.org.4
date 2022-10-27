Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373AC61066D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbiJ0Xb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiJ0Xb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:31:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AD425C75
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666913515; x=1698449515;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xb34HM1PJPWlVXKpZk1fn15yijOC0zLVZmc/tTvrib0=;
  b=UWeeFdWYQTa8P0xUCrYK9sZdKYfvpA/GktLTpfqyyBGuxPsaSUReR86p
   +inQ27qWnhwdxjNKVHfxDnpNXjP691hpacdZrYxMPM8exT3mczghCLy9K
   R/QOCONjafoYPMsLeOsnhkV2SJbavTcO2BO7aoKdW1BGLXnecf+cqWTYF
   w8ttgU0RfcWviU7Ot68JMR7XRUwLrFlKaT4wkgi4CzVa45GEoZfiDx/Aa
   sYzoeu0zuawE+IksFpP3Q+cIOGezHjpc/yfCj68dYfsmx1epPlNeofcrR
   t553xxuhUknU8Q2IzJOUw+cx9vr0+Shi762kvD7Zd0nkKHKd1JAgQspQY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="295776751"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="295776751"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 16:31:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="665866601"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="665866601"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 27 Oct 2022 16:31:53 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooCLp-0009GJ-11;
        Thu, 27 Oct 2022 23:31:53 +0000
Date:   Fri, 28 Oct 2022 07:31:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 3011466f39cd2d82825785b68270fbc3ba22a5c5
Message-ID: <635b14b8.gDNfq0fn77K4onxS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 3011466f39cd2d82825785b68270fbc3ba22a5c5  Merge branch into tip/master: 'x86/core'

elapsed time: 854m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
arm                                 defconfig
x86_64                              defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
x86_64                        randconfig-a006
x86_64                          rhel-8.3-func
i386                          randconfig-a003
x86_64                    rhel-8.3-kselftests
s390                                defconfig
riscv                randconfig-r042-20221026
arc                  randconfig-r043-20221026
s390                             allmodconfig
x86_64                               rhel-8.3
arm                              allyesconfig
s390                 randconfig-r044-20221026
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
mips                             allyesconfig
i386                          randconfig-a005
m68k                             allmodconfig
i386                                defconfig
s390                             allyesconfig
arc                              allyesconfig
x86_64                           allyesconfig
ia64                             allmodconfig
alpha                            allyesconfig
sh                               allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
i386                          randconfig-a014
m68k                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
arm64                            allyesconfig
powerpc                          allmodconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
hexagon              randconfig-r045-20221026
hexagon              randconfig-r041-20221026
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
