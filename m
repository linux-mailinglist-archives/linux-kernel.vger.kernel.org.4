Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A3C65C9C2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 23:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjACWov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 17:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjACWoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 17:44:46 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EF412778
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 14:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672785883; x=1704321883;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mtlX47+Z3ns5ozM/925OaZSnF1blsARejIrKBV7Z0Ic=;
  b=jcJZA4+UV6cd4oUVDjZEKDhDrTmVDEwqFobRMn12TF9yKOuF5AdeuWyE
   kHttNUy3op+mosf+/Iy7rtI6B1lkr7TYRjwR5AOUr4+qwLnzli/77L5Fc
   N21fd4iDuFAfmTh5jpwDunT8gJD8mB09/vx0H1pN0DNpBXQh0FNu0YuZ9
   PIAKPUxRtdArWoINFolwTpAs+wbwO2adJZsC8FyITfWr9EbKO1k/ezwX+
   zjq4v2nTYgT2pB4vJVwB2gmPSLPHUfY4nHoyv1+f/n3YdBKxxEzO/LHjF
   5dNaRvMxSPKKAhrgBl+UHxgkd2+fDKbDc6wNb0+yqP/PsgQpFRzQJXOQH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="323007063"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="323007063"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 14:44:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="983707526"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="983707526"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jan 2023 14:44:41 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pCq1R-000SrF-0L;
        Tue, 03 Jan 2023 22:44:41 +0000
Date:   Wed, 04 Jan 2023 06:44:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 f3cb80804b8295323919e031281768ba3bf5f8da
Message-ID: <63b4afd3.7YDvp+CbPw3L9hi9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: f3cb80804b8295323919e031281768ba3bf5f8da  time: Fix various kernel-doc problems

elapsed time: 720m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
arc                                 defconfig
s390                             allmodconfig
arc                              allyesconfig
powerpc                           allnoconfig
m68k                             allmodconfig
alpha                               defconfig
m68k                             allyesconfig
s390                                defconfig
um                             i386_defconfig
s390                             allyesconfig
um                           x86_64_defconfig
sh                               allmodconfig
arm                                 defconfig
mips                             allyesconfig
arm64                            allyesconfig
powerpc                          allmodconfig
ia64                             allmodconfig
arm                              allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
i386                 randconfig-a004-20230102
i386                 randconfig-a003-20230102
i386                 randconfig-a001-20230102
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                 randconfig-a002-20230102
i386                 randconfig-a005-20230102
i386                 randconfig-a006-20230102
riscv                randconfig-r042-20230101
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64               randconfig-a001-20230102
arc                  randconfig-r043-20230102
x86_64               randconfig-a004-20230102
x86_64               randconfig-a002-20230102
x86_64               randconfig-a003-20230102
x86_64               randconfig-a005-20230102
arm                  randconfig-r046-20230102
x86_64               randconfig-a006-20230102
arc                  randconfig-r043-20230101
s390                 randconfig-r044-20230101
i386                             allyesconfig
x86_64                            allnoconfig
i386                          randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
i386                 randconfig-a012-20230102
i386                 randconfig-a011-20230102
i386                 randconfig-a014-20230102
i386                 randconfig-a013-20230102
i386                 randconfig-a015-20230102
i386                 randconfig-a016-20230102
x86_64                          rhel-8.3-rust
x86_64               randconfig-a011-20230102
hexagon              randconfig-r041-20230102
x86_64               randconfig-a012-20230102
x86_64               randconfig-a013-20230102
s390                 randconfig-r044-20230102
x86_64               randconfig-a015-20230102
hexagon              randconfig-r045-20230101
x86_64               randconfig-a016-20230102
hexagon              randconfig-r045-20230102
x86_64               randconfig-a014-20230102
arm                  randconfig-r046-20230101
riscv                randconfig-r042-20230102
hexagon              randconfig-r041-20230101
x86_64                        randconfig-k001
s390                             alldefconfig
mips                  cavium_octeon_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
