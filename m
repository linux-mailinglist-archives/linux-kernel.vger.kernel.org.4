Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA6B693422
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 23:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBKWFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 17:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKWF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 17:05:29 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855E013DF6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 14:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676153128; x=1707689128;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zoTfmhWOcE0SUEMvbuujmyATgYFjCA9Uk+A4XShbsWc=;
  b=IBlTcgeMR4+jZIJwyUY1gMvT3fBmhy2PEYyx1TjMh3U4cxU4O+m/ypfR
   QKg3AkLHeFAz8FEdMnJrRlGHcs1UTILszdFh9mxgYYEi/kXIJsSAM0Qrv
   rbv2xGAygyp9kAPWlvNMaWa86/VOdfMy936osO30KxOvYkQh9VNhyoX8L
   jWCNE3YMXkX/FVyLPMqU4OLolbV0zBBFTraoVjNDfSrpRgTaIbf4J2QI6
   Ojp+my9IHHrUWViSibbKib0cAglbYZ0Npf99fQGkRzCO8pInZCDLbtNu4
   2BzQAY21qVDbjwrBQepWsPfKf/O8Ek6uSs2nNa1VcnYZqd39zDar0+Lln
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="393061801"
X-IronPort-AV: E=Sophos;i="5.97,290,1669104000"; 
   d="scan'208";a="393061801"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2023 14:05:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="777340724"
X-IronPort-AV: E=Sophos;i="5.97,290,1669104000"; 
   d="scan'208";a="777340724"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2023 14:05:26 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQxzq-0006pF-00;
        Sat, 11 Feb 2023 22:05:26 +0000
Date:   Sun, 12 Feb 2023 06:05:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 6b8d5dde5b6903baf82fc7400e0b3376b10805b4
Message-ID: <63e8110e.ugm764I1wwDhibkO%lkp@intel.com>
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
branch HEAD: 6b8d5dde5b6903baf82fc7400e0b3376b10805b4  x86/tsc: Do feature check as the very first thing

elapsed time: 720m

configs tested: 54
configs skipped: 86

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                 nsimosci_hs_smp_defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-c001
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                          multi_defconfig
parisc                generic-64bit_defconfig
powerpc                 linkstation_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                  storcenter_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv             nommu_k210_sdcard_defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
um                               alldefconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                               rhel-8.3

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
