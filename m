Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8096967669A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 14:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjAUNv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 08:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjAUNv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 08:51:27 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6A6193C6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 05:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674309086; x=1705845086;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wZsTDq8tT2GhkMpsNd8DggSnRzxicVC2bzNMp7Ceh8Q=;
  b=PApcRP43L9KsRHBw66uA0s4Ug/aXX1v226wCITyshJZuQZkS2BTmIXA3
   FT+oTzSgqdAsD97V7R342L4hlU9M9MlAwe2fY62ea/1yEmBihm9PaL4hV
   f2ZMtVyWACPuqHylJ5xSMnzsJxtjXC3LTTcvHd7tPiZrSj/XXAfG0DwXj
   vFjjaK2sH7ncG9/deGD7bdbGfnKnuhkcK3D369im2YLpeVDT/hi7oEDfZ
   OaHiZdZpssNXIcciskfsdz2vADXicMT+7EunFAsFL3byni4N7RzQXd/zU
   MxyXEXUAFVkiUa5iXp+IeOVPtx34gMECp2uisX0dH2U3ynt1FyRhQgo1z
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="327873707"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="327873707"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 05:51:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="989702848"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="989702848"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jan 2023 05:51:24 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJEHD-000486-1W;
        Sat, 21 Jan 2023 13:51:23 +0000
Date:   Sat, 21 Jan 2023 21:51:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:nmitest.2023.01.20a] BUILD REGRESSION
 53e298568bde2c728ee2aac4ac634cca8550a4b4
Message-ID: <63cbedcb.935XIQz8TNWAaVX4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git nmitest.2023.01.20a
branch HEAD: 53e298568bde2c728ee2aac4ac634cca8550a4b4  rcutorture: Test NMI diagnostics

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202301211106.33rvYsWW-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202301211247.Isi7qGD5-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202301211327.02xyAfS3-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202301211330.0IJsirCg-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202301211331.RMgsACsP-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

.tmp_gl_rcutorture.o:(.text+0x7860): undefined reference to `set_nmi_torture'
ERROR: modpost: "set_nmi_torture" [kernel/rcu/rcutorture.ko] undefined!
aarch64-linux-ld: kernel/rcu/rcutorture.c:3303: undefined reference to `set_nmi_torture'
aarch64-linux-ld: rcutorture.c:(.text+0x5a80): undefined reference to `set_nmi_torture'
arc-elf-ld: rcutorture.c:(.text+0x5352): undefined reference to `set_nmi_torture'
arch/x86/kernel/nmi.c:441:6: warning: no previous prototype for 'set_nmi_torture' [-Wmissing-prototypes]
arch/x86/kernel/nmi.c:441:6: warning: no previous prototype for function 'set_nmi_torture' [-Wmissing-prototypes]
arm-linux-gnueabi-ld: rcutorture.c:(.text+0x1acc): undefined reference to `set_nmi_torture'
arm-linux-gnueabi-ld: rcutorture.c:(.text+0x352c): undefined reference to `set_nmi_torture'
csky-linux-ld: rcutorture.c:(.text+0x3e4c): undefined reference to `set_nmi_torture'
kernel/rcu/rcutorture.c:(.text+0x33b8): undefined reference to `set_nmi_torture'
kernel/rcu/rcutorture.c:2230: undefined reference to `set_nmi_torture'
kernel/rcu/rcutorture.c:3291: undefined reference to `set_nmi_torture'
kernel/rcu/rcutorture.c:3292: undefined reference to `set_nmi_torture'
ld.lld: error: undefined symbol: set_nmi_torture
microblaze-linux-ld: .tmp_gl_rcutorture.o:(.text+0x78c0): undefined reference to `set_nmi_torture'
mips-linux-ld: rcutorture.c:(.text+0x41a8): undefined reference to `set_nmi_torture'
mipsel-linux-ld: kernel/rcu/rcutorture.c:(.text+0x3424): undefined reference to `set_nmi_torture'
or1k-linux-ld: rcutorture.c:(.text+0x3ecc): undefined reference to `set_nmi_torture'
rcutorture.c:(.text+0x1a8c): undefined reference to `set_nmi_torture'
rcutorture.c:(.text+0x3e0a): undefined reference to `set_nmi_torture'
rcutorture.c:(.text+0x3eb0): undefined reference to `set_nmi_torture'
rcutorture.c:(.text+0x5352): undefined reference to `set_nmi_torture'
rcutorture.c:(.text+0xa48c): undefined reference to `set_nmi_torture'
s390-linux-ld: kernel/rcu/rcutorture.c:3303: undefined reference to `set_nmi_torture'
s390-linux-ld: rcutorture.c:(.text+0xa594): undefined reference to `set_nmi_torture'
s390x-linux-ld: rcutorture.c:(.text+0x1f6): undefined reference to `set_nmi_torture'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-r016-20230119
|   |-- arc-elf-ld:rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|   `-- rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|-- arm-allyesconfig
|   `-- arm-linux-gnueabi-ld:rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|-- arm-randconfig-r046-20230119
|   |-- arm-linux-gnueabi-ld:rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|   `-- rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|-- arm64-allyesconfig
|   `-- aarch64-linux-ld:kernel-rcu-rcutorture.c:undefined-reference-to-set_nmi_torture
|-- arm64-randconfig-r004-20230119
|   `-- aarch64-linux-ld:rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|-- csky-randconfig-r004-20230119
|   `-- ERROR:set_nmi_torture-kernel-rcu-rcutorture.ko-undefined
|-- csky-randconfig-r026-20230119
|   |-- csky-linux-ld:rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|   `-- rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|-- i386-randconfig-a001
|   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
|-- loongarch-randconfig-r002-20230119
|   `-- kernel-rcu-rcutorture.c:undefined-reference-to-set_nmi_torture
|-- loongarch-randconfig-r003-20230119
|   `-- ERROR:set_nmi_torture-kernel-rcu-rcutorture.ko-undefined
|-- microblaze-randconfig-r013-20230119
|   |-- microblaze-linux-ld:.tmp_gl_rcutorture.o:(.text):undefined-reference-to-set_nmi_torture
|   `-- tmp_gl_rcutorture.o:(.text):undefined-reference-to-set_nmi_torture
|-- mips-randconfig-m041-20230119
|   `-- mips-linux-ld:rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|-- mips-randconfig-r025-20230119
|   |-- kernel-rcu-rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|   `-- mipsel-linux-ld:kernel-rcu-rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|-- openrisc-randconfig-r025-20230119
|   |-- or1k-linux-ld:rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|   `-- rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|-- riscv-randconfig-r001-20230119
|   `-- kernel-rcu-rcutorture.c:undefined-reference-to-set_nmi_torture
|-- s390-allmodconfig
|   `-- ERROR:set_nmi_torture-kernel-rcu-rcutorture.ko-undefined
|-- s390-allyesconfig
|   |-- kernel-rcu-rcutorture.c:undefined-reference-to-set_nmi_torture
|   `-- s390-linux-ld:kernel-rcu-rcutorture.c:undefined-reference-to-set_nmi_torture
|-- s390-randconfig-r034-20230119
|   |-- rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|   `-- s390-linux-ld:rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|-- x86_64-allmodconfig
|   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
|-- x86_64-allyesconfig
|   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
`-- x86_64-rhel-8.3-syz
    `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
