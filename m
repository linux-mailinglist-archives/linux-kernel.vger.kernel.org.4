Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCCB634B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiKVXin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKVXil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:38:41 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84A624BDD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669160320; x=1700696320;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eJeUfkGvKQCbty09QO6WabRmWGyyKdZU632idMtkHKU=;
  b=aJWBK/qa7sq3UKtGyY6KbjeJJ9yd8uIqpwQDXwLfY7aNsKjbeCXc54A5
   sWmcZGhTPcqs4SVJv+18JNHXlwbib0aavsxE0Eebaz8y70eiTWkxfnR+4
   9uI5dgQtQJckrWgk+RRmWijr7QelTn/kkWC7VKp1CB3mn/Emiu1VomOEz
   /ggTOcqHLd38dwaII9snXGwt0czTkQKyevVa3sn1eTrF4mTWgJQ2mv0iQ
   U1J+8dGOfJ4NOMrSja2oCyfvanfb9lUCSy/zWTrsXSt1G2vSWAWDKk+Kl
   HfcJs+fO6WWfU+OIm0o7393SMLjPS8Yza0vVnu0JqvSz/zqWj27dwWYsv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="376083884"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="376083884"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 15:38:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="886723723"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="886723723"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Nov 2022 15:38:39 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxcqc-000207-2K;
        Tue, 22 Nov 2022 23:38:38 +0000
Date:   Wed, 23 Nov 2022 07:37:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 2072e952de1d5c2748165a6818e4986d24dae06e
Message-ID: <637d5d45.cGu9BJ56BkbgGV3L%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 2072e952de1d5c2748165a6818e4986d24dae06e  Merge branch 'x86/core' into x86/mm, to resolve conflicts

elapsed time: 1498m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
um                             i386_defconfig
s390                             allmodconfig
um                           x86_64_defconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
ia64                             allmodconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a014-20221121
i386                 randconfig-a016-20221121
i386                 randconfig-a015-20221121
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64               randconfig-a012-20221121
x86_64               randconfig-a011-20221121
x86_64               randconfig-a013-20221121
m68k                             allmodconfig
x86_64               randconfig-a014-20221121
arc                              allyesconfig
arc                  randconfig-r043-20221120
alpha                            allyesconfig
x86_64                               rhel-8.3
x86_64               randconfig-a016-20221121
m68k                             allyesconfig
x86_64               randconfig-a015-20221121
i386                                defconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20221121
s390                 randconfig-r044-20221121
riscv                randconfig-r042-20221121
i386                             allyesconfig
arm                                 defconfig

clang tested configs:
hexagon              randconfig-r041-20221120
hexagon              randconfig-r041-20221121
hexagon              randconfig-r045-20221120
hexagon              randconfig-r045-20221121
riscv                randconfig-r042-20221120
s390                 randconfig-r044-20221120
x86_64               randconfig-a003-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a002-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a006-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a001-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
