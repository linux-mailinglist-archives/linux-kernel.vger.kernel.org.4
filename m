Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6F36917FD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 06:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjBJFcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 00:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjBJFcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 00:32:36 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4154860E7D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 21:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676007155; x=1707543155;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0dFcyVD1oH3bjnCx3SnrQoe2jS+/49+/6tdl/6g+w/A=;
  b=kXQULOy2hj2DK7TCBEFWEJ52nZMrUO8cdG8JDkaPQV/sn3+7PRSS9i9C
   N0W+QvFOQiJ8x0/GtbsOB3YaFcxUBCN64cKWusn5fkXA/MrjzIq9OpMjc
   hMNoXT3Nqi2xO6pbzdQV5gt4hn1jSH4iiKBe1DhZRFnmmEI/fYknT3+Eg
   sB5Z3Xm/Qn149S6Tb/qYJsZrCUE+ruiZzi6CsoL0aJ/dxNtJ1UgVaWdge
   hQtjq7mgqhqK6k3eZwaCRj7Bb5qt/btJuz4sblNFW8A3ooxOOWJ+YIfs1
   DGBSyFJl/Jk7X1xc5f7mdX45g+FTgv5TYCyIFfNxZp9H8tEmzoIvRdoRy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="331645082"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="331645082"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 21:32:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="667934711"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="667934711"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Feb 2023 21:32:24 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQM1I-0005Zw-0q;
        Fri, 10 Feb 2023 05:32:24 +0000
Date:   Fri, 10 Feb 2023 13:32:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:usama.2023.02.09a] BUILD REGRESSION
 d0fd6cf85f2b25e89444a52b75edbf3e96f99cdb
Message-ID: <63e5d6db.iFZNCjHyv/bGg62H%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git usama.2023.02.09a
branch HEAD: d0fd6cf85f2b25e89444a52b75edbf3e96f99cdb  x86/smpboot: Serialize topology updates for secondary bringup

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202302100556.sUYjKgbk-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/powerpc/kernel/smp.c:1768:1: error: function declared 'noreturn' should not return [-Werror,-Winvalid-noreturn]

Error/Warning ids grouped by kconfigs:

clang_recent_errors
`-- powerpc-buildonly-randconfig-r003-20230209
    `-- arch-powerpc-kernel-smp.c:error:function-declared-noreturn-should-not-return-Werror-Winvalid-noreturn

elapsed time: 727m

configs tested: 62
configs skipped: 2

gcc tested configs:
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20230209
arm                  randconfig-r046-20230209
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
s390                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
s390                             allmodconfig
i386                          randconfig-a005
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
s390                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                                defconfig
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
ia64                             allmodconfig
i386                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r041-20230209
hexagon              randconfig-r045-20230209
riscv                randconfig-r042-20230209
s390                 randconfig-r044-20230209
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
x86_64                        randconfig-a005
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
