Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B3568D5E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjBGLrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjBGLrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:47:02 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553D61F5E2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675770421; x=1707306421;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BTvG9kI9p6Tr6QLTjIBDLYTbEVrjqthWyGfLVJv/gow=;
  b=k4fNJwv7HWp+sxqS9gj1s/JtWnMx9lOD4gRXXkcP7uApFcPVhrQvWm0t
   3V4IanBMTTq8+ciJE7BMHfGWUxABTXC5TR7GDdO3bvxoomeSP4cspkXtD
   FUKt+SxG8A9hlvW35l528sVAbc/C29ySvqtxyynFoSqlZ6JpOwFXpSMbZ
   6G7Fdol2D1PkOBeMAAaKPKYHLpyQFrrenKyOt+4x5gQc4S2Vx2lSjP5gn
   WIxlNAADE375OAecP2WIst94aLRN/GVFgqUnFEctRC7gKGDoN1RZ8Hx+a
   Y/4oLc89hhwdEznhN2zJMWnbEgX5ah7XUx29s6m0rqzIuVQiYfgu1w2vi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="329503328"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="329503328"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 03:47:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="995700462"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="995700462"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Feb 2023 03:47:00 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPMR9-0003WI-1F;
        Tue, 07 Feb 2023 11:46:59 +0000
Date:   Tue, 07 Feb 2023 19:46:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.02.03a] BUILD SUCCESS
 077af4236f06a251931179a46f69d1815ceb4f97
Message-ID: <63e23a2a.hYZC5Us8w0z98alf%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.02.03a
branch HEAD: 077af4236f06a251931179a46f69d1815ceb4f97  locktorture: With nested locks, occasionally skip main lock

elapsed time: 723m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                              defconfig
ia64                             allmodconfig
x86_64               randconfig-a014-20230206
x86_64                           rhel-8.3-syz
x86_64               randconfig-a013-20230206
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a011-20230206
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a015-20230206
x86_64                           rhel-8.3-bpf
x86_64               randconfig-a012-20230206
x86_64               randconfig-a016-20230206
x86_64                           allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
arc                  randconfig-r043-20230205
arm                  randconfig-r046-20230205
powerpc                           allnoconfig
arc                  randconfig-r043-20230206
i386                          randconfig-a016
powerpc                          allmodconfig
mips                             allyesconfig
riscv                randconfig-r042-20230206
s390                 randconfig-r044-20230206
arm                                 defconfig
sh                               allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                                defconfig
i386                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
mips                           jazz_defconfig
sh                          r7780mp_defconfig
arc                                 defconfig
um                               alldefconfig
s390                             allmodconfig
xtensa                  nommu_kc705_defconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
alpha                            allyesconfig
arc                              allyesconfig

clang tested configs:
i386                          randconfig-a013
hexagon              randconfig-r041-20230205
riscv                randconfig-r042-20230205
hexagon              randconfig-r045-20230206
hexagon              randconfig-r041-20230206
i386                 randconfig-a002-20230206
i386                 randconfig-a005-20230206
i386                 randconfig-a004-20230206
i386                 randconfig-a003-20230206
i386                 randconfig-a001-20230206
i386                          randconfig-a011
arm                  randconfig-r046-20230206
s390                 randconfig-r044-20230205
i386                          randconfig-a015
hexagon              randconfig-r045-20230205
i386                 randconfig-a006-20230206
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a001-20230206
x86_64               randconfig-a005-20230206
x86_64               randconfig-a006-20230206
powerpc                      ppc44x_defconfig
hexagon                             defconfig
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
