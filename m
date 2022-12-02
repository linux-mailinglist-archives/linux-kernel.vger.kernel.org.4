Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12A9640805
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiLBNzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiLBNyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:54:18 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35BFB0A36
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 05:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669989257; x=1701525257;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RuoiChgynWYwC9FY/B75XMRI15E8yWs09qhxYV7dsIY=;
  b=G9EyT7t0aL48PhhTf2HtFXuLXaZmWiofBbY6ofNlFrkktsDMU5INzFIU
   yggsMGbwyz/8pyLGfUftfYvpjKsc52AkGQ9UnzoPw9Jaq79JdBb3EFdfp
   IDKvl2/3Hn0N4EZFqFsmuYqwnLp2mnoBChYk5J0b3F9CUSKCTsJR1du6f
   QbcNKC3OJz9zwkAaIaKICHGnzLGz/535V6WjG92Vv2yJU7yIt5fwHJUvJ
   iqTVYo5d9WV4fIkvTiLgaTnDoh1ROpYYgwe6rFw8r7XO8N+FZ0VEKI2PQ
   ngBosfiz20U+OUhQPwmdK/vjltnsOzRfz3O9CMZgqnIQPAgjrZiMkhpto
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="315983467"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="315983467"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 05:54:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="708482267"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="708482267"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Dec 2022 05:54:15 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p16UZ-000Dib-0S;
        Fri, 02 Dec 2022 13:54:15 +0000
Date:   Fri, 02 Dec 2022 21:54:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 6885a2611073edaed81bfcbf39be39843c723bd2
Message-ID: <638a0383.02QVzKowh97moGDj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 6885a2611073edaed81bfcbf39be39843c723bd2  Merge branch into tip/master: 'x86/tdx'

elapsed time: 1372m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
mips                             allyesconfig
x86_64                           allyesconfig
x86_64                        randconfig-a013
powerpc                          allmodconfig
x86_64                        randconfig-a011
arc                  randconfig-r043-20221201
x86_64                        randconfig-a015
s390                 randconfig-r044-20221201
riscv                randconfig-r042-20221201
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                                defconfig
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221201
hexagon              randconfig-r045-20221201
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
