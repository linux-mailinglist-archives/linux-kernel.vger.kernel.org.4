Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EAF5F7538
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJGIVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJGIVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:21:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC0EB14F5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 01:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665130878; x=1696666878;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=C16SNrV/I3TUlfXkTZ4QxxvSnd24YdLTYu5UZutpLmw=;
  b=McsJGvh+vrk5FUp6BnLykwpASzixvKy5LmFwyRzfhaGe+p9xHf+Ysojq
   E8WLvltbP5tSMO3etjrxevyEZNbfz2CF7fcn6zAXKPm+2hHA39+E/d94t
   jG9xVk2hMpe3RrN98kkgU2rsyz4U4xXyAuPy9Pm87Nslcc/4QZcxlzJ5e
   X1bXS1ZKMLp8ebdrVv5/LD+NmXV03+Vmuu63gp5O21W5qq6cdQ0sx7IqI
   xHEMkcijMvEEe+JaLeSDeAvtBSudDpIIahcDsYzkTZkk/VseRNuWN40Re
   KEwNp0KaZ2JkzNI4LUtqab8qQEeaCR63et8V1PgfhKUtgjr9uSdTwoelP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="283402029"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="283402029"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 01:21:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="714192408"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="714192408"
Received: from lkp-server01.sh.intel.com (HELO 3c15167049b7) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Oct 2022 01:21:16 -0700
Received: from kbuild by 3c15167049b7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogibb-0000vk-2Q;
        Fri, 07 Oct 2022 08:21:15 +0000
Date:   Fri, 07 Oct 2022 16:20:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.10.06a] BUILD SUCCESS
 aa1d63eb63e267678a3528cb4ef65fe6d6234125
Message-ID: <633fe14d.a7JOfuOtqFU5Q4eP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.10.06a
branch HEAD: aa1d63eb63e267678a3528cb4ef65fe6d6234125  fixup! EXP cpu: Add CPU-online debugging

elapsed time: 723m

configs tested: 57
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
alpha                               defconfig
x86_64                              defconfig
sh                               allmodconfig
s390                                defconfig
x86_64                               rhel-8.3
s390                             allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
i386                 randconfig-a014-20221003
x86_64                           rhel-8.3-kvm
i386                 randconfig-a011-20221003
x86_64                          rhel-8.3-func
i386                 randconfig-a012-20221003
i386                                defconfig
i386                 randconfig-a013-20221003
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
s390                             allyesconfig
arm                                 defconfig
i386                 randconfig-a015-20221003
arc                              allyesconfig
i386                 randconfig-a016-20221003
alpha                            allyesconfig
m68k                             allyesconfig
i386                             allyesconfig
x86_64               randconfig-a011-20221003
arm                              allyesconfig
x86_64               randconfig-a015-20221003
riscv                randconfig-r042-20221003
arm64                            allyesconfig
arc                  randconfig-r043-20221003
x86_64               randconfig-a014-20221003
x86_64               randconfig-a012-20221003
arc                  randconfig-r043-20221002
s390                 randconfig-r044-20221003
x86_64               randconfig-a013-20221003
x86_64               randconfig-a016-20221003
ia64                             allmodconfig

clang tested configs:
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a006-20221003
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a003-20221003
hexagon              randconfig-r041-20221003
riscv                randconfig-r042-20221002
hexagon              randconfig-r041-20221002
s390                 randconfig-r044-20221002
hexagon              randconfig-r045-20221002
hexagon              randconfig-r045-20221003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
