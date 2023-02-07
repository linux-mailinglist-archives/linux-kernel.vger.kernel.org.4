Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8497168CC44
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBGBrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjBGBrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:47:14 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089CA166E1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675734423; x=1707270423;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=glBvUKQi8107vpSshLnxm4vxr2kJ98K6Ym6W4kCmRgY=;
  b=UzYL3lEtiMbSBib3V4uCopZ9oT4RxdcT52E/NVQrA7T8xgE/+UJKLfch
   u+sUzrVqffiVuSmliuQLXkv41W8X2tJOYLkLcmTjGkfpxVmcD+eqnb8HH
   47HZtOA3E+0NLWoKmgh6GGmxSDJltbNWBHFImJ6hD1UKRFQvEgTM88/6M
   BDamW8skfIYqtXYLVdfBLpj7lriNr066GOHU3tr36ODMdfFOPX8kxg51K
   6iZceB7628LlWtEHt8kFYcEyQeuDBdx3ZNgV2pCFud8u5MPrtWHwEIhHj
   5tWmkmhicEqNIdfXtBd8IWxbCyJ2LETU1oq+Pwe2mBBmEiANH852a2bhs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="328009135"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="328009135"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 17:46:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="644266764"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="644266764"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Feb 2023 17:46:27 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPD3y-0002wA-12;
        Tue, 07 Feb 2023 01:46:26 +0000
Date:   Tue, 07 Feb 2023 09:45:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 915d4ad3830aa1a2dafda9b737749fb410cb9790
Message-ID: <63e1ad41.7CQytyqpe5hobaV4%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 915d4ad3830aa1a2dafda9b737749fb410cb9790  posix-timers: Use atomic64_try_cmpxchg() in __update_gt_cputime()

elapsed time: 725m

configs tested: 32
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
x86_64                            allnoconfig
arc                                 defconfig
alpha                               defconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
s390                             allmodconfig
s390                                defconfig
sh                               allmodconfig
s390                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arm                                 defconfig
i386                                defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
