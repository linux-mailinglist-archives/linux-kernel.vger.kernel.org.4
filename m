Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79086497C3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 02:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiLLBuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 20:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiLLBum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 20:50:42 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E39D2E9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 17:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670809841; x=1702345841;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Tee/Oivb18BiFgFGCkf3jp2sN6byXipvw+G8cqwjWZ4=;
  b=m5d3//J6jQk5sVm0moEKhbZgATGiAyUTBwc9enMsq1/rOC9ZQ1jhS5YX
   URp+UJ3Hzks7IOGJeJR4kUqJ9wJY96AAjKvq7bdmJT5v6JnyCel3re3nf
   b8bOhYYM+yiPssOABpCPiMlkzD37ycNlAFAV4C1rIUmyCKrwQEV0Py+YC
   VoHXlXFULbk4fVainDnkJBir+BPtnHcoyAin00qaTbQe4ZU5glYZyzffU
   s9zWItCx25Cva4SulEE8cHNFk9XrBv8wYTNIY30bzYHCzL24eMMOvNSpw
   BFhm8SzFkT85zxEXkz4kxtxAqh6hIsszzGzLFd70xEt5uqglgG9rhF8v7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="301168712"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="301168712"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 17:50:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="754754942"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="754754942"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 11 Dec 2022 17:50:39 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p4Xxn-0003MR-10;
        Mon, 12 Dec 2022 01:50:39 +0000
Date:   Mon, 12 Dec 2022 09:49:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 61c792643dddf90a044c6af8206d0f1133cdbec7
Message-ID: <639688b9.Ck/0rCpX8HxssznL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 61c792643dddf90a044c6af8206d0f1133cdbec7  Merge branch 'timers/core'

elapsed time: 776m

configs tested: 78
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
i386                                defconfig
x86_64                              defconfig
i386                          randconfig-a014
x86_64                        randconfig-a002
i386                          randconfig-a012
x86_64                        randconfig-a004
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                        randconfig-a006
arm                                 defconfig
arc                  randconfig-r043-20221211
arm                  randconfig-r046-20221211
i386                          randconfig-a016
x86_64                               rhel-8.3
s390                                defconfig
x86_64                           rhel-8.3-syz
x86_64                            allnoconfig
i386                          randconfig-a001
sh                               allmodconfig
i386                          randconfig-a003
ia64                             allmodconfig
x86_64                           rhel-8.3-bpf
x86_64                        randconfig-a013
x86_64                          rhel-8.3-rust
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
s390                             allyesconfig
x86_64                        randconfig-a011
i386                          randconfig-a005
x86_64                           rhel-8.3-kvm
mips                             allyesconfig
x86_64                        randconfig-a015
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                             allyesconfig
alpha                            alldefconfig
mips                    maltaup_xpa_defconfig
powerpc                     pq2fads_defconfig
arm                        oxnas_v6_defconfig
arm                         at91_dt_defconfig
openrisc                            defconfig
sparc                       sparc64_defconfig
sh                             espt_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                    xip_kc705_defconfig
powerpc                       ppc64_defconfig
i386                          randconfig-c001
powerpc                          allmodconfig

clang tested configs:
i386                          randconfig-a013
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221211
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20221211
riscv                randconfig-r042-20221211
i386                          randconfig-a002
x86_64                        randconfig-a016
x86_64                        randconfig-a012
s390                 randconfig-r044-20221211
i386                          randconfig-a006
x86_64                        randconfig-a014
i386                          randconfig-a004
arm                          sp7021_defconfig
arm                            mmp2_defconfig
arm                          collie_defconfig
i386                              allnoconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
