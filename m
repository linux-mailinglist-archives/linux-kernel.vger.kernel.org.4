Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30349626DBF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 05:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbiKME7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 23:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiKME7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 23:59:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C504C13DFB
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668315577; x=1699851577;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xgbSj7xkpUOjyv4jO1MebIUk2iVIOMvFbiNdHuiZAD4=;
  b=Mz0GZh8/QMP3Fsaa967KExqzh2UtbhKQWw/oFUvGNlQVVO8CAuFqxqJj
   T6KYmGNZpm+RhJo69S/CVj4G3qitP2b/1Q7zZY3hJVAXhYjmsSDiWga5i
   aJHMGAFv+wJfpb4RMeG85/REMzMuHOCH/1NuhmRp9+j0XiLFUMUmLsVZB
   u+NJ9XMWb67Nw+C4QRXkndmAODSHlTMYDz9wgbbso3oQxCJf4fhGgRTkz
   2n9Ve8EsBIjlW34QdVD7h7nK4Uk3/4nlciY+POZi6O1d53b+ksjiVZCOe
   cKZIrC+iSj1r3KtdLZZh1qqPRPrWHa24CedXHWdm0iEVctgALy06Scb3x
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="310492104"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="310492104"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 20:59:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="883135440"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="883135440"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 12 Nov 2022 20:59:17 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ou55R-0005YD-0f;
        Sun, 13 Nov 2022 04:59:17 +0000
Date:   Sun, 13 Nov 2022 12:58:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b930cf5ce69f7aeceb614228c66464c3c55cf0b1
Message-ID: <63707972.spxre6fZklteGoyO%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: b930cf5ce69f7aeceb614228c66464c3c55cf0b1  Merge x86/mm into tip/master

elapsed time: 724m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
alpha                               defconfig
x86_64                              defconfig
i386                                defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                           rhel-8.3-syz
i386                          randconfig-a005
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
powerpc                           allnoconfig
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a006
x86_64                           allyesconfig
powerpc                          allmodconfig
i386                          randconfig-a001
riscv                randconfig-r042-20221113
sh                               allmodconfig
arm                                 defconfig
i386                          randconfig-a003
mips                             allyesconfig
ia64                             allmodconfig
i386                             allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                          rhel-8.3-func
s390                 randconfig-r044-20221113
arm64                            allyesconfig
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a012
arc                  randconfig-r043-20221113
i386                          randconfig-a016
i386                          randconfig-a014
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a016
x86_64                        randconfig-a001
hexagon              randconfig-r041-20221113
i386                          randconfig-a006
x86_64                        randconfig-a012
i386                          randconfig-a002
x86_64                        randconfig-a003
i386                          randconfig-a004
i386                          randconfig-a013
x86_64                        randconfig-a014
i386                          randconfig-a011
hexagon              randconfig-r045-20221113
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
