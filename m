Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CF764F05E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 18:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiLPR0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 12:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiLPR0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 12:26:39 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494A910FD2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 09:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671211598; x=1702747598;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KpGYV+m7MyfuJOI4O3vKLHjkWPzImLJ0igcC0Y+vu5c=;
  b=LTbLFc/AcqxeiTejwwi/+0p7Da+0TsmcraFX4+Vqp5B0V+XUElaeVfXG
   Ic3bK4wlJJn+AANGydNJbcWQubBjZU3AcizzR0ZC4NfW1a2CNls7MszmS
   3a9jRRrGnSY5O6NXr3/u/ojnt29Wd9/rNpsWW+8eO9/qn5cA90JiABJHa
   yEqPgaWEr3waifadPbpzSkRdl77K3n8EOslCyr6ipG6Yzjq0D2HaPIL0V
   uaPTvC+6UIif4ZhWFfMtahSxGXZCF5CIjU76rh6bZb+2oNZXya0CPBQoy
   92TzLTLW2+TjygHbDc4G/52KvU83X6VOSty1iIeydAlxdNR6bhTPVaUv9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="320188207"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="320188207"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 09:26:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="718435005"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="718435005"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 Dec 2022 09:26:36 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p6ETj-0007JS-1r;
        Fri, 16 Dec 2022 17:26:35 +0000
Date:   Sat, 17 Dec 2022 01:26:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.12.12a] BUILD SUCCESS
 33bb97ec03485acc4463ccfc78f834e04e688b85
Message-ID: <639caa3f.bR199CRiXMG/SBG+%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.12.12a
branch HEAD: 33bb97ec03485acc4463ccfc78f834e04e688b85  rcu/kvfree: Split ready for reclaim objects from a batch

elapsed time: 1176m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20221215
arm                  randconfig-r046-20221215
sh                               allmodconfig
ia64                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a002
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
x86_64                              defconfig
arm64                            allyesconfig
i386                                defconfig
x86_64                               rhel-8.3
arm                              allyesconfig
x86_64                           allyesconfig
i386                             allyesconfig
x86_64                            allnoconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm

clang tested configs:
hexagon              randconfig-r041-20221215
hexagon              randconfig-r045-20221215
riscv                randconfig-r042-20221215
s390                 randconfig-r044-20221215
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a006
i386                          randconfig-a015
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
