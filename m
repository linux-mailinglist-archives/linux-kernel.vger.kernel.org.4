Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A8760F647
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiJ0Leb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiJ0Le3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:34:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB512AE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666870466; x=1698406466;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=flCRs9jw0HAjMIFvnZCYTgvhKf7rP5DZDjYxa1HnfSE=;
  b=UHI+yI3q1i6NwMAKhKy24AJTSw7gNOpDRK2OUWqdGqw2iJPMTys6KQEu
   d/BsgceTW3kLF16m8XWz+aSYAJrlKvx/cSnVGrzlvaJv6tAzra0qzIaub
   XiQLuLGu+7VZRQUjMqxtytdABxZch6KReSzJbWKLN1iivqyNBClQdhRLN
   uQDwZBmBQriFU7Ih6o5FURxvOEM+qTPYKYSrkcB4LGqbOh3jAnFES0hpK
   tLqm/O2EHIj+CHRFCnX5C/bATTu23r57kO8ve6Umcs+Ach0ISgHWSWYJo
   uBlkeuAsvnvHphojrxJsAeqYgDDYCY4Ruk8Fs0WUqAzd+E8/LCzffUXxW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="309289877"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="309289877"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 04:34:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="583524315"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="583524315"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 27 Oct 2022 04:34:21 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oo19Q-0008jJ-1r;
        Thu, 27 Oct 2022 11:34:20 +0000
Date:   Thu, 27 Oct 2022 19:33:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 1c382012d3fc642907b0dd1c729e0f38d6f8fb21
Message-ID: <635a6c8f.4nUDNT4Uh7UC28TZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 1c382012d3fc642907b0dd1c729e0f38d6f8fb21  rcu: Refactor kvfree_call_rcu() and high-level helpers

elapsed time: 1022m

configs tested: 66
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
i386                          randconfig-a001
s390                             allyesconfig
i386                          randconfig-a003
powerpc                           allnoconfig
x86_64                              defconfig
powerpc                          allmodconfig
riscv                randconfig-r042-20221026
i386                          randconfig-a005
i386                                defconfig
mips                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a013
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a011
i386                          randconfig-a014
x86_64                        randconfig-a002
arm                                 defconfig
arc                  randconfig-r043-20221026
x86_64                               rhel-8.3
ia64                             allmodconfig
s390                 randconfig-r044-20221026
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
i386                          randconfig-a012
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a006
i386                          randconfig-a016
arm64                            allyesconfig
x86_64                        randconfig-a015
arm                              allyesconfig
i386                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
m68k                       m5249evb_defconfig
parisc                generic-32bit_defconfig
arm                          pxa910_defconfig
powerpc                    amigaone_defconfig
sh                           se7724_defconfig
sh                          rsk7201_defconfig
i386                          randconfig-c001

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a016
x86_64                        randconfig-a001
hexagon              randconfig-r045-20221026
i386                          randconfig-a011
hexagon              randconfig-r041-20221026
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a015
x86_64                        randconfig-a003
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
