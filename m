Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0003E6412FB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiLCBUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbiLCBUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:20:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16146E464E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 17:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670030437; x=1701566437;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tpOVgajJlng5hJ/4hlcGYKF/uyTgAMAHpeOUDqZ+h/U=;
  b=cddCt9fdD7r9PhhfPuiaR4hQj3BIgAYRfa0WDKqpZjQJW5Oyu7naqnE4
   EWcMHIrY/rddu6i0e3+qFCik61aNE79GrVatYBg0TUADdNYgkAAPPdF0J
   QvBX9jlZ17uXX8xfPxGhSsT8zkaYiz5RWyZzs9Fh+wfkB0Qv+48ferxAf
   5O5558BSaZaOGoUod8GhmHyBcWq51scxDeVIXuIl1tqbAbP9RXOCGeDp9
   3g398G56ZTKnjjX6PReo86mlgsMf6M1eKVYKjahAp3eRyNIZh+9REfMxk
   U693N97ePm3zXsDh+XUgkHwF6UHVhREpLPOkJA+x0iwcxQVsFUpjkwwdO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="316104548"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="316104548"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 17:20:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="645219711"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="645219711"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2022 17:20:35 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1HCk-000EBH-1b;
        Sat, 03 Dec 2022 01:20:34 +0000
Date:   Sat, 03 Dec 2022 09:19:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 ff4c85c05333c6f24d3fe0a344c6dacd18a7ee49
Message-ID: <638aa42d.CjupqW5n6v/p+em/%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: ff4c85c05333c6f24d3fe0a344c6dacd18a7ee49  x86/asm/32: Remove setup_once()

elapsed time: 723m

configs tested: 62
configs skipped: 74

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a006
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                              defconfig
x86_64                           allyesconfig
i386                                defconfig
x86_64                        randconfig-a013
i386                          randconfig-a001
x86_64                        randconfig-a011
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
ia64                             allmodconfig
arc                  randconfig-r043-20221201
riscv                randconfig-r042-20221201
s390                 randconfig-r044-20221201
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-c001

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a014
x86_64                        randconfig-a012
i386                          randconfig-a004
i386                          randconfig-a002
x86_64                        randconfig-a016
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
arm                     am200epdkit_defconfig
mips                      malta_kvm_defconfig
powerpc                      katmai_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
