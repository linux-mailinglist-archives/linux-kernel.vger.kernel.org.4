Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B87B631DAE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiKUKGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiKUKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:06:27 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037889E97B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669025186; x=1700561186;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GaMn7dC411IWc5qWRi4thrL7ZVwcHNGKp/49m65jbqA=;
  b=ie+e/S6xe6oQxlvC0BOMBxDuuxtlfTM2MCJY/EcC4pFKDwso/5pWd03D
   v4VurLbWlcKuT7rxGY2YJE+lRXz9yYilyifEfQCU2BuHzTcAJy8OAG5Jf
   VimVUmVxPOSo+NnaR83S2H6IpUBkfylrfmH2z7dgw9P8i4beQmS35r/0k
   +AfaWTMkbd6sJ+9d9VQc4+UOPc1UFwDbpveJp40vmUXQrgRXdguWwtNY7
   sgxjr0487BAJeGaxvaCMDeaLSykrBm8UyeaqPjFeGtnphN2TEuXWCFfbd
   uI3SVfLx/z0LT7PbluUo9sct53dSSnVjgYKxbeGCNqoPLl9q40Md4Pf52
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="375668243"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="375668243"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 02:06:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="640967942"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="640967942"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 21 Nov 2022 02:06:15 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ox3gs-0000LC-1L;
        Mon, 21 Nov 2022 10:06:14 +0000
Date:   Mon, 21 Nov 2022 18:06:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:clocksource.2022.11.09a] BUILD SUCCESS
 0e2ab9bfb9d7b13c6074b1e9e1e69033a30952e4
Message-ID: <637b4d93.Fw4cn+DhiS6ZV3wb%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git clocksource.2022.11.09a
branch HEAD: 0e2ab9bfb9d7b13c6074b1e9e1e69033a30952e4  clocksource: Exponential backoff for load-induced bogus watchdog reads

elapsed time: 4873m

configs tested: 56
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
alpha                               defconfig
arc                                 defconfig
s390                                defconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
m68k                             allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a012-20221121
mips                             allyesconfig
x86_64               randconfig-a011-20221121
x86_64               randconfig-a015-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a014-20221121
arc                  randconfig-r043-20221121
x86_64               randconfig-a016-20221121
sh                               allmodconfig
s390                 randconfig-r044-20221121
x86_64                          rhel-8.3-func
s390                             allmodconfig
x86_64                    rhel-8.3-kselftests
riscv                randconfig-r042-20221121
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
arm                                 defconfig
i386                 randconfig-a012-20221121
i386                 randconfig-a014-20221121
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                            allnoconfig
i386                 randconfig-a015-20221121
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                 randconfig-a016-20221121

clang tested configs:
i386                 randconfig-a004-20221121
i386                 randconfig-a001-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
i386                 randconfig-a005-20221121
hexagon              randconfig-r041-20221121
i386                 randconfig-a006-20221121
hexagon              randconfig-r045-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a003-20221121
x86_64               randconfig-a002-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
