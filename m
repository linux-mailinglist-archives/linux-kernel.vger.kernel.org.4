Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B3E68DE2D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjBGQrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBGQrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:47:17 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989A239B96
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675788436; x=1707324436;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DsOK4vKSMQgQY8rpRAJjjVTikkqV9NOuG7jF/Xfiv9w=;
  b=m+07OCqMteb+LGlIsM7P742awArdrszW+co5tCol37GnUUY6ocRwf8KC
   PRPlB9Vq8+F4HbfbVCnmXTW6BYJ8bnV9ko2uebql3TZLRIPrUAF1LkfR4
   PzSJVzl6rzrIvI7REuGlkch9kbctItloFfncD8eiSNGnfHGweYhYdCz4e
   Aw7Z/nxh1zkFr60w6SsiqspVm60287t4C3D5AGk7oIGsIRu9XcHpWet+o
   R2NvaSVpunNNr9RpSA+W1eDP39Vdo/YWHNe16IX2iOrBVK+cIfTuQ0jkc
   D7QslxH7FPWlvCn/tYOx5V1PCSEHimKn4CAFiVWBzFoFdxikZHzJT8qY9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="327248499"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="327248499"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 08:47:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="840833570"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="840833570"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Feb 2023 08:47:14 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPR7h-0003iC-1y;
        Tue, 07 Feb 2023 16:47:13 +0000
Date:   Wed, 08 Feb 2023 00:46:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 cdd4b92e382b4245faca3713c2efb9ecd46cd5a2
Message-ID: <63e28058.gfkRX9SgQ5FfjczH%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: cdd4b92e382b4245faca3713c2efb9ecd46cd5a2  tools/memory-model: Provide exact SRCU semantics

elapsed time: 728m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
powerpc                           allnoconfig
arm                                 defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
arc                                 defconfig
x86_64                           rhel-8.3-bpf
s390                             allmodconfig
x86_64                           rhel-8.3-syz
alpha                               defconfig
s390                                defconfig
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
i386                 randconfig-a011-20230206
x86_64               randconfig-a014-20230206
ia64                             allmodconfig
arm64                            allyesconfig
mips                             allyesconfig
s390                             allyesconfig
m68k                             allyesconfig
i386                                defconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64               randconfig-a013-20230206
x86_64                           allyesconfig
arm                              allyesconfig
alpha                            allyesconfig
i386                 randconfig-a014-20230206
powerpc                          allmodconfig
x86_64               randconfig-a011-20230206
i386                 randconfig-a012-20230206
x86_64               randconfig-a015-20230206
i386                 randconfig-a016-20230206
x86_64               randconfig-a012-20230206
i386                 randconfig-a013-20230206
x86_64               randconfig-a016-20230206
i386                 randconfig-a015-20230206
i386                             allyesconfig
s390                 randconfig-r044-20230206
arc                  randconfig-r043-20230205
arm                  randconfig-r046-20230205
arc                  randconfig-r043-20230206
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
riscv                randconfig-r042-20230206
arm                         assabet_defconfig
powerpc                 mpc834x_itx_defconfig
sh                            titan_defconfig
sh                          sdk7780_defconfig
alpha                             allnoconfig

clang tested configs:
i386                 randconfig-a002-20230206
i386                 randconfig-a005-20230206
i386                 randconfig-a004-20230206
i386                 randconfig-a003-20230206
i386                 randconfig-a001-20230206
i386                 randconfig-a006-20230206
x86_64               randconfig-a001-20230206
x86_64               randconfig-a005-20230206
x86_64               randconfig-a006-20230206
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
x86_64               randconfig-a003-20230206
hexagon              randconfig-r041-20230205
riscv                randconfig-r042-20230205
hexagon              randconfig-r045-20230206
hexagon              randconfig-r041-20230206
arm                  randconfig-r046-20230206
x86_64                          rhel-8.3-rust
s390                 randconfig-r044-20230205
hexagon              randconfig-r045-20230205

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
