Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA32767B2A5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbjAYMgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjAYMgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:36:02 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD3728D38
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674650161; x=1706186161;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vBQkJeIzwH+e7IOR/sqo6ZxXcDGVF9+RW9NzXLr6yxs=;
  b=GHDYkmWJrBRQZ9K9FpTX65p4XCXUYIYWY17wScJIN25pvcqE2now7iS3
   zE6tkJGxFWI5sVOE7rjrv49DYyXahY+/42bdENlLHdgwA8mlaDJVqmdPZ
   1nLZr7xxy0AIKi5xyEEqlDvIlrOFx7x65jHIhb/6ejyfn6Hh3AiA28A56
   hh3c8ZdAldc9e3Cc195NmrhpZ4W1uiihSivtbDcz+G4Af1h6DWr55l/Hr
   W/qeFUBY6B+H8Lfci9Lo/jEic9vr4w9OslaX1Ez0B2u63i6HpZ2Hxz0dr
   E88zL6dJZZ/L26qvBkcNp6VF+WzYYnfjkfT4sRVaTGvI8qEMVy9m3untd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="325217079"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="325217079"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 04:36:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="612400685"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="612400685"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Jan 2023 04:35:59 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKf0Q-0007Ii-00;
        Wed, 25 Jan 2023 12:35:58 +0000
Date:   Wed, 25 Jan 2023 20:35:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:nolibc] BUILD SUCCESS
 c54ba4178159e440bea3826d22d43a9d0d94b071
Message-ID: <63d1220c.Assan/CP1aorZDS6%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git nolibc
branch HEAD: c54ba4178159e440bea3826d22d43a9d0d94b071  selftests/nolibc: Add a "run-user" target to test the program in user land

elapsed time: 726m

configs tested: 80
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
i386                                defconfig
x86_64                              defconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
powerpc                          allmodconfig
arc                              allyesconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20230123
arm                  randconfig-r046-20230123
ia64                             allmodconfig
x86_64                           allyesconfig
x86_64               randconfig-a002-20230123
x86_64               randconfig-a001-20230123
x86_64               randconfig-a003-20230123
x86_64               randconfig-a004-20230123
x86_64               randconfig-a005-20230123
x86_64               randconfig-a006-20230123
i386                             allyesconfig
arm                                 defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
i386                 randconfig-a004-20230123
i386                 randconfig-a006-20230123
i386                 randconfig-a005-20230123
i386                 randconfig-a002-20230123
i386                 randconfig-a003-20230123
i386                 randconfig-a001-20230123
i386                          randconfig-c001
sh                           se7724_defconfig
sh                          kfr2r09_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
riscv                randconfig-r042-20230123
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a014-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a015-20230123
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64               randconfig-k001-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a016-20230123
i386                 randconfig-a012-20230123
i386                 randconfig-a015-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a014-20230123
mips                   sb1250_swarm_defconfig
mips                     cu1000-neo_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
