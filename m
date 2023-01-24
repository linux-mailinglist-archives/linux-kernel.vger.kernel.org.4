Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C147F67A525
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjAXVn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjAXVn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:43:26 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81034B1A0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674596604; x=1706132604;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VcrqEe6Km/L2X5JIGGdYUgr/lMDqTHgg4WixbCE0ESo=;
  b=TCr2w9s5AySmf0hVz3kWMczwLh3I3PoEppY3x/3Fb8R0RsRTF3EAQm6/
   RszQGahC05j8WvRLgBqRH4vOcrYsQqm67LQKs3+pKHQAfA74gMWDYD29Z
   nJDIfMNMn/VvNTJNJzBcPwuepp3ilT5GFE8adw0SGvfKbVLJhwmpkULdN
   RaxnyTE/htNMdpT3vlPFPTw6ZATFOZ9/vnCbPhsY/USWuvP9WefUP+3J1
   MaNhoAUKG9WQnC22AfH5QZoX+nTzd4uM2UaCxBgv09hk/eMrpl86TG0p7
   jshVoRmaZ3DsC+mvF8iBijn6qFzs5GVviyXGUx0KQX1JP5sfXJ+VN04j9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="412646364"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="412646364"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 13:43:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="750964787"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="750964787"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jan 2023 13:43:22 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKR4c-0006nq-0O;
        Tue, 24 Jan 2023 21:43:22 +0000
Date:   Wed, 25 Jan 2023 05:42:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS WITH WARNING
 0a363fb23ee2f7beb08437ad7db86d195878d79f
Message-ID: <63d050e3.qKwyYprmXbnyOL4/%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: 0a363fb23ee2f7beb08437ad7db86d195878d79f  Documentation/x86: Update resctrl.rst for new features

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202301241934.L4ops5VY-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202301242015.kbzkVteJ-lkp@intel.com

Warning: (recently discovered and may have been fixed)

arch/x86/kernel/cpu/resctrl/rdtgroup.c:1456:13: warning: variable 'h' set but not used [-Wunused-but-set-variable]
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1456:6: warning: variable 'h' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-allyesconfig
    `-- arch-x86-kernel-cpu-resctrl-rdtgroup.c:warning:variable-h-set-but-not-used
clang_recent_errors
|-- x86_64-randconfig-a012-20230123
|   `-- arch-x86-kernel-cpu-resctrl-rdtgroup.c:warning:variable-h-set-but-not-used
`-- x86_64-randconfig-a013-20230123
    `-- arch-x86-kernel-cpu-resctrl-rdtgroup.c:warning:variable-h-set-but-not-used

elapsed time: 725m

configs tested: 82
configs skipped: 3

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
arm                                 defconfig
s390                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20230123
arm64                            allyesconfig
alpha                            allyesconfig
x86_64                    rhel-8.3-kselftests
mips                             allyesconfig
arm                  randconfig-r046-20230123
arm                              allyesconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
sh                               allmodconfig
x86_64                           rhel-8.3-bpf
i386                                defconfig
ia64                             allmodconfig
x86_64                              defconfig
i386                 randconfig-a004-20230123
x86_64               randconfig-a002-20230123
i386                 randconfig-a003-20230123
x86_64               randconfig-a001-20230123
x86_64                               rhel-8.3
i386                 randconfig-a002-20230123
x86_64               randconfig-a004-20230123
x86_64               randconfig-a003-20230123
x86_64               randconfig-a005-20230123
i386                 randconfig-a001-20230123
x86_64               randconfig-a006-20230123
i386                 randconfig-a005-20230123
i386                 randconfig-a006-20230123
x86_64                           allyesconfig
i386                             allyesconfig
m68k                        m5407c3_defconfig
arm                             rpc_defconfig
s390                          debug_defconfig
arc                    vdk_hs38_smp_defconfig
openrisc                       virt_defconfig
i386                 randconfig-c001-20230123
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                         wii_defconfig
arm                           imxrt_defconfig
powerpc                    sam440ep_defconfig
xtensa                              defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
x86_64                          rhel-8.3-rust
riscv                randconfig-r042-20230123
s390                 randconfig-r044-20230123
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
i386                 randconfig-a012-20230123
x86_64               randconfig-a012-20230123
i386                 randconfig-a013-20230123
x86_64               randconfig-a016-20230123
i386                 randconfig-a011-20230123
x86_64               randconfig-a015-20230123
i386                 randconfig-a014-20230123
i386                 randconfig-a016-20230123
i386                 randconfig-a015-20230123
x86_64               randconfig-a014-20230123
x86_64               randconfig-k001-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
