Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00476636354
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbiKWPW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbiKWPWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:22:33 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7BD1134
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669216950; x=1700752950;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0NIejNQpV8quIAUKsiRNP8gc7z0BU9lL3ortd8Zz/VQ=;
  b=CEFI7BCMlSlVnj2YlznAvRxu+O24jP+fg0mq0LIE7Od/HU6ujPbp/N5Y
   9qM29uV3jN19Vksrutzs+dyoSaFQmVw4HtQhtXJ4c+FJm6h00X1NBMusY
   mN9s16qhcLVstJjQNb+ilCnhI8nio2Zw8Rpiyt+bLoHCnap7tH2LYQ0lW
   Xkmqr56/DUk9yCi3J74hrjWEXAq7BY4wup6hdCycuQ/8pa7wWV7HRgYWE
   NS8G6YlWhOtX5DZhs9BBUO4eDciqYVW5bSSa+sr3SrhGF7G5qZ/KNnTGA
   sxF/SgrxDS98TbNA2CtZ2hMhhew2HBDXYyvC67dXpL+fjBeoa9jHk08dU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="294478018"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="294478018"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 07:22:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="886987956"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="886987956"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Nov 2022 07:22:24 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxrZw-0002qh-0v;
        Wed, 23 Nov 2022 15:22:24 +0000
Date:   Wed, 23 Nov 2022 23:21:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 4dbd6a3e90e03130973688fd79e19425f720d999
Message-ID: <637e3a89.Zt8Syc8jB/xFgTPO%lkp@intel.com>
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
branch HEAD: 4dbd6a3e90e03130973688fd79e19425f720d999  x86/ioremap: Fix page aligned size calculation in __ioremap_caller()

elapsed time: 1661m

configs tested: 80
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a014-20221121
i386                 randconfig-a015-20221121
i386                 randconfig-a016-20221121
ia64                             allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64               randconfig-a012-20221121
x86_64               randconfig-a011-20221121
m68k                             allmodconfig
x86_64               randconfig-a013-20221121
arc                              allyesconfig
alpha                            allyesconfig
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
m68k                             allyesconfig
x86_64               randconfig-a014-20221121
i386                                defconfig
arc                  randconfig-r043-20221122
i386                             allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20221120
riscv                randconfig-r042-20221121
arc                  randconfig-r043-20221121
s390                 randconfig-r044-20221121
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
x86_64               randconfig-a001-20221121
x86_64               randconfig-a003-20221121
x86_64               randconfig-a002-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a006-20221121
hexagon              randconfig-r041-20221122
hexagon              randconfig-r045-20221122
s390                 randconfig-r044-20221122
riscv                randconfig-r042-20221122
i386                 randconfig-a001-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221120
hexagon              randconfig-r041-20221121
hexagon              randconfig-r045-20221120
hexagon              randconfig-r045-20221121
riscv                randconfig-r042-20221120
s390                 randconfig-r044-20221120

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
