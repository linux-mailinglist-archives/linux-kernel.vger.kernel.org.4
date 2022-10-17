Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4C16006CD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJQGq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJQGqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:46:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8A454CB6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 23:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665989213; x=1697525213;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aM3kuleMLB4hHeXqi9/ov/sE1POW2+uDfsUYnLokQpw=;
  b=Gq6S8zHpiKVGsumOUg1VmdKbuMOECqr56N4zVrwdhVRsofTxb2L16G3j
   57gopEjSG18G5ypqPbPX3UMkI+QggWAJGM2vKW4x4ROX4A4J8hj1EKKS7
   GZi3lmaqXZfdU2B817xhLfx8NmQU+eogcI9G/ne1aCpOs7uDXiPWe80b7
   VCg1Lqs12Oj2Wzn3844YMO5gP1a9EnAZaqUQeu1AEHGtxjwbVCtVIIUeh
   4VSwkeBemzn/5oEMNfa6jhx4HwUTP7rnmUw2CcCf9it3fZbA7KJr4k/Mm
   zBLntcgHViKawGFcenBhX3SDiWNbqrjPZw6TVbw5SdwYAIZFoVjLvywL1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="285447701"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="285447701"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2022 23:46:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="957227904"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="957227904"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2022 23:46:51 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1okJtj-00009P-0J;
        Mon, 17 Oct 2022 06:46:51 +0000
Date:   Mon, 17 Oct 2022 14:46:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/6.0-Wcast-function-type-strict] BUILD SUCCESS ad215a992fbcb23d59c55280bb8e730994bd476e
Message-ID: <634cfa29.Pz9JBTX5LYvs3SJf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/6.0-Wcast-function-type-strict
branch HEAD: ad215a992fbcb23d59c55280bb8e730994bd476e  Makefile: Add -Wcast-function-type-strict to test branch

elapsed time: 4336m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
arc                  randconfig-r043-20221012
riscv                randconfig-r042-20221012
um                             i386_defconfig
arm                                 defconfig
um                           x86_64_defconfig
x86_64                              defconfig
s390                                defconfig
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20221017
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                 randconfig-a004-20221017
alpha                            allyesconfig
i386                 randconfig-a005-20221017
i386                 randconfig-a003-20221017
i386                 randconfig-a002-20221017
i386                 randconfig-a001-20221017
i386                 randconfig-a006-20221017
arc                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
i386                             allyesconfig
powerpc                           allnoconfig
sh                   sh7724_generic_defconfig
sh                          rsk7264_defconfig
mips                 decstation_r4k_defconfig
loongarch                         allnoconfig
sh                ecovec24-romimage_defconfig
arm                      footbridge_defconfig
m68k                             alldefconfig
arm                         assabet_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                          allmodconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
mips                             allyesconfig
sh                               allmodconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20221012
hexagon              randconfig-r045-20221012
x86_64               randconfig-a013-20221017
x86_64               randconfig-a014-20221017
x86_64               randconfig-a012-20221017
x86_64               randconfig-a011-20221017
x86_64               randconfig-a015-20221017
x86_64               randconfig-a016-20221017
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
s390                 randconfig-r044-20221017
hexagon              randconfig-r045-20221017
riscv                randconfig-r042-20221017
hexagon              randconfig-r041-20221017

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
