Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BF16106F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 02:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiJ1AwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 20:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiJ1Av5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 20:51:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094ED8305D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 17:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666918317; x=1698454317;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=euJaYfUDbJHGRmJYbLyxb2ClKZhGxqh6Xe13Fv3W/jc=;
  b=jKzg1tlpiLZsiIxVqInzfYGBvhHUn2B10EEYtx59L5hLBOdpE3vH+1qm
   1e6OerGLQ3ou09cFy4i2X5cAe4pj6oIroqaBCwfx+UqG0dXsBKxnikKKB
   /TkzuCkt5d5WbZ1RL3UjV6BMJUQsDgVEcnHKiqHekCb5cptWIO/5Rg2Zt
   nwD9LLVziLTruvYSbTdts8njygrVsxdsoq4CN2b/12zSUTR7m0NpOVetD
   MZkhZdwInK2f4f6q5U4i6XgaONBNNmbIYJ1GPW1hlfYPjptmnM2rYte8a
   kzC051iTfJm1/96BXwnTVMW201ykyqMXAyekkrGcfMfGX6MrNVOmurqAc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="309471436"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="309471436"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 17:51:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="610566989"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="610566989"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 27 Oct 2022 17:51:55 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooDbH-0009JT-0N;
        Fri, 28 Oct 2022 00:51:55 +0000
Date:   Fri, 28 Oct 2022 08:51:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 c6fbb759d68898aad40e57d09ed18df6094a1874
Message-ID: <635b2793.RQLw4nfMy2uU/Qee%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: c6fbb759d68898aad40e57d09ed18df6094a1874  virt/sev-guest: Remove unnecessary free in init_crypto()

elapsed time: 724m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                          rhel-8.3-func
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
s390                             allmodconfig
s390                                defconfig
powerpc                           allnoconfig
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
x86_64                           rhel-8.3-kvm
riscv                randconfig-r042-20221026
x86_64                           rhel-8.3-syz
mips                             allyesconfig
arc                  randconfig-r043-20221026
s390                             allyesconfig
s390                 randconfig-r044-20221026
sh                               allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                        randconfig-a002
m68k                             allyesconfig
i386                          randconfig-a001
arm                                 defconfig
m68k                             allmodconfig
i386                                defconfig
arc                              allyesconfig
i386                          randconfig-a003
alpha                            allyesconfig
x86_64                        randconfig-a004
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a006
arm                              allyesconfig
x86_64                        randconfig-a013
arm64                            allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                             allyesconfig
i386                          randconfig-a016

clang tested configs:
hexagon              randconfig-r045-20221026
hexagon              randconfig-r041-20221026
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
x86_64                        randconfig-a005
i386                          randconfig-a006
x86_64                        randconfig-a012
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
