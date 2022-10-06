Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED335F61A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJFH27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJFH24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:28:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8077F111
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665041336; x=1696577336;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0hHB0HurPLCsv05+ws89CRXb9GtCxT7+4TZpgH3fRR8=;
  b=cNJ9poIcco4B0vGWHD3RDSFHxTvk98nRZgGLwMgQ7ql5K9iUjWir/tON
   gftC4vC+A6StyN7n6/GfLSGGNbQLENPcCtHH8shRLiyGyQhDlUarIDqvd
   2SOklSsKGkZgnVa0JbqiN+k2Axcx5g3H6YLL/LfPcE2AhPWMU8HCQJUtY
   QVD4bwbTgZWNLwt2HYI5ZPZ0SWLlhc+dYek4fIO+cMjqVQi1ldygM30Jf
   jU6Eauo3xVP8Yz3LzU7WH6sZazHMqqrRXFfd5lbvBzPv6zU4T7Uy948on
   VP66R0ntysOdWV1hrlEuqvdodBoRID7ofY2TCD40xPNZb9tab3g/r4Io/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="283088341"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="283088341"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 00:28:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="953513215"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="953513215"
Received: from lkp-server01.sh.intel.com (HELO d4f44333118a) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 06 Oct 2022 00:28:54 -0700
Received: from kbuild by d4f44333118a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogLJO-00024L-0j;
        Thu, 06 Oct 2022 07:28:54 +0000
Date:   Thu, 06 Oct 2022 15:28:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.10.03a] BUILD SUCCESS
 fece0fa66ffa3c22dcc8845d0081b2849c1d4295
Message-ID: <633e8398.2wKda/Mx7WYnDWZg%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.10.03a
branch HEAD: fece0fa66ffa3c22dcc8845d0081b2849c1d4295  clocksource: Reject bogus watchdog clocksource measurements

elapsed time: 797m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
s390                                defconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
s390                             allmodconfig
i386                                defconfig
i386                 randconfig-a011-20221003
powerpc                          allmodconfig
m68k                             allyesconfig
mips                             allyesconfig
i386                 randconfig-a012-20221003
m68k                             allmodconfig
i386                 randconfig-a013-20221003
arc                              allyesconfig
i386                 randconfig-a015-20221003
alpha                            allyesconfig
i386                 randconfig-a016-20221003
i386                 randconfig-a014-20221003
s390                             allyesconfig
i386                             allyesconfig
arm                                 defconfig
arc                  randconfig-r043-20221003
arc                  randconfig-r043-20221002
s390                 randconfig-r044-20221003
riscv                randconfig-r042-20221003
x86_64               randconfig-a011-20221003
x86_64               randconfig-a012-20221003
ia64                             allmodconfig
arm64                            allyesconfig
x86_64               randconfig-a013-20221003
arm                              allyesconfig
x86_64               randconfig-a014-20221003
x86_64               randconfig-a016-20221003
x86_64               randconfig-a015-20221003

clang tested configs:
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a004-20221003
hexagon              randconfig-r041-20221003
hexagon              randconfig-r041-20221002
i386                 randconfig-a005-20221003
hexagon              randconfig-r045-20221002
i386                 randconfig-a006-20221003
hexagon              randconfig-r045-20221003
riscv                randconfig-r042-20221002
s390                 randconfig-r044-20221002
x86_64               randconfig-a005-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a006-20221003
x86_64               randconfig-a003-20221003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
