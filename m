Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F5A61D8EC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 09:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKEIx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 04:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEIx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 04:53:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE37B1036
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 01:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667638403; x=1699174403;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cJWg3yAlwsAfeXaANa8CBAQalPeBRTf4JxiTggBSXno=;
  b=KFyxIdHXlYTDPxn+tX4waYiQl+SgFdU/4PYeipZ+A21rNYvMnT1R4Stu
   rFX/joKFlJyP5hXwfkLl6sj8HFCC7n7+6ZB9eWiuDzyTI9zukVKYpmmw3
   UjLkrwAuxxQoFug1cstjXQD80skyMYjOhjLy83o67sBHt+nKRA5EyrfbP
   T5y77Pm6q2UulqoX+ipLi0+JLoF9FxAYNU/NX/PI853CuzESlmcwYRogn
   p5ic1Z0gqq5ISJh38DUzeuQ3qVK3uEhuKt396l1lkBDWfoZGQkPPxbEyr
   vNEhyVEBP0Za3R+cV3EV/g9AIiZyXD8/ogCr8BTCeGrt22SItVB+Iqd9J
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="293476055"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="293476055"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2022 01:53:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="760581168"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="760581168"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 05 Nov 2022 01:53:21 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1orEvZ-000Hpb-0J;
        Sat, 05 Nov 2022 08:53:21 +0000
Date:   Sat, 05 Nov 2022 16:53:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 7beade0dd41d42d797ccb7791b134a77fcebf35b
Message-ID: <63662479.1eLXhVP7hqBao6+q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 7beade0dd41d42d797ccb7791b134a77fcebf35b  x86/cpu: Add several Intel server CPU model numbers

elapsed time: 726m

configs tested: 56
configs skipped: 83

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                              defconfig
x86_64                        randconfig-a015
i386                                defconfig
x86_64                           allyesconfig
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
riscv                randconfig-r042-20221104
arc                  randconfig-r043-20221104
s390                 randconfig-r044-20221104
arm                         s3c6400_defconfig
arc                      axs103_smp_defconfig
m68k                       bvme6000_defconfig
i386                          randconfig-c001
m68k                           sun3_defconfig
csky                                defconfig
nios2                         10m50_defconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
powerpc                 xes_mpc85xx_defconfig
hexagon              randconfig-r041-20221104
hexagon              randconfig-r045-20221104
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
