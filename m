Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707CB61DB91
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiKEPJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiKEPJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:09:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BCAEE30
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667660975; x=1699196975;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pb/3In8zvGVVLyunePkPe4yXkZquqxYoACGo8jdmt7I=;
  b=GrxPji22A11dJljZFwHFrsBcPE55Xb4yCXwXqbvOgb08CFL6XA0jPVqt
   uj7aHmbsq4LKc2fUAjHxfo38IjfI21T+/RjdraIa6TcQ7KBSLDpw+nJ6n
   VFhryTsLgHqHvPdq7GdSHhEYAWoYl+G8xcRb4SvDoLGZp6jxvFclZB89w
   R+xZUPuj17o/rxmNcx/f9Fk3ZCor6DyzWSFTbkV75awXh+sOiUZ8W1X+h
   Gqc3FvRL/bPcoRixovFhIRqE98qGK+yN97+tB5/4YQrToIdoXTIYdPswp
   Xsv4yl4I/LMVNBMQANtAEjLbaA8cz2pZXT19i+Lw9fdZAnfcdp2eNI9lU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="311309488"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="311309488"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2022 08:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="613401261"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="613401261"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Nov 2022 08:09:34 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1orKnd-000I65-1O;
        Sat, 05 Nov 2022 15:09:33 +0000
Date:   Sat, 05 Nov 2022 23:08:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.11.03a] BUILD SUCCESS
 f843407d2393a3db87bdbd420cd55a7fe1cddbe1
Message-ID: <63667c74.v7rA54Rxg8IUUNkX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.11.03a
branch HEAD: f843407d2393a3db87bdbd420cd55a7fe1cddbe1  fixup! clocksource: Exponential backoff for load-induced bogus watchdog reads

elapsed time: 721m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a013
x86_64                        randconfig-a011
um                             i386_defconfig
um                           x86_64_defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
arc                                 defconfig
x86_64                        randconfig-a015
alpha                               defconfig
s390                                defconfig
x86_64                               rhel-8.3
mips                             allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20221104
x86_64                          rhel-8.3-func
s390                             allmodconfig
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
powerpc                          allmodconfig
ia64                             allmodconfig
sh                               allmodconfig
i386                          randconfig-a014
m68k                             allmodconfig
riscv                randconfig-r042-20221104
arc                              allyesconfig
i386                          randconfig-a012
s390                 randconfig-r044-20221104
x86_64                           allyesconfig
i386                          randconfig-a016
s390                             allyesconfig
m68k                             allyesconfig
arm                                 defconfig
i386                                defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                             allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a006
hexagon              randconfig-r041-20221104
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20221104
i386                          randconfig-a011

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
