Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23B061A16E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKDTrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKDTqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:46:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8520927FE6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667591211; x=1699127211;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=B80wUz+lPhOrtVxH6IN7uyzaqJc/c+y0CsA8Q7VN93A=;
  b=hn7fZACbE342RRbN6NqOzpSmX3PRbDEWXbuJ7e7GKhJ8ByqNhFtGm79M
   q+LLq3By5oE8T4/EfkveGoEGFUXbOklxtyTl3I9AYMFYXoUXPx+MPtfaz
   lGk4hAy+HShOowMcmUjQlS3eWFfb5p6itRjs66Fy7Hl4Lh6rFh8qD+Vhp
   7pUSAM5pcf25t8ffgsRhmvpZvzby5fg1bJE1kCyfh8pKyPa4hCIGXK4ER
   4ge/zB9+02pG9/Lz6TluQIg6cbCMHJYL9Df5Yro5j3WJNYVbksB5jZU0d
   kBHBExnyEniTS7aGGirdrh0wPF7+tCR+iS29RLG1qPY7JgHoZfggd6ZKS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="307680499"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="307680499"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 12:46:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="586293854"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="586293854"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 04 Nov 2022 12:46:37 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1or2eC-000HHJ-2D;
        Fri, 04 Nov 2022 19:46:36 +0000
Date:   Sat, 05 Nov 2022 03:45:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1f741723738e130d3062081107d9a8f2e6dae9d4
Message-ID: <63656be0.oIYnEM+S5sRTEHvl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 1f741723738e130d3062081107d9a8f2e6dae9d4  Merge branch 'x86/mm'

elapsed time: 720m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
um                             i386_defconfig
um                           x86_64_defconfig
alpha                               defconfig
x86_64                               rhel-8.3
mips                             allyesconfig
arc                                 defconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20221104
x86_64                              defconfig
i386                                defconfig
powerpc                          allmodconfig
x86_64                        randconfig-a013
i386                          randconfig-a001
x86_64                         rhel-8.3-kunit
i386                          randconfig-a003
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a011
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a015
i386                          randconfig-a005
arc                              allyesconfig
s390                 randconfig-r044-20221104
x86_64                        randconfig-a006
riscv                randconfig-r042-20221104
x86_64                        randconfig-a004
i386                          randconfig-a014
alpha                            allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
sh                               allmodconfig
m68k                             allyesconfig
s390                             allmodconfig
m68k                             allmodconfig
i386                             allyesconfig
s390                                defconfig
arm                                 defconfig
s390                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64                           allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20221104
hexagon              randconfig-r041-20221104
i386                          randconfig-a002
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a014
x86_64                        randconfig-a001
i386                          randconfig-a004
x86_64                        randconfig-a003
i386                          randconfig-a013
x86_64                        randconfig-a016
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
