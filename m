Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E7D650790
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiLSGcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiLSGcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:32:04 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B9F642A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 22:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671431523; x=1702967523;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=09rO7y+QGwWxfSypBxMyudL81kLYeHKmjoumZkz+UF0=;
  b=O4oSJlVsmerpDxjOftQMxu6YWVdrL4FpJX01hw+RObAmAkoYGccvrVzX
   MltjJvje45rfelCupUphZXSWlN3vyV3tRn1QN9LjB4M1QHAseUdofxvag
   LoFDbs4lETVSupO9yIO8ju2RKikJNrAkj3EA2rzKhR+BlEQYB5PwwDSNi
   iPwKwAoJ1FPNvAyAp6F6hTdl8zOGRA96FpfkWAKIPCMbV4Y/Me6InXdiy
   t/l1XCeVU02CZ00XZ8z39mtshsRAYhc204X3JaaS0y7R28rttwQs4xlhM
   XFwmdIM5SqkLlWHJrAVW8AJpHUU+IPEtopAAGQndBA8mLJvna09ZB1pL1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="299611964"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="299611964"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2022 22:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="681112580"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="681112580"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 18 Dec 2022 22:32:01 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p79gv-0008av-02;
        Mon, 19 Dec 2022 06:32:01 +0000
Date:   Mon, 19 Dec 2022 14:31:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 f061f6b881994ce14e12b7d6a8aa92b299db1d3d
Message-ID: <63a00541.PEt40r7KUZjlEvHx%lkp@intel.com>
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
branch HEAD: f061f6b881994ce14e12b7d6a8aa92b299db1d3d  Merge branch 'nolibc.2022.10.28a' into HEAD

elapsed time: 725m

configs tested: 93
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                           rhel-8.3-syz
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-bpf
x86_64                               rhel-8.3
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
i386                                defconfig
x86_64               randconfig-a002-20221219
x86_64               randconfig-a003-20221219
x86_64               randconfig-a001-20221219
x86_64               randconfig-a004-20221219
arc                                 defconfig
riscv                randconfig-r042-20221218
s390                             allmodconfig
ia64                             allmodconfig
arc                  randconfig-r043-20221219
alpha                               defconfig
arm                  randconfig-r046-20221219
arm                                 defconfig
i386                 randconfig-a004-20221219
arc                  randconfig-r043-20221218
s390                                defconfig
x86_64               randconfig-a005-20221219
x86_64               randconfig-a006-20221219
m68k                             allmodconfig
i386                 randconfig-a001-20221219
s390                             allyesconfig
sh                               allmodconfig
i386                 randconfig-a006-20221219
i386                 randconfig-a003-20221219
x86_64                           allyesconfig
i386                 randconfig-a002-20221219
i386                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                 randconfig-a005-20221219
mips                             allyesconfig
m68k                             allyesconfig
s390                 randconfig-r044-20221218
sh                        edosk7760_defconfig
riscv                    nommu_k210_defconfig
powerpc                          allmodconfig
microblaze                          defconfig
arm                              allyesconfig
arm64                            allyesconfig
mips                      fuloong2e_defconfig
m68k                            mac_defconfig
arm                      footbridge_defconfig
powerpc                  storcenter_defconfig
riscv                               defconfig
arm                            pleb_defconfig
arc                          axs103_defconfig
openrisc                            defconfig
powerpc                     taishan_defconfig
powerpc                   currituck_defconfig
powerpc                     ep8248e_defconfig
powerpc                      mgcoge_defconfig
arm                          exynos_defconfig
arm                          lpd270_defconfig
arm                      jornada720_defconfig
i386                 randconfig-c001-20221219
powerpc              randconfig-c003-20221219

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a011-20221219
x86_64               randconfig-a012-20221219
hexagon              randconfig-r045-20221219
i386                 randconfig-a016-20221219
s390                 randconfig-r044-20221219
x86_64               randconfig-a014-20221219
hexagon              randconfig-r041-20221219
x86_64               randconfig-a015-20221219
arm                  randconfig-r046-20221218
x86_64               randconfig-a013-20221219
hexagon              randconfig-r045-20221218
x86_64               randconfig-a016-20221219
hexagon              randconfig-r041-20221218
riscv                randconfig-r042-20221219
i386                 randconfig-a012-20221219
i386                 randconfig-a013-20221219
arm                        neponset_defconfig
i386                 randconfig-a011-20221219
i386                 randconfig-a014-20221219
i386                 randconfig-a015-20221219
powerpc                     tqm8560_defconfig
arm                          pxa168_defconfig
arm                           sama7_defconfig
x86_64               randconfig-k001-20221219

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
