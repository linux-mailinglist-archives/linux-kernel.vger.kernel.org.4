Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613EC639905
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 00:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiKZX5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 18:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKZX5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 18:57:18 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D906BDE83
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 15:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669507037; x=1701043037;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zePaHQ3Uq4Fki0IlWa3f0B6fZX9ZaDH6K+0/3/HQ7eI=;
  b=cTeKdVrQK0yv/0vvWNWnKosdb5+KgEHLMrzRzZWy+VNSSuvMa+CRhH48
   e/AcLjE2wn8BBMXLquwJSS72FlTq9iX/9Pvsx/Eqy/7DkC2PokdAK5kUu
   onMqO8607vKV0olAwOrwwQ884Oz4qR23EJIBBOj53GCCFMTzk7VQOVsOt
   fLJc4hWUgv6fkTTOmKZM2fxZ3AN2TnpJa/u+BZO6CCgKfpeGsRsIGXY4z
   2n/tum05eyazIHvzVqRddymahs8cevgoQbw38RkHlpfcospI/f244LImN
   MSLMMLyMgBshJrqH1/uVDuMyAG9Du9ax6ZORalnVyAAayi/l3ky0osxZK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="378884654"
X-IronPort-AV: E=Sophos;i="5.96,197,1665471600"; 
   d="scan'208";a="378884654"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 15:57:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="887999913"
X-IronPort-AV: E=Sophos;i="5.96,197,1665471600"; 
   d="scan'208";a="887999913"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 26 Nov 2022 15:57:16 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oz52p-0006ez-1M;
        Sat, 26 Nov 2022 23:57:15 +0000
Date:   Sun, 27 Nov 2022 07:56:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 36575b684b1b8ba4e7dba35aeda254861f84a705
Message-ID: <6382a7aa.vnSNt1lSkJhH+FU2%lkp@intel.com>
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
branch HEAD: 36575b684b1b8ba4e7dba35aeda254861f84a705  Merge x86/boot into tip/master

elapsed time: 2197m

configs tested: 56
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arc                  randconfig-r043-20221124
x86_64                           rhel-8.3-syz
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig

clang tested configs:
riscv                randconfig-r042-20221124
hexagon              randconfig-r041-20221124
hexagon              randconfig-r045-20221124
s390                 randconfig-r044-20221124
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
