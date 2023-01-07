Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03A3661299
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 00:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjAGXga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 18:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjAGXg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 18:36:27 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518B462EA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 15:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673134586; x=1704670586;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=K6PA/E6ULto1DeVkUgKc+rIt4dtykUitthTQhQ3lmUE=;
  b=kiR9EWLtMin9t3N3VkIY0Z49XZIML4sAedusfW1msUZFIXNcL7c25V2Q
   YouQtON3B63PZuIEKTKWaGL0AS9h3c4gN9aPp0Wt6wMvEqud349bw62NY
   ZcDslDj08/c/TKnyFGqaVuz0JsLcBQrKaR1wlw+5oi5rYmuFrUnSeG1Lr
   U2pYwGItWpg9dEh06pgsxGrZG+xIq8A1hHSRnkruuH7iF5ek5gM26syeB
   pvqNUtsqq8dF8VGfhfVVjmsxUkANxfD+FwPyR+IWy52mxVTveerny9Ncm
   Utyu26SyiM3TVtxjxaK6QLzYSnV8Z42snl2Jw4ZFFU92VXRGdeo37uZcy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10583"; a="349890475"
X-IronPort-AV: E=Sophos;i="5.96,309,1665471600"; 
   d="scan'208";a="349890475"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 15:36:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10583"; a="686820329"
X-IronPort-AV: E=Sophos;i="5.96,309,1665471600"; 
   d="scan'208";a="686820329"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 07 Jan 2023 15:36:22 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pEIjd-0004wM-2P;
        Sat, 07 Jan 2023 23:36:21 +0000
Date:   Sun, 08 Jan 2023 07:35:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 7fb3ff22ad8772bbf0e3ce1ef3eb7b09f431807f
Message-ID: <63ba01be.Hu3RBveMFjfh2+Pn%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 7fb3ff22ad8772bbf0e3ce1ef3eb7b09f431807f  sched/core: Fix arch_scale_freq_tick() on tickless systems

elapsed time: 721m

configs tested: 71
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arc                                 defconfig
alpha                               defconfig
x86_64                        randconfig-a015
powerpc                           allnoconfig
s390                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
x86_64                              defconfig
i386                          randconfig-a001
i386                          randconfig-a003
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a005
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
x86_64                        randconfig-a004
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20230107
s390                             allyesconfig
x86_64                        randconfig-a002
powerpc                          allmodconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20230106
x86_64                        randconfig-a006
riscv                randconfig-r042-20230107
i386                          randconfig-a014
arm                                 defconfig
x86_64                           allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arm                  randconfig-r046-20230106
arc                              allyesconfig
alpha                            allyesconfig
s390                 randconfig-r044-20230107
i386                          randconfig-a012
arm64                            allyesconfig
i386                          randconfig-a016
arm                              allyesconfig
i386                                defconfig
i386                             allyesconfig
arm                           imxrt_defconfig
arc                            hsdk_defconfig
s390                       zfcpdump_defconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
arm                  randconfig-r046-20230107
hexagon              randconfig-r041-20230107
i386                          randconfig-a013
x86_64                        randconfig-a001
i386                          randconfig-a015
hexagon              randconfig-r045-20230107
i386                          randconfig-a011
hexagon              randconfig-r041-20230106
x86_64                        randconfig-a003
s390                 randconfig-r044-20230106
riscv                randconfig-r042-20230106
x86_64                        randconfig-a005
hexagon              randconfig-r045-20230106

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
