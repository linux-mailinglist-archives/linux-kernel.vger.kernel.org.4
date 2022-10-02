Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2CB5F235C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 15:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiJBN2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 09:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJBN2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 09:28:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8B42C67D
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664717316; x=1696253316;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=CzG516wv8y+w0k/q2NPg6R7JFzfPW2TbNUYupBQuOFA=;
  b=lUdFUHG0K9lOFlu6B8Mv5mig1/7Jjmf+rbLy1khCDOwCtbC49UCsIYn5
   fcN3usS56aHTCPln6GOWRNhpMMa3jgkosi3RnBweLtM0re5yvyJsrWu7S
   zTrpwq1ukZtY7c5t8LNNRklsgVmAN3XSl8ghFqwU9y3cvQxtk8o9jIQog
   bowlWo27oDJIfB+j8SbjrPjfowf1G4fdO+wacvPd7tebQA4tPTkJLtkqy
   9FW1FvdmrMWjg5K5JbctBrzy1O/GhCpHxhDONRrN60F5Dcx4++ccSSB5a
   x2J1Zn1sCCxyO14Ex44GDl6v85h1N60J5ZdZ2WEuf351aG0j2BmL80zcV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="300078743"
X-IronPort-AV: E=Sophos;i="5.93,363,1654585200"; 
   d="scan'208";a="300078743"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2022 06:28:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="574362554"
X-IronPort-AV: E=Sophos;i="5.93,363,1654585200"; 
   d="scan'208";a="574362554"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Oct 2022 06:28:34 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oez1F-0003f3-1t;
        Sun, 02 Oct 2022 13:28:33 +0000
Date:   Sun, 02 Oct 2022 21:28:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:srcunmisafe.2022.09.30a] BUILD SUCCESS
 90fa0944665d6fb980c2b8bde8fd45d3b5b1e1af
Message-ID: <633991f5.mrAf6ganLKhRWQKm%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git srcunmisafe.2022.09.30a
branch HEAD: 90fa0944665d6fb980c2b8bde8fd45d3b5b1e1af  arch/s390: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option

elapsed time: 1209m

configs tested: 91
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20221002
i386                                defconfig
arm                                 defconfig
arc                                 defconfig
x86_64                              defconfig
alpha                               defconfig
s390                                defconfig
x86_64                        randconfig-a004
x86_64                          rhel-8.3-func
x86_64                        randconfig-a002
x86_64                               rhel-8.3
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
powerpc                          allmodconfig
s390                             allmodconfig
mips                             allyesconfig
x86_64                           allyesconfig
s390                             allyesconfig
x86_64                        randconfig-a006
arm64                            allyesconfig
m68k                             allmodconfig
i386                             allyesconfig
arc                              allyesconfig
arm                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a001
m68k                             allyesconfig
i386                          randconfig-a014
sh                               allmodconfig
x86_64                        randconfig-a015
i386                          randconfig-a003
i386                          randconfig-a012
x86_64                        randconfig-a013
i386                          randconfig-a016
i386                          randconfig-a005
x86_64                        randconfig-a011
arm                             pxa_defconfig
xtensa                         virt_defconfig
powerpc                     asp8347_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
csky                                defconfig
m68k                       m5475evb_defconfig
mips                           ip32_defconfig
arm                            lart_defconfig
arm                         lpc18xx_defconfig
powerpc                  storcenter_defconfig
i386                          randconfig-c001
openrisc                       virt_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                  randconfig-c002-20221002
x86_64                        randconfig-c001
powerpc                        cell_defconfig
nios2                         3c120_defconfig
m68k                           virt_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                        m5407c3_defconfig
ia64                            zx1_defconfig
arm                      jornada720_defconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20221002
hexagon              randconfig-r045-20221002
riscv                randconfig-r042-20221002
s390                 randconfig-r044-20221002
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a015
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
