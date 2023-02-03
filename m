Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1914B688C1E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjBCAuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBCAuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:50:02 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5456124C9A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 16:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675385401; x=1706921401;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Gk3ml2Z5jytvLNegKp01VCVeRY2RTIDK6G9+rwIJID0=;
  b=htTDZbKh5qf2kUZEzUq7TPAAmk0WzMFYXrvXD7PaWLZmS5ebmoUdQDRH
   VXaWfP41q4hYQqOVg3cseVd2mVkZvupFqvtltKTu0IAzNUpDOBngot3zz
   Wf0wiWp4u4UVnZ91G86IPAPaOfZOO93rbmrz+ayzJm0dYzghkq3yt565r
   yh/DXwYgRXNm3W3NpwR9aQ5MucIsPRAGsvOUWixlbFblQTazpx6Xrrv5V
   60tOol/vf3U8T067UTtNZd3riOMaCDZ9XwBuX79XY/Bk2zF+RX7pTJNhL
   1T02NbOui4f5av5cr2ogFkIL650LGJtLKzd/hNQaZmYuDlm5KUaLgX32z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="328634123"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="328634123"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 16:50:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="667484795"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="667484795"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 02 Feb 2023 16:49:59 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNkH9-00071o-0b;
        Fri, 03 Feb 2023 00:49:59 +0000
Date:   Fri, 03 Feb 2023 08:49:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:paronl.2023.02.01a] BUILD REGRESSION
 05792727280c094a8dcd1aa4950a61a2d214ddb8
Message-ID: <63dc5a2d.wIh/nekchR0RO5a8%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git paronl.2023.02.01a
branch HEAD: 05792727280c094a8dcd1aa4950a61a2d214ddb8  x86/smpboot: Serialize topology updates for secondary bringup

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202302021011.Db4Od62h-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202302021018.uy6CiyRh-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202302021025.R4dApIXe-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202302021052.NLAk6zgv-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202302021103.5o9vwutp-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202302021243.bku0pJhm-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/x86/kernel/head_64.S:286: undefined reference to `__per_cpu_offset'
arch/x86/kernel/smpboot.c:1251:5: warning: no previous prototype for 'do_cpu_up' [-Wmissing-prototypes]
arch/x86/kernel/smpboot.c:1251:5: warning: no previous prototype for function 'do_cpu_up' [-Wmissing-prototypes]
arch/x86/kernel/smpboot.c:1361:24: error: implicit declaration of function 'idle_thread_get' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
arch/x86/kernel/smpboot.c:1361:24: warning: incompatible integer to pointer conversion passing 'int' to parameter of type 'struct task_struct *' [-Wint-conversion]
arch/x86/kernel/smpboot.c:1361:31: error: implicit declaration of function 'idle_thread_get' [-Werror=implicit-function-declaration]
arch/x86/kernel/smpboot.c:1361:31: warning: passing argument 2 of 'do_cpu_up' makes pointer from integer without a cast [-Wint-conversion]
ld: arch/x86/kernel/head_64.S:298: undefined reference to `idle_threads'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- x86_64-randconfig-a001-20230130
|   |-- arch-x86-kernel-smpboot.c:error:implicit-declaration-of-function-idle_thread_get
|   |-- arch-x86-kernel-smpboot.c:warning:no-previous-prototype-for-do_cpu_up
|   `-- arch-x86-kernel-smpboot.c:warning:passing-argument-of-do_cpu_up-makes-pointer-from-integer-without-a-cast
|-- x86_64-randconfig-a003-20230130
|   |-- arch-x86-kernel-head_64.S:undefined-reference-to-__per_cpu_offset
|   `-- ld:arch-x86-kernel-head_64.S:undefined-reference-to-idle_threads
`-- x86_64-rhel-8.3-func
    |-- arch-x86-kernel-smpboot.c:error:implicit-declaration-of-function-idle_thread_get
    |-- arch-x86-kernel-smpboot.c:warning:no-previous-prototype-for-do_cpu_up
    `-- arch-x86-kernel-smpboot.c:warning:passing-argument-of-do_cpu_up-makes-pointer-from-integer-without-a-cast
clang_recent_errors
`-- x86_64-rhel-8.3-rust
    |-- arch-x86-kernel-smpboot.c:error:implicit-declaration-of-function-idle_thread_get-is-invalid-in-C99-Werror-Wimplicit-function-declaration
    |-- arch-x86-kernel-smpboot.c:warning:incompatible-integer-to-pointer-conversion-passing-int-to-parameter-of-type-struct-task_struct
    `-- arch-x86-kernel-smpboot.c:warning:no-previous-prototype-for-function-do_cpu_up

elapsed time: 1528m

configs tested: 66
configs skipped: 2

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
x86_64               randconfig-a001-20230130
i386                 randconfig-a002-20230130
x86_64               randconfig-a003-20230130
alpha                               defconfig
x86_64               randconfig-a004-20230130
i386                 randconfig-a001-20230130
s390                                defconfig
i386                 randconfig-a004-20230130
x86_64               randconfig-a002-20230130
i386                 randconfig-a003-20230130
x86_64               randconfig-a006-20230130
i386                 randconfig-a006-20230130
x86_64               randconfig-a005-20230130
i386                 randconfig-a005-20230130
s390                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
ia64                             allmodconfig
alpha                            allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
sh                               allmodconfig
x86_64                              defconfig
mips                             allyesconfig
x86_64                               rhel-8.3
powerpc                          allmodconfig
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
arc                  randconfig-r043-20230129
arm                  randconfig-r046-20230129
i386                                defconfig
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130
i386                             allyesconfig
arm                                 defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a014-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
i386                 randconfig-a011-20230130
hexagon              randconfig-r041-20230129
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
s390                 randconfig-r044-20230129
riscv                randconfig-r042-20230129
riscv                randconfig-r042-20230130
s390                 randconfig-r044-20230130

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
