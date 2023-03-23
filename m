Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B37A6C5E97
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCWFQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCWFQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:16:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3452B29A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679548572; x=1711084572;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gNgKC7hXaaakNENsoQ9nXW0Jnii/VQ0CLFsaL8/5Fjg=;
  b=QHQRhoAcIqq5K/RoBQBBzUA1C78UuBPSXB2E4MChOMkqamteUQe3CiuI
   DpKkldYCw0coPlNSrzE0xKHte9Voh4v5ZYa0rHBtfzwM53hANmC4OGGhp
   Ka0RCRpJnaudPDcn0uP2GYxaU2mydWRPdA9j3eLfxkYXfZg96HYsRYt96
   VuuB/YZWYmII73sjTVzKFjF/acVKmk7j7ajETGRR9PWKQvWDNTIW9OCo+
   gnqdtdFdKIMCtGmWcx4BcIR8pNUsvTipfJ4lWMYOgpYyH+2kqOaZ5xxgg
   IeFq3Hqs2tqk7v46Jyagzi0QGgZDdCVpgdUi69hVbcxd+XuMEcytwoQAZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319049618"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="319049618"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:16:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="682180079"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="682180079"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2023 22:16:10 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfDJ3-000DzE-2e;
        Thu, 23 Mar 2023 05:16:09 +0000
Date:   Thu, 23 Mar 2023 13:16:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 dfd7a1569e25996575a24725b64f73162155bcd6
Message-ID: <641be097.HFLiw5DinCLajHzG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: dfd7a1569e25996575a24725b64f73162155bcd6  selftests/x86/lam: Add test cases for LAM vs thread creation

elapsed time: 9134m

