Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122B062D590
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbiKQIyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiKQIys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:54:48 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E4F6A690
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668675286; x=1700211286;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FrC/238rWZDFvnrulenbQDUe4LWyJ9YpJGBPwZxw4ig=;
  b=RHvvohlqbjzHyxWf/vypUe11tIddB1IQ0SR6gJOY9b1xCCkULHPHDL7a
   w5Ee3QxQEa96S8zNJxg2aqf++ZqX425TTch4FQmw2bA04jIT2jrda75Q0
   MfLa+A5Jx806Uh77nDR3VXP+a7KM0T7AiDRd3ufknaNf1ciQDnxe6kBB8
   N1dj9tDRzlcTvbn/bOPNvTAOWB2KVMNYsEVNuTSAWQ7SewrQ47DhVqpUO
   ODedGGG6RcJaJVRJZv3Vtn2vETYB9Ct37NHz9/A0tM6RUY03Q1a8yBuGT
   MuBdNimErYOJOMAqiPKJ1WJK7Ux8/sA+i76XH3mz2pAEewYauKLEmPDyc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="300331435"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="300331435"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 00:54:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="782146569"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="782146569"
Received: from lkp-server01.sh.intel.com (HELO 55744f5052f8) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 17 Nov 2022 00:54:45 -0800
Received: from kbuild by 55744f5052f8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovafU-000061-1O;
        Thu, 17 Nov 2022 08:54:44 +0000
Date:   Thu, 17 Nov 2022 16:54:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.11.09a] BUILD SUCCESS
 01ecdf0059a55d2ef4d548f1ae9c7b7c4085ba09
Message-ID: <6375f6cb.jX5GS3M9ZusQSKP6%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.11.09a
branch HEAD: 01ecdf0059a55d2ef4d548f1ae9c7b7c4085ba09  clocksource: Print clocksource name when clocksource is tested unstable

elapsed time: 731m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
mips                             allyesconfig
i386                          randconfig-a001
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a003
i386                          randconfig-a005
sh                               allmodconfig
alpha                            allyesconfig
x86_64                        randconfig-a002
m68k                             allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a006
arc                  randconfig-r043-20221116
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
i386                             allyesconfig
i386                                defconfig
arm                                 defconfig
x86_64                            allnoconfig
arc                        nsim_700_defconfig
powerpc                        cell_defconfig
x86_64                              defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                               rhel-8.3
x86_64                           allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
riscv                randconfig-r042-20221116
hexagon              randconfig-r041-20221116
hexagon              randconfig-r045-20221116
x86_64                        randconfig-a012
s390                 randconfig-r044-20221116
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221117
hexagon              randconfig-r045-20221117
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
