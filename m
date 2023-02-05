Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB97768B2E5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 00:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjBEXj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 18:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBEXjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 18:39:54 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FE81B315
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 15:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675640381; x=1707176381;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nfNnvmwzVZ3ZIWt9dU+cShvgsU/wr/5tSjmEf7fvn08=;
  b=QgESnrmlIDb2BdZTYm8gnT3h0HT8/INmLBC13uby4ae7kvBxZJj51rwG
   CO9LouDw1lVyJD6Ks1iVkMM7PGNTsiSNAwvhGZJOMU0RvBnPA4/MFz/yH
   PS7zF4uTHhy7368gIoGy/0smzE9N+vVz3mdVs/ctdP4XvjjZCoy80rqpo
   AX7bnIxkPILd20ekc4O6UT2Bnzvz+fFNFcTmdYYcMmrH4RZUMQoWZ4OKf
   OZsoCksDSNyrbcZ+XcfC9M9DYycbEEL6D23xp/NLuwkhAZnsAv7X7Z801
   946LzNby/Jlut/VOkkxNFvrE5F9AogCnbuPA+sOHsiLm8x04jPrcz+T7B
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="312755525"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="312755525"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 15:39:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="790276997"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="790276997"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Feb 2023 15:39:40 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOobj-0002Hg-1Z;
        Sun, 05 Feb 2023 23:39:39 +0000
Date:   Mon, 06 Feb 2023 07:39:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 9c1bb6c60d0a90d04dc5245be86a19daf9ac5c69
Message-ID: <63e03e3b.667wjNLzQWB/D1rJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 9c1bb6c60d0a90d04dc5245be86a19daf9ac5c69  Merge branch into tip/master: 'x86/vdso'

elapsed time: 783m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                              defconfig
arc                  randconfig-r043-20230205
arm                  randconfig-r046-20230205
i386                                defconfig
x86_64                        randconfig-a004
x86_64                               rhel-8.3
x86_64                        randconfig-a013
arc                                 defconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a011
s390                             allmodconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-bpf
alpha                               defconfig
arc                              allyesconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
sh                               allmodconfig
s390                                defconfig
x86_64                    rhel-8.3-kselftests
alpha                            allyesconfig
x86_64                        randconfig-a006
i386                          randconfig-a001
ia64                             allmodconfig
m68k                             allyesconfig
x86_64                        randconfig-a015
x86_64                           allyesconfig
mips                             allyesconfig
s390                             allyesconfig
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
powerpc                          allmodconfig

clang tested configs:
hexagon              randconfig-r045-20230205
x86_64                        randconfig-a012
hexagon              randconfig-r041-20230205
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a016
riscv                randconfig-r042-20230205
s390                 randconfig-r044-20230205
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
