Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A896599BA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiL3Pcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiL3Pci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:32:38 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B748B841
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672414358; x=1703950358;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2v8sLWkDrcSCyeFNqqdqHCd0wgQyVwBFHiHdI3p9Yf0=;
  b=i5bJvKV4etPsv6RFywefiVkz86XOwQMYP22kqoZoI2T+p23prSMcnR5S
   GyfQwcsEa8ApJpTM2JLaXcTEliz5nnBknjJ1Ab4SJhVoNdPffx+NdM+n1
   oI2SgNdyajoMepHbdjQXgjMFx5HIcQkfy9Xsp4sVyX8vBOzXacNx4ljd9
   F7RoaFYJYYsoKF96PR6jZoAJxahjhGxYfrowR8D251QqpjdwaxHqGt/Io
   7eWtbUpZsqU/4el5OKf7zXj9joVLax0gbJIPEJhUtnhecvT594EmN7K3o
   OeN8PUZyyhywHd809ZTdT3zCVGCVpIEvLK72fikyjBn0SVyUXeU5nPJYF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="318918491"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="318918491"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 07:32:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="796254531"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="796254531"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2022 07:32:36 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pBHN5-000I5d-2n;
        Fri, 30 Dec 2022 15:32:35 +0000
Date:   Fri, 30 Dec 2022 23:32:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 aee251fd2163cbf05d3aeae838340d55bee4b137
Message-ID: <63af0475.PUlgQ73puo+cDgWH%lkp@intel.com>
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
branch HEAD: aee251fd2163cbf05d3aeae838340d55bee4b137  clocksource: Permit limited-duration clocksource watchdogging

elapsed time: 720m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
i386                 randconfig-a012-20221226
i386                 randconfig-a011-20221226
um                             i386_defconfig
x86_64                              defconfig
i386                 randconfig-a013-20221226
x86_64                               rhel-8.3
i386                 randconfig-a014-20221226
i386                                defconfig
i386                 randconfig-a016-20221226
i386                 randconfig-a015-20221226
um                           x86_64_defconfig
x86_64                           allyesconfig
sh                               allmodconfig
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-bpf
x86_64               randconfig-a014-20221226
x86_64                           rhel-8.3-syz
x86_64               randconfig-a013-20221226
x86_64               randconfig-a011-20221226
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a012-20221226
x86_64                           rhel-8.3-kvm
mips                             allyesconfig
arc                                 defconfig
powerpc                          allmodconfig
x86_64               randconfig-a016-20221226
alpha                               defconfig
x86_64               randconfig-a015-20221226
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
arm                                 defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                  randconfig-r046-20221225
arc                  randconfig-r043-20221225
arc                  randconfig-r043-20221227
arm                  randconfig-r046-20221227
arc                  randconfig-r043-20221226
riscv                randconfig-r042-20221226
s390                 randconfig-r044-20221226
x86_64                            allnoconfig

clang tested configs:
x86_64               randconfig-a002-20221226
x86_64               randconfig-a003-20221226
x86_64               randconfig-a001-20221226
x86_64               randconfig-a004-20221226
i386                 randconfig-a004-20221226
i386                 randconfig-a001-20221226
x86_64               randconfig-a005-20221226
x86_64                          rhel-8.3-rust
x86_64               randconfig-a006-20221226
i386                 randconfig-a003-20221226
i386                 randconfig-a002-20221226
i386                 randconfig-a006-20221226
i386                 randconfig-a005-20221226
hexagon              randconfig-r045-20221225
riscv                randconfig-r042-20221227
hexagon              randconfig-r041-20221225
hexagon              randconfig-r041-20221227
hexagon              randconfig-r041-20221226
arm                  randconfig-r046-20221226
s390                 randconfig-r044-20221225
hexagon              randconfig-r045-20221226
hexagon              randconfig-r045-20221227
s390                 randconfig-r044-20221227
riscv                randconfig-r042-20221225

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
