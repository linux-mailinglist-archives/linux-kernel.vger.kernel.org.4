Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F7965509D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiLWMyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbiLWMyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:54:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD1A1E738
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 04:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671800055; x=1703336055;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=K1zb73M1e+HkN/4ZdeyZI0bcxoXHxLhf2vn3McmTE9w=;
  b=CJokEF5RPoz9lb6YeE21G6L67789XtlEjKYvyId5Pkibt7MwGPS1Y+DK
   2rWcBdHtJUGYFbIu9lkrJ2KpHmgzNfCBryhQyfDdCF/hg06U8XNyHoFly
   BK313dPhbbNFm0CvgvWTtSN8bKJPchawIqHQvR4HpaNwHIupPLVTQbvka
   tAKoBgz/ox8FdE9nwgh/SUih/eQpWJuNm3VE7POvq4ex5SJW+r3cUs4Yz
   dW6cQxJmYvYMhVhbK99KvZNL51A+mG9nuhUl71xLRYCAlWZa70o8lXIhd
   Bx0zO19PLQC3uDbKTe+pC4QmpBRsnetFViUpIdY30VFtxz8Ke0t4/jjGW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="406566079"
X-IronPort-AV: E=Sophos;i="5.96,268,1665471600"; 
   d="scan'208";a="406566079"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2022 04:54:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="720636733"
X-IronPort-AV: E=Sophos;i="5.96,268,1665471600"; 
   d="scan'208";a="720636733"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Dec 2022 04:54:13 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p8hYy-000CgO-0r;
        Fri, 23 Dec 2022 12:54:12 +0000
Date:   Fri, 23 Dec 2022 20:54:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.12.19a] BUILD SUCCESS
 b9beaa80c8459952fc9683eb07ae8df985af8c19
Message-ID: <63a5a4ec.OWlXsaB7d6MyVH+S%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.12.19a
branch HEAD: b9beaa80c8459952fc9683eb07ae8df985af8c19  clocksource: Permit limited-duration clocksource watchdogging

elapsed time: 733m

configs tested: 79
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
m68k                             allyesconfig
um                           x86_64_defconfig
m68k                             allmodconfig
s390                             allmodconfig
sh                               allmodconfig
s390                                defconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64               randconfig-a002-20221219
x86_64                           rhel-8.3-bpf
mips                             allyesconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20221221
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
arm                  randconfig-r046-20221221
powerpc                          allmodconfig
x86_64                               rhel-8.3
x86_64               randconfig-a003-20221219
x86_64               randconfig-a001-20221219
x86_64                          rhel-8.3-func
s390                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a004-20221219
x86_64                           allyesconfig
i386                 randconfig-a001-20221219
x86_64               randconfig-a006-20221219
x86_64               randconfig-a005-20221219
i386                 randconfig-a003-20221219
i386                          randconfig-a012
i386                 randconfig-a002-20221219
i386                 randconfig-a006-20221219
arm                                 defconfig
i386                          randconfig-a016
i386                             allyesconfig
i386                 randconfig-a005-20221219
i386                 randconfig-a004-20221219
arm                              allyesconfig
arm64                            allyesconfig
arc                  randconfig-r043-20221219
arm                  randconfig-r046-20221219
arc                  randconfig-r043-20221218
s390                 randconfig-r044-20221218
riscv                randconfig-r042-20221218

clang tested configs:
i386                          randconfig-a013
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20221221
x86_64               randconfig-a011-20221219
x86_64               randconfig-a012-20221219
hexagon              randconfig-r041-20221221
x86_64               randconfig-a014-20221219
riscv                randconfig-r042-20221221
i386                          randconfig-a011
x86_64               randconfig-a013-20221219
s390                 randconfig-r044-20221221
x86_64               randconfig-a016-20221219
i386                          randconfig-a015
x86_64               randconfig-a015-20221219
arm                  randconfig-r046-20221218
hexagon              randconfig-r041-20221218
hexagon              randconfig-r045-20221219
s390                 randconfig-r044-20221219
hexagon              randconfig-r041-20221219
i386                 randconfig-a014-20221219
i386                 randconfig-a012-20221219
hexagon              randconfig-r045-20221218
i386                 randconfig-a013-20221219
i386                 randconfig-a011-20221219
riscv                randconfig-r042-20221219
i386                 randconfig-a015-20221219
i386                 randconfig-a016-20221219

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
