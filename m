Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEBF622876
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiKIK17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiKIK1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:27:50 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3872FAC1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667989669; x=1699525669;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WV/gmQWpif5YetN8I9e228Wyglq3gQWaYAYoT80lyI4=;
  b=P9Yy73nIQ++gTp7TQXipkoaGhBxxUogGRTpxSzzfv6q4ly0NBVkzhKPt
   hrupUj0f8bocleyQbU5rOpYL9guQv6qFGc+HBR9DGRtOWmsAjQVFqcQd+
   lIeljuP+QiL1FlggMOedUWsC0eT3DFqjbPRPPp1Pb686J8WUp1Wcg73fb
   pFYxwgDwmQo8dU4WpS5NxyCQKs1fkkb+93m/dPDy9l5eYrU1GDJoBK819
   qSWrSwSFaIJC6aLa3c5ccFynbnl9fEa0oEbVkHe0idYLqGmhR+KklDSxi
   WrAOvjZz0ky4mXZNvYJIDekWWZH+ysRH/mnJbYauHwzZz2+L5S19teuKK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="309654610"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="309654610"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 02:27:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="631207775"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="631207775"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Nov 2022 02:27:32 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1osiIt-0001S2-2S;
        Wed, 09 Nov 2022 10:27:31 +0000
Date:   Wed, 09 Nov 2022 18:27:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.11.04a] BUILD SUCCESS WITH WARNING
 b05c2a06ff8a1267b7e8dc812e3944119535d6b6
Message-ID: <636b8079.IXIqM/2AJPas0awb%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.11.04a
branch HEAD: b05c2a06ff8a1267b7e8dc812e3944119535d6b6  doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202211090849.sUpamKcV-lkp@intel.com

Warning: (recently discovered and may have been fixed)

kernel/rcu/refscale.c:649:27: warning: no previous prototype for 'typesafe_alloc_one' [-Wmissing-prototypes]
kernel/rcu/refscale.c:649:27: warning: no previous prototype for function 'typesafe_alloc_one' [-Wmissing-prototypes]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-r014-20221108
|   `-- kernel-rcu-refscale.c:warning:no-previous-prototype-for-typesafe_alloc_one
|-- alpha-randconfig-r031-20221108
|   `-- kernel-rcu-refscale.c:warning:no-previous-prototype-for-typesafe_alloc_one
|-- arm64-randconfig-m031-20221109
|   `-- kernel-rcu-refscale.c:warning:no-previous-prototype-for-typesafe_alloc_one
|-- arm64-randconfig-r013-20221108
|   `-- kernel-rcu-refscale.c:warning:no-previous-prototype-for-typesafe_alloc_one
|-- loongarch-randconfig-r035-20221109
|   `-- kernel-rcu-refscale.c:warning:no-previous-prototype-for-typesafe_alloc_one
|-- loongarch-randconfig-r036-20221109
|   `-- kernel-rcu-refscale.c:warning:no-previous-prototype-for-typesafe_alloc_one
|-- microblaze-buildonly-randconfig-r005-20221108
|   `-- kernel-rcu-refscale.c:warning:no-previous-prototype-for-typesafe_alloc_one
|-- microblaze-randconfig-r005-20221109
|   `-- kernel-rcu-refscale.c:warning:no-previous-prototype-for-typesafe_alloc_one
|-- microblaze-randconfig-r012-20221108
|   `-- kernel-rcu-refscale.c:warning:no-previous-prototype-for-typesafe_alloc_one
|-- powerpc-randconfig-r011-20221108
|   `-- kernel-rcu-refscale.c:warning:no-previous-prototype-for-typesafe_alloc_one
|-- s390-buildonly-randconfig-r006-20221108
|   `-- kernel-rcu-refscale.c:warning:no-previous-prototype-for-typesafe_alloc_one
|-- sh-randconfig-r022-20221108
|   `-- kernel-rcu-refscale.c:warning:no-previous-prototype-for-typesafe_alloc_one
`-- sparc64-randconfig-r023-20221108
    `-- kernel-rcu-refscale.c:warning:no-previous-prototype-for-typesafe_alloc_one
clang_recent_errors
|-- arm-buildonly-randconfig-r002-20221108
|   `-- kernel-rcu-refscale.c:warning:no-previous-prototype-for-function-typesafe_alloc_one
|-- hexagon-randconfig-r001-20221109
|   `-- kernel-rcu-refscale.c:warning:no-previous-prototype-for-function-typesafe_alloc_one
`-- hexagon-randconfig-r036-20221108
    `-- kernel-rcu-refscale.c:warning:no-previous-prototype-for-function-typesafe_alloc_one

elapsed time: 729m

configs tested: 58
configs skipped: 2

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                         rhel-8.3-kunit
arc                                 defconfig
x86_64                           rhel-8.3-kvm
s390                             allmodconfig
powerpc                           allnoconfig
alpha                               defconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a013
x86_64                           rhel-8.3-syz
s390                                defconfig
sh                               allmodconfig
x86_64                        randconfig-a011
ia64                             allmodconfig
x86_64                        randconfig-a015
s390                             allyesconfig
i386                                defconfig
arc                  randconfig-r043-20221108
riscv                randconfig-r042-20221108
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
s390                 randconfig-r044-20221108
i386                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a005
m68k                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016

clang tested configs:
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
hexagon              randconfig-r041-20221108
hexagon              randconfig-r045-20221108
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
