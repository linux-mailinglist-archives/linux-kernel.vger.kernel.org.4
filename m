Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F64D5FBDBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJKWRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJKWRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:17:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C95F7FE67
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665526672; x=1697062672;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Ua5/Csqjm8uWuY7ps9DHpzOnNxBxnKO7KvdNYr3Z4Lc=;
  b=jK4010efLIIN66hz3NOo5TglFCrQUas6UvDfBIQyxqI7B4owUlCo4WVE
   +mOPhZaTDk7dFZ9HfifPxEPzGowwciFPsUnhZ+2a2m0j7Rrsmpo6vdPHM
   JOwJahqlk5xL/wbHU7+bdEqPwQ0tzMK+e9Svfhg1YArlvGjstIrPRrzJK
   aJdDq5+UZQPfWUVxduH17Yi/70iSb2eq6M2VPRTd2WaGMuzify/5jetYQ
   fEakVMqb6vLWad3vGF3KvFICyEHQi5jvwU9Vr0kXyC4q2ds6TtoenK7oY
   L0d8z+ze2BNYKhn9NxlvoL9bYivFKPkQAAV29SkUqE+cgZtQwp6oKYalG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="302250462"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="302250462"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 15:17:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="659701586"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="659701586"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Oct 2022 15:17:50 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oiNZN-0003CJ-0r;
        Tue, 11 Oct 2022 22:17:49 +0000
Date:   Wed, 12 Oct 2022 06:16:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD REGRESSION
 38b3262a0a12381ebcc93c24c7d3af2e0c9ad843
Message-ID: <6345eb50.HGq7jAhLFoA5HXMa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 38b3262a0a12381ebcc93c24c7d3af2e0c9ad843  Merge branch 'linus'

Error/Warning reports:

https://lore.kernel.org/lkml/202210112238.4QYsE6EH-lkp@intel.com
https://lore.kernel.org/llvm/202210112134.ARWlOFUs-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

kernel/cgroup/cgroup.c:5271:26: error: 'CFTYPE_PRESSURE' undeclared here (not in a function)
kernel/cgroup/cgroup.c:5281:26: error: 'CFTYPE_PRESSURE' undeclared here (not in a function)

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- arc-allyesconfig
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- arc-randconfig-r003-20221010
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- arm-allyesconfig
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- arm64-allyesconfig
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- arm64-randconfig-r021-20221010
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- csky-randconfig-r015-20221010
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- i386-allyesconfig
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a013-20221010
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a016-20221010
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- i386-randconfig-s001-20221010
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- ia64-allmodconfig
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- m68k-allmodconfig
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- m68k-allyesconfig
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- m68k-randconfig-s043-20221010
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- mips-allyesconfig
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- mips-randconfig-r035-20221010
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- nios2-allyesconfig
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- nios2-randconfig-r034-20221010
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- parisc-allyesconfig
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- parisc-buildonly-randconfig-r004-20221010
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- powerpc-allmodconfig
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- powerpc-randconfig-r011-20221010
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- powerpc-randconfig-r023-20221010
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
|-- riscv-randconfig-c042-20221010
|   `-- kernel-cgroup-cgroup.c:error:CFTYPE_PRESSURE-undeclared-here-(not-in-a-function)
clang_recent_errors
|-- arm-buildonly-randconfig-r002-20221010
|   |-- kernel-cgroup-cgroup.c:error:use-of-undeclared-identifier-CFTYPE_PRESSURE
|   `-- kernel-cgroup-cgroup.c:warning:tentative-array-definition-assumed-to-have-one-element
|-- hexagon-randconfig-r024-20221010
|   |-- kernel-cgroup-cgroup.c:error:use-of-undeclared-identifier-CFTYPE_PRESSURE
|   `-- kernel-cgroup-cgroup.c:warning:tentative-array-definition-assumed-to-have-one-element
|-- hexagon-randconfig-r041-20221010
|   |-- kernel-cgroup-cgroup.c:error:use-of-undeclared-identifier-CFTYPE_PRESSURE
|   `-- kernel-cgroup-cgroup.c:warning:tentative-array-definition-assumed-to-have-one-element
|-- i386-randconfig-a001-20221010
|   |-- kernel-cgroup-cgroup.c:error:use-of-undeclared-identifier-CFTYPE_PRESSURE
|   `-- kernel-cgroup-cgroup.c:warning:tentative-array-definition-assumed-to-have-one-element
|-- i386-randconfig-a002-20221010
|   |-- kernel-cgroup-cgroup.c:error:use-of-undeclared-identifier-CFTYPE_PRESSURE
|   `-- kernel-cgroup-cgroup.c:warning:tentative-array-definition-assumed-to-have-one-element
|-- i386-randconfig-a003-20221010
|   |-- kernel-cgroup-cgroup.c:error:use-of-undeclared-identifier-CFTYPE_PRESSURE
|   `-- kernel-cgroup-cgroup.c:warning:tentative-array-definition-assumed-to-have-one-element
|-- i386-randconfig-a004-20221010
|   |-- kernel-cgroup-cgroup.c:error:use-of-undeclared-identifier-CFTYPE_PRESSURE
|   `-- kernel-cgroup-cgroup.c:warning:tentative-array-definition-assumed-to-have-one-element
|-- i386-randconfig-a006-20221010
|   |-- kernel-cgroup-cgroup.c:error:use-of-undeclared-identifier-CFTYPE_PRESSURE
|   `-- kernel-cgroup-cgroup.c:warning:tentative-array-definition-assumed-to-have-one-element
|-- x86_64-randconfig-a001-20221010
|   |-- kernel-cgroup-cgroup.c:error:use-of-undeclared-identifier-CFTYPE_PRESSURE
|   `-- kernel-cgroup-cgroup.c:warning:tentative-array-definition-assumed-to-have-one-element
|-- x86_64-randconfig-a004-20221010
|   |-- kernel-cgroup-cgroup.c:error:use-of-undeclared-identifier-CFTYPE_PRESSURE
|   `-- kernel-cgroup-cgroup.c:warning:tentative-array-definition-assumed-to-have-one-element
|-- x86_64-randconfig-a005-20221010
|   |-- kernel-cgroup-cgroup.c:error:use-of-undeclared-identifier-CFTYPE_PRESSURE
|   `-- kernel-cgroup-cgroup.c:warning:tentative-array-definition-assumed-to-have-one-element
`-- x86_64-randconfig-k001
    |-- kernel-cgroup-cgroup.c:error:use-of-undeclared-identifier-CFTYPE_PRESSURE
    `-- kernel-cgroup-cgroup.c:warning:tentative-array-definition-assumed-to-have-one-element

