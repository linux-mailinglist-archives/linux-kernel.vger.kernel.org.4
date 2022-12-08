Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA76465E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 01:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiLHAcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 19:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLHAci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:32:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCE5D4B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 16:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670459554; x=1701995554;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DM2Z+fucXtQJUS648zmE4VTfNU26g25896Sw4A0QP1s=;
  b=QIIcW+goMFc6z1H+gWuqw0xIjfsKFlqnyIg9dq2SlaRNN1U3U/Oot6J4
   7RmsTwgyCPgLbbqyfyDvfpboQHunBsd7kTGNwIiOwgQE/BfnggcrktKE/
   WCXcMuFxXAqr1frPRc5WDUYpAr7PShFxu7dQ3oadX9fKl8kNM8Q8d1i8e
   +/cGKvt1rxylIGUDycMS0FqFOlesoLyPpJY5nrUxOWT/k4LDc1eRFCX6I
   +Uaj+TrqdwNWPu5eDLzWEnabDQfsm2DogrTwTlz01JhgM5w+/7ZUVBVYE
   d8J0Lc1Sll1v6+IQ5A5MpifcVVEqCvmRbZKO5lcWUlDUQOXwJzmANHIUS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="315754491"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="315754491"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 16:32:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="892010785"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="892010785"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Dec 2022 16:32:24 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p34pr-0000gV-1F;
        Thu, 08 Dec 2022 00:32:23 +0000
Date:   Thu, 08 Dec 2022 08:32:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 593cc58736a386aa845707ddcc8de71e252479a4
Message-ID: <6391308a.j7nC6bY//9lkBmth%lkp@intel.com>
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
branch HEAD: 593cc58736a386aa845707ddcc8de71e252479a4  Merge branch into tip/master: 'x86/tdx'

elapsed time: 726m

configs tested: 66
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
um                             i386_defconfig
alpha                               defconfig
um                           x86_64_defconfig
s390                                defconfig
i386                                defconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64                           rhel-8.3-syz
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                           allyesconfig
x86_64                        randconfig-a004
ia64                             allmodconfig
arc                  randconfig-r043-20221207
x86_64                        randconfig-a011
x86_64                        randconfig-a002
x86_64                          rhel-8.3-rust
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
mips                             allyesconfig
x86_64                          rhel-8.3-func
powerpc                          allmodconfig
riscv                randconfig-r042-20221207
x86_64                        randconfig-a006
i386                             allyesconfig
s390                 randconfig-r044-20221207
x86_64                        randconfig-a015
m68k                             allyesconfig
i386                          randconfig-a012
m68k                             allmodconfig
i386                          randconfig-a016
arc                              allyesconfig
alpha                            allyesconfig
arm                                 defconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
arm                        shmobile_defconfig
nios2                            alldefconfig
powerpc                     tqm8555_defconfig
sparc                       sparc64_defconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64                            allnoconfig

clang tested configs:
arm                  randconfig-r046-20221207
x86_64                        randconfig-a014
hexagon              randconfig-r041-20221207
hexagon              randconfig-r045-20221207
i386                          randconfig-a013
x86_64                        randconfig-a016
x86_64                        randconfig-a001
i386                          randconfig-a011
x86_64                        randconfig-a012
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
arm                           omap1_defconfig
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
