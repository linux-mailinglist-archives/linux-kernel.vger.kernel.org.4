Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1306C63E32F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 23:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiK3WKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 17:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiK3WKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 17:10:11 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AD7975CC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 14:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669846189; x=1701382189;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ml3wv57xZNwgwF7hGo3K4/qvXtTdZjCodPVJomOlOoo=;
  b=AU+90+kIaFzXsams66uqmnlmZkSSM/i/otn1oVl9jGiDKr81h30UhCS9
   nnpV5AE2qlODotr5xiL/R+8YKJwI3BggJj1Dw8pSRr71HYvXS1yDhZeNM
   vBfzIULwjil9zOXilRaepnsi5X1z5vn0fSBRCmp7vHcc1maUb/VG1sbJH
   78AFgeRqhAg5GUslHikywy55otnySGEZ2gdeZr1xBwVYNq4iwqUqd11PE
   LrW4v0Xn0hxoPMitj+O26+xnBrStrt3gSzGge+Tai96qF2oSN+QuwJ5jW
   CKP7jyeTpVp/o0JP18vwgrKPPgPWz60tjVl90rD4O3fyaoFCfECtDINuW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="298895212"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="298895212"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 14:09:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="675191160"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="675191160"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Nov 2022 14:09:47 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0VH1-000Bnc-0P;
        Wed, 30 Nov 2022 22:09:47 +0000
Date:   Thu, 01 Dec 2022 06:09:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 517e6a301f34613bff24a8e35b5455884f2d83d8
Message-ID: <6387d4a8.Xrkf76S9i6aY0p4X%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 517e6a301f34613bff24a8e35b5455884f2d83d8  perf: Fix perf_pending_task() UaF

elapsed time: 724m

configs tested: 84
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
s390                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
s390                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
arc                  randconfig-r043-20221128
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                            allnoconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64               randconfig-a001-20221128
x86_64               randconfig-a003-20221128
x86_64               randconfig-a004-20221128
arm                       omap2plus_defconfig
powerpc                      ep88xc_defconfig
sparc64                          alldefconfig
x86_64               randconfig-a002-20221128
x86_64               randconfig-a005-20221128
x86_64               randconfig-a006-20221128
i386                 randconfig-a001-20221128
i386                 randconfig-a005-20221128
i386                 randconfig-a006-20221128
i386                 randconfig-a004-20221128
i386                 randconfig-a003-20221128
i386                 randconfig-a002-20221128
sh                           se7722_defconfig
sh                          polaris_defconfig
sh                           se7705_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                        trizeps4_defconfig
m68k                          atari_defconfig
sh                             shx3_defconfig
mips                 decstation_r4k_defconfig
ia64                            zx1_defconfig
sh                        edosk7705_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002

clang tested configs:
hexagon              randconfig-r045-20221128
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
s390                 randconfig-r044-20221128
x86_64               randconfig-a012-20221128
x86_64               randconfig-a014-20221128
x86_64               randconfig-a011-20221128
x86_64               randconfig-a015-20221128
x86_64               randconfig-a013-20221128
x86_64               randconfig-a016-20221128
i386                 randconfig-a014-20221128
i386                 randconfig-a011-20221128
i386                 randconfig-a013-20221128
i386                 randconfig-a016-20221128
i386                 randconfig-a012-20221128
i386                 randconfig-a015-20221128
x86_64               randconfig-k001-20221128
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
