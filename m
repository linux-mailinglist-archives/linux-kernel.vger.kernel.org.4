Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7E668A91F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 10:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjBDJDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 04:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBDJDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 04:03:41 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6977229E02
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 01:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675501420; x=1707037420;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HgDuakfv3ZA9HGRn4tut7Md/Jwkb35uPuJfaMab9L20=;
  b=SgsIdImg/Oh87G8/kzE1rx8I62Vjqs60qOzlV55nr9Ld5aHhMhUT7aVc
   aDtNowSfU4b9wcM8n1h2XXxGrIMNZ5Ldu7/Mu1LmB9yUS37RuOiwgcKzk
   Fqt0bXYaa6eiOGx1EpjQT2EOQfyIuEL5NMqfC3LB/xVUUFB2zlzWD57c9
   6zSviuAqcdns22V1kQhrH0Kyr6y4XdqI6GZqUU5UvtbSxZUR1APtRSJl9
   4X/+KOVnELvqXzdozLBSQNXsmYZ7qWUxgNIj8oEzPfin51tokYjHbYIRc
   b6tkROqYIOF2gxUSZvYkN5SuzM94797GSxLnmXbLizT1jt7rQbWghCbRz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="330220742"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="330220742"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 01:03:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="839862147"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="839862147"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Feb 2023 01:03:38 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOESP-0001BM-2q;
        Sat, 04 Feb 2023 09:03:37 +0000
Date:   Sat, 04 Feb 2023 17:02:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:clocksource.2023.02.02a] BUILD SUCCESS
 2ff7dacc88b0c7592650e8f62d9e4c13cdc31ea5
Message-ID: <63de1f2e.lbaZgGHZTc0fOi7W%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git clocksource.2023.02.02a
branch HEAD: 2ff7dacc88b0c7592650e8f62d9e4c13cdc31ea5  clocksource: Enable TSC watchdog checking of HPET and PMTMR only when requested

elapsed time: 1875m

configs tested: 65
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
ia64                             allmodconfig
sh                               allmodconfig
s390                             allmodconfig
x86_64                        randconfig-a006
s390                                defconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arc                  randconfig-r043-20230203
arm                  randconfig-r046-20230203
x86_64                          rhel-8.3-func
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                                defconfig
m68k                             allmodconfig
i386                             allyesconfig
powerpc                     stx_gp3_defconfig
xtensa                  cadence_csp_defconfig
powerpc                      mgcoge_defconfig
sh                            migor_defconfig
x86_64                    rhel-8.3-kselftests
arm                                 defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20230203
hexagon              randconfig-r041-20230203
riscv                randconfig-r042-20230203
s390                 randconfig-r044-20230203
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
