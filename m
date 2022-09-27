Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAC65ECE99
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiI0Ud6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiI0Udz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:33:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD3CB2CDF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664310834; x=1695846834;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=psQUvekD0UFhkXqvpEfv0S+bNH7n4mkxbyLouyQNObw=;
  b=idIy3Ti92+K5BY3gQJRKjuwGnCuvJlIFvRNwvHfgdWugH93qZBtnQPuy
   XCXI1AXM/Ga/Fx3/g2aIi7enr7PW4RyPzcja/YjBQ03deIxGQSRYgMvvC
   lDAuZ6K5qMIbijbB7ZYkt566fx/6M6Fz7SYh52XgSypnLdtx/qakewOh9
   /8i84jWaqbYvfzFJkt/hJPHl+2BTmbhz8472V05vMxt3b5m3qo2B1XTO1
   BJDDg97p+NDSFNaHqysMAwwELMz+PXHKNFEBZ1q7x4yXU+UDnhH4Ir9o1
   hGAyDosuqNhvb7O/hmRYVK33YWL/WXT29DC7YfV6TqyF2sDKPyOWtyvHp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="387710463"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="387710463"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 13:33:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="652418606"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="652418606"
Received: from lkp-server02.sh.intel.com (HELO dfa2c9fcd321) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 27 Sep 2022 13:33:52 -0700
Received: from kbuild by dfa2c9fcd321 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1odHH6-0001YG-0i;
        Tue, 27 Sep 2022 20:33:52 +0000
Date:   Wed, 28 Sep 2022 04:33:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b4d0dcbca84a68ac7094f697b3ceef938bf0f755
Message-ID: <63335e2d.AdsWT5qts5FY/goE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: b4d0dcbca84a68ac7094f697b3ceef938bf0f755  Merge branch into tip/master: 'x86/cleanups'

elapsed time: 789m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
powerpc                           allnoconfig
alpha                               defconfig
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
arc                  randconfig-r043-20220925
riscv                randconfig-r042-20220925
x86_64                           rhel-8.3-syz
x86_64                              defconfig
arc                  randconfig-r043-20220926
x86_64                           rhel-8.3-kvm
s390                 randconfig-r044-20220925
s390                                defconfig
x86_64                         rhel-8.3-kunit
s390                             allmodconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
i386                 randconfig-a001-20220926
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a004-20220926
x86_64               randconfig-a002-20220926
i386                 randconfig-a005-20220926
x86_64               randconfig-a004-20220926
i386                 randconfig-a006-20220926
x86_64               randconfig-a001-20220926
i386                 randconfig-a002-20220926
s390                             allyesconfig
i386                 randconfig-a003-20220926
x86_64               randconfig-a003-20220926
x86_64               randconfig-a005-20220926
x86_64               randconfig-a006-20220926
i386                                defconfig
arm                                 defconfig
m68k                             allyesconfig
i386                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
i386                 randconfig-a011-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a016-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a014-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a016-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
