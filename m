Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F12F677497
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 05:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjAWEOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 23:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjAWEOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 23:14:00 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ACBB75B
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 20:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674447237; x=1705983237;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=g4IKKk+7YUdNxZPwMy1Bf8HH8N9H0J8jbgE5JUK+7ZE=;
  b=gIE6dWQzeTZWB3IL2RIIh1qZqhCUqVK1Ag1+/YPLChK/ev5Bwqcsfg+v
   XihZFziPoMVsUjkFIAzq+adKr3A6Q4CSwKOJQf7T8quyBD09BfkKpmAFv
   C4Jz+JzOgT/1mzMckyx1kwo9D4jSzMOActH1TuaEQaq1lAoGiuEVK7zal
   Y/esegn9QZsJvogZVxZEeQKPkh4pN9pf6dMGjzr4PNBfYcjSktmBZwsyc
   MdvlQ+rAXlkVYuiuQ90nnhHKzs3x8UypGX0CRagOk/TOT4a1I1RhQr50p
   3Kx9l6GljJJXTAmj2uYNRdBWPszY8h8OSp8dC/7pUhbW720KhD+dtosom
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="306324705"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="306324705"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 20:13:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="990272327"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="990272327"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jan 2023 20:13:55 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJoDS-0005PX-2n;
        Mon, 23 Jan 2023 04:13:54 +0000
Date:   Mon, 23 Jan 2023 12:12:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 27b5de622ea3fe0ad5a31a0ebd9f7a0a276932d1
Message-ID: <63ce0948.uecOB5ZfFdpWh6K6%lkp@intel.com>
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
branch HEAD: 27b5de622ea3fe0ad5a31a0ebd9f7a0a276932d1  x86/build: Move '-mindirect-branch-cs-prefix' out of GCC-only block

elapsed time: 720m

configs tested: 81
configs skipped: 70

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                          randconfig-a005
x86_64                           allyesconfig
i386                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a012
x86_64               randconfig-a002-20230123
i386                          randconfig-a016
x86_64               randconfig-a001-20230123
x86_64               randconfig-a004-20230123
i386                          randconfig-a014
x86_64               randconfig-a003-20230123
x86_64               randconfig-a006-20230123
x86_64               randconfig-a005-20230123
um                           x86_64_defconfig
um                             i386_defconfig
ia64                             allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sh                            titan_defconfig
sh                          rsk7264_defconfig
powerpc                 linkstation_defconfig
arc                  randconfig-r043-20230122
riscv                randconfig-r042-20230122
s390                 randconfig-r044-20230122
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sparc                               defconfig
powerpc                         ps3_defconfig
arm                           tegra_defconfig
powerpc                        cell_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                          rhel-8.3-rust
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a014-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a015-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a016-20230123
i386                 randconfig-a012-20230123
i386                 randconfig-a015-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a014-20230123
riscv                randconfig-r042-20230123
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
arm                         s5pv210_defconfig
arm                         mv78xx0_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                    gamecube_defconfig
i386                             allyesconfig
riscv                          rv32_defconfig
powerpc                     skiroot_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
