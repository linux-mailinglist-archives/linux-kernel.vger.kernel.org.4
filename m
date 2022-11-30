Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDC663E0D2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiK3Tfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiK3Tfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:35:42 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D28B18D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 11:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669836941; x=1701372941;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1BNUhRHLTpMh+TTEvTc+kokjaII/m4N83pxSmpjXGOA=;
  b=D61x7XIaB2GlTxCCgSTL1qoXoKgJl+Bp2YqJNxGK7cf7Ekxwe+E46SPj
   djgu0O8HsUqj+0/crLH2ACXS6jAqGnGhGj6jpsq7f7RfnfSwu5KWXyUUT
   gFnH6CyRIqo/NfDSWDWtCPFvN8y/TxNlzHKkZgUnKt5vrZhMup3P0/uAx
   BChDBnoWHmQ6PItD1+LJrgNQ6LduN8a6HL8Rk3IJPbZdzI5C2YgFPMS/C
   whlfeuxxzHCrbGtuhrdbrKCCByKjJE6WueQQNpMC/NL9hxWI3WM+4TmSX
   xVjTAxmJdyi1ZqEX+zB/2ki3ZI0LkUPN3hh+zwAbGsPPwSrLI9cPMXPnF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="295189993"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="295189993"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 11:35:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="750481108"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="750481108"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 30 Nov 2022 11:35:39 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0Srr-000BdP-11;
        Wed, 30 Nov 2022 19:35:39 +0000
Date:   Thu, 01 Dec 2022 03:34:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:srcunmisafe.2022.11.29a] BUILD SUCCESS
 64e838679e149b6074507b50f0e2c68a2cd6990f
Message-ID: <6387b050.oSvD/DsDxuV5Pckr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git srcunmisafe.2022.11.29a
branch HEAD: 64e838679e149b6074507b50f0e2c68a2cd6990f  rcu: Make SRCU mandatory

elapsed time: 1074m

configs tested: 85
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
arc                              allyesconfig
x86_64                           allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
m68k                             allmodconfig
arc                  randconfig-r043-20221128
ia64                             allmodconfig
i386                                defconfig
i386                             allyesconfig
i386                 randconfig-a001-20221128
i386                 randconfig-a005-20221128
i386                 randconfig-a006-20221128
i386                 randconfig-a004-20221128
i386                 randconfig-a003-20221128
i386                 randconfig-a002-20221128
x86_64               randconfig-a002-20221128
x86_64               randconfig-a001-20221128
x86_64               randconfig-a004-20221128
x86_64               randconfig-a006-20221128
x86_64               randconfig-a005-20221128
x86_64               randconfig-a003-20221128
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                            allnoconfig
csky                                defconfig
nios2                               defconfig
mips                           gcw0_defconfig
xtensa                    xip_kc705_defconfig
arm                        oxnas_v6_defconfig
sh                          lboxre2_defconfig
sh                           se7750_defconfig
sh                             espt_defconfig
sparc64                          alldefconfig
powerpc                   currituck_defconfig
arc                               allnoconfig
i386                 randconfig-c001-20221128

clang tested configs:
x86_64               randconfig-a013-20221128
x86_64               randconfig-a012-20221128
x86_64               randconfig-a014-20221128
x86_64               randconfig-a011-20221128
x86_64               randconfig-a016-20221128
x86_64               randconfig-a015-20221128
hexagon              randconfig-r045-20221128
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
s390                 randconfig-r044-20221128
i386                 randconfig-a014-20221128
i386                 randconfig-a011-20221128
i386                 randconfig-a013-20221128
i386                 randconfig-a016-20221128
i386                 randconfig-a012-20221128
i386                 randconfig-a015-20221128
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
arm                      tct_hammer_defconfig
arm                        vexpress_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
