Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D856759A0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjATQPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjATQPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:15:13 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B493B472
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674231312; x=1705767312;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JZ9P+5adVxPWgRnaAl1SngyBKOW4WW4SHnXZ1TGiEWI=;
  b=B8JWY26mXeVK9VU+KVxbNUNPTyWq12cpuLAYmSABeKpYl2xqlGAfINXw
   m4TUf9vdyQ7TdoE9ZuALqHJycQSXed4X3VdoYZ18NVb2eB7r+1d1jHdXq
   faWrs2MsKys6jPcMEB3Ma5PYZNRFwDYGwr/BKUL4/4QCbTo/S7Ihrntyv
   O7M4ao3KwBUTTkbOeG258CNG+jnRIkZcs+dTQ8esgzVO2HKWNdnPZxYMj
   utjIJB2Z+Cy59sZSdSxRe6LfyW+ToVeIzdm9p8dllXIwwQy4wXPSYH6b6
   SsGJlv6Hj24IAzDGOyn0DJ2yWSTWPHMPon4t3TLCRm4hR3sy6n3bYVqKO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="309187366"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="309187366"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 08:15:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="638198976"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="638198976"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Jan 2023 08:15:10 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIu2n-0002gs-2w;
        Fri, 20 Jan 2023 16:15:09 +0000
Date:   Sat, 21 Jan 2023 00:14:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.01.17a] BUILD SUCCESS
 c7b1319271df427da37720a1b656297dd73da37e
Message-ID: <63cabde4.TMCYN2X7zmdHc3nM%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.01.17a
branch HEAD: c7b1319271df427da37720a1b656297dd73da37e  locking/csd_lock: Remove per-CPU data indirection from CSD lock debugging

elapsed time: 1017m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
ia64                             allmodconfig
s390                             allyesconfig
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                               rhel-8.3
sh                               allmodconfig
i386                          randconfig-a001
x86_64                           allyesconfig
mips                             allyesconfig
i386                          randconfig-a003
arc                              allyesconfig
x86_64                           rhel-8.3-syz
powerpc                          allmodconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a005
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
i386                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allmodconfig
sh                           se7722_defconfig
powerpc                  storcenter_defconfig
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a013
sh                          rsk7269_defconfig
powerpc                       maple_defconfig
ia64                                defconfig
sh                        sh7757lcr_defconfig
openrisc                  or1klitex_defconfig
x86_64                        randconfig-a011
i386                          randconfig-a016
x86_64                        randconfig-a015
i386                             allyesconfig
x86_64                        randconfig-a004
arm                  randconfig-r046-20230119
x86_64                        randconfig-a002
arc                  randconfig-r043-20230119
x86_64                        randconfig-a006
i386                          randconfig-c001
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
riscv                randconfig-r042-20230119
s390                 randconfig-r044-20230119
hexagon              randconfig-r041-20230119
hexagon              randconfig-r045-20230119
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
