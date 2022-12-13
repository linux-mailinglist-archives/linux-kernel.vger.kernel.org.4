Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7340E64B038
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 08:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiLMHMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 02:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiLMHMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 02:12:05 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1162B6318
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670915523; x=1702451523;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Ll+D5zvxpWN8ppQVMuvDAeq2PDR9RSDK8wNFPhmGN+0=;
  b=CUWbVHQcEZkF9oWM5AUMpDT7AR25uAo6tuUjbdViDSzVaPfWsro4RawE
   5jLFfrq8bTl6BTj/rZ4/cVvk2kcdKNpvJ6oNKYzZRKP27kg5tJ2gxSUeR
   eA04mhZ0gpKDmNJaipFIMPzCqfenbBcOaJ9q8ZZAMS4eEapJTY1DO6nmc
   VRV+44uO2qxkElQc8LXXIlmca/Q7kNtbqvg7F8gISCddup6HPyMexEAUe
   yBS+be+xvVKemhgnW7F8kKsNy938NG924KMvve0a6cFcxYF1C/4VOXgGF
   GdMN/6IFUM2iGxC+cLj08x42VZKAyCHPX8ZcBA1Z0RE7WgwYrMMfiqUvz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="316764080"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="316764080"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 23:12:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="893805812"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="893805812"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 12 Dec 2022 23:12:01 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p4zSK-00049r-2x;
        Tue, 13 Dec 2022 07:12:00 +0000
Date:   Tue, 13 Dec 2022 15:11:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 1c0908d8e441631f5b8ba433523cf39339ee2ba0
Message-ID: <63982594.LCGcp9JlS9qVv85G%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: 1c0908d8e441631f5b8ba433523cf39339ee2ba0  rtmutex: Add acquire semantics for rtmutex lock acquisition slow path

elapsed time: 726m

configs tested: 85
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
i386                 randconfig-a013-20221212
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
s390                                defconfig
i386                 randconfig-a014-20221212
s390                             allmodconfig
x86_64                         rhel-8.3-kunit
i386                 randconfig-a012-20221212
x86_64                           rhel-8.3-kvm
i386                 randconfig-a011-20221212
i386                 randconfig-a015-20221212
i386                 randconfig-a016-20221212
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                            allnoconfig
s390                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
ia64                             allmodconfig
i386                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-rust
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-c001
x86_64               randconfig-a013-20221212
x86_64               randconfig-a015-20221212
x86_64               randconfig-a012-20221212
x86_64               randconfig-a016-20221212
x86_64               randconfig-a014-20221212
x86_64               randconfig-a011-20221212
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                        shmobile_defconfig
powerpc                     pq2fads_defconfig
sh                 kfr2r09-romimage_defconfig
openrisc                         alldefconfig
sh                   secureedge5410_defconfig
sh                          rsk7203_defconfig
arc                     haps_hs_smp_defconfig
nios2                            allyesconfig
powerpc                 mpc837x_rdb_defconfig
sh                               j2_defconfig
mips                           gcw0_defconfig
xtensa                          iss_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-c001
arm                  randconfig-c002-20221211

clang tested configs:
i386                 randconfig-a002-20221212
i386                 randconfig-a003-20221212
i386                 randconfig-a001-20221212
i386                 randconfig-a004-20221212
i386                 randconfig-a006-20221212
i386                 randconfig-a005-20221212
x86_64               randconfig-a006-20221212
x86_64               randconfig-a002-20221212
x86_64               randconfig-a005-20221212
x86_64               randconfig-a003-20221212
x86_64               randconfig-a001-20221212
x86_64               randconfig-a004-20221212
x86_64                        randconfig-k001
arm                          pxa168_defconfig
mips                        omega2p_defconfig
mips                          ath79_defconfig
mips                  cavium_octeon_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
