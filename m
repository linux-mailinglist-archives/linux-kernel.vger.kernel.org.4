Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B9D61DF8A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 00:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiKEXBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 19:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKEXBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 19:01:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3501520A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 16:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667689260; x=1699225260;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KP1+0hyL0u9Lkw2wtAiD7I+CPaEIYM9+ZIYzR7LEP9k=;
  b=GrP7M7tW7H183lzIB2dl/yohtVsx60NIy9ErtvXq/rC71D2Vk2J72FCa
   DLk1WDSK4XOCufNPLgg/3o6V4MNpzs7mupp6EpZgzifb39zCo0LMx6P7H
   Sglzy5bmhuGjOck5tJKH+bRdBv6PPNquEvwdTKMIoQzzflYrLltKeaWE3
   SW/W0Akic+BMGMVhplYqu9xcMOxedT9p6kVKyItje1e4IJD+zZj09ibJs
   3ga0LDh4sYKWJ3k9O2x7+8h4jjtiaiT88uL9AveSpn3IuxG9CP+IO7ExG
   iu+04PQdnRAKh3abVUXlzNZv71ZeeVJN2T0jG3pjdMCE3+oAT0rw+vkVA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="289937394"
X-IronPort-AV: E=Sophos;i="5.96,141,1665471600"; 
   d="scan'208";a="289937394"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2022 16:00:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="586562946"
X-IronPort-AV: E=Sophos;i="5.96,141,1665471600"; 
   d="scan'208";a="586562946"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 05 Nov 2022 16:00:58 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1orS9p-000IPP-1t;
        Sat, 05 Nov 2022 23:00:57 +0000
Date:   Sun, 06 Nov 2022 07:00:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ff1af09af49c5fe53f38ff67baf2787025300462
Message-ID: <6366eb24.55TIPXFPgvR3XKku%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: ff1af09af49c5fe53f38ff67baf2787025300462  Merge branch into tip/master: 'x86/sgx'

elapsed time: 746m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                          randconfig-a012
i386                          randconfig-a016
um                             i386_defconfig
um                           x86_64_defconfig
i386                          randconfig-a014
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                              defconfig
arc                                 defconfig
x86_64                        randconfig-a013
s390                             allmodconfig
alpha                               defconfig
x86_64                        randconfig-a011
i386                          randconfig-a001
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
i386                          randconfig-a005
s390                                defconfig
i386                                defconfig
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
x86_64                        randconfig-a015
powerpc                           allnoconfig
i386                          randconfig-a003
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
arm64                            allyesconfig
s390                             allyesconfig
arm                              allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
riscv                randconfig-r042-20221104
arc                  randconfig-r043-20221105
alpha                            allyesconfig
arc                              allyesconfig
arc                  randconfig-r043-20221104
s390                 randconfig-r044-20221104
m68k                             allyesconfig
x86_64                           allyesconfig
m68k                             allmodconfig

clang tested configs:
i386                          randconfig-a011
i386                          randconfig-a013
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a015
i386                          randconfig-a002
x86_64                        randconfig-a016
i386                          randconfig-a006
x86_64                        randconfig-a012
i386                          randconfig-a004
x86_64                        randconfig-a014
hexagon              randconfig-r045-20221105
hexagon              randconfig-r041-20221105
hexagon              randconfig-r041-20221104
hexagon              randconfig-r045-20221104
riscv                randconfig-r042-20221105
s390                 randconfig-r044-20221105

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