configs tested: 211
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230322   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230322   gcc  
arc          buildonly-randconfig-r004-20230312   gcc  
arc          buildonly-randconfig-r004-20230322   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                  randconfig-r002-20230313   gcc  
arc                  randconfig-r003-20230322   gcc  
arc                  randconfig-r006-20230313   gcc  
arc                  randconfig-r032-20230312   gcc  
arc                  randconfig-r043-20230312   gcc  
arc                  randconfig-r043-20230313   gcc  
arc                  randconfig-r043-20230322   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230313   gcc  
arm          buildonly-randconfig-r001-20230322   clang
arm          buildonly-randconfig-r005-20230313   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-c002-20230318   gcc  
arm                  randconfig-r004-20230313   clang
arm                  randconfig-r046-20230312   clang
arm                  randconfig-r046-20230313   gcc  
arm                  randconfig-r046-20230322   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230312   clang
arm64                randconfig-r016-20230312   gcc  
arm64                randconfig-r025-20230322   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230312   gcc  
csky                 randconfig-r033-20230313   gcc  
csky                 randconfig-r036-20230312   gcc  
hexagon                          alldefconfig   clang
hexagon              randconfig-r001-20230313   clang
hexagon              randconfig-r014-20230322   clang
hexagon              randconfig-r026-20230322   clang
hexagon              randconfig-r033-20230322   clang
hexagon              randconfig-r041-20230312   clang
hexagon              randconfig-r041-20230313   clang
hexagon              randconfig-r041-20230322   clang
hexagon              randconfig-r045-20230312   clang
hexagon              randconfig-r045-20230313   clang
hexagon              randconfig-r045-20230322   clang
i386                             alldefconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r002-20230313   gcc  
i386         buildonly-randconfig-r003-20230313   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230313   gcc  
i386                          randconfig-a001   gcc  
i386                 randconfig-a002-20230313   gcc  
i386                          randconfig-a002   clang
i386                 randconfig-a003-20230313   gcc  
i386                          randconfig-a003   gcc  
i386                 randconfig-a004-20230313   gcc  
i386                          randconfig-a004   clang
i386                 randconfig-a005-20230313   gcc  
i386                          randconfig-a005   gcc  
i386                 randconfig-a006-20230313   gcc  
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230313   clang
i386                          randconfig-a011   clang
i386                 randconfig-a012-20230313   clang
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230313   clang
i386                          randconfig-a013   clang
i386                 randconfig-a014-20230313   clang
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230313   clang
i386                          randconfig-a015   clang
i386                 randconfig-a016-20230313   clang
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
i386                 randconfig-r004-20230313   gcc  
i386                 randconfig-r035-20230313   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230312   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230312   gcc  
ia64                 randconfig-r011-20230322   gcc  
ia64                 randconfig-r013-20230322   gcc  
ia64                 randconfig-r016-20230322   gcc  
ia64                 randconfig-r031-20230312   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230322   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230322   gcc  
loongarch            randconfig-r006-20230312   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r013-20230313   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips                           ip28_defconfig   clang
mips                 randconfig-r001-20230322   gcc  
mips                 randconfig-r022-20230313   gcc  
nios2                            allyesconfig   gcc  
nios2        buildonly-randconfig-r003-20230312   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230313   gcc  
nios2                randconfig-r005-20230312   gcc  
nios2                randconfig-r025-20230313   gcc  
openrisc     buildonly-randconfig-r001-20230312   gcc  
openrisc             randconfig-r026-20230312   gcc  
parisc       buildonly-randconfig-r006-20230312   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r005-20230313   gcc  
parisc               randconfig-r012-20230313   gcc  
parisc               randconfig-r034-20230313   gcc  
parisc               randconfig-r036-20230322   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r036-20230313   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230312   clang
riscv                randconfig-r002-20230322   clang
riscv                randconfig-r022-20230312   gcc  
riscv                randconfig-r031-20230313   gcc  
riscv                randconfig-r042-20230312   gcc  
riscv                randconfig-r042-20230313   clang
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230312   gcc  
s390                 randconfig-r044-20230313   clang
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230313   gcc  
sh                               j2_defconfig   gcc  
sh                   randconfig-r034-20230322   gcc  
sh                   randconfig-r035-20230312   gcc  
sparc        buildonly-randconfig-r006-20230322   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230313   gcc  
sparc                randconfig-r004-20230312   gcc  
sparc                randconfig-r004-20230322   gcc  
sparc                randconfig-r015-20230322   gcc  
sparc                randconfig-r024-20230312   gcc  
sparc64              randconfig-r004-20230312   gcc  
sparc64              randconfig-r012-20230312   gcc  
sparc64              randconfig-r024-20230322   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230313   gcc  
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230313   gcc  
x86_64                        randconfig-a002   gcc  
x86_64               randconfig-a003-20230313   gcc  
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230313   gcc  
x86_64                        randconfig-a004   gcc  
x86_64               randconfig-a005-20230313   gcc  
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230313   gcc  
x86_64                        randconfig-a006   gcc  
x86_64               randconfig-a011-20230313   clang
x86_64                        randconfig-a011   gcc  
x86_64               randconfig-a012-20230313   clang
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230313   clang
x86_64                        randconfig-a013   gcc  
x86_64               randconfig-a014-20230313   clang
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230313   clang
x86_64                        randconfig-a015   gcc  
x86_64               randconfig-a016-20230313   clang
x86_64                        randconfig-a016   clang
x86_64                        randconfig-c001   gcc  
x86_64                        randconfig-k001   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa               randconfig-r001-20230312   gcc  
xtensa               randconfig-r001-20230313   gcc  
xtensa               randconfig-r003-20230312   gcc  
xtensa               randconfig-r005-20230313   gcc  
xtensa               randconfig-r014-20230313   gcc  
xtensa               randconfig-r021-20230313   gcc  
xtensa               randconfig-r022-20230322   gcc  
xtensa               randconfig-r032-20230313   gcc  
xtensa               randconfig-r033-20230312   gcc  
xtensa               randconfig-r034-20230312   gcc  
xtensa               randconfig-r035-20230322   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
