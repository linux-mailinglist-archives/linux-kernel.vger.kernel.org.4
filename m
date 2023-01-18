Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CE1672CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjARXuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjARXue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:50:34 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB976CCC5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674085751; x=1705621751;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XZWPdxsEFZeQX0dOtD54StaOkc/y+F+H3AY93mGePGw=;
  b=I+/6w8CMmn7xxPv3iw0kqoPNtLkGRpRAkBYVBqtsqOB0y4yYrjOFCZdr
   NWV369p1ogZ4Gw1w+gbHoh9Sl3gAuof8a/xIo1NTORZT15uhS6+IWUvXe
   NPnBOmVPVGV5CWRG61YesmUB7+ImGnEP+vazgIRvhC87xK+ue2iBVRTP/
   YEPPckzZ5cpjDY9dma68sEiP7e5qER3Js8VuvvCfg+QfSyLk/Gfb3viyd
   XQISH3NbFsXzTOxmodnP7D7cgaidp8qv/AcsdWX0w/dCPzlHgtoeVfiam
   B9qoYEUOA8jR60VyUcBKjV/vKvHevTDFeCGV7y018k55MdQSVU8Evvf99
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="304820882"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="304820882"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 15:48:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="748679589"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="748679589"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jan 2023 15:48:20 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIIAF-0000pD-1g;
        Wed, 18 Jan 2023 23:48:19 +0000
Date:   Thu, 19 Jan 2023 07:47:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 188a569658584e93930ab60334c5a1079c0330d8
Message-ID: <63c88510.batZIyeWwNgS336y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 188a569658584e93930ab60334c5a1079c0330d8  genirq/affinity: Only build SMP-only helper functions on SMP kernels

elapsed time: 726m

configs tested: 65
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
sh                             sh03_defconfig
powerpc                     ep8248e_defconfig
powerpc                      ppc6xx_defconfig
sh                        dreamcast_defconfig
m68k                        m5307c3_defconfig
powerpc                      cm5200_defconfig
ia64                             allmodconfig
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
riscv                randconfig-r042-20230118
s390                 randconfig-r044-20230118
arc                  randconfig-r043-20230118
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allmodconfig
i386                          randconfig-c001
sh                                  defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
parisc                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
nios2                            allyesconfig
nios2                               defconfig
parisc64                            defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016

clang tested configs:
mips                          rm200_defconfig
powerpc                     skiroot_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                    socrates_defconfig
arm                          ep93xx_defconfig
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
