Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B526920EF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjBJOjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjBJOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:39:43 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A605B7406C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676039979; x=1707575979;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+qFyI8CtoSpela224521qFYjjdIfiZwCh1kqDCU2iSw=;
  b=GXJNYWzavCydx+3CGiS7dkbxC8e8UamyjED9cwQ3Q8Dv7Rdk8b8Vdoyl
   LkZ1AHlQKfWReZ3cvYge8Een5b3kr4Kq+PlDdt+UQDM8YMjF36gsTUCuu
   w+ibNmzqptZqtwQ86zKTTx1EAIPFcrA8kxd1e9FR491NGPDzoeKVoBOnJ
   Bvj+j95QPRfJYFu1VKJuvskEML0RKvDlNLRsL5/KDaxz68XKEUIdq6+kV
   3muRzfNckZDS3gqTCd6VhZXrvQ3PDi3DbYevjerX6s8Lq3xZ1dE/cU0Kv
   DF/+LIB20in7ElIrvffds8RU6UP7XHvGkT+3jT4msIZ7yjP3DTfNe9xGF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310795749"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="310795749"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 06:39:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="698446951"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="698446951"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 10 Feb 2023 06:39:37 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQUYr-0005qT-0G;
        Fri, 10 Feb 2023 14:39:37 +0000
Date:   Fri, 10 Feb 2023 22:39:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 5b268d8abaec6cbd4bd70d062e769098d96670aa
Message-ID: <63e65704.J26Trc5m9tdshyvf%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 5b268d8abaec6cbd4bd70d062e769098d96670aa  time/debug: Fix memory leak with using debugfs_lookup()

elapsed time: 1135m

configs tested: 93
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                              defconfig
s390                             allyesconfig
x86_64                           rhel-8.3-bpf
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20230209
arm                  randconfig-r046-20230209
x86_64                           allyesconfig
sh                               allmodconfig
ia64                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                                defconfig
i386                          randconfig-a003
x86_64                        randconfig-a006
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                             allyesconfig
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
arm64                            allyesconfig
x86_64                          rhel-8.3-func
arm                              allyesconfig
m68k                                defconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
arm64                               defconfig
mips                             allmodconfig
csky                                defconfig
sparc                               defconfig
arm                              allmodconfig
x86_64                                  kexec
arm                  randconfig-r046-20230210
arc                  randconfig-r043-20230210
loongarch                         allnoconfig
ia64                                defconfig
loongarch                           defconfig
m68k                          hp300_defconfig
sparc64                             defconfig
i386                              debian-10.3
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
loongarch                        allmodconfig
riscv                            allmodconfig

clang tested configs:
hexagon              randconfig-r045-20230209
s390                 randconfig-r044-20230209
riscv                randconfig-r042-20230209
hexagon              randconfig-r041-20230209
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230210
riscv                randconfig-r042-20230210
hexagon              randconfig-r045-20230210
s390                 randconfig-r044-20230210
arm                            mmp2_defconfig
powerpc                 mpc8272_ads_defconfig
mips                           ip28_defconfig
mips                      bmips_stb_defconfig

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
