Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237F55F7536
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJGIVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJGIVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:21:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02107B0B01
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 01:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665130877; x=1696666877;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DAETs5P/Uqo8ED6WU+3FVFAUbNP8iAmq1+SJzIX/O9M=;
  b=Lrpt5YE7hcRpRWrD24hffwPn8ii24ZU6fYySl1Ufy8qSV+Dv76flgxL5
   ZW2c/QM40m9kT3V7wRJnEib+9FL05pU641evDxDxlTmqgZd9NYZGROKzI
   IBg7+1qWYRUjC5zjS6W40esmKX21NtpOYSXlxRp2kD4hNO+bV6vciFEfN
   Ns0WH08Mbgt0vMJgi2HBLRvOulsMh/J0YaEY2l6/vBWprPZbRpfQ8Mz+3
   DnN00twKL2Rffq4V7kEHpHXKp8JDSrGFIIgxqd9/BxSGcJEuiJYJxCnoa
   Je6CxIYCobDCoBoX9PS/kjaLAv42o/TrBF3UDWfUTcZJfwzQZWYlpOi/+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="305263812"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="305263812"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 01:21:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="800226071"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="800226071"
Received: from lkp-server01.sh.intel.com (HELO 3c15167049b7) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Oct 2022 01:21:16 -0700
Received: from kbuild by 3c15167049b7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogibb-0000vq-2Z;
        Fri, 07 Oct 2022 08:21:15 +0000
Date:   Fri, 07 Oct 2022 16:20:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:lazy.2022.10.06a] BUILD SUCCESS
 12712ae0200147e018aa7854f21cc7bfd95ba96e
Message-ID: <633fe149.2BlTB92PiksagG7/%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lazy.2022.10.06a
branch HEAD: 12712ae0200147e018aa7854f21cc7bfd95ba96e  workqueue: Make queue_rcu_work() use call_rcu_flush()

elapsed time: 722m

configs tested: 57
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
x86_64                              defconfig
arc                                 defconfig
x86_64                               rhel-8.3
alpha                               defconfig
sh                               allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
m68k                             allmodconfig
powerpc                          allmodconfig
s390                                defconfig
i386                 randconfig-a011-20221003
mips                             allyesconfig
x86_64                           rhel-8.3-syz
i386                 randconfig-a012-20221003
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                 randconfig-a013-20221003
alpha                            allyesconfig
arm                                 defconfig
m68k                             allyesconfig
x86_64                           allyesconfig
arc                              allyesconfig
x86_64                           rhel-8.3-kvm
i386                                defconfig
x86_64                    rhel-8.3-kselftests
s390                             allmodconfig
s390                             allyesconfig
i386                 randconfig-a015-20221003
i386                 randconfig-a016-20221003
i386                 randconfig-a014-20221003
i386                             allyesconfig
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
arc                  randconfig-r043-20221002
arm64                            allyesconfig
s390                 randconfig-r044-20221003
arm                              allyesconfig
x86_64               randconfig-a011-20221003
x86_64               randconfig-a013-20221003
x86_64               randconfig-a012-20221003
x86_64               randconfig-a014-20221003
x86_64               randconfig-a015-20221003
x86_64               randconfig-a016-20221003
ia64                             allmodconfig

clang tested configs:
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
hexagon              randconfig-r041-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a006-20221003
hexagon              randconfig-r041-20221002
hexagon              randconfig-r045-20221002
hexagon              randconfig-r045-20221003
riscv                randconfig-r042-20221002
s390                 randconfig-r044-20221002

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
