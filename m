Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967F9608D54
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 15:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJVNIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 09:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJVNH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 09:07:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707262B7B45
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 06:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666444077; x=1697980077;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=q1uUyvjxY30CJnGf2JYeBa/8cQOEMC9GXr4VwSr82gA=;
  b=jCc11E/UD/tIl2PZMr/zI4jPeC6K8P9DGocY+MEvENm/f/1D5oytOHZr
   QYC+vNAAps9lIV1kEHYo4wSsIxbJyuPNQkgTzvr4GSCVriSWedlR8WyqP
   EVHXmJXL82NH5uhr0n6HB94+HxMjNIPEbJeZuyToEDEZ4hmVsv+MNRBKQ
   HLta6GSdHQYEsONhOE5F/1WE3/GVvbmXYBmhDVs1IxtdeyTLOIt722GSl
   YGA3xJ1+sCo+XTsVdkYKk1kUqY2NVknyLhfYjavy5RQ2KZo6nTknX1T1P
   QXtWQe9ttIoqB7plVFYAQW6IuyiXSZp4dVcMtKknKVAMoHsZSfc+wLUMB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="290490331"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="290490331"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 06:07:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="581900652"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="581900652"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 22 Oct 2022 06:07:55 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1omEEF-0003ep-0t;
        Sat, 22 Oct 2022 13:07:55 +0000
Date:   Sat, 22 Oct 2022 21:07:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD REGRESSION
 1248fb6a8201ddac1c86a202f05a0a1765efbfce
Message-ID: <6353eb06.VDrziTqYsQjw5M8P%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 1248fb6a8201ddac1c86a202f05a0a1765efbfce  x86/mm: Randomize per-cpu entry area

Error/Warning: (recently discovered and may have been fixed)

vmlinux.o: warning: objtool: get_cpu_entry_area+0x0: call to cea_offset.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: get_cpu_entry_area+0x5: call to cea_offset.constprop.0() leaves .noinstr.text section

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- x86_64-randconfig-a013
|   `-- vmlinux.o:warning:objtool:get_cpu_entry_area:call-to-cea_offset()-leaves-.noinstr.text-section
`-- x86_64-randconfig-c022
    `-- vmlinux.o:warning:objtool:get_cpu_entry_area:call-to-cea_offset()-leaves-.noinstr.text-section
clang_recent_errors
|-- x86_64-randconfig-a001
|   `-- vmlinux.o:warning:objtool:get_cpu_entry_area:call-to-cea_offset()-leaves-.noinstr.text-section
`-- x86_64-randconfig-k001
    `-- vmlinux.o:warning:objtool:get_cpu_entry_area:call-to-cea_offset()-leaves-.noinstr.text-section

elapsed time: 726m

configs tested: 90
configs skipped: 81

gcc tested configs:
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                                defconfig
x86_64                        randconfig-a015
x86_64                              defconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
i386                          randconfig-a005
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a014
x86_64                        randconfig-a006
i386                          randconfig-a012
i386                          randconfig-a016
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                        multi_v7_defconfig
sh                           se7721_defconfig
powerpc                         ps3_defconfig
m68k                           virt_defconfig
sh                         microdev_defconfig
arm                            qcom_defconfig
ia64                          tiger_defconfig
arm                        mvebu_v7_defconfig
mips                    maltaup_xpa_defconfig
sh                               allmodconfig
i386                          randconfig-c001
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
arm                           u8500_defconfig
csky                                defconfig
parisc                generic-64bit_defconfig
arm                            zeus_defconfig
sh                               alldefconfig
loongarch                         allnoconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-c001
arm                  randconfig-c002-20221019
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                          exynos_defconfig
alpha                             allnoconfig
arc                               allnoconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
i386                          randconfig-a013
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a011
i386                          randconfig-a015
powerpc                   microwatt_defconfig
arm                         orion5x_defconfig
powerpc                      obs600_defconfig
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
x86_64                        randconfig-k001
s390                 randconfig-r044-20221019
hexagon              randconfig-r045-20221019
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221019
arm                      pxa255-idp_defconfig
mips                          ath79_defconfig
powerpc                      acadia_defconfig
arm                             mxs_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
