Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B70860C330
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJYFVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiJYFVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:21:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E643611541B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666675261; x=1698211261;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uByfUWIOND2taocQHvxQidCm33vd0DriLyHb1/9PpGk=;
  b=F02r0IkNthbpVB8D+7WnksN9ZpMzmmy5Gq9Hk0M9rH84yS0h9S22R8e6
   b4MfbVDfc45+F9FLa+vGFNm+NjTLG2aViVz8y1yn2KYj1/knOnEXoyWK2
   NWMMag9aiOtNU1ndvKL5RdayFd28BqMfBbJZWpfuzVinpJjx4JCudBeC2
   feHfn6vL761GxC4g+sn4pWmJe7gXYloYsFqs80Kp4nWXvUnNcqUFASC0r
   sW1OGoo6h33GlHpdZtMudHgg86CcjyS8BWfulzAJERaZBtzZs/7CtRFLX
   dnITcMoQYCLDGapQk/91VPINzgQ0OpSr751R6/xWMb2m0K8w3ffdT+hzt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="371805893"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="371805893"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 22:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="582650607"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="582650607"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 24 Oct 2022 22:21:00 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onCN1-0005ws-2p;
        Tue, 25 Oct 2022 05:20:59 +0000
Date:   Tue, 25 Oct 2022 13:20:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 9440c42941606af4c379afa3cf8624f0dc43a629
Message-ID: <6357721b.kUPzJ+9NUpvcVFpW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 9440c42941606af4c379afa3cf8624f0dc43a629  x86/syscall: Include asm/ptrace.h in syscall_wrapper header

elapsed time: 731m

configs tested: 79
configs skipped: 78

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                 randconfig-a011-20221024
i386                 randconfig-a013-20221024
i386                 randconfig-a012-20221024
i386                 randconfig-a015-20221024
i386                 randconfig-a014-20221024
i386                 randconfig-a016-20221024
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arc                  randconfig-r043-20221024
s390                 randconfig-r044-20221024
riscv                randconfig-r042-20221024
arc                              alldefconfig
sh                        dreamcast_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                          polaris_defconfig
riscv                    nommu_k210_defconfig
xtensa                    xip_kc705_defconfig
ia64                             allmodconfig
x86_64               randconfig-k001-20221024
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64               randconfig-a014-20221024
x86_64               randconfig-a015-20221024
x86_64               randconfig-a016-20221024
x86_64               randconfig-a013-20221024
x86_64               randconfig-a012-20221024
x86_64               randconfig-a011-20221024
arm                        mini2440_defconfig
powerpc                      chrp32_defconfig
sh                          lboxre2_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-c001
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                       m5249evb_defconfig
arm                       aspeed_g5_defconfig
powerpc                  storcenter_defconfig
powerpc                 canyonlands_defconfig
powerpc                     tqm8555_defconfig
sh                           se7712_defconfig

clang tested configs:
i386                 randconfig-a004-20221024
i386                 randconfig-a001-20221024
i386                 randconfig-a002-20221024
i386                 randconfig-a003-20221024
i386                 randconfig-a005-20221024
x86_64               randconfig-a001-20221024
i386                 randconfig-a006-20221024
x86_64               randconfig-a003-20221024
x86_64               randconfig-a002-20221024
x86_64               randconfig-a004-20221024
x86_64               randconfig-a005-20221024
x86_64               randconfig-a006-20221024
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
