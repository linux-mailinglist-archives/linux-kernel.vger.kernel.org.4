Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBACE65ACE8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 03:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjABCqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 21:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABCqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 21:46:44 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D772109F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 18:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672627603; x=1704163603;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rm6tHu29DRSynHaxRDKpj+NTjm943vjbM7JHGwY4I8Y=;
  b=GIV5CfGiOAuNI7qwdMUC0MD+ogUGP2XzZ7uSyuMHeJhR8r2QCuUAYeQ7
   I/OC8PVowVa+RLNFLqpuk9hfb2vtDVaggOCatM0eAED7ARuKaFpt40xsL
   x1EUAGzUFw/nk8nnmGaAMQ9nPoq/Z573dIDYURpurFxdhnTGO9wOHtxia
   fGYBKATwzg3RNbP8SKC4lBfeRnns5nmmONhG5fN61uR4HRgWu7EAU77Ky
   Mo68WFPELiKaEvXfqWkkqfaQmuKmjPgU+3rSiNm5GZpr7uSwKcFgUeJ9/
   TxfkazGnWArzbtQqSvHxH+BHJu+exQSnrVeVVDEy5QqkdURyCn4RB2373
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="383726282"
X-IronPort-AV: E=Sophos;i="5.96,293,1665471600"; 
   d="scan'208";a="383726282"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2023 18:46:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="684983122"
X-IronPort-AV: E=Sophos;i="5.96,293,1665471600"; 
   d="scan'208";a="684983122"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Jan 2023 18:46:41 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pCAqW-000QXE-2K;
        Mon, 02 Jan 2023 02:46:40 +0000
Date:   Mon, 02 Jan 2023 10:46:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 e2cda209b2a67d5921cf9ef4cdca57dc9eb3affe
Message-ID: <63b24582.e8BdWnURUoOw9JTy%lkp@intel.com>
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
branch HEAD: e2cda209b2a67d5921cf9ef4cdca57dc9eb3affe  Merge branch into tip/master: 'x86/microcode'

elapsed time: 725m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                        randconfig-a013
i386                          randconfig-a001
x86_64                        randconfig-a011
i386                          randconfig-a003
i386                                defconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
arm                                 defconfig
x86_64                         rhel-8.3-kunit
x86_64                            allnoconfig
x86_64                              defconfig
x86_64                        randconfig-a015
alpha                            allyesconfig
ia64                             allmodconfig
arc                  randconfig-r043-20230101
i386                          randconfig-a014
riscv                randconfig-r042-20230101
s390                 randconfig-r044-20230101
m68k                             allyesconfig
s390                                defconfig
sh                               allmodconfig
s390                             allmodconfig
i386                          randconfig-a005
i386                          randconfig-a012
m68k                             allmodconfig
arc                              allyesconfig
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
s390                             allyesconfig
mips                             allyesconfig
x86_64                               rhel-8.3
powerpc                          allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                           allyesconfig
i386                             allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a014
i386                          randconfig-a002
x86_64                        randconfig-a016
x86_64                        randconfig-a012
hexagon              randconfig-r041-20230101
i386                          randconfig-a004
i386                          randconfig-a013
hexagon              randconfig-r045-20230101
i386                          randconfig-a006
arm                  randconfig-r046-20230101
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
