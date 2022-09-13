Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230275B6E93
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiIMNrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiIMNrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:47:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C156E32050
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663076850; x=1694612850;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2TWOm5uFVC8P+j+zdR7eM1mklWUqxiAoUlJoCO1wwGw=;
  b=LmF0Mfky2dnqPPSR5dhH6alDD7o1KCnfUrxfT5ETW2BHoNwIaBdDOtGc
   VCfUEEIk+guEM2V+DZcRsPoDGjg/A+bC2dkB9VbouHhF7L03LJnvmDFQc
   qGadNuPCVGJMSsYlQDZuRNKp8KeMpF4UvW1d92ztzAVPjxHLS/Bc2Ig4I
   09BirKh9wJRGS920SWNcCHrm2mckjm74BzqazeWhiUJG91rtn0Bw9f0vG
   Gwv7/TL9CeLr//5d91FrjUBSS5PimNLtPFiEXOSFzSyCuQyrDBSA4y7Al
   d/ogdbQFQfILBHMkiUMTy2LOOj3xMFba/FlwHzYNqn0spRLZ/fj7Khvb0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="362088917"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="362088917"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 06:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="593945352"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Sep 2022 06:47:29 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oY6G8-0003cl-21;
        Tue, 13 Sep 2022 13:47:28 +0000
Date:   Tue, 13 Sep 2022 21:47:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/6.0-rc5-other] BUILD SUCCESS
 315b7aca3a3f36bef8cf1dccdff3670cd67e244d
Message-ID: <632089e1.P8TjFeIQqQqgmFW6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/6.0-rc5-other
branch HEAD: 315b7aca3a3f36bef8cf1dccdff3670cd67e244d  code_for_slides: snippets

elapsed time: 725m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
um                             i386_defconfig
i386                 randconfig-a001-20220912
um                           x86_64_defconfig
i386                 randconfig-a002-20220912
arm                                 defconfig
i386                 randconfig-a004-20220912
arc                              allyesconfig
alpha                            allyesconfig
i386                 randconfig-a003-20220912
m68k                             allmodconfig
i386                 randconfig-a006-20220912
m68k                             allyesconfig
x86_64                              defconfig
i386                 randconfig-a005-20220912
arm64                            allyesconfig
x86_64                               rhel-8.3
arm                              allyesconfig
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
riscv                randconfig-r042-20220911
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20220912
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20220911
s390                 randconfig-r044-20220911
x86_64               randconfig-a001-20220912
i386                             allyesconfig
x86_64               randconfig-a004-20220912
x86_64               randconfig-a002-20220912
x86_64               randconfig-a005-20220912
x86_64               randconfig-a003-20220912
x86_64               randconfig-a006-20220912
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arc                     haps_hs_smp_defconfig
sh                   sh7724_generic_defconfig
xtensa                              defconfig
powerpc                      tqm8xx_defconfig
sh                         ecovec24_defconfig
mips                       bmips_be_defconfig

clang tested configs:
i386                 randconfig-a014-20220912
i386                 randconfig-a013-20220912
i386                 randconfig-a011-20220912
i386                 randconfig-a012-20220912
i386                 randconfig-a015-20220912
i386                 randconfig-a016-20220912
riscv                randconfig-r042-20220912
hexagon              randconfig-r041-20220912
hexagon              randconfig-r045-20220911
hexagon              randconfig-r041-20220911
hexagon              randconfig-r045-20220912
s390                 randconfig-r044-20220912
x86_64               randconfig-a014-20220912
x86_64               randconfig-a011-20220912
x86_64               randconfig-a012-20220912
x86_64               randconfig-a013-20220912
x86_64               randconfig-a016-20220912
x86_64               randconfig-a015-20220912
arm                         s3c2410_defconfig
arm                            dove_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                          g5_defconfig
arm                         orion5x_defconfig
arm                       imx_v4_v5_defconfig
riscv                          rv32_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