clang_recent_errors
|-- arm-randconfig-r006-20230119
|   `-- ld.lld:error:undefined-symbol:set_nmi_torture
|-- arm64-randconfig-r015-20230119
|   `-- ld.lld:error:undefined-symbol:set_nmi_torture
|-- hexagon-randconfig-r045-20230119
|   `-- ld.lld:error:undefined-symbol:set_nmi_torture
|-- i386-randconfig-a002
|   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-function-set_nmi_torture
|-- riscv-randconfig-r014-20230119
|   `-- ld.lld:error:undefined-symbol:set_nmi_torture
|-- riscv-randconfig-r015-20230119
|   `-- ld.lld:error:undefined-symbol:set_nmi_torture
|-- s390-randconfig-r011-20230119
|   `-- s39-linux-ld:rcutorture.c:(.text):undefined-reference-to-set_nmi_torture
|-- s390-randconfig-r044-20230119
|   `-- ERROR:set_nmi_torture-kernel-rcu-rcutorture.ko-undefined
`-- x86_64-randconfig-a001
    `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-function-set_nmi_torture

elapsed time: 721m

configs tested: 62
configs skipped: 2

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                           rhel-8.3-syz
um                             i386_defconfig
x86_64                            allnoconfig
x86_64                           rhel-8.3-kvm
um                           x86_64_defconfig
x86_64                         rhel-8.3-kunit
s390                                defconfig
x86_64                           rhel-8.3-bpf
powerpc                           allnoconfig
s390                             allyesconfig
x86_64                        randconfig-a004
i386                          randconfig-a001
x86_64                        randconfig-a002
x86_64                              defconfig
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a005
arm                  randconfig-r046-20230119
arc                  randconfig-r043-20230119
sh                               allmodconfig
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
powerpc                          allmodconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                        randconfig-a013
m68k                             allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a011
m68k                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                              allyesconfig
i386                                defconfig
arm64                            allyesconfig
x86_64                           allyesconfig
ia64                             allmodconfig
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
x86_64                        randconfig-a005
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r045-20230119
hexagon              randconfig-r041-20230119
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a014
s390                 randconfig-r044-20230119
riscv                randconfig-r042-20230119
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
