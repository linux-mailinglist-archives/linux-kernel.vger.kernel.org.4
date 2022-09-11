Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329AB5B51F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 01:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiIKXlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 19:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIKXlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 19:41:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC7118B39
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 16:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662939676; x=1694475676;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=56SUwRSqqNshIHQCEVkpCwIJIFwbhCTzBn4IiA1xJCM=;
  b=TGGD5Z6hd3TqIsyhQn2k5iT8RLNMCjWknOaezJaF5ew1srFLq7bfXA7N
   dfDbochPEJmJ1bdMxATRpYoDH4llHEKFRT5JifjojOkWQZW1EoY3ody0h
   st/uzCer3HHWvra0zTMli4NhU/sgLOlOHsL7Oc+PBwGK/zljun/1PyefL
   PGcR+icusccaVHUvOqLNYs6NViEkaaGeL1OD1SeiCz0eiSfoK8WrrpvBa
   76r2fV6Y0N3e5rXoffGel875yWSkStVu8bj2A2DwBycTJhVvGjK6bhzHT
   Basl2m2PGPSTKo5uoLNdXvCW04+t0mMEVV5tvAkHatgcY2cc+BKuNvldS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="278151350"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="278151350"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 16:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="646242857"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 11 Sep 2022 16:41:14 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXWZe-0001yd-0I;
        Sun, 11 Sep 2022 23:41:14 +0000
Date:   Mon, 12 Sep 2022 07:40:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:printk.2022.09.11a] BUILD REGRESSION
 8f9a00355ec3d95247589328c221086edc42b099
Message-ID: <631e71e8.RpaYCm9lJ5QXI6DZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git printk.2022.09.11a
branch HEAD: 8f9a00355ec3d95247589328c221086edc42b099  printk: Add atomic write enforcement to warn/panic...

Error/Warning: (recently discovered and may have been fixed)

aarch64-linux-ld: panic.c:(.text+0x74c): undefined reference to `cons_atomic_exit'
cat: 'smatch_trinity_*': No such file or directory
grep: smatch_trinity_*: No such file or directory
ia64-linux-ld: kernel/panic.c:647: undefined reference to `cons_atomic_exit'
mips-linux-ld: panic.c:(.text.__warn+0xc4): undefined reference to `cons_atomic_exit'
nios2-linux-ld: panic.c:(.text+0x5b4): undefined reference to `cons_atomic_exit'
or1k-linux-ld: panic.c:(.text+0x57c): undefined reference to `cons_atomic_exit'
riscv32-linux-ld: panic.c:(.text+0xe84): undefined reference to `cons_atomic_exit'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-randconfig-r021-20220911
|   `-- aarch64-linux-ld:panic.c:(.text):undefined-reference-to-cons_atomic_exit
|-- ia64-randconfig-r001-20220911
|   `-- ia64-linux-ld:kernel-panic.c:undefined-reference-to-cons_atomic_exit
|-- mips-buildonly-randconfig-r003-20220911
|   `-- mips-linux-ld:panic.c:(.text.__warn):undefined-reference-to-cons_atomic_exit
|-- nios2-buildonly-randconfig-r004-20220911
|   `-- nios2-linux-ld:panic.c:(.text):undefined-reference-to-cons_atomic_exit
|-- openrisc-randconfig-m031-20220911
|   |-- cat:smatch_trinity_:No-such-file-or-directory
|   `-- grep:smatch_trinity_:No-such-file-or-directory
|-- openrisc-randconfig-r034-20220911
|   `-- or1k-linux-ld:panic.c:(.text):undefined-reference-to-cons_atomic_exit
`-- riscv-randconfig-r014-20220911
    `-- riscv32-linux-ld:panic.c:(.text):undefined-reference-to-cons_atomic_exit

elapsed time: 721m

configs tested: 44
configs skipped: 2

gcc tested configs:
x86_64                        randconfig-a002
um                             i386_defconfig
x86_64                        randconfig-a006
um                           x86_64_defconfig
arm                                 defconfig
x86_64                              defconfig
x86_64                        randconfig-a004
i386                                defconfig
i386                          randconfig-a014
x86_64                               rhel-8.3
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a005
i386                          randconfig-a016
arm                              allyesconfig
x86_64                        randconfig-a013
x86_64                           allyesconfig
x86_64                        randconfig-a011
arm64                            allyesconfig
x86_64                          rhel-8.3-func
i386                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
arc                              allyesconfig
powerpc                           allnoconfig
alpha                            allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
mips                             allyesconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
i386                          randconfig-a006
x86_64                        randconfig-a014

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
