Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DA060BBAF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiJXVKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiJXVIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:08:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59CD56B8C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666638943; x=1698174943;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VtRRzCi2FJUwmOuhomGCrHmbE+Ce41NeeiTU2r/kyEA=;
  b=KpcFTl6rsfhDICFygmb8Id9qMIQdBgaM9TwTit52kCHdjmVmZ4GL7L8d
   5DwawwEaf/sDHZPJclQZL8+WX0XPui06rJ1gbBk7UISxeU6g6sdHoAdqx
   vbtRh9n8fIC5eQO5Af6JgujDF1srNeVpKYqCwBkXLV0PQneUzadF/A6Ni
   O0uxtl84e+Jq0GQS6TIhbsOTgd2qub6PL7mnxiwGFpLA06a71LY2+pkeE
   Js+L2SwtvW7uw38ux0R/Kihzn0WWHykNVo8lIvpQIOpVWjDkMVihv4yuE
   zeb7H0kKWx7/paVUTabTbirtSLTM1RueckhKUMf+xxbX7dLE859bDTjwb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="306229098"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="306229098"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 11:58:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="662530008"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="662530008"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 24 Oct 2022 11:58:47 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1on2es-0005Z9-2e;
        Mon, 24 Oct 2022 18:58:46 +0000
Date:   Tue, 25 Oct 2022 02:58:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1e385c81b73d100673ab1d4f732251a1d7ec6441
Message-ID: <6356e03a.jghS9SNISASAvSNg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 1e385c81b73d100673ab1d4f732251a1d7ec6441  Merge branch into tip/master: 'x86/paravirt'

elapsed time: 800m

configs tested: 77
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
mips                             allyesconfig
x86_64                              defconfig
s390                             allyesconfig
i386                                defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
i386                 randconfig-a011-20221024
i386                 randconfig-a014-20221024
x86_64                           allyesconfig
i386                 randconfig-a013-20221024
arm                                 defconfig
i386                 randconfig-a012-20221024
i386                 randconfig-a016-20221024
i386                 randconfig-a015-20221024
i386                             allyesconfig
x86_64               randconfig-a013-20221024
arm                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64               randconfig-a012-20221024
arm64                            allyesconfig
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a011-20221024
x86_64               randconfig-a015-20221024
x86_64               randconfig-a014-20221024
x86_64               randconfig-a016-20221024
arc                  randconfig-r043-20221024
riscv                randconfig-r042-20221024
arc                  randconfig-r043-20221023
s390                 randconfig-r044-20221024
arc                              allyesconfig
alpha                            allyesconfig
ia64                             allmodconfig
m68k                             allyesconfig
arm                        mini2440_defconfig
x86_64               randconfig-k001-20221024
parisc                generic-64bit_defconfig
sh                           se7712_defconfig
powerpc                     tqm8555_defconfig
sh                          lboxre2_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
m68k                             allmodconfig

clang tested configs:
x86_64               randconfig-a001-20221024
x86_64               randconfig-a003-20221024
x86_64               randconfig-a002-20221024
x86_64               randconfig-a004-20221024
x86_64               randconfig-a005-20221024
x86_64               randconfig-a006-20221024
i386                 randconfig-a001-20221024
i386                 randconfig-a002-20221024
i386                 randconfig-a005-20221024
hexagon              randconfig-r045-20221023
i386                 randconfig-a003-20221024
i386                 randconfig-a004-20221024
hexagon              randconfig-r041-20221024
i386                 randconfig-a006-20221024
riscv                randconfig-r042-20221023
hexagon              randconfig-r045-20221024
s390                 randconfig-r044-20221023
hexagon              randconfig-r041-20221023
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                        mvebu_v5_defconfig
powerpc                 mpc832x_mds_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
