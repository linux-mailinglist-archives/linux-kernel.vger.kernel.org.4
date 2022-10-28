Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62EB610EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiJ1Kov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiJ1Kok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:44:40 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F026AD111
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666953874; x=1698489874;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9rIv6tGZ/biObzV9fIJT/+3bPEx7LR+XItAQ6I+mAGU=;
  b=cDz3S2soWO7pS/2djPmERewRvytcuz3HhjSpMm7M1tVp4bJQJ7Qc5ZEh
   Ihw4kzuSeRkCXa/3BLGK1qyuzLHGMliHvPJX6hFqleEe2vVEeppRQ2533
   8RwfULmaeoheZBCsAXrEathKjUeBooHXS9Il4B7EpQys/vq2BU0UzQOen
   Zh1XFgGdQkKJQyN1Ci5W7nlVWUgebIlncRRcu2W1NaCJIHV/PiW4VF+9F
   Mu3D8/66sI4u080ZLmH+CGpgbYkekySG4833G+eVQnIWYB6yo/J6wNs6R
   wLofcYJbIYpgHpuY6zbunv9DBLKV85LUk+jpL3XQ2Y8z351Xa8fYcavbo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="307191148"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="307191148"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 03:44:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="738063672"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="738063672"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 28 Oct 2022 03:44:33 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooMqm-0009p3-38;
        Fri, 28 Oct 2022 10:44:32 +0000
Date:   Fri, 28 Oct 2022 18:43:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 d6d1a3923799d04f56cd644a9cb7ecf19de67949
Message-ID: <635bb25d.kIZ4hyLxAOSIzaHL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: d6d1a3923799d04f56cd644a9cb7ecf19de67949  x86/mm: Randomize per-cpu entry area

Unverified Warning (likely false positive, please contact us if interested):

arch/x86/kernel/hw_breakpoint.c:265:13: warning: unused variable 'cpu' [-Wunused-variable]
arch/x86/mm/cpu_entry_area.c:247:23: warning: unused variable 'start' [-Wunused-variable]
arch/x86/mm/cpu_entry_area.c:247:30: warning: unused variable 'end' [-Wunused-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allyesconfig
|   |-- arch-x86-kernel-hw_breakpoint.c:warning:unused-variable-cpu
|   |-- arch-x86-mm-cpu_entry_area.c:warning:unused-variable-end
|   `-- arch-x86-mm-cpu_entry_area.c:warning:unused-variable-start
|-- i386-defconfig
|   |-- arch-x86-kernel-hw_breakpoint.c:warning:unused-variable-cpu
|   |-- arch-x86-mm-cpu_entry_area.c:warning:unused-variable-end
|   `-- arch-x86-mm-cpu_entry_area.c:warning:unused-variable-start
|-- i386-randconfig-a001
|   |-- arch-x86-kernel-hw_breakpoint.c:warning:unused-variable-cpu
|   |-- arch-x86-mm-cpu_entry_area.c:warning:unused-variable-end
|   `-- arch-x86-mm-cpu_entry_area.c:warning:unused-variable-start
|-- i386-randconfig-a003
|   |-- arch-x86-kernel-hw_breakpoint.c:warning:unused-variable-cpu
|   |-- arch-x86-mm-cpu_entry_area.c:warning:unused-variable-end
|   `-- arch-x86-mm-cpu_entry_area.c:warning:unused-variable-start
|-- i386-randconfig-a005
|   |-- arch-x86-kernel-hw_breakpoint.c:warning:unused-variable-cpu
|   |-- arch-x86-mm-cpu_entry_area.c:warning:unused-variable-end
|   `-- arch-x86-mm-cpu_entry_area.c:warning:unused-variable-start
|-- i386-randconfig-a012
|   |-- arch-x86-kernel-hw_breakpoint.c:warning:unused-variable-cpu
|   |-- arch-x86-mm-cpu_entry_area.c:warning:unused-variable-end
|   `-- arch-x86-mm-cpu_entry_area.c:warning:unused-variable-start
|-- i386-randconfig-a014
|   |-- arch-x86-kernel-hw_breakpoint.c:warning:unused-variable-cpu
|   |-- arch-x86-mm-cpu_entry_area.c:warning:unused-variable-end
|   `-- arch-x86-mm-cpu_entry_area.c:warning:unused-variable-start
`-- i386-randconfig-a016
    |-- arch-x86-kernel-hw_breakpoint.c:warning:unused-variable-cpu
    |-- arch-x86-mm-cpu_entry_area.c:warning:unused-variable-end
    `-- arch-x86-mm-cpu_entry_area.c:warning:unused-variable-start

elapsed time: 745m

configs tested: 62
configs skipped: 69

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a015
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a004
i386                          randconfig-a016
x86_64                        randconfig-a002
x86_64                        randconfig-a006
powerpc                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
ia64                             allmodconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
sh                               allmodconfig
arc                  randconfig-r043-20221026
arc                  randconfig-r043-20221028
s390                 randconfig-r044-20221028
s390                 randconfig-r044-20221026
riscv                randconfig-r042-20221026
riscv                randconfig-r042-20221028
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
arm                         hackkit_defconfig
arm                         socfpga_defconfig
mips                      bmips_stb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
