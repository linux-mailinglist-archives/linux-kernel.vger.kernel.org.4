Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA10643959
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiLEXPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbiLEXP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:15:26 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76F363C9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670282124; x=1701818124;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=++8mm9Uwiga3553gE9s0Gb0Gr/N5guA8OdaxRzGiBQ4=;
  b=YNlNK47p6U34XnL+Ay1W/+nUKhP1sn9ge15j4fPBtx5qwakkFz3GmxLA
   9eauJlZ2biQUTZr4ea00lHagxB7lO4LGpvylO6ChpSXzYTJCIrYnXQqCy
   4TnOfk103V0rH2qPg95pxdTo78RyzXMeNlXpbNi4Q1kBeEPxhN/t8Wttp
   paFTmbC8pGnJztAiBksg0OQglQCAPVM8fwahCmZlQPOo/2RF2dSCCTQyl
   ZpQZLtFpUZvCHhfFjWR2nu9WBvJhNrbxSWAR0Au/JdPfYCX1mjCd7/D0U
   oxgwJUiTZGMk4NVVbAEok0yvF2HljExvLwZ26QF3aI998+uWjsi4SPRz7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="343503572"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="343503572"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 15:15:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="596366749"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="596366749"
Received: from lkp-server01.sh.intel.com (HELO b3c45e08cbc1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Dec 2022 15:15:22 -0800
Received: from kbuild by b3c45e08cbc1 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p2KgE-0000PU-0c;
        Mon, 05 Dec 2022 23:15:22 +0000
Date:   Tue, 06 Dec 2022 07:14:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 cefa72129e45313655d53a065b8055aaeb01a0c9
Message-ID: <638e7b5b.7jThKvEy0VBw62ki%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: cefa72129e45313655d53a065b8055aaeb01a0c9  uprobes/x86: Allow to probe a NOP instruction with 0x66 prefix

elapsed time: 723m

configs tested: 60
configs skipped: 87

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
i386                 randconfig-a014-20221205
i386                 randconfig-a013-20221205
i386                 randconfig-a012-20221205
i386                 randconfig-a015-20221205
x86_64                         rhel-8.3-kunit
i386                 randconfig-a011-20221205
i386                 randconfig-a016-20221205
x86_64               randconfig-a011-20221205
x86_64               randconfig-a014-20221205
x86_64               randconfig-a013-20221205
x86_64               randconfig-a012-20221205
x86_64               randconfig-a015-20221205
i386                             allyesconfig
i386                                defconfig
x86_64               randconfig-a016-20221205
x86_64                               rhel-8.3
x86_64                           allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
ia64                             allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig

clang tested configs:
x86_64               randconfig-a001-20221205
x86_64               randconfig-a002-20221205
x86_64               randconfig-a004-20221205
x86_64               randconfig-a003-20221205
x86_64               randconfig-a006-20221205
x86_64               randconfig-a005-20221205
i386                 randconfig-a001-20221205
i386                 randconfig-a002-20221205
i386                 randconfig-a004-20221205
i386                 randconfig-a003-20221205
i386                 randconfig-a005-20221205
i386                 randconfig-a006-20221205
hexagon              randconfig-r041-20221205
hexagon              randconfig-r041-20221204
arm                  randconfig-r046-20221205
riscv                randconfig-r042-20221204
hexagon              randconfig-r045-20221205
hexagon              randconfig-r045-20221204
s390                 randconfig-r044-20221204

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
