Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B345F6D8D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 20:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiJFScr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 14:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJFSco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 14:32:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D741727A1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665081162; x=1696617162;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FtP3irN2yi0dlbcCwo1TNXjKuigWX1/G3V8ZbKCv2DI=;
  b=QKqLAu6qd8PAJqzhILVZcFgnHvohRsEJBV0Lq6oyy0p5O1wYMIFWel6P
   XWTIOV6EduSV5JthgU8LKp1Acl7AcnBIj8zM6DgGRBIMmDStr56rBCNgc
   fwyXpWrPLPg/zrYjKABNAUEHx1DJfOSJJ5zD+pHAqUvBuvMF8/frgHV+T
   Y3NrOmMYwoP51Japo+nwOlfFT6mfssxVxLfDeoPwjCJ9kdQElLmnrOCz2
   Vb5LoY+9+Pn7MDPCBRLzzf7gec/ntTJxhapvqwEr+ygXj044i8xCzK812
   iPImTkMLbRo/j1uiQ/LHd9DHrZISMsOh1TPWMmOOzD3x7O1qUqnw9VVTl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="367659798"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="367659798"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 11:32:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="602550602"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="602550602"
Received: from lkp-server01.sh.intel.com (HELO 3c15167049b7) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Oct 2022 11:32:39 -0700
Received: from kbuild by 3c15167049b7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogVfi-0000NH-1i;
        Thu, 06 Oct 2022 18:32:38 +0000
Date:   Fri, 07 Oct 2022 02:31:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 af5711744371af25129fa6b4cd836ac5c8337039
Message-ID: <633f1f1b.uIITF4CfdUCNRSdh%lkp@intel.com>
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
branch HEAD: af5711744371af25129fa6b4cd836ac5c8337039  Merge branch into tip/master: 'x86/mm'

elapsed time: 725m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
s390                             allmodconfig
s390                                defconfig
i386                 randconfig-a014-20221003
i386                 randconfig-a011-20221003
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a012-20221003
i386                 randconfig-a013-20221003
x86_64                              defconfig
i386                 randconfig-a015-20221003
i386                 randconfig-a016-20221003
arm                                 defconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                               rhel-8.3
x86_64               randconfig-a011-20221003
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64               randconfig-a012-20221003
s390                             allyesconfig
x86_64               randconfig-a013-20221003
x86_64               randconfig-a015-20221003
mips                             allyesconfig
arm64                            allyesconfig
sh                               allmodconfig
arm                              allyesconfig
m68k                             allmodconfig
x86_64               randconfig-a014-20221003
x86_64               randconfig-a016-20221003
x86_64                           allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
i386                             allyesconfig
riscv                randconfig-r042-20221003
ia64                             allmodconfig
arc                  randconfig-r043-20221003
arc                  randconfig-r043-20221002
s390                 randconfig-r044-20221003
csky                              allnoconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig

clang tested configs:
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a006-20221003
hexagon              randconfig-r041-20221003
x86_64               randconfig-a003-20221003
riscv                randconfig-r042-20221002
x86_64               randconfig-a002-20221003
hexagon              randconfig-r041-20221002
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
s390                 randconfig-r044-20221002
x86_64               randconfig-a006-20221003
x86_64               randconfig-a005-20221003
hexagon              randconfig-r045-20221002
hexagon              randconfig-r045-20221003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