elapsed time: 722m

configs tested: 82
configs skipped: 2

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
arm                                 defconfig
x86_64               randconfig-a011-20221010
x86_64                              defconfig
arc                  randconfig-r043-20221010
i386                                defconfig
x86_64                           allyesconfig
sh                               allmodconfig
arm                              allyesconfig
i386                 randconfig-a012-20221010
x86_64               randconfig-a016-20221010
mips                             allyesconfig
i386                 randconfig-a011-20221010
x86_64                               rhel-8.3
arm64                            allyesconfig
x86_64               randconfig-a014-20221010
i386                 randconfig-a013-20221010
arc                              allyesconfig
powerpc                          allmodconfig
riscv                randconfig-r042-20221010
alpha                            allyesconfig
x86_64               randconfig-a015-20221010
s390                 randconfig-r044-20221010
i386                 randconfig-a015-20221010
i386                 randconfig-a014-20221010
x86_64               randconfig-a012-20221010
i386                             allyesconfig
x86_64               randconfig-a013-20221010
i386                 randconfig-a016-20221010
s390                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
ia64                             allmodconfig
s390                             allmodconfig
s390                             allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                 randconfig-c001-20221010
arm                        mini2440_defconfig
powerpc                     rainier_defconfig
ia64                        generic_defconfig
nios2                         3c120_defconfig
sh                           se7722_defconfig
nios2                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig

clang tested configs:
hexagon              randconfig-r045-20221010
hexagon              randconfig-r041-20221010
x86_64               randconfig-a002-20221010
x86_64               randconfig-a001-20221010
x86_64               randconfig-a003-20221010
x86_64               randconfig-a004-20221010
x86_64               randconfig-a005-20221010
i386                 randconfig-a003-20221010
x86_64               randconfig-a006-20221010
i386                 randconfig-a004-20221010
i386                 randconfig-a002-20221010
i386                 randconfig-a005-20221010
i386                 randconfig-a001-20221010
i386                 randconfig-a006-20221010
x86_64                        randconfig-k001
riscv                    nommu_virt_defconfig
arm                         orion5x_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
