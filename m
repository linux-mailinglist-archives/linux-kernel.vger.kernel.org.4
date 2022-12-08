Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED825646859
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 05:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLHE6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 23:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLHE6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 23:58:38 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7227169A8E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 20:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670475515; x=1702011515;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Ai/eEVhiyeCH/nlgV7CHlgLb7hSoFxNkJmm/rasEqW8=;
  b=AQXUPKQNEXEFbuJ5/8fuSkDFFSX7TNwskmx81DUlyIHizwCK/MZQm0+G
   x/1w59WSyn1EvaLXxaFS/pIN+qOqUMk1rxuTXY9etx/CuYfr3W+5qyJXh
   7ZSBv6fX2hF+njh1R93CZzH317eGrb3yv1Jhh2ucNmcfgn4lOHinhhMqE
   q8zf7a1LECEDmLfISyVM/WQw5H0N9S6QyOHMvwwxmM7kmYVli/tp/trMX
   c6oEEB96YWmRAAUzK4B3MBw2bvoFDekwh/cclq6VzvnxZ6KbMg5ZBfZ15
   WeGz5Y74MmcsuiimCi079ypET6Up0UdvTNEEflvRvrIbiMKHOt3OfOjJ3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="314718235"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="314718235"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 20:58:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="679390356"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="679390356"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Dec 2022 20:58:32 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p38zQ-0000qt-0i;
        Thu, 08 Dec 2022 04:58:32 +0000
Date:   Thu, 08 Dec 2022 12:57:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 6132a490f9c81d621fdb4e8c12f617dc062130a2
Message-ID: <63916ec6.FqpCMBExaG3sY/9j%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 6132a490f9c81d621fdb4e8c12f617dc062130a2  Merge tag 'irqchip-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

elapsed time: 721m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
powerpc                           allnoconfig
s390                             allyesconfig
um                             i386_defconfig
alpha                            allyesconfig
um                           x86_64_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                        randconfig-a004
arc                              allyesconfig
x86_64                        randconfig-a002
x86_64                              defconfig
x86_64                        randconfig-a006
x86_64                          rhel-8.3-rust
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                               rhel-8.3
arc                  randconfig-r043-20221207
x86_64                           allyesconfig
i386                          randconfig-a016
i386                          randconfig-a001
i386                          randconfig-a003
riscv                randconfig-r042-20221207
s390                 randconfig-r044-20221207
x86_64                           rhel-8.3-kvm
i386                          randconfig-a005
x86_64                           rhel-8.3-syz
i386                                defconfig
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
arm                                 defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
sh                               allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                            allnoconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
arm                  randconfig-r046-20221207
i386                          randconfig-a011
hexagon              randconfig-r041-20221207
i386                          randconfig-a015
hexagon              randconfig-r045-20221207
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
