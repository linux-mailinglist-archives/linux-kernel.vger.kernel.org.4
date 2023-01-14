Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FC266AE43
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 23:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjANW0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 17:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjANW0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 17:26:37 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5539EF7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 14:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673735195; x=1705271195;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Li1dRGDKEKTFGiSZRcpXBG+tYzPDrB6DHNe3oGObjXk=;
  b=k3ABPVPv4umE2dKn9suANtHpKp2rcwk+vahzNyBmw65+iHjJExj0fbLM
   QoQUTgWlF43P6bk4UznCQ1k7MFay6avgRCi5iCnHxNxy+huZCb5JJqAsY
   IQVRQMaymoqf6XBGcxWKk2K8MDTQ3C9xhX/iTi8KMtB/3XeRSIz3IOcup
   yi182u506KJbJz9zr/gzTus02/LxtHIt/iGYIP+7QP2J0i84wABxQ+e2v
   xpaTdqElk7VP15zQQWKjHJHkIISQ/CaT3wWWwYfLCAeD/A+lTgKtsdFzg
   lA7UGjloz/QeC3T2W+bsDqnFU7t1WJHSGqdXPmN77aLh7kq1xFOjTyBIY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10590"; a="312092614"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="312092614"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2023 14:26:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10590"; a="660578329"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="660578329"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jan 2023 14:26:34 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGoyv-000CRW-1G;
        Sat, 14 Jan 2023 22:26:33 +0000
Date:   Sun, 15 Jan 2023 06:26:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ea3c44fcb5e87ab5824ceeb039bc2b4e29d9f755
Message-ID: <63c32c19.lf5qoOztyUvIm5U0%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: ea3c44fcb5e87ab5824ceeb039bc2b4e29d9f755  Merge branch into tip/master: 'x86/platform'

elapsed time: 720m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
um                             i386_defconfig
s390                                defconfig
x86_64                            allnoconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20230112
s390                 randconfig-r044-20230112
riscv                randconfig-r042-20230112
x86_64                           rhel-8.3-bpf
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
s390                             allyesconfig
ia64                             allmodconfig
i386                                defconfig
x86_64                               rhel-8.3
arm                                 defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a013
i386                          randconfig-a001
x86_64                          rhel-8.3-func
x86_64                        randconfig-a011
x86_64                        randconfig-a002
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a006
alpha                            allyesconfig
x86_64                        randconfig-a015
x86_64                           allyesconfig
i386                          randconfig-a003
m68k                             allyesconfig
i386                          randconfig-a014
m68k                             allmodconfig
i386                          randconfig-a012
arc                              allyesconfig
i386                          randconfig-a005
sh                               allmodconfig
arm64                            allyesconfig
i386                          randconfig-a016
arm                              allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
i386                          randconfig-c001

clang tested configs:
arm                  randconfig-r046-20230112
hexagon              randconfig-r041-20230112
hexagon              randconfig-r045-20230112
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a014
x86_64                        randconfig-a003
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a011
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
