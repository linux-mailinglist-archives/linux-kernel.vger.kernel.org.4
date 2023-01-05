Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BEE65E7D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjAEJbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjAEJbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:31:45 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE4F54739
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672911103; x=1704447103;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7zH7C/PCfGV9ys5s9SZpMIakdNBiBO+Dyt9aQktyFGk=;
  b=ILxiU+S/JiEXVBoe5z+eOM84zwA5KSbVaiUnJ4mL2hL4Sn3dpzBZDY5n
   C9E5fRh8PkzDbshH6Q+plaOqPVmKmCDZ0aGvviMSC6eMHfg5W2LN2Mmm9
   JnWWVFmPnWVoSqb2RdFuojY9anXe8IVOeMDL3iB6eTWH27Kd3NasXb1U0
   vUi2YQ+Su0+bBp4V5qrVp5birRE/x4gioXKvQhNtz4bZFwZCFX27/RdD0
   mmwCupLt4cuFQA14NN/oNk7xlh7cKlQzUw8bbA2QYW/Du++VyGg96KvGy
   8ZKT+X8XrYWe/z6ihfmwq1oE2pgEmUVYUEN0I4QaO9+ei58+zMuocmGJA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="349380396"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="349380396"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 01:31:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="686053560"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="686053560"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 05 Jan 2023 01:31:41 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDMb6-0001SC-25;
        Thu, 05 Jan 2023 09:31:40 +0000
Date:   Thu, 05 Jan 2023 17:31:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.01.03a] BUILD SUCCESS
 6c40b2f9652385191c2e166137f4902873cd757a
Message-ID: <63b698e0.JI1VCEQIR7Rn2JzH%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.01.03a
branch HEAD: 6c40b2f9652385191c2e166137f4902873cd757a  srcu: Add comments for srcu_size_state

elapsed time: 725m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
powerpc                           allnoconfig
alpha                               defconfig
x86_64                            allnoconfig
s390                                defconfig
s390                             allyesconfig
sh                               allmodconfig
m68k                             allmodconfig
m68k                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
powerpc                          allmodconfig
um                             i386_defconfig
mips                             allyesconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           rhel-8.3-bpf
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
i386                 randconfig-a004-20230102
i386                 randconfig-a003-20230102
i386                 randconfig-a001-20230102
arm                                 defconfig
i386                 randconfig-a002-20230102
i386                 randconfig-a005-20230102
i386                 randconfig-a006-20230102
arm64                            allyesconfig
x86_64                        randconfig-a002
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a006
x86_64                          rhel-8.3-func
x86_64                        randconfig-a004
i386                                defconfig
arm                              allyesconfig
arc                  randconfig-r043-20230105
s390                 randconfig-r044-20230105
riscv                randconfig-r042-20230105
i386                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
arm                  randconfig-r046-20230105
hexagon              randconfig-r041-20230105
hexagon              randconfig-r045-20230105
i386                 randconfig-a013-20230102
i386                 randconfig-a012-20230102
i386                 randconfig-a011-20230102
i386                 randconfig-a014-20230102
i386                 randconfig-a015-20230102
i386                 randconfig-a016-20230102
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
