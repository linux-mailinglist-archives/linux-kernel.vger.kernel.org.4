Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BE1625289
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiKKE35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKKE3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:29:54 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733CB3204B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668140993; x=1699676993;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gP3LrtLGBNDMEHTeh2Vrb+HmrPaY9IeSaR3ZxTIPMtQ=;
  b=TfOl6Tu5ZI5N7spx0YSZ54adb5UXkTDyMvTn6+xfMZnGZaAHXqzCW1E2
   uDzsoQvI8cpjvbdj8BEPvO8bGSOKab51a4sdCagdz1Pn5r68BbqIuwjMc
   w/CLCjt5Aed4KZXM0okECNDh+HA7xn9Y/QS8cSmq4/QcyMb0cB1M9O2Z3
   NdcD4c6bXNEHemfvjcjNLoThXTzxR3h09xJ+uhoCsIaK/u+xKJPrZ8GbL
   HSTsqTKbXMjh5fCH0ZLXnIpGpcX8dopEBQCYumO+jTQJdAeWyLyx10bcU
   5KJrCSXWo/NNhWNSyJMMRpr3a0KKn0mlJBK5ieGdy5eIG2P6+JwX6nXtY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="310234305"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="310234305"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:29:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="670617289"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="670617289"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 Nov 2022 20:29:51 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otLfr-0003Z9-0p;
        Fri, 11 Nov 2022 04:29:51 +0000
Date:   Fri, 11 Nov 2022 12:29:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 36b038791e1e2baea892e9276588815fd14894b4
Message-ID: <636dcf9b.CvIkT/1b7fdqRoIt%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 36b038791e1e2baea892e9276588815fd14894b4  x86/fpu: Drop fpregs lock before inheriting FPU permissions

elapsed time: 720m

configs tested: 66
configs skipped: 65

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                            allnoconfig
sh                           se7722_defconfig
arm                         cm_x300_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
ia64                        generic_defconfig
openrisc                         alldefconfig
i386                          randconfig-c001
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                     taishan_defconfig
mips                             allyesconfig
powerpc                 mpc85xx_cds_defconfig
arm                         vf610m4_defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
powerpc                       ppc64_defconfig
arm                          pxa910_defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
s390                 randconfig-r044-20221111
powerpc                    amigaone_defconfig
arm                           viper_defconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
s390                 randconfig-r044-20221110
riscv                randconfig-r042-20221110
hexagon              randconfig-r041-20221110
hexagon              randconfig-r045-20221110
x86_64                        randconfig-k001
hexagon              randconfig-r041-20221111
hexagon              randconfig-r045-20221111
mips                malta_qemu_32r6_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
