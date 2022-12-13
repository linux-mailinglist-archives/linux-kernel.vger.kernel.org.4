Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311A764B15D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiLMInP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiLMInE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:43:04 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7255421BF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 00:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670920976; x=1702456976;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OwPqb26X0c57yPJeKhmq65AtMaG4racM+d4naLqCajs=;
  b=TVD8Ad+n+h3Bj7urvFozMTZrR5S4XrBJ/ZaYqFvHAHhG4IdQ9De9iGuW
   AMOtXfo5GGMQn6uflWLQfRfMEQ6oSUiqVd/7lT/hiW5rGgFUK/e6XCaAh
   lf66En27FpmTB49QHU5pQeojuPWpWQOAEfBzwjVPhtx4OMP1JgHJsMPAt
   YjjyQbK5DA2fwhTf6R+VzHGUud8fWKueYmTwIVqkezFatk/P6WrRnfDHJ
   TVNEmDIGVHVrtiMdChSqx3AMydd34cce5bQ8To8nHFNuJf1OuPH9WK/eU
   MwRcQeIyagyHGtRhQYQIEVZCVcgAjnUvH0ISxhxVuGoz1jLqyIAtNGLff
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="319934969"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="319934969"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 00:42:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="648484434"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="648484434"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Dec 2022 00:42:54 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p50sH-0004CR-3D;
        Tue, 13 Dec 2022 08:42:54 +0000
Date:   Tue, 13 Dec 2022 16:42:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 892cd97d2c733b4faa9799dd30967c04d40b7eed
Message-ID: <63983afe.jxwxH6Z+EKCKdXLy%lkp@intel.com>
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
branch HEAD: 892cd97d2c733b4faa9799dd30967c04d40b7eed  Merge branch into tip/master: 'locking/urgent'

elapsed time: 727m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
um                             i386_defconfig
alpha                               defconfig
um                           x86_64_defconfig
s390                                defconfig
x86_64                          rhel-8.3-rust
s390                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64               randconfig-a011-20221212
x86_64                           rhel-8.3-bpf
i386                                defconfig
x86_64                               rhel-8.3
m68k                             allmodconfig
i386                 randconfig-a013-20221212
x86_64               randconfig-a012-20221212
s390                             allyesconfig
x86_64               randconfig-a014-20221212
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                 randconfig-a014-20221212
x86_64                           allyesconfig
x86_64               randconfig-a013-20221212
i386                 randconfig-a012-20221212
x86_64                           rhel-8.3-kvm
sh                               allmodconfig
arc                              allyesconfig
i386                 randconfig-a011-20221212
alpha                            allyesconfig
i386                 randconfig-a015-20221212
x86_64               randconfig-a015-20221212
arm                                 defconfig
mips                             allyesconfig
x86_64               randconfig-a016-20221212
powerpc                          allmodconfig
ia64                             allmodconfig
i386                 randconfig-a016-20221212
m68k                             allyesconfig
riscv                randconfig-r042-20221212
arc                  randconfig-r043-20221211
arc                  randconfig-r043-20221212
arm                  randconfig-r046-20221211
s390                 randconfig-r044-20221212
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64               randconfig-a002-20221212
x86_64               randconfig-a001-20221212
x86_64               randconfig-a004-20221212
i386                 randconfig-a002-20221212
x86_64               randconfig-a003-20221212
i386                 randconfig-a003-20221212
x86_64               randconfig-a006-20221212
i386                 randconfig-a001-20221212
i386                 randconfig-a004-20221212
x86_64               randconfig-a005-20221212
i386                 randconfig-a006-20221212
i386                 randconfig-a005-20221212
arm                  randconfig-r046-20221212
riscv                randconfig-r042-20221211
hexagon              randconfig-r045-20221211
hexagon              randconfig-r041-20221211
hexagon              randconfig-r045-20221212
s390                 randconfig-r044-20221211
hexagon              randconfig-r041-20221212

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
