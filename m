Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D740663DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjAJKRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbjAJKRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:17:08 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A8343E5B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673345801; x=1704881801;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QxTdU7E8BL2ibSooTQm+bF0sSkws8xhiP9rVOGYn27c=;
  b=TelnG8xa9Z4NfIniMPqjxEDcYgf0mCtnZ6FUz01JzVQaLhaTkMPc2jtm
   Mzz40hePujSH639I3kWoYWj68fEXAFEUCouItT1GwORKUSUC/FqzRe4eH
   5aYNGCOUhtVmJNlB6HL0W0/FLi3iTdafge/i/DIAWhEwEcgpQcRzTuDhY
   Ch8X9RJmEda85LoGFHL9BQ7Toco1XMEmIFvYv3rbNBGDIrIDTx6wtm4tQ
   q8Zjb1QcnzSRscm6uL+ak4kCabiclvCXZ/2toxL9dp3KJWDotz0pBYj3A
   imtFVf+owH8CH3FDwiY0g799gSj2qfOZmIVw2lsG0cj53FNFzkrq/eqGX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="320803701"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="320803701"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 02:16:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="650314141"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="650314141"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 10 Jan 2023 02:16:35 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFBgJ-0007rw-0K;
        Tue, 10 Jan 2023 10:16:35 +0000
Date:   Tue, 10 Jan 2023 18:16:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:nolibc] BUILD SUCCESS
 28ef4c3753a4e57a347b2bf5f598645de966c137
Message-ID: <63bd3af5.4McHAJSmGUxkVHh+%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git nolibc
branch HEAD: 28ef4c3753a4e57a347b2bf5f598645de966c137  rcutorture: build initrd for rcutorture with nolibc

elapsed time: 728m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
um                           x86_64_defconfig
arc                              allyesconfig
um                             i386_defconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
i386                 randconfig-a014-20230109
x86_64                               rhel-8.3
i386                 randconfig-a011-20230109
i386                 randconfig-a016-20230109
ia64                             allmodconfig
i386                 randconfig-a015-20230109
x86_64                           allyesconfig
i386                 randconfig-a013-20230109
i386                 randconfig-a012-20230109
sh                               allmodconfig
x86_64               randconfig-a011-20230109
mips                             allyesconfig
x86_64               randconfig-a013-20230109
powerpc                          allmodconfig
x86_64               randconfig-a012-20230109
i386                                defconfig
x86_64               randconfig-a014-20230109
x86_64               randconfig-a016-20230109
x86_64               randconfig-a015-20230109
arm                                 defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
arc                  randconfig-r043-20230110
riscv                randconfig-r042-20230109
s390                 randconfig-r044-20230110
s390                 randconfig-r044-20230109
arm                  randconfig-r046-20230108
arc                  randconfig-r043-20230108
arc                  randconfig-r043-20230109
riscv                randconfig-r042-20230110

clang tested configs:
i386                 randconfig-a004-20230109
i386                 randconfig-a002-20230109
i386                 randconfig-a003-20230109
i386                 randconfig-a001-20230109
i386                 randconfig-a005-20230109
i386                 randconfig-a006-20230109
x86_64               randconfig-a003-20230109
x86_64               randconfig-a002-20230109
x86_64               randconfig-a004-20230109
x86_64               randconfig-a005-20230109
x86_64               randconfig-a001-20230109
x86_64               randconfig-a006-20230109
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20230109
hexagon              randconfig-r041-20230110
arm                  randconfig-r046-20230109
riscv                randconfig-r042-20230108
arm                  randconfig-r046-20230110
hexagon              randconfig-r041-20230108
hexagon              randconfig-r041-20230109
hexagon              randconfig-r045-20230108
s390                 randconfig-r044-20230108
hexagon              randconfig-r045-20230110

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
