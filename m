Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143C667FBC9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 00:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjA1XLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 18:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjA1XLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 18:11:02 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B6E212B8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 15:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674947460; x=1706483460;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+wrxrpkkQOX9UObXXVjWtKyld0h6Jq47DEHPphoOWdY=;
  b=TMzMGbbfBUh/zs5CUr35N6iypq8nD9gFJSTA1mGM2//G2O5tAjvSQMsi
   xiliOTzFhQfR2DmUJlXTTH/uJ9H2Flvb1RLNUnSAJW4lM4K8z5ikY1SMc
   4DpXJX2Ut4+s8fdMaKzENKv3iQKrFe2jBpbbcsblKrBelC0GvoAoN0Ve0
   WQC/AdkHiRm35+9qR8fKL3RB59LZvD7o3gDcN9+8EdOISrTJFdDIs7FFA
   qjev+WhMIUZGPPhd1EyGZRBVLd73LADY2Br4Xf0Dw9QUzAs1SursdNdGy
   1UzFH7MhM1K6/MkBORy59b4AT9hIjzqtBziqOLn/F7vM4RfWPVqbb8rb5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="389725044"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="389725044"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 15:10:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="992454864"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="992454864"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jan 2023 15:10:58 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLuLZ-0001DU-1k;
        Sat, 28 Jan 2023 23:10:57 +0000
Date:   Sun, 29 Jan 2023 07:10:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1bc06a9b91315cf43491f07beed3837012d9fac2
Message-ID: <63d5ab51.6h6Z8w+N/nFs8Ai7%lkp@intel.com>
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
branch HEAD: 1bc06a9b91315cf43491f07beed3837012d9fac2  Merge branch 'x86/tdx'

elapsed time: 726m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
ia64                             allmodconfig
arc                  randconfig-r043-20230128
i386                 randconfig-a004-20230123
i386                 randconfig-a003-20230123
i386                 randconfig-a002-20230123
arc                                 defconfig
i386                 randconfig-a001-20230123
riscv                randconfig-r042-20230128
s390                             allmodconfig
s390                 randconfig-r044-20230128
alpha                               defconfig
i386                 randconfig-a005-20230123
i386                 randconfig-a006-20230123
s390                                defconfig
x86_64               randconfig-a002-20230123
x86_64               randconfig-a001-20230123
s390                             allyesconfig
x86_64               randconfig-a004-20230123
x86_64               randconfig-a003-20230123
x86_64               randconfig-a005-20230123
x86_64               randconfig-a006-20230123
i386                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                 mpc837x_rdb_defconfig
arm                           sama5_defconfig
i386                          randconfig-c001
arm                             pxa_defconfig
mips                     decstation_defconfig
powerpc                      ep88xc_defconfig
arm                            xcep_defconfig
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
mips                             allyesconfig
alpha                            allyesconfig
powerpc                          allmodconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec

clang tested configs:
arm                  randconfig-r046-20230128
hexagon              randconfig-r041-20230128
hexagon              randconfig-r045-20230128
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a015-20230123
i386                 randconfig-a012-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a011-20230123
x86_64               randconfig-a016-20230123
i386                 randconfig-a014-20230123
x86_64               randconfig-a014-20230123
i386                 randconfig-a016-20230123
i386                 randconfig-a015-20230123
riscv                randconfig-r042-20230123
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
mips                     loongson2k_defconfig
mips                      maltaaprp_defconfig
powerpc                 xes_mpc85xx_defconfig
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
