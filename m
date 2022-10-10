Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DDB5F9D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiJJKt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiJJKt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:49:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE5F5FAD0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665398965; x=1696934965;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rhy7kGOCOYV3cl0qx/Rbp7vAd0IYqrbC4amiV1bgRrU=;
  b=jppb4a9KhCp3euVikoi2nPSpe8wSNsH9QAj/e0y/llz2ZMlP1MLHq+C5
   8PjcnnPZ+XobwxazBx0elo8gxG6VLTi1yofwk32pt/ktBxegavqvYrnEK
   bOgzgbI0Z/6yPMEYfd2gLnMAR5/KUlRp22agvlmo5P+r4BIBYYGGc/ATt
   WpRcLfPrqzHBldDoiZS7vJtplnC+wEHuF7qMIbaTkd8YKcDIdY40V1w5/
   AfL0ttBUJFEH/EB64ubURPQ7eci+d8tFmTppt42S/TE27XaPbnObA+OUN
   7ZYRRQFiO1woKEfEfp3enT0csD6niDna8i1NW/ttY42wbWHiqimzH1yHA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="390503513"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="390503513"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 03:49:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="656891795"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="656891795"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 10 Oct 2022 03:49:24 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ohqLb-0001iq-1t;
        Mon, 10 Oct 2022 10:49:23 +0000
Date:   Mon, 10 Oct 2022 18:48:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam0-uapi-warnings] BUILD SUCCESS
 fa2ad63ff42c407ad38a094fd4d435f162625e05
Message-ID: <6343f890.7CYLUcfSaJwcC0XG%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam0-uapi-warnings
branch HEAD: fa2ad63ff42c407ad38a094fd4d435f162625e05  USB: usbfs: Fix flexible-array warning in user-space

elapsed time: 724m

configs tested: 93
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
arm                                 defconfig
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
i386                 randconfig-a014-20221010
x86_64               randconfig-a011-20221010
arm                              allyesconfig
i386                 randconfig-a012-20221010
x86_64               randconfig-a014-20221010
i386                 randconfig-a011-20221010
x86_64                          rhel-8.3-func
s390                                defconfig
x86_64               randconfig-a012-20221010
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64               randconfig-a013-20221010
s390                             allmodconfig
x86_64                           rhel-8.3-syz
i386                 randconfig-a013-20221010
x86_64                        randconfig-a002
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a016-20221010
x86_64               randconfig-a015-20221010
powerpc                           allnoconfig
arc                               allnoconfig
x86_64                           rhel-8.3-kvm
alpha                             allnoconfig
i386                             allyesconfig
riscv                             allnoconfig
csky                              allnoconfig
i386                 randconfig-a015-20221010
i386                 randconfig-a016-20221010
mips                             allyesconfig
arc                              allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
s390                             allyesconfig
arc                  randconfig-r043-20221009
x86_64                        randconfig-a004
alpha                            allyesconfig
sh                               allmodconfig
m68k                             allyesconfig
ia64                             allmodconfig
riscv                randconfig-r042-20221009
m68k                             allmodconfig
s390                 randconfig-r044-20221009
arm                         vf610m4_defconfig
arm                         lubbock_defconfig
powerpc                      tqm8xx_defconfig
sh                          lboxre2_defconfig
mips                    maltaup_xpa_defconfig
powerpc                      mgcoge_defconfig
mips                        bcm47xx_defconfig
xtensa                  nommu_kc705_defconfig
arm                           sama5_defconfig
arm                          pxa910_defconfig
arm                           h5000_defconfig
arm                        keystone_defconfig
sh                      rts7751r2d1_defconfig
x86_64               randconfig-k001-20221010
sh                            shmin_defconfig
powerpc                      pcm030_defconfig
powerpc                 canyonlands_defconfig
sh                        sh7785lcr_defconfig
i386                 randconfig-c001-20221010
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                       omap2plus_defconfig
m68k                                defconfig
sh                          sdk7780_defconfig
parisc                generic-64bit_defconfig
mips                          rb532_defconfig
parisc64                         alldefconfig

clang tested configs:
i386                 randconfig-a003-20221010
x86_64                        randconfig-a005
hexagon              randconfig-r045-20221009
i386                 randconfig-a004-20221010
i386                 randconfig-a002-20221010
hexagon              randconfig-r041-20221009
i386                 randconfig-a005-20221010
x86_64                        randconfig-a001
i386                 randconfig-a001-20221010
i386                 randconfig-a006-20221010
x86_64                        randconfig-a003
powerpc                  mpc885_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
