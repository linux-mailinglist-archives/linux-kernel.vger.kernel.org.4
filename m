Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CE6666824
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbjALAyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbjALAyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:54:35 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F82F584
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673484874; x=1705020874;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=AXTEgfXLluYIaIyviLVvMHoUo7nuk4yv86VjfX2zmGY=;
  b=A9IcbPB26QSjkZqe+d1SQERY//JcZuvnBAlhW3WfioQVFCdQG36Ya1V5
   5QZBRSvcPEpqICq/CA0soD7XWziHLRds8Zk/LCX732A6QYpT+HARwGf1r
   bfGEhgVSg9T7ilWMJJaJebEQknIrf/tgXXUlwcEVdTFz76vFkpkoo3roi
   /46Q1nXS5NYR4ksJ+EtHOIsX0MBs9UpWaKmxHYcTHu5aTsaUNkpO6B6TV
   apJorOf5Fj0uE4vw57abpkz8vST5ILkQ/koLukhc3RuH6VAh2g8caZuHC
   MCS+3DU2ouhppVmikiODR8XaBDIdi2tRpyvE307EKelgceuvwBWZ7xnEj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303953719"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="303953719"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 16:54:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="720904689"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="720904689"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jan 2023 16:54:32 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFlrT-0009fW-0x;
        Thu, 12 Jan 2023 00:54:31 +0000
Date:   Thu, 12 Jan 2023 08:54:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 50c66d7b049ddec095644a005bfe0b28e22c4b02
Message-ID: <63bf5a41.617hhbPSVhmsKcsr%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 50c66d7b049ddec095644a005bfe0b28e22c4b02  x86/setup: Move duplicate boot_cpu_data definition out of the ifdeffery

elapsed time: 728m

configs tested: 79
configs skipped: 75

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                              defconfig
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                        randconfig-a002
i386                          randconfig-a001
x86_64                        randconfig-a013
i386                          randconfig-a003
x86_64                        randconfig-a011
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                          rhel-8.3-func
x86_64                        randconfig-a015
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
riscv                randconfig-r042-20230110
s390                 randconfig-r044-20230110
arc                  randconfig-r043-20230110
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
ia64                             allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm                          gemini_defconfig
powerpc                     tqm8548_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arc                        vdk_hs38_defconfig
sh                   sh7770_generic_defconfig
loongarch                           defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                         amcore_defconfig
arm                        multi_v7_defconfig
sh                              ul2_defconfig
m68k                             alldefconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    klondike_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a016
i386                          randconfig-a006
powerpc                      chrp32_defconfig
powerpc                        fsp2_defconfig
arm                         shannon_defconfig
x86_64                        randconfig-k001
arm                  randconfig-r046-20230110
hexagon              randconfig-r041-20230110
hexagon              randconfig-r045-20230110

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
