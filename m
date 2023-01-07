Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65665660F43
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 14:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjAGN4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 08:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjAGN4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 08:56:48 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F91961339
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 05:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673099807; x=1704635807;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HuB/iDR/q2A/v/K+y+rdj7DtUd8ZBviD2uQ7V8xuARI=;
  b=TymzUjhpzZxI8haZw03er8lGC9fWnoj6Eirf13HUCedZYAjuihv6+cJh
   coGX2qXzOdIbIuFmslAjGTIqgor4nn5UhFJjIBxou/bK9oIptwP9QXviU
   AL6x0sreWN7wGaXAhEbVDtc8CQ8h4SfdX9GoIuOQrB7ZyKxVu2EGf1AMU
   A0YJJEoyiGTVL60eKw/ZNeIke3paEaz9MXCVUYVXd56M0zO+axakQhnpC
   eUm5rYwfwBn0yliVMiKCHedLPLzumTEz/6qzzEN3TGBd42u8s2MtTx4ge
   TSY6/poY7jVb1cNxJPCR+r+EXASxmaiykgt/goXW8ppovb9FGjMknJ8yD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="408884324"
X-IronPort-AV: E=Sophos;i="5.96,308,1665471600"; 
   d="scan'208";a="408884324"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 05:56:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="984947025"
X-IronPort-AV: E=Sophos;i="5.96,308,1665471600"; 
   d="scan'208";a="984947025"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jan 2023 05:56:45 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pE9gg-0004aO-0f;
        Sat, 07 Jan 2023 13:56:43 +0000
Date:   Sat, 07 Jan 2023 21:56:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:workqueue.2023.01.06a] BUILD REGRESSION
 1d85f95f4694b6a8eb0d4a11bdd38a92abcbe002
Message-ID: <63b979f7.82v5PXXG3EB8TcJa%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git workqueue.2023.01.06a
branch HEAD: 1d85f95f4694b6a8eb0d4a11bdd38a92abcbe002  workqueue: Make show_pwq() use run-length encoding

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202301071437.qTKn0SDP-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "show_all_workqueues" [kernel/rcu/rcutorture.ko] undefined!

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-randconfig-r046-20230106
|   `-- ERROR:show_all_workqueues-kernel-rcu-rcutorture.ko-undefined
|-- i386-randconfig-c001
|   `-- ERROR:show_all_workqueues-kernel-rcu-rcutorture.ko-undefined
|-- i386-randconfig-c021
|   `-- ERROR:show_all_workqueues-kernel-rcu-rcutorture.ko-undefined
|-- i386-randconfig-m021
|   `-- ERROR:show_all_workqueues-kernel-rcu-rcutorture.ko-undefined
|-- i386-randconfig-s001
|   `-- ERROR:show_all_workqueues-kernel-rcu-rcutorture.ko-undefined
|-- i386-randconfig-s002
|   `-- ERROR:show_all_workqueues-kernel-rcu-rcutorture.ko-undefined
|-- i386-randconfig-s003
|   `-- ERROR:show_all_workqueues-kernel-rcu-rcutorture.ko-undefined
|-- powerpc-allmodconfig
|   `-- ERROR:show_all_workqueues-kernel-rcu-rcutorture.ko-undefined
|-- s390-randconfig-s041-20230106
|   `-- ERROR:show_all_workqueues-kernel-rcu-rcutorture.ko-undefined
|-- x86_64-randconfig-c002
|   `-- ERROR:show_all_workqueues-kernel-rcu-rcutorture.ko-undefined
|-- x86_64-randconfig-c022
|   `-- ERROR:show_all_workqueues-kernel-rcu-rcutorture.ko-undefined
|-- x86_64-randconfig-m001
|   `-- ERROR:show_all_workqueues-kernel-rcu-rcutorture.ko-undefined
|-- x86_64-randconfig-s021
|   `-- ERROR:show_all_workqueues-kernel-rcu-rcutorture.ko-undefined
|-- x86_64-randconfig-s022
|   `-- ERROR:show_all_workqueues-kernel-rcu-rcutorture.ko-undefined
`-- x86_64-randconfig-s023
    `-- ERROR:show_all_workqueues-kernel-rcu-rcutorture.ko-undefined

elapsed time: 732m

configs tested: 101
configs skipped: 3

gcc tested configs:
i386                                defconfig
powerpc                           allnoconfig
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
arc                  randconfig-r043-20230106
sh                               allmodconfig
arm                  randconfig-r046-20230106
powerpc                          allmodconfig
x86_64                        randconfig-a004
i386                          randconfig-a001
s390                             allmodconfig
i386                          randconfig-a003
mips                             allyesconfig
arm                                 defconfig
i386                          randconfig-a005
i386                          randconfig-a014
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a016
alpha                               defconfig
x86_64                        randconfig-a015
arm64                            allyesconfig
i386                             allyesconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a006
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
arm                              allyesconfig
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                               rhel-8.3
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
s390                                defconfig
x86_64                          rhel-8.3-func
alpha                            allyesconfig
m68k                             allyesconfig
ia64                             allmodconfig
arc                              allyesconfig
powerpc                 linkstation_defconfig
sparc64                             defconfig
powerpc                       ppc64_defconfig
sh                            titan_defconfig
ia64                             alldefconfig
powerpc                     mpc83xx_defconfig
powerpc                      ppc40x_defconfig
arc                              alldefconfig
mips                           ci20_defconfig
arm                        cerfcube_defconfig
m68k                        mvme147_defconfig
i386                          randconfig-c001
arm                        clps711x_defconfig
arm                       imx_v6_v7_defconfig
mips                           xway_defconfig
arm                            lart_defconfig
mips                         db1xxx_defconfig
powerpc                      ppc6xx_defconfig
mips                         cobalt_defconfig
sh                          rsk7264_defconfig
x86_64                           alldefconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm64                               defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     rainier_defconfig
sh                           se7619_defconfig
arm                        oxnas_v6_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
hexagon              randconfig-r045-20230106
i386                          randconfig-a002
hexagon              randconfig-r041-20230106
i386                          randconfig-a004
i386                          randconfig-a013
riscv                randconfig-r042-20230106
i386                          randconfig-a011
x86_64                        randconfig-a012
x86_64                        randconfig-a001
i386                          randconfig-a015
i386                          randconfig-a006
x86_64                        randconfig-a014
s390                 randconfig-r044-20230106
x86_64                        randconfig-a016
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust
x86_64                        randconfig-k001
hexagon              randconfig-r041-20230107
hexagon              randconfig-r045-20230107
arm                  randconfig-r046-20230107

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
