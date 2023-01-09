Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153656634DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjAIXNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjAIXNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:13:33 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8862D3B92A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673306012; x=1704842012;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LM4WQxi02oz822DzRs+F84SR/uXNs8ylwKn1OZk6d4Y=;
  b=iWnm7D5a1URkpPCpx113H5eXorL0mgS2rrMHTz/BAGUc1ckXl1dJOeQ0
   UiXEsem8wx+4pNQYHrxwH6W7+5Wrh7fau8EG71hEzItz36e0OaA29nqHe
   fG9wIoX0zbmis6Dd5N6TzpJETbsiN3t+lrnZ9g6ZqPzT3iSmvNe3mTFWr
   /jziZODJ70+6Ok7y4VtoB7BjfbEwRr4CRBgHvVOIv9F3T9FPSTHp61X53
   H6Z25GfRnOq1/LWY3qgm3Otx+2Grs5K1mUM036UAPkimFP9yjQEeCKJMx
   1uAKVbTTvfhZr2Adu0gmL73edpEH57rf7fnAKL8FG9+5U3NiC8jxIgflB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="387459423"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="387459423"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 15:13:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="634387804"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="634387804"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Jan 2023 15:13:30 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pF1Kc-0007LD-0C;
        Mon, 09 Jan 2023 23:13:30 +0000
Date:   Tue, 10 Jan 2023 07:13:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 9a5418bc48babb313d2a62df29ebe21ce8c06c59
Message-ID: <63bc9f92.r1QIRRShhp9rDCzI%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 9a5418bc48babb313d2a62df29ebe21ce8c06c59  sched/core: Use kfree_rcu() in do_set_cpus_allowed()

elapsed time: 725m

configs tested: 108
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
x86_64                            allnoconfig
x86_64                              defconfig
sh                               allmodconfig
x86_64                           allyesconfig
mips                             allyesconfig
x86_64                               rhel-8.3
ia64                             allmodconfig
arm                                 defconfig
arc                                 defconfig
s390                             allmodconfig
i386                                defconfig
x86_64                    rhel-8.3-kselftests
alpha                               defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-bpf
s390                                defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
powerpc                          allmodconfig
arm64                            allyesconfig
m68k                             allyesconfig
i386                 randconfig-a011-20230109
i386                 randconfig-a013-20230109
m68k                             allmodconfig
s390                             allyesconfig
arm                              allyesconfig
i386                 randconfig-a012-20230109
x86_64               randconfig-a011-20230109
x86_64               randconfig-a012-20230109
arc                              allyesconfig
i386                          randconfig-a001
x86_64               randconfig-a014-20230109
alpha                            allyesconfig
x86_64               randconfig-a013-20230109
i386                 randconfig-a014-20230109
i386                 randconfig-a016-20230109
i386                 randconfig-a015-20230109
x86_64               randconfig-a016-20230109
i386                          randconfig-a003
x86_64               randconfig-a015-20230109
i386                          randconfig-a005
riscv                randconfig-r042-20230109
s390                 randconfig-r044-20230109
arm                  randconfig-r046-20230108
i386                             allyesconfig
arc                  randconfig-r043-20230108
arc                  randconfig-r043-20230109
sh                         apsh4a3a_defconfig
powerpc                   motionpro_defconfig
arc                     haps_hs_smp_defconfig
powerpc                      makalu_defconfig
powerpc                      mgcoge_defconfig
arm64                            alldefconfig
mips                         cobalt_defconfig
mips                  maltasmvp_eva_defconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
m68k                          hp300_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                         microdev_defconfig
m68k                        stmark2_defconfig
arm                             pxa_defconfig
arc                           tb10x_defconfig
arm                              allmodconfig
arm                       multi_v4t_defconfig
arc                    vdk_hs38_smp_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20230109
arm                  randconfig-r046-20230109
hexagon              randconfig-r041-20230108
i386                          randconfig-a002
x86_64               randconfig-a003-20230109
x86_64               randconfig-a002-20230109
hexagon              randconfig-r041-20230109
x86_64               randconfig-a004-20230109
x86_64               randconfig-a001-20230109
hexagon              randconfig-r045-20230108
i386                          randconfig-a006
s390                 randconfig-r044-20230108
i386                          randconfig-a004
x86_64               randconfig-a005-20230109
x86_64               randconfig-a006-20230109
riscv                randconfig-r042-20230108
x86_64                        randconfig-k001
i386                 randconfig-a005-20230109
i386                 randconfig-a006-20230109
i386                 randconfig-a001-20230109
i386                 randconfig-a002-20230109
i386                 randconfig-a003-20230109
i386                 randconfig-a004-20230109
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
mips                     loongson1c_defconfig
mips                      maltaaprp_defconfig
powerpc               mpc834x_itxgp_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
