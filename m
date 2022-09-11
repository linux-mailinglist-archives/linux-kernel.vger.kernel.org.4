Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C585B4C84
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 09:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiIKHZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 03:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiIKHY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 03:24:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15045193CA
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 00:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662881097; x=1694417097;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IFkm61Pu9LUOcfPITXbv2dBr6wA4lOYZQ/zwskcQpy8=;
  b=eE9DwdyrqdgX58XAAJsv3y3h83r2cFj0ft8PBy8eCWognEQMy8MA66QR
   ODgDiZHCeGH9UwfQFhllH918n/0afBGYP1ywfV2l3XzQA5XjMMn9Rx9uZ
   S9d71JsJvoEjd6l8pV3NStNnRllBh2ljrs8fs6FAfPFn5uxCT69xuh+H6
   K3lRGrvoplN6/viHMVpP1KmOZrHgvzZ2PRXntW6aUtpIjVwxLNJr4hPwZ
   9pJ20cmj7HFgF6ky3IWL+frb+hKfpTbQi613LEzwzk0HPQfGTv3PRBkXw
   Z0PHg0AxCCadXjzTy8xOeOH0Dhx/8Q/3H55xmvUYsVHZuPr6AX8ehfRfh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="278093985"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="278093985"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 00:24:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="684094215"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Sep 2022 00:24:41 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXHKb-00017B-0J;
        Sun, 11 Sep 2022 07:24:41 +0000
Date:   Sun, 11 Sep 2022 15:23:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 746afd7df756f8080ae04ddfedfe92c0930cb782
Message-ID: <631d8d03.qJ5R9lPUKRUuMgyR%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 746afd7df756f8080ae04ddfedfe92c0930cb782  Merge branch into tip/master: 'x86/timers'

elapsed time: 720m

configs tested: 72
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-a012
x86_64                        randconfig-a004
i386                          randconfig-a001
x86_64                        randconfig-a002
i386                          randconfig-a003
x86_64                        randconfig-a006
arc                  randconfig-r043-20220911
m68k                             allmodconfig
i386                          randconfig-a005
x86_64                        randconfig-a013
powerpc                           allnoconfig
arc                              allyesconfig
arm                                 defconfig
powerpc                          allmodconfig
x86_64                        randconfig-a011
i386                             allyesconfig
sh                               allmodconfig
riscv                randconfig-r042-20220911
x86_64                    rhel-8.3-kselftests
s390                 randconfig-r044-20220911
arm                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-syz
m68k                             allyesconfig
x86_64                          rhel-8.3-func
mips                             allyesconfig
arm64                            allyesconfig
x86_64                        randconfig-a015
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
xtensa                         virt_defconfig
arm                          pxa3xx_defconfig
arm                         assabet_defconfig
arm                            xcep_defconfig
arm                         nhk8815_defconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220911
loongarch                           defconfig
loongarch                         allnoconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220911
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220911
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-k001
arm                            mmp2_defconfig
powerpc                    mvme5100_defconfig
mips                        bcm63xx_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 mpc8315_rdb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
