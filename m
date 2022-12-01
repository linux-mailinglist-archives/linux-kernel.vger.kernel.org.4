Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A1063E63D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiLAAMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiLAAMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:12:25 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4085A99F3C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 16:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669853096; x=1701389096;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8w8AxXq0ytyb8v/ve43TWCjscPBiKmJB4AeElJTMUcA=;
  b=hKryAQ4+7zvrzZf2OsERqvDWOqmAJHcVOnpJhKpBhRc+JszfbQlc2F2H
   n1bfULCwlYboAu8y9/fT9rdwduR95JFjSuVuuD6d2fbbRLX8zUo/a/pJA
   DaCw6nJVIxGIPrNpjNVsPxPwzDdhTcVI/L1IRpZWO9rJR1xjKKCyoAD3f
   FWIIXRYBaGjxP8TxUvJr93O7GxTqMzfcgwbgJP27ynaEm9RnZAnI5hn0r
   NV9/6pFDc79t6uSr2UA4YrtTZ9g9ocslEIDAIedXMcLpLw0VqrZGTX8uQ
   QNJGURllNVKEaEbewetGP8FMjxrGMY/m3kqHkzgMSgfTrgPE3tNG81k+V
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="295906526"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="295906526"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:04:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="644417166"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="644417166"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 Nov 2022 16:04:54 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0X4O-000Bw7-32;
        Thu, 01 Dec 2022 00:04:52 +0000
Date:   Thu, 01 Dec 2022 08:03:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 d800169041c0e035160c8b81f30d4b7e8f8ef777
Message-ID: <6387ef67.TNT/9jrW3IL8AQnd%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: d800169041c0e035160c8b81f30d4b7e8f8ef777  x86/cpuid: Carve out all CPUID functionality

elapsed time: 725m

configs tested: 83
configs skipped: 61

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
ia64                             allmodconfig
i386                 randconfig-a001-20221128
i386                 randconfig-a005-20221128
i386                 randconfig-a006-20221128
i386                 randconfig-a004-20221128
i386                 randconfig-a003-20221128
i386                 randconfig-a002-20221128
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                              defconfig
x86_64                           allyesconfig
x86_64               randconfig-a002-20221128
x86_64               randconfig-a001-20221128
x86_64               randconfig-a004-20221128
x86_64               randconfig-a006-20221128
x86_64               randconfig-a005-20221128
x86_64               randconfig-a003-20221128
x86_64                            allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
um                               alldefconfig
alpha                             allnoconfig
powerpc                     asp8347_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig

clang tested configs:
s390                 randconfig-r044-20221128
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
hexagon              randconfig-r045-20221128
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a014-20221128
i386                 randconfig-a011-20221128
i386                 randconfig-a013-20221128
i386                 randconfig-a016-20221128
i386                 randconfig-a012-20221128
i386                 randconfig-a015-20221128
x86_64               randconfig-a011-20221128
x86_64               randconfig-a014-20221128
x86_64               randconfig-a012-20221128
x86_64               randconfig-a013-20221128
x86_64               randconfig-a016-20221128
x86_64               randconfig-a015-20221128
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-k001-20221128

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
