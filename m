Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B3D685D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 03:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjBACwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 21:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjBACwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 21:52:41 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE38637561
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 18:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675219960; x=1706755960;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Uk1BX4f6QQ/zXlji16FNAdOz63zZH56+GIghBi/d7t0=;
  b=ec1VzI93RAD7E1jAwM4i4w6JQNgvpz0zsc2Rt6ELVYC0Lnj6L4MowHBA
   CzgEvyiQfOBj2FF0ELo/NmPHK9C58H6bWhu7JwP77UFDU3T42wOpjYDoR
   z9ZZaCSGregnKQtjghoPkrB/8+OFTc1/JOSmJAN5hhJUNWRXAzUSZOVuB
   802lTS1/l1aSMQRGTb2IJcX7+zHTbLxcx7iwH80pAGHqRjLd/9wJ+x50V
   uFStuiOIp8zKLr+BQkL/ORsyXHU25he8jCIaBI9pjNoRB1+enaLl5fSR+
   CwSAkk7ELj4iGJIFYLKYs3k7AYBG6DYEtHmnaxhRbDaTN12wNIMK6ZxGA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="315993299"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="315993299"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 18:52:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="666749236"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="666749236"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 31 Jan 2023 18:52:38 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pN3Ek-0004xC-0g;
        Wed, 01 Feb 2023 02:52:38 +0000
Date:   Wed, 01 Feb 2023 10:51:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD REGRESSION
 4d627628d7584f3d3add1d53342d0f01aa878e04
Message-ID: <63d9d3bb.bkyAX5M/QME3dryL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 4d627628d7584f3d3add1d53342d0f01aa878e04  cpuidle: Fix poll_idle() noinstr annotation

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202301160853.WV6WFdzk-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202301161525.7zBM5pCN-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

vmlinux.o: warning: objtool: acpi_idle_enter+0x42: call to ftrace_likely_update() leaves .noinstr.text section
vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0x6b: call to ftrace_likely_update() leaves .noinstr.text section
vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0xef: call to ftrace_likely_update() leaves .noinstr.text section
vmlinux.o: warning: objtool: mwait_idle+0x26: call to ftrace_likely_update() leaves .noinstr.text section

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-a002-20230130
    |-- vmlinux.o:warning:objtool:acpi_idle_enter:call-to-ftrace_likely_update()-leaves-.noinstr.text-section
    |-- vmlinux.o:warning:objtool:acpi_idle_enter_s2idle:call-to-ftrace_likely_update()-leaves-.noinstr.text-section
    |-- vmlinux.o:warning:objtool:acpi_processor_ffh_cstate_enter:call-to-ftrace_likely_update()-leaves-.noinstr.text-section
    `-- vmlinux.o:warning:objtool:mwait_idle:call-to-ftrace_likely_update()-leaves-.noinstr.text-section
clang_recent_errors
`-- x86_64-randconfig-a016-20230130
    `-- vmlinux.o:warning:objtool:acpi_idle_do_entry:call-to-perf_lopwr_cb()-leaves-.noinstr.text-section

elapsed time: 724m

configs tested: 79
configs skipped: 2

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
powerpc                           allnoconfig
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
i386                 randconfig-a002-20230130
i386                 randconfig-a001-20230130
arc                                 defconfig
x86_64               randconfig-a001-20230130
s390                             allmodconfig
x86_64               randconfig-a003-20230130
x86_64                              defconfig
x86_64               randconfig-a004-20230130
alpha                               defconfig
i386                 randconfig-a005-20230130
x86_64               randconfig-a002-20230130
i386                 randconfig-a006-20230130
ia64                             allmodconfig
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
s390                                defconfig
x86_64                               rhel-8.3
i386                                defconfig
arc                  randconfig-r043-20230129
arm                  randconfig-r046-20230129
s390                             allyesconfig
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
i386                             allyesconfig
m68k                             allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
arm                                 defconfig
mips                             allyesconfig
powerpc                          allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
hexagon              randconfig-r041-20230129
riscv                randconfig-r042-20230129
riscv                randconfig-r042-20230130
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
s390                 randconfig-r044-20230129
x86_64                          rhel-8.3-rust
s390                 randconfig-r044-20230130
x86_64               randconfig-a014-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a016-20230130
x86_64               randconfig-a015-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
