Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BB8648D08
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 04:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLJD7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 22:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLJD7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 22:59:42 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EA557B53
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 19:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670644781; x=1702180781;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0X9OwuZMbdNQM7XtGGxu40OsIqDtg+iXa4gvwj4cN+c=;
  b=mDECCwht32KA/+U5xEFrmt48j0BPGJ4CQWHmO6t/QtqXghiohoNAE8ii
   SLKL0vvBVcZyLVtYlWCBvV9y3J8j25NfkHP/8pRQFUMYdzGIrHXTF5PYH
   fbO5/0v7GFcSlWmVSV0tcQJWMARV/Y6xoBHD/v5aDEX9jwz5at7O+sMsd
   JTPIzVT70DuBLnnbYYRsnppgVvEGpDk7LsihhbaDZY3nl5vC+OPEMJ2sX
   KiE92wQZMthWKzto4bAIXmGoAxG+3zGLE2UEYUkLmf0cBhae2RPnyVtdO
   bmRpqe2wSzkaIIKg3zSgMH3K1jcBbleHzyewNTkDUG+jKWcSPNFIZuJfF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="297270490"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="297270490"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 19:59:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="678351532"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="678351532"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Dec 2022 19:59:39 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3r1X-0002Fn-03;
        Sat, 10 Dec 2022 03:59:39 +0000
Date:   Sat, 10 Dec 2022 11:58:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 18a207849218d8c15072f449e6d0b901262290c9
Message-ID: <639403f0.LlCYRh2b+XAoTNvX%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 18a207849218d8c15072f449e6d0b901262290c9  Merge tag 'timers-v6.2-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

elapsed time: 721m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
sh                               allmodconfig
s390                                defconfig
mips                             allyesconfig
s390                             allyesconfig
m68k                             allyesconfig
um                             i386_defconfig
powerpc                          allmodconfig
i386                          randconfig-a014
m68k                             allmodconfig
um                           x86_64_defconfig
arc                              allyesconfig
riscv                randconfig-r042-20221209
alpha                            allyesconfig
x86_64                          rhel-8.3-rust
i386                          randconfig-a012
arc                  randconfig-r043-20221209
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a016
s390                 randconfig-r044-20221209
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a004
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                                defconfig
x86_64                               rhel-8.3
x86_64                              defconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           allyesconfig
ia64                             allmodconfig
i386                          randconfig-a005
i386                             allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
arm                  randconfig-r046-20221209
i386                          randconfig-a013
hexagon              randconfig-r041-20221209
hexagon              randconfig-r045-20221209
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
