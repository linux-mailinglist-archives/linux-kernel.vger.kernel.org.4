Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060C763AB8D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiK1Osu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiK1Oss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:48:48 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899AE615D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669646927; x=1701182927;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3FilFUSsLfTHEvHoamlt7F3oU8W6TpDl0eJ1J4FTPMI=;
  b=E4HKSXyWhfY5pCuEUIrQbXPZchYfP3rFZjQeKI+Jhdjmq5CTqSpoyIRc
   eCHbWuJRjujoBZEGvFWJmDU1FroEjJklxeXcXq9DGt1kczbDh+yg+OoDN
   wUeRNIUY2AUEJijESEyN6SfC90Sm6PBaGT8/+Syt8YsrccwQ7sBagDGjR
   l+Bv4LuGU2/WxyYLkfPblZ3Anu3A7Tz1UINHEIpRSwyCFwPpIZjJ/U8gS
   gvQO2WbsAPtrStko1W1rkafm5nYsmq0A40O3K5nzTpaCwRlOux05+7DqE
   NI8B9zn1GBM6OalUx96zKqWOr6aJTfZHf85K4iTLyHtelgnk4Yq8Rekto
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="316679469"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="316679469"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 06:48:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="711988412"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="711988412"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Nov 2022 06:48:45 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ozfR7-00085N-0Y;
        Mon, 28 Nov 2022 14:48:45 +0000
Date:   Mon, 28 Nov 2022 22:48:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7613c41a0d75ae7e5bce39bdb2bb48736c9420bd
Message-ID: <6384ca28.Mx/mODEEE0IIwlLh%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 7613c41a0d75ae7e5bce39bdb2bb48736c9420bd  Merge x86/cache into tip/master

elapsed time: 922m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
arc                  randconfig-r043-20221127
arc                  randconfig-r043-20221128
x86_64                              defconfig
riscv                randconfig-r042-20221127
s390                 randconfig-r044-20221127
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                          randconfig-a014
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a012
s390                                defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                             allyesconfig
i386                          randconfig-a016
s390                             allmodconfig
i386                 randconfig-a002-20221128
powerpc                           allnoconfig
i386                 randconfig-a003-20221128
arc                              allyesconfig
i386                 randconfig-a001-20221128
powerpc                          allmodconfig
alpha                            allyesconfig
mips                             allyesconfig
i386                 randconfig-a005-20221128
s390                             allyesconfig
i386                 randconfig-a006-20221128
i386                 randconfig-a004-20221128
x86_64               randconfig-a002-20221128
sh                               allmodconfig
x86_64               randconfig-a001-20221128
x86_64               randconfig-a003-20221128
x86_64               randconfig-a004-20221128
m68k                             allyesconfig
x86_64               randconfig-a005-20221128
x86_64               randconfig-a006-20221128
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
m68k                             allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r045-20221127
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
s390                 randconfig-r044-20221128
hexagon              randconfig-r041-20221127
hexagon              randconfig-r045-20221128
i386                          randconfig-a013
i386                          randconfig-a011
x86_64               randconfig-a012-20221128
x86_64               randconfig-a016-20221128
x86_64               randconfig-a014-20221128
i386                          randconfig-a015
x86_64               randconfig-a011-20221128
x86_64               randconfig-a013-20221128
x86_64               randconfig-a015-20221128
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                 randconfig-a012-20221128
i386                 randconfig-a011-20221128
i386                 randconfig-a013-20221128
x86_64                        randconfig-a005
i386                 randconfig-a015-20221128
i386                 randconfig-a016-20221128
i386                 randconfig-a014-20221128

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
