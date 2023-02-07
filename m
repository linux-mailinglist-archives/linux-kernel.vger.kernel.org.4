Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A5968D64A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjBGMSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjBGMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:18:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5291E2B6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 04:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675772284; x=1707308284;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2CRBK11OpDQPINTmW6yxqLV2jTk49RnhRdZNxJ/8ij0=;
  b=cX9dufh/6aqTm7a1OKVpDX4Wo7xXdmGJhKQjBHJQEsdsI1kySEhkMc/D
   fooeTrf5ySIM/7UGJoB6Xwr6p17cRHDltbzswj9nyZYzsX5duRP+RTTuX
   mI+p5+Ycbzq4Nqb3x1vGoFEWx+xNsR5J0qZzJLa+EPrwVsYoB3Rd8++AD
   dMk9Rk3ke/WNBIMknqFpaZ5GgnFZFRXUzGtFtWY1p+yJGo7ZB4SnogJCa
   WAeB/R7+IV16vo6XS6SfAeYHZSj0Vn4rKFbrbDXFnYEE7gyUUMUb/IY3w
   15GaEY1hDvKBOJygHD8yonYiRV00d/4/xwp51JaSY59Lp42/gS7Vmu6rA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="309823204"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="309823204"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 04:18:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616794306"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="616794306"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Feb 2023 04:18:01 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPMvA-0003XC-0d;
        Tue, 07 Feb 2023 12:18:00 +0000
Date:   Tue, 07 Feb 2023 20:17:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 d67c17ddc89943480da8cd3bfd383d087de45908
Message-ID: <63e24177.M6B/TLj5cgOMktkj%lkp@intel.com>
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
branch HEAD: d67c17ddc89943480da8cd3bfd383d087de45908  Merge branch into tip/master: 'x86/vdso'

elapsed time: 726m

configs tested: 83
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
x86_64                              defconfig
ia64                             allmodconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
i386                 randconfig-a013-20230206
x86_64               randconfig-a014-20230206
i386                 randconfig-a011-20230206
s390                 randconfig-r044-20230206
arc                  randconfig-r043-20230205
i386                 randconfig-a014-20230206
x86_64                           rhel-8.3-bpf
x86_64               randconfig-a013-20230206
i386                 randconfig-a012-20230206
arm                  randconfig-r046-20230205
x86_64                           rhel-8.3-syz
arm                                 defconfig
i386                 randconfig-a016-20230206
x86_64                           allyesconfig
x86_64               randconfig-a011-20230206
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a015-20230206
arc                  randconfig-r043-20230206
x86_64               randconfig-a012-20230206
x86_64                           rhel-8.3-kvm
i386                 randconfig-a015-20230206
x86_64               randconfig-a016-20230206
riscv                randconfig-r042-20230206
arm64                            allyesconfig
arm                              allyesconfig
i386                                defconfig
i386                          randconfig-c001
x86_64                        randconfig-c001
arm                  randconfig-c002-20230207
i386                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
mips                           jazz_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
sh                          r7780mp_defconfig
s390                                defconfig
um                               alldefconfig
xtensa                  nommu_kc705_defconfig
arm                            xcep_defconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
s390                             allyesconfig
arc                              allyesconfig
powerpc                       eiger_defconfig
powerpc                      ppc6xx_defconfig

clang tested configs:
hexagon              randconfig-r041-20230205
riscv                randconfig-r042-20230205
hexagon              randconfig-r045-20230206
hexagon              randconfig-r041-20230206
arm                  randconfig-r046-20230206
s390                 randconfig-r044-20230205
hexagon              randconfig-r045-20230205
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a001-20230206
x86_64               randconfig-a005-20230206
x86_64               randconfig-a006-20230206
i386                 randconfig-a002-20230206
i386                 randconfig-a004-20230206
i386                 randconfig-a003-20230206
i386                 randconfig-a001-20230206
i386                 randconfig-a005-20230206
i386                 randconfig-a006-20230206
x86_64                          rhel-8.3-rust
powerpc                      ppc44x_defconfig
hexagon                             defconfig
arm                         hackkit_defconfig
i386                              allnoconfig
powerpc                     akebono_defconfig

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
