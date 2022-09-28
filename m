Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9005ED3ED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 06:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiI1EeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 00:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiI1EeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 00:34:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19C0F8C2F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 21:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664339648; x=1695875648;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XBf1OJAEQCXrpN+dmbGuJvECsb2rwRN/HMmFQYTcU/Y=;
  b=MvuWVNqhwKTAuoEiJiKol1K+p3U7cdgKmYr/3psEjJqd19lpC+0PpAIy
   pv38Hgb5/rldfb4NpFtUpjJZM7F+EPNntLtoP3ZOi4PRkoFaGMGe7Orxe
   D/dsgy1XmRbFecXsY+PGKLT1wO81FP2qKwYIijZSJ/P8J19KlqABVB4r6
   AdLMpsESrs6SSzKJVxJoEOOTPWBEpIzh1yrSociAll0PHQoFVB7479GKn
   iNc1cUr1KE0i5Gv+QuEKFm7KNC8yfo60XQlB3kj12TRZT0vWTLU//YH5+
   y38RGpNDdrP6aRi/nHinuG/taTM62txlRYUkC06VpnxbZf9cL/kiJCD7e
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="288658657"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="288658657"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 21:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="710817321"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="710817321"
Received: from lkp-server02.sh.intel.com (HELO dfa2c9fcd321) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Sep 2022 21:34:06 -0700
Received: from kbuild by dfa2c9fcd321 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1odOlq-0001yd-07;
        Wed, 28 Sep 2022 04:34:06 +0000
Date:   Wed, 28 Sep 2022 12:33:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 c0cca6a66458a0daa627774de7ca2b678a6bb3d8
Message-ID: <6333ce91.3yGgWIK4clPMdQEC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: c0cca6a66458a0daa627774de7ca2b678a6bb3d8  Merge tag 'irqchip-fixes-6.0-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

elapsed time: 878m

configs tested: 60
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
sh                               allmodconfig
alpha                            allyesconfig
powerpc                          allmodconfig
arc                              allyesconfig
i386                 randconfig-a001-20220926
x86_64                               rhel-8.3
mips                             allyesconfig
x86_64               randconfig-a002-20220926
x86_64                           allyesconfig
m68k                             allyesconfig
i386                 randconfig-a002-20220926
x86_64               randconfig-a005-20220926
i386                 randconfig-a003-20220926
arc                  randconfig-r043-20220926
x86_64               randconfig-a004-20220926
i386                 randconfig-a004-20220926
x86_64               randconfig-a006-20220926
x86_64               randconfig-a001-20220926
i386                 randconfig-a005-20220926
x86_64               randconfig-a003-20220926
i386                 randconfig-a006-20220926
arm                                 defconfig
i386                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm                              allyesconfig
i386                             allyesconfig
arm64                            allyesconfig
x86_64                        randconfig-a015
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220926
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
hexagon              randconfig-r041-20220926
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                 randconfig-a011-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a016-20220926
hexagon              randconfig-r041-20220925
hexagon              randconfig-r045-20220925

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
